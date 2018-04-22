//
//  ViewController.swift
//  HamHyeJin_A
//
//  Created by SWUCOMPUTER on 2018. 4. 13..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet var assignView: UIView! //결과 창
    @IBOutlet var venderView: UIView! //vender 창 | assign 상태 선택 시, vender를 고를 수 있도록 뜨게 하는 창
    @IBOutlet var buttonView: UIView! //button 창 |결과를 띄우거나, 다시 처음으로 돌아가게끔 하는 버튼
    
    @IBOutlet var textFieldInput: UITextField! //샷네임을 쓰는 텍스트필드
    @IBOutlet var assigntextFieldOutput: UILabel! //샷네임 결과가 뜨는 label

    @IBOutlet var StatusView: UIPickerView! //상태를 고를 수 있는, pickerview
    @IBOutlet var statusOutput: UILabel! //상태 값이 출력되는 label
    @IBOutlet var autoSwitch: UISwitch! //샷네임, 상태를 고르고 난 후, 다음 단계로 넘어가게 하는 버튼
    
    @IBOutlet var vfxWorkInput: UITextField! //assign 상태 시, 작업 내용 적는 textfield창
    @IBOutlet var vfxVorkOutput: UILabel! //vender 배정을 알리는 label
    @IBOutlet var venderSegment: UISegmentedControl! //vender를 고르는 segmentedcontrol
    @IBOutlet var vfxWorkOutput: UILabel! //작업내용이 출력되는 label
    
    @IBOutlet var activiauIndicator: UIActivityIndicatorView!
    
    @IBOutlet var NextView: UIView!
    
    var statusArray: Array<String> = ["Assign", "Wip", "Confirm", "Done", "Omit"] //pickerview의 상태 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activiauIndicator.startAnimating()
        NextView.isHidden = true // Next창 : 기본 꺼진 상태
        assignView.isHidden = true //결과창 : 기본 꺼진 상태
        venderView.isHidden = true //벤터창 : 기본 꺼진 상태
        buttonView.isHidden = true //버튼창 : 기본 꺼진 상태
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setOn(_ on: Bool, _ animageted: Bool) {} //switch 버튼, 자동으로 꺼지게 설정하기 위해 선언
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReturnView" {
            let destVC = segue.destination as! ReturnViewController
        }
    }
    @IBAction func switchButton(_ sender: UISwitch) {
        let index: String = statusArray[self.StatusView.selectedRow(inComponent: 0)]
        if sender.isOn { //switch가 ON상태에서
        if index == "Assign" { //상태가 assign이면
            venderView.isHidden = false //vender창 켜짐
            buttonView.isHidden = false //버튼창 켜짐
        }
        else { //그 나머지 상태이면 vender창은 꺼지고, 버튼창은 보임
            venderView.isHidden = true
            buttonView.isHidden = false
            } }
        else { //switch가 OFF상태이면 모든 기록 삭제
            textFieldInput.text = nil
            vfxWorkInput.text = nil
            statusOutput.text = nil
            vfxVorkOutput.text = nil
            vfxWorkOutput.text = nil
            venderView.isHidden = true //vender창 꺼짐
            buttonView.isHidden = true //버튼창 꺼짐
            assignView.isHidden = true //상태창 꺼짐
            self.activiauIndicator.startAnimating() //다시 재실행
        }
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        let index: String = statusArray[self.StatusView.selectedRow(inComponent: 0)] //상태값 배열 index로 받기
        statusOutput.text = index //상태값은 나타내기
        let assign: String! = statusOutput.text //선택한 상태값, assign상수에 대입
        let vender: String! = vfxVorkOutput.text //vender선택값, vender상수에 대입
        let shotname: String! = textFieldInput.text //입력한 샷네임, shotname상수에 대입
        let vfxwork: String! = vfxWorkInput.text //작업내용입력내용, vfxwork상수에 대입
        
        switch (index) {
        case "Assign" : //상태가 assign이면
        self.activiauIndicator.stopAnimating() //중지
        assignView.isHidden = false //상태창 켜짐
        NextView.isHidden = false //Next창 켜짐
        assigntextFieldOutput.text = "shotname | \(shotname!)"
        statusOutput.text = "상태 : \(assign!)에서 WIP으로 변경 완료"
        vfxVorkOutput.text = "외주업체 : \(vender!)로 배정 완료"
        vfxWorkOutput.text = "작업내용 : \(vfxwork!)"
        break;
    
        case "Wip" : //상태가 wip이면
        self.activiauIndicator.stopAnimating() //중지
        assignView.isHidden = false //상태창 꺼짐
        NextView.isHidden = false //Next창 켜짐
        assigntextFieldOutput.text = "shotname | \(shotname!)"
        statusOutput.text = "상태 : \(assign!)"
        vfxWorkOutput.text = "작업진행중으로 변경 완료되었습니다."
        break;
        
        case "Confirm" : //상태가 confirm이면
        self.activiauIndicator.stopAnimating() //중지
        assignView.isHidden = false //상태창 꺼짐
        NextView.isHidden = false //Next창 켜짐
        assigntextFieldOutput.text = "shotname | \(shotname!)"
        statusOutput.text = "상태 : \(assign!)"
        vfxWorkOutput.text = "작업 컨펌진행중 상태로 변경 완료되었습니다."
        break;
        
        case "Done" : //상태가 Done이면
        self.activiauIndicator.stopAnimating() //중지
        assignView.isHidden = false //상태창 꺼짐
        NextView.isHidden = false //Next창 켜ㅈ
        assigntextFieldOutput.text = "shotname | \(shotname!)"
        statusOutput.text = "상태 : \(assign!)"
        vfxWorkOutput.text = "작업완료 상태로 변경 완료되었습니다."
        break;
            
        case "Omit" : //상태가 omit이면
        self.activiauIndicator.stopAnimating() //중지
        assignView.isHidden = false //상태창 꺼짐
        NextView.isHidden = false //Next창 켜짐
        assigntextFieldOutput.text = "shotname | \(shotname!)"
        statusOutput.text = "상태 : \(assign!)"
        vfxWorkOutput.text = "삭제 처리 완료되었습니다."
        break;
            
        default : return
        }
    }

    @IBAction func returnButton(_ sender: UIButton) { //return버튼 함수
            NextView.isHidden = true //Next창 꺼짐
            assignView.isHidden = true //상태창 꺼짐
            venderView.isHidden = true //vender창 꺼짐
            buttonView.isHidden = true //버튼창 꺼짐
        
        //모든 기록 삭제
            textFieldInput.text = nil
            vfxWorkInput.text = nil
            statusOutput.text = nil
            vfxVorkOutput.text = nil
            vfxWorkOutput.text = nil
        
            autoSwitch.setOn(false, animated: true) //return버튼 누르면, 자동 switch 버튼 꺼지게 설정
            self.activiauIndicator.startAnimating() //return버튼 누르면, 다시 재실행
    }
    @IBAction func venderOutput(_ sender: UISegmentedControl) { //segmentControl 설정, 버튼 누른 값 그대로 받아서 출력하도록 설정
            self.vfxVorkOutput.text = sender.titleForSegment(at: sender.selectedSegmentIndex)
        }
    
    func textFieldShouldReturn(_ textFieldInput: UITextField) -> Bool { //키보드 없애는 약속
        textFieldInput.resignFirstResponder()
        assigntextFieldOutput.text = textFieldInput.text
        return true
    }

    //pickerview 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int { //1개의 열 반환
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //각 슬롯 안에 배열 값들이 맞춰 채워짐
        return statusArray[row]
    }
}
