import XCTest

protocol AuthenticationProcess {

    /// The template method defines the skeleton of an algorithm. Ideally, it should be final because concrete implementations should not override and update actual structure of algorithm.
    ///However, because of protocol usage, we won't be able to mark the method as final neither in protocol nor in its extension.
    func authenticate()

    /// These operations already have implementations.
    func internetConnectivityCheck()


    /// These method must be implemented in subclasses.
    func serverAuthentication()

    
    /// These are "hook methods." Subclasses may override them, but it's not mandatory
    /// since the hook methods already have default (but empty) implementation. Hooks
    /// provide additional extension points in some crucial places of the
    /// algorithm.
    func checkDeviceCapability()
    func checkDeviceEligibility()
    func localAuthentication()
}

extension AuthenticationProcess {

    func authenticate() {
        checkDeviceCapability()
        checkDeviceEligibility()
        localAuthentication()
        internetConnectivityCheck()
        serverAuthentication()
    }

    /// These method already have implementation.
    func internetConnectivityCheck() {
        print("Check internetConnectivity here..")
    }

    func checkDeviceCapability() {}
    func checkDeviceEligibility() {}
    func localAuthentication() {}
}

/// Concrete classes must implement all abstract methods of the base
/// class. They can also override some methods with a default implementation.
class PINAuthentication: AuthenticationProcess {
    func serverAuthentication() {
        print("Authentication service call..")
    }
}

/// Usually, concrete classes override only a fraction of base class'
/// operations.
class TouchIDAuthentication: AuthenticationProcess {
    func checkDeviceCapability() {
        print("Check whether device is having finger print auth capacity..")
    }
    
    func checkDeviceEligibility() {
        print("Check whether user has enrolled fingerprint for local auth..")
    }
    
    func localAuthentication() {
        print("localAuthentication via touch ID..")
    }
    
    func serverAuthentication() {
        print("Authentication service call..")
    }
}

class FaceIDAuthentication: AuthenticationProcess {
    func checkDeviceCapability() {
        print("Check whether device is having face auth capacity..")
    }
    
    func checkDeviceEligibility() {
        print("Check whether user has enrolled face for local auth..")
    }
    
    func localAuthentication() {
        print("localAuthentication via face ID..")
    }
    
    func serverAuthentication() {
        print("Authentication service call..")
    }
}


/// The client code calls the template method to execute the algorithm. Client
/// code does not have to know the concrete class of an object it works with..
class ClientAppAuthentication {
    // ...
    static func authenticate(_ obj: AuthenticationProcess) {
        // ...
        obj.authenticate()
    }
}


/// Testing...
class TemplateMethodConceptual: XCTestCase {

    func test() {

        ClientAppAuthentication.authenticate(PINAuthentication())

        ClientAppAuthentication.authenticate(FaceIDAuthentication())
    }
}

let test = TemplateMethodConceptual()
test.test()
