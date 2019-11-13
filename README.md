# thesis-ios-api
```
thesis-ios-api
```



### Todo 
- [x] Title
```
* Title
- title
```


### Guide line
**Design**
```
https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/custom-icons/
```
**Note**
```
[break-point]: print function bt 1
[Edit all in files]: ctrl + cmd + e
[ota]: http://ios-preload.omumusic.net/ios/install.html
[api spec]: https://docs.google.com/document/d/1HxS4coGVnrzQjT6k2sAJZILMHv34f0Q2ZioVGNPGJBg/edit#heading=h.955pjvj717qz
https://github.com/sjsoad/SKUtils
```
**Prefix-Commit**
```
[save]: Bad habbit but useful
[api]: New apis, functions / changes to apis, functions
[minor]: Small changes
[chore]: Something boring
[docs]: Updates to documentation
[test]: Update test files
[dist]: Changes to submodules
[fix]: Bug fixes
[feat]: Done for job
[refactor]: Refactor of existing code
[bin]: Update binary associated with the project
[merge]: Resolved git merge from upstream or otherwise
[style]: convert tabs to spaces
```
**SnapKit**
```
* offset is set as the constant value regardless of the attribute.
* inset is set as the constant value, but sometimes inverted depending on the attribute. For instance right/bottom/width/height will be -(value)
```
**Error**
```
* https://nshipster.com/nserror/
* NSException(name: .internalInconsistencyException, reason:"\(#function) must be overridden in a subclass/category", userInfo: nil).raise()
```
**OTA**
```
Now, if you don't have an SSL enabled server you can upload the Plist file to your Dropbox account while keeping the IPA file on your non-SSL enabled server and use it like this:

1. Get the link to the file. Should be something like this: https://www.dropbox.com/s/a8hpnmq654pmbaw/AppName.plist?dl=0

2. Copy everything starting with /s/..... and remove the ?dl=0 parameter.

3. Create your installation link like this: itms-services://?action=download-manifest&url=https://dl.dropbox.com/s/a8hpnmq654pmbaw/AppName.plist

4. Send the link to your testers to open it on their devices.
```
