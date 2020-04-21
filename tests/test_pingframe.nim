discard """
  cmd:      "nim c -r --styleCheck:hint --panics:on $options $file"
  matrix:   "--gc:refc; --gc:arc"
  targets:  "c"
  nimout:   ""
  action:   "run"
  exitcode: 0
  timeout:  60.0
"""
import ../src/zest/frame/baseframe
import ../src/zest/frame/pingframe


# ack flag
block:
  block:
    let pingFrame = initPingFrame(hasAckFlag = true, opaqueData = 12'u64)
    doAssert pingFrame.serialize.fromByteSeq.newStringStream.readPingFrame == pingFrame

  block:
    let pingFrame = initPingFrame(hasAckFlag = false, opaqueData = 12'u64)
    doAssert pingFrame.serialize.fromByteSeq.newStringStream.readPingFrame == pingFrame

# oqaque data
block:
  block:
    let pingFrame = initPingFrame(hasAckFlag = true, opaqueData = 0'u64)
    doAssert pingFrame.serialize.fromByteSeq.newStringStream.readPingFrame == pingFrame

  block:
    let pingFrame = initPingFrame(hasAckFlag = false, opaqueData = 4512'u64)
    doAssert pingFrame.serialize.fromByteSeq.newStringStream.readPingFrame == pingFrame

  block:
    let pingFrame = initPingFrame(hasAckFlag = false, opaqueData = high(uint64))
    doAssert pingFrame.serialize.fromByteSeq.newStringStream.readPingFrame == pingFrame
