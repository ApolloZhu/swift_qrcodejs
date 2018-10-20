import XCTest
@testable import swift_qrcodejs

private func expect(_ qrCode: QRCode?, withFill fill: String, andPatch patch: String, toMatch expected: String) {
    XCTAssertNotNil(qrCode)
    let generated = qrCode!.toString(filledWith: fill, patchedWith: patch)
    XCTAssertEqual(generated, expected)
}

class swift_qrcodejsTests: XCTestCase {
    func testSimple() {
        expect(QRCode("https://gist.github.com/agentgt/1700331"),
               withFill: "##", andPatch: "  ",
               toMatch: """
                                                                              
  ##############    ####      ##    ######          ####      ##############  
  ##          ##        ##  ####    ####      ####  ##    ##  ##          ##  
  ##  ######  ##  ########  ##########    ##  ########  ##    ##  ######  ##  
  ##  ######  ##  ####  ######  ####  ####          ##    ##  ##  ######  ##  
  ##  ######  ##          ####    ######  ##    ####  ##      ##  ######  ##  
  ##          ##    ####      ####  ##    ##    ####          ##          ##  
  ##############  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##############  
                            ####  ##  ####  ####    ##  ####                  
        ####  ####  ##  ######    ####    ####    ####    ##        ####      
    ######        ##    ##  ##    ####  ######      ##      ##    ######      
      ##      ####    ####  ####    ##    ####  ##  ##      ######    ##  ##  
    ####  ##        ########    ####      ##    ####  ####  ####      ##      
      ##    ####  ##    ######  ########    ########          ####            
    ######  ##      ##########  ##  ##  ##          ##########    ##  ####    
    ##        ####  ####    ####  ####    ##    ##      ####        ########  
    ##  ##      ##  ##    ####          ####  ##      ####  ####  ########    
    ##  ####  ##  ##  ######  ##########  ####    ######  ##  ##      ######  
        ######  ######    ##  ##          ##    ####    ##      ##  ######    
    ##    ######  ##    ######  ####  ##      ######    ####  ##    ####  ##  
      ######    ##  ##    ##      ##  ##    ##########      ##    ##    ##    
    ##      ######        ##    ##  ######  ####      ##  ######  ####  ####  
        ##  ##    ##  ##  ####        ##  ########  ##  ####    ######  ##    
        ##  ####      ##  ######      ##    ##      ##  ##  ####  ##    ####  
      ##    ##      ####  ############  ##  ##  ######  ####    ##    ##  ##  
    ##    ##############  ####  ####      ##      ####    ######    ##  ####  
      ##        ##############            ##  ##    ####    ##  ####          
    ##  ##  ####  ##    ####    ##    ####    ######  ####    ####  ########  
    ########      ######    ####    ####    ######        ####    ##  ####    
      ####  ########    ######    ####              ##  ############  ######  
                  ######  ##            ########  ####    ##      ######      
  ##############  ##      ##  ####  ######      ##        ##  ##  ######  ##  
  ##          ##    ##    ##  ####        ##  ####  ########      ####  ####  
  ##  ######  ##  ##    ##  ######    ####  ##  ##    ##############          
  ##  ######  ##  ##    ##    ########    ####    ##  ######  ##    ##        
  ##  ######  ##    ##  ##  ######    ##    ######              ############  
  ##          ##      ##      ##        ############          ##############  
  ##############      ####    ######  ##  ##    ####  ##  ######    ##    ##  
                                                                              
""")
    }

