//
//  Facade.swift
//  codeDesign
//
//  Created by zhengzhiwen on 2021/5/26.
//

import Foundation

class VideoFile {
    let fileName: String
    
    init(fn: String) {
        self.fileName = fn
    }
}

class Result {
    
}

class File {
    let result: Result
    
    init(r: Result) {
        self.result = r
    }
    
    func save() {
        
    }
}

class SourceCodec {
    
}

class OggCompressionCodec: SourceCodec {
    
}

class MPEG4CompressionCodec: SourceCodec {
    
}

class Buffer {
    
}


class AudioMixer {
    
    func fix(r: Result) -> Result {
        return Result()
    }
}

class BitrateReader {
    
    class func read(fn: String, sc: SourceCodec) -> Buffer{
        return Buffer()
    }
    
    class func convert(bf: Buffer, dc: SourceCodec) -> Result {
        return Result()
    }
}

class CodecFactory {
    
    class func extract(vf: VideoFile) -> SourceCodec {
        return SourceCodec()
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
    let mp4 = convertor.convert(fn: "abc.ogg", format: "mp4")
    mp4.save()
}


