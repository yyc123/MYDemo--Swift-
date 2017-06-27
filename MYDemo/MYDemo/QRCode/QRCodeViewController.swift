//
//  QRCodeViewController.swift
//  MYDemo
//
//  Created by 德基 on 2017/6/24.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: BaseViewController {
    //扫描框大小
    var QRCodeFrame: CGSize = CGSize(width: 290, height: 290)
    var previewLayer: AVCaptureVideoPreviewLayer?
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
    
    lazy var cameraView: QRView = {
        
        let view = QRView(frame: CGRect(origin: CGPoint(), size: self.QRCodeFrame))
        view.center = self.view.center
        return view
    }()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraView.layer.removeAllAnimations()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "二维码"
        
        guard !Platform.isSimulator else {
            let alert = UIAlertController(title: "错误", message: "模拟器无法扫描二维码", preferredStyle: .alert);
            
            let defaultAction = UIAlertAction(title: "确定", style: .cancel) { (_) in
                
               self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)

            return
        }
        
        setupCamera()
        addScanBackGround()
        let flashBtn = UIBarButtonItem(title: "闪光灯", style: .plain, target: self, action: #selector(flashClick))
        let photoBtn = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(photoClick))
        navigationItem.rightBarButtonItems = [photoBtn,flashBtn]

    }
    //闪光灯
    @objc private func flashClick() {
        guard let dev = device else{
            return
        }
        switch dev.torchMode {
        case .off:
            try? dev.lockForConfiguration()
            dev.torchMode = .on
            dev.unlockForConfiguration()
        case .on:
            try? dev.lockForConfiguration()
            dev.torchMode = .off
            dev.unlockForConfiguration()
        default:
            try? dev.lockForConfiguration()
            dev.torchMode = .on
            dev.unlockForConfiguration()
        }
        
    }
    //打开相册
    @objc private func photoClick() {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            return
        }
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        cameraView.startAnimation()
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
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.frame = view.layer.bounds
        guard previewLayer != nil else {
            printDebug("previewLayer不存在")

            return
        }
        view.layer.addSublayer(previewLayer!)
        view.addSubview(cameraView)
        //扫描范围
        let  x = cameraView.frame.origin.x;
        let  y = cameraView.frame.origin.y;
        output.rectOfInterest = CGRect(x: y/view.frame.height, y: x/view.frame.width, width: QRCodeFrame.height/view.frame.height, height: QRCodeFrame.width/view.frame.width)
        
        session.startRunning()
    }
    //背景色
    func addScanBackGround() {
       
        let cover1Rect =  CGRect(x: 0, y: 0, width: view.frame.width, height: cameraView.frame.minY)
        view.addSubview(cover(rect: cover1Rect))
        
        let cover2Rect =  CGRect(x: 0, y: cameraView.frame.minY, width: cameraView.frame.minX, height: cameraView.frame.height)
        view.addSubview(cover(rect: cover2Rect))
        
        let cover3Rect =  CGRect(x: cameraView.frame.maxX, y:cameraView.frame.minY, width: cameraView.frame.minX, height: cameraView.frame.height)
        view.addSubview(cover(rect: cover3Rect))
        
        let cover4Rect =  CGRect(x: 0, y: cameraView.frame.maxY, width: view.frame.width, height: view.frame.maxY-cameraView.frame.maxY)
        view.addSubview(cover(rect: cover4Rect))

      
        
    }
    func cover(rect: CGRect) -> UIView {
        let cover = UIView(frame: rect)
        cover.backgroundColor = UIColor.black
        cover.alpha = 0.7
        return cover;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        
        printDebug("释放内存")

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
            session.stopRunning()
            navigationController?.popViewController(animated: true)
            
        }
    }
}
//相册代理方法
extension QRCodeViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        guard let image = (info[UIImagePickerControllerOriginalImage] as? UIImage) else { return
        }
        guard let ciImage = CIImage(image: image) else { return
        }
        //探测器
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]) else{
            return
        }
        let results = detector.features(in: ciImage)
        if results.count == 0 {
            print("没有识别到二维码")

        }
        for result in results {
            
            guard let str = (result as! CIQRCodeFeature).messageString else {
                print("识别出错")
                return
            }

            print(str)
        }
        
        
        //实现此方法,系统就不会自动关闭相册,需手动关闭
        picker.dismiss(animated: true, completion: nil)
    }
  
}
