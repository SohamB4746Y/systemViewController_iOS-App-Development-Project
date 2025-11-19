import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate ,UINavigationControllerDelegate {

    @IBOutlet weak var Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Share(_ sender: UIButton) {
        guard let image = Image.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        present(activityViewController, animated: true)
    }
    @IBAction func Safari(_ sender: UIButton) {
        guard let urlString = URL(string : "https://developer.apple.com/")else { return }
        let safariViewController = SFSafariViewController(url : urlString)
        safariViewController.popoverPresentationController?.sourceView = sender
        present(safariViewController, animated: true)
    }
    
    @IBAction func Camera(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Medium", message: "Please choose an image", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in print( "Camera")
            }
        alertController.addAction(cameraAction)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in print( "Photo Library")
        }
        alertController.addAction(photoLibraryAction)
        present(alertController, animated: true)
    }
  
        
        @IBAction func Mail(_ sender: UIButton) {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.delegate = self
        mailComposeViewController.setToRecipients([""])
        mailComposeViewController.setSubject("")
        mailComposeViewController.setMessageBody("", isHTML: false)
        
        if let image = Image.image , let data = image.jpegData(compressionQuality: 0.6) {
            mailComposeViewController.addAttachmentData(data, mimeType: "image/jpeg", fileName: "photo.jpg")
        }
        
        mailComposeViewController.popoverPresentationController?.sourceView = sender
        present(mailComposeViewController, animated: true)
    }
    
    
    @IBAction func saveFile(_ sender: UIButton)
    {
        saveImage(image: Image.image, fileName: "photo.jpg")
    }
    
    @IBAction func fetchFile(_ sender: UIButton)
    {
        if let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let filePath = fileUrl.appendingPathComponent("photo.jpg")
            
            if FileManager.default.fileExists(atPath: filePath.path)
            {
                print("File exists at file path",filePath)
            }
            else
            {
                print("File does not exist")
            }
        }
    }
    
    func saveImage(image : UIImage?,fileName : String)
    {
        guard let image = image, let data = image.jpegData(compressionQuality: 1) else { return }
        
        if let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        {
            let filePath = fileUrl.appendingPathComponent(fileName)
            do
            {
                try data.write(to: filePath)
                print("saved to \(filePath)")
            }
            catch
            {
                print ("error is \(error.localizedDescription)")
            }
        }
    }
    
    
}
//The entire project is complete