    func testLowErrorCorrectLevel() {
        expect(QRCode("https://passport.bilibili.com/qrcode/h5/login?oauthKey=2f3ab118e214e7ad69683df50918a481",
                      errorCorrectLevel: .L),
               withFill: "@@", andPatch: "  ",
               toMatch: """
                                                                              
  @@@@@@@@@@@@@@  @@        @@  @@        @@@@  @@  @@@@@@@@  @@@@@@@@@@@@@@  
  @@          @@  @@    @@@@@@@@    @@  @@        @@  @@      @@          @@  
  @@  @@@@@@  @@  @@@@    @@  @@@@@@@@@@  @@@@@@@@@@  @@  @@  @@  @@@@@@  @@  
  @@  @@@@@@  @@  @@@@@@  @@          @@    @@  @@@@@@@@@@    @@  @@@@@@  @@  
  @@  @@@@@@  @@    @@@@  @@  @@@@    @@    @@  @@    @@@@@@  @@  @@@@@@  @@  
  @@          @@  @@@@@@              @@@@@@@@            @@  @@          @@  
  @@@@@@@@@@@@@@  @@  @@  @@  @@  @@  @@  @@  @@  @@  @@  @@  @@@@@@@@@@@@@@  
                      @@@@  @@  @@  @@@@  @@@@  @@@@  @@@@@@                  
  @@@@    @@@@@@      @@  @@@@    @@@@  @@  @@@@          @@    @@  @@@@@@@@  
      @@  @@@@              @@@@@@    @@  @@    @@  @@@@@@@@      @@  @@@@    
    @@@@  @@@@@@@@              @@  @@@@  @@@@  @@@@  @@@@  @@@@  @@@@  @@    
    @@      @@    @@      @@  @@@@@@@@      @@  @@                  @@@@  @@  
    @@        @@  @@@@@@@@  @@@@    @@@@@@  @@@@  @@    @@  @@@@@@    @@  @@  
        @@@@        @@@@  @@    @@@@      @@@@@@@@  @@@@@@        @@@@@@@@    
    @@  @@  @@@@  @@@@  @@@@@@@@@@@@  @@    @@@@@@@@  @@@@    @@  @@          
    @@@@@@        @@@@  @@  @@  @@@@@@  @@  @@    @@  @@@@  @@  @@@@@@@@@@    
          @@@@@@@@@@      @@@@  @@@@@@@@@@  @@  @@@@  @@@@  @@@@@@    @@  @@  
      @@        @@@@  @@    @@@@@@  @@    @@@@@@@@    @@@@@@    @@@@@@@@@@    
    @@@@  @@  @@    @@          @@  @@    @@@@  @@@@@@@@@@  @@@@              
    @@@@@@@@@@      @@@@  @@  @@@@@@@@@@  @@@@    @@  @@        @@    @@@@    
            @@@@  @@@@@@@@  @@@@  @@@@@@@@@@@@  @@      @@  @@@@    @@@@@@@@  
    @@      @@    @@@@@@  @@    @@            @@@@@@  @@@@@@      @@    @@    
    @@@@@@  @@@@@@@@@@  @@@@@@@@@@    @@      @@@@      @@  @@    @@@@@@      
      @@@@@@        @@  @@  @@  @@@@@@      @@@@  @@      @@@@@@      @@@@    
    @@    @@  @@    @@    @@@@  @@@@@@@@    @@@@@@@@  @@    @@@@      @@@@@@  
      @@  @@    @@    @@    @@@@@@  @@    @@    @@  @@  @@@@      @@    @@    
          @@  @@@@@@@@          @@@@@@    @@    @@@@  @@@@@@@@@@@@@@  @@      
    @@@@    @@  @@        @@  @@@@@@@@      @@@@@@    @@        @@@@  @@@@    
    @@    @@@@@@        @@  @@@@  @@@@@@@@  @@  @@@@  @@@@@@@@@@@@@@@@@@      
                  @@      @@    @@        @@  @@@@    @@  @@      @@          
  @@@@@@@@@@@@@@    @@  @@@@@@@@@@        @@  @@@@@@@@@@  @@  @@  @@          
  @@          @@  @@  @@@@  @@  @@  @@@@    @@    @@  @@@@@@      @@  @@  @@  
  @@  @@@@@@  @@  @@      @@@@    @@@@  @@  @@@@  @@      @@@@@@@@@@@@@@@@@@  
  @@  @@@@@@  @@            @@@@@@    @@  @@    @@    @@@@  @@@@@@      @@@@  
  @@  @@@@@@  @@      @@        @@@@@@@@    @@@@@@@@  @@@@  @@@@@@            
  @@          @@  @@  @@  @@  @@    @@  @@  @@    @@    @@    @@      @@@@    
  @@@@@@@@@@@@@@  @@@@@@@@  @@@@    @@  @@@@@@@@@@@@    @@    @@@@@@@@@@@@@@  
                                                                              
""")
    }
    
