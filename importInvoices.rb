#!/usr/bin/ruby
# Usage :
# ruby importInvoices.rb
#
# Configuration :
# Get [AUTHTOKEN] at https://accounts.zoho.com/apiauthtoken/create?SCOPE=ZohoInvoice/invoiceapi
# Get [ORGANIZATIONID] at https://invoice.zoho.com/api/v3/organizations?authtoken=[AUTHTOKEN]
# Update your credential

require 'rest-client'
require 'json'
require 'open-uri'
require 'fileutils'

# Config
baseApiUrl = 'https://invoice.zoho.com/api/v3'
expensesEndPointApi = baseApiUrl + "/expenses"
authToken = [AUTHTOKEN]
organizationId = [ORGANIZATIONID]

# Local path where receipts will be stored
localReceiptPath = "./invoices/"

localPathWithBillable = true
localPathWithCustomerName = true
localPathWithProjectName = true
localPathWithYearMonth = true

data = RestClient.get expensesEndPointApi, {:params => {:authtoken => authToken, :organization_id => organizationId}}

data = JSON.parse(data)

data["expenses"].each do |line|
	if line["expense_receipt_name"] != ""
		expense = JSON.parse(RestClient.get expensesEndPointApi + '/' + line["expense_id"], {:params => {:authtoken => authToken, :organization_id => organizationId}})
		expense = expense["expense"]
		fileName = ""
		filePath = ""
		if localPathWithBillable && expense["is_billable"]
			filePath = "billable/"
		elsif localPathWithBillable
			filePath = "nonbillable/"
		end

		if localPathWithCustomerName && expense["customer_name"] != ""
			filePath = filePath + expense["customer_name"] + "/"
		end

		if localPathWithProjectName && expense["project_name"] != ""
			filePath = filePath + expense["project_name"] + "/"
		end

		if localPathWithYearMonth
			d = Date.parse(expense["date"])
			if d.month < 10
				month = "0" + d.month.to_s
			else
				month = d.month.to_s
			end
			filePath = filePath + d.year.to_s + "-" + month + "/"
		end

		FileUtils::mkdir_p localReceiptPath + filePath

		fileName = filePath + expense["date"] + "_" + expense["expense_id"] + "_" + expense["expense_receipt_name"]

		url = expensesEndPointApi + "/" + expense["expense_id"] + "/receipt?organization_id=" + organizationId + "&authtoken=" + authToken

		unless File.exists?(localReceiptPath+fileName)
			puts "Downloading " + fileName 
			File.open(localReceiptPath+fileName, "wb") do |saved_file|
				open(url, "rb") do |read_file|
					saved_file.write(read_file.read)
				end
			end
		else
			puts fileName + " already exists locally"
		end
	end
end
