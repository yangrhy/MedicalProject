//
//  CustomerInfoViewController.swift
//  MedicalProject
//
//  Created by Ricky Yang on 2/10/19.
//

import UIKit
import Firebase

class CustomerInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var customerInfo: DatabaseReference!
    var customerList = [Customers]()

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomerTableViewCell
        
        let eachCustomer:Customers
        eachCustomer = customerList[indexPath.row]
        
        cell.lblCustName.text = eachCustomer.custName
        cell.lblCustAddress.text = eachCustomer.custAddy
        cell.lblDelivDate.text = eachCustomer.deliv
        cell.lblDelivTime.text = eachCustomer.time
        cell.lblDelivStatus.text = eachCustomer.delivStat
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customerInfo = Database.database().reference().child("customer")
        
        customerInfo?.observeSingleEvent(of: .value) { (snapshot:DataSnapshot) in
            for customers in snapshot.children.allObjects as![DataSnapshot] {
                let custObj = customers.value as? [String: AnyObject]
                let custName = custObj?["customerName"]
                let custAddress = custObj?["customerAddress"]
                let delivDate = custObj?["date"]
                let delivTime = custObj?["time"]
                let delivStatus = custObj?["deliveryStatus"]
                
                let customer = Customers(custName: custName as! String?, custAddy: custAddress as! String?, deliv: delivDate as! String?, time: delivTime as! String?, delivStat: delivStatus as! String?)
                
                self.customerList.append(customer)
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
