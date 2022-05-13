//
//  Facade.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/5/26.
//

import Foundation

class VideoFile {
    let fileName: String
    let sc: SourceCodec
    
    init(fn: String) {
        self.fileName = fn
        sc = AVICodec()
    }
}

class Result {
    let buffer: Buffer
    let name: String
    init(b: Buffer, n: String) {
        buffer = b
        name = n
    }
}

class File {
    let result: Result
    
    init(r: Result) {
        self.result = r
    }
    
    func save() {
        let n = result.name
        print("保存\(n)")
    }
}

class SourceCodec {
    func buffer(fn: String) -> Buffer {
        return Buffer(fn: fn)
    }
    
    func name() -> String {
        return ""
    }
}

class AVICodec: SourceCodec {
    override func name() -> String {
        return "AVI"
    }
}

class OggCompressionCodec: SourceCodec {
    override func name() -> String {
        return "OGG"
    }
}

class MPEG4CompressionCodec: SourceCodec {
    override func name() -> String {
        return "MPEG4"
    }
}

class Buffer {
    
    let filePath: String
    
    init(fn: String) {
        filePath = fn
    }
}


class AudioMixer {
    
    func fix(r: Result) -> Result {
        print("将音频和视频数据进行同步")
        return r
    }
}

class BitrateReader {
    
    class func read(fn: String, sc: SourceCodec) -> Buffer{
        print("读取\(fn) 通过 \(sc.name()) 解码获得二进制流")
        return Buffer(fn: fn)
    }
    
    class func convert(bf: Buffer, dc: SourceCodec) -> Result {
        let n = dc.name()
        print("将二进制转换为\(n) 格式的二进制")
        return Result(b: bf, n: dc.name())
    }
}

class CodecFactory {
    
    class func extract(vf: VideoFile) -> SourceCodec {
        return vf.sc
    }
}

class VideoConverter {
    func convert(fn: String, format: String) -> File {
        
        let file = VideoFile(fn: fn)
        let sourceCodec = CodecFactory.extract(vf: file)
        var destinationCodec:SourceCodec = OggCompressionCodec()
        if format == "mp4" {
            destinationCodec = MPEG4CompressionCodec()
        }
        let buffer = BitrateReader.read(fn: fn, sc: sourceCodec)
        var result = BitrateReader.convert(bf: buffer, dc: destinationCodec)
        result = AudioMixer().fix(r: result)
        return File(r: result)
    }
}

func testFacade() {
    let convertor = VideoConverter()
    let mp4 = convertor.convert(fn: "abc.avi", format: "mp4")
    mp4.save()
}


