//
//  QRCodeViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {
    
    lazy var device: AVCaptureDevice?  = {
        guard let dev = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else {
            return nil;
        }
        return dev
        
    }()
    lazy var input: AVCaptureDeviceInput? = {
        guard self.device != nil else{
            return nil;
        }
        let input = try? AVCaptureDeviceInput(device: self.device)
        return input
    }()
    lazy var output: AVCaptureMetadataOutput  = {
        
        let output = AVCaptureMetadataOutput()
        return output
    }()
    lazy var session: AVCaptureSession = {
        let session = AVCaptureSession()
        return session
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "二维码"
        view.backgroundColor = UIColor.white
        guard !Platform.isSimulator else {
            let alert = UIAlertController(title: "错误", message: "模拟器无法扫描二维码", preferredStyle: .alert);
            
            let defaultAction = UIAlertAction(title: "确定", style: .cancel) { (_) in
                
               self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)

            return
        }
        
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func setupCamera() {
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        if session.canSetSessionPreset(AVCaptureSessionPresetHigh){
            
            session.sessionPreset  = AVCaptureSessionPresetHigh
        }
        if session.canAddInput(input){
            session.addInput(input)
        }
        if session.canAddOutput(output){
            session.addOutput(output)
        }
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    // Elsewhere...
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate{
    
    //扫描到数据
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        
        var stringValue: String?
        
        if metadataObjects.count>0 {
            let  metadataObject: AVMetadataMachineReadableCodeObject? = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            guard (metadataObject != nil)  else {
                return
            }
            
            stringValue = metadataObject?.stringValue
            print(stringValue ?? "扫描出错")
            
            
        }
    }
}
