Zoho Invoice Get Receipt
========================

[Zoho Invoice](https://www.zoho.com/invoice/) is a very useful tool to generate clean, professional invoices.
It includes a function of "Expenses" enabling you to record into the tool the expenses you made for a project/client and automatically rebill them to the client.

As there is a mobile application, you can, at the end of a lunch for example, take a picture of the receipt and immediatly record it into Zoho Invoice.

BUT, there is no way to "bulk export" the receipts 
- to give them to your accountant
- to provide it to your client if needed

This is what this script aim to do very simply.
It uses the [Zoho API](https://www.zoho.com/invoice/api/v3/index.html) to get the list of all your expense and to download all the receipt classified under a directory tree

    invoices/
      [non]billable/
        [Client Name]/
          [Project Name]/

(you should be able to modify this sheme easily)

Usage
-----------
- Connect to https://www.zoho.com/invoice/
- Go to https://accounts.zoho.com/apiauthtoken/create?SCOPE=ZohoInvoice/invoiceapi to get an **[AUTHTOKEN]**
- Go to https://invoice.zoho.com/api/v3/organizations?authtoken=[AUTHTOKEN] to get your **[ORGANIZATIONID]**
- Edit *importInvoices.rb* and update these 2 items
- Run `ruby importInvoices.rb`

