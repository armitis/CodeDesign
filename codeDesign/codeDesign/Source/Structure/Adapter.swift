//
//  Adapter.swift
//  CodeDesign
//
//  Created by zhengzhiwen on 2021/10/13.
//

import Foundation


//圆柱体
class RoundPeg {
    
    let radius: Double
    
    init(r: Double) {
        self.radius = r
    }
    
    func radiusValue() -> Double {
        return self.radius
    }
}

class RoundHole {
    
    let radius: Double
    
    init(r: Double) {
        self.radius = r
    }
    
    func fits(roundPeg: RoundPeg) -> Bool {
        return self.radius >= roundPeg.radiusValue()
    }
}

//长方体，长和宽一样
class SquarePeg {
    
    let width: Double
    
    init(width: Double) {
        self.width = width
    }
}

//适配长方体和圆柱体
class SquarePegAdapter: RoundPeg {
    
    let peg: SquarePeg
    
    init(peg: SquarePeg) {
        self.peg = peg
        super.init(r: self.peg.width)
    }
    
    override func radiusValue() -> Double {
        return self.peg.width * sqrt(2) / 2
    }
}

func testAdapter() {
    
    let roundHole = RoundHole(r: 100)
    
    let roundPeg = RoundPeg(r: 99)
    
    print("\(roundHole.fits(roundPeg: roundPeg))")
    
    let squarePeg1 = SquarePeg(width: 200)
    let squarePeg2 = SquarePeg(width: 120)
    
//    print("\(roundHole.fits(roundPeg: squarePeg))")
    
    let squarePegAdaptor1 = SquarePegAdapter(peg: squarePeg1)
    let squarePegAdaptor2 = SquarePegAdapter(peg: squarePeg2)
    print("\(roundHole.fits(roundPeg: squarePegAdaptor1))")
    print("\(roundHole.fits(roundPeg: squarePegAdaptor2))")
    
    
}