    func testBorderless() {
        expect(QRCode("https://github.com/ApolloZhu", withBorder: false),
               withFill: "MM", andPatch: "  ",
               toMatch: """
MMMMMMMMMMMMMM  MM    MMMM  MM  MM  MMMMMM  MM  MM  MMMMMMMMMMMMMM
MM          MM    MM  MMMM        MM  MM  MMMM  MM  MM          MM
MM  MMMMMM  MM  MMMMMMMM    MMMM    MM  MMMM  MMMM  MM  MMMMMM  MM
MM  MMMMMM  MM      MM        MM  MM  MM  MM  MM    MM  MMMMMM  MM
MM  MMMMMM  MM  MM  MMMMMMMMMMMMMM  MMMM        MM  MM  MMMMMM  MM
MM          MM    MM  MM  MM      MMMMMM    MM      MM          MM
MMMMMMMMMMMMMM  MM  MM  MM  MM  MM  MM  MM  MM  MM  MMMMMMMMMMMMMM
                MMMM  MMMMMMMMMM  MM  MMMM      MM                
          MMMM    MM          MMMM  MM  MM  MM  MM  MM  MM  MM  MM
      MM  MM    MMMMMMMMMM  MMMMMM  MMMMMMMMMMMM  MM  MMMMMM      
  MMMM    MMMMMM  MM            MMMMMMMMMM  MM  MM  MMMM  MMMMMM  
    MMMMMMMM  MM  MMMMMM      MM      MMMMMM          MM    MMMMMM
    MM  MM  MMMM    MM        MM  MM      MM    MM  MMMMMMMM    MM
      MM          MM  MM  MMMMMMMM      MMMM  MMMMMMMMMMMM      MM
    MM  MM  MM    MMMMMM        MM    MM    MM  MM    MMMM  MMMM  
                  MM  MM    MM  MM    MM      MMMM  MMMM  MMMM  MM
  MMMM    MMMMMM  MM        MMMM  MM  MM          MM    MMMM  MMMM
  MM  MMMM      MM    MMMMMM  MM  MM  MMMM    MMMM  MMMM        MM
          MMMM    MM  MM  MMMM  MMMMMM      MMMM  MMMM  MMMMMM  MM
    MMMM              MMMM    MM  MM        MMMMMMMM      MMMM  MM
    MM    MMMM        MM  MM      MMMMMMMM  MM  MM    MMMMMM    MM
  MMMMMM  MM      MMMM  MMMM  MMMM    MM  MMMM    MMMMMMMM        
      MM    MM    MM  MMMM  MMMMMMMM  MMMM  MMMMMM    MM  MMMMMM  
    MM          MMMMMM        MMMMMM        MMMM      MM  MMMMMMMM
  MM  MMMMMMMM  MMMM      MM  MMMM  MM  MMMM    MMMMMMMMMM        
                MMMMMMMMMM          MMMM    MM  MM      MMMM    MM
MMMMMMMMMMMMMM    MMMM  MM    MMMMMMMM  MMMM  MMMM  MM  MMMM  MM  
MM          MM  MMMMMM    MMMM        MMMM    MMMM      MMMMMMMM  
MM  MMMMMM  MM    MM        MMMMMMMMMM    MM    MMMMMMMMMM  MMMMMM
MM  MMMMMM  MM      MMMMMMMM    MM  MMMM  MMMMMM  MM  MMMMMMMMMM  
MM  MMMMMM  MM    MM  MM  MMMMMM  MM  MM    MM          MM  MMMMMM
MM          MM    MMMM    MMMM      MMMMMM  MM    MM        MM    
MMMMMMMMMMMMMM    MMMMMMMMMMMMMM    MM      MMMMMMMM        MMMM  
""")
    }

    static var allTests = [
        ("testSimple", testSimple),
        ("testLowErrorCorrectLevel", testLowErrorCorrectLevel),
        ("testBorderless", testBorderless),
    ]
}
