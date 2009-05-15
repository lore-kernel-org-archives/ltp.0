Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1M518M-000478-53
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 17:23:46 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M518C-0006DC-JS
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 17:23:41 +0000
Date: Fri, 15 May 2009 19:24:11 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Content-Type: multipart/mixed; boundary=----------D3cboU09gUBdcXPwsQELZL
MIME-Version: 1.0
References: <4A09F967.8030402@web.de>
	<20090513.224735.226784134.caiqian@cclom.cn>
Message-ID: <op.utzemhltu2flwt@debian>
In-Reply-To: <20090513.224735.226784134.caiqian@cclom.cn>
Subject: Re: [LTP] [PATCH] Fix the splice02 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

------------D3cboU09gUBdcXPwsQELZL
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2009 16:47:35 +0200, CAI Qian <caiqian@cclom.cn> wrote:

> From: Jiri Palecek <jpalecek@web.de>
> Subject: [LTP] [PATCH] Fix the splice02 test
> Date: Wed, 13 May 2009 00:34:15 +0200
>
>>   Particularly:
>>
>>    - TEST_ERRNO is only set when the syscall is executed using the
>>      TEST() macro. The tests gave bad error messages because of that.
>>
>>    - The end of the test was dead code; moved the TPASS code to pass at
>>      the end of file.
>>
>>    - The test assumes std. input is a pipe; reflect this in the runtest
>>      file
>>
>> Regards
>>      Jiri Palecek
>>
>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>> ---
>>   runtest/syscalls                            |    2 +-
>>   testcases/kernel/syscalls/splice/splice02.c |   16 ++++++----------
>>   2 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index 9b7b2ca..33beff0 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1033,7 +1033,7 @@ sockioctl01 sockioctl01
>>    #splice test
>>   splice01 splice01
>> -splice02 echo "Test splice02()" > splice02-temp; splice02 splice02-temp
>> +splice02 seq 1 10000000 | splice02 splice02-temp
>>    tee01 tee01
>>   diff --git a/testcases/kernel/syscalls/splice/splice02.c
>> b/testcases/kernel/syscalls/splice/splice02.c
>> index 321d002..16bff86 100644
>> --- a/testcases/kernel/syscalls/splice/splice02.c
>> +++ b/testcases/kernel/syscalls/splice/splice02.c
>> @@ -108,7 +108,6 @@ void setup() {
>>    int main(int ac, char **av) {
>>   	int fd = 0;
>> -	int ret = 0;
>>   	
>>           setup();
>>   @@ -118,26 +117,23 @@ int main(int ac, char **av) {
>>   	}
>>   	fd=open(av[1], O_WRONLY | O_CREAT | O_TRUNC, 0644);
>>   	if(fd < 0 ) {
>> -           tst_resm(TFAIL, "%s failed - errno = %d : %s", TCID,  
>> TEST_ERRNO,
>> strerror(TEST_ERRNO));
>> +		tst_resm(TFAIL, "open(%s) failed - errno = %d : %s", av[1], errno,
>> strerror(errno));
>>   	   cleanup();
>>   	   tst_exit();
>>   	}
>>   			
>>           do {
>> -	    ret = splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0);
>> -	    if (ret < 0) {
>> -            	tst_resm(TFAIL, "%s failed - errno = %d : %s",TCID,  
>> TEST_ERRNO,
>> strerror(TEST_ERRNO));
>> +					TEST(splice(STDIN_FILENO, NULL, fd, NULL, SPLICE_SIZE, 0));
>> +	    if (TEST_RETURN < 0) {
>> +            	tst_resm(TFAIL, "splice failed - errno = %d : %s",  
>> TEST_ERRNO,
>> strerror(TEST_ERRNO));
>>   	        cleanup();
>>   		tst_exit();
>>   	    } else
>> -            if (ret < SPLICE_SIZE){
>> +            if (TEST_RETURN == 0){
>> +							tst_resm(TPASS, "splice() system call Passed");
>>   	        cleanup();
>>   	        tst_exit();
>>   	    }
>>   	} while(1);
>> -
>> -	close(fd);
>> -        tst_resm(TPASS, "splice() system call Passed");
>> -        tst_exit();
>>   }
>>   -- 1.6.2
>
> Can't apply this patch -- long lines are wrapped. Please re-send it.

It seems not to be caused by wrapped lines - I can still see them in the  
digest. However, some empty lines seem to be lost.

Anyway, it should be better now (see attachment).

Regards
    Jiri Palecek
------------D3cboU09gUBdcXPwsQELZL
Content-Disposition: attachment; filename=0020-Fix-the-splice02-test.patch
Content-Type: application/octet-stream; name=0020-Fix-the-splice02-test.patch
Content-Transfer-Encoding: Base64

RnJvbSAxNDBiZmI0ZWFlY2E3M2U0MDdmNmEyYzY1YTdlYTJkMGNiODBmZDM4IE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFBhbGVjZWsgPGpwYWxl
Y2VrQHdlYi5kZT4KRGF0ZTogVHVlLCAxMiBNYXkgMjAwOSAxODo1MDoxMCArMDIw
MApTdWJqZWN0OiBbUEFUQ0hdIEZpeCB0aGUgc3BsaWNlMDIgdGVzdApDYzogImx0
cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIgPGx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldD4KCiBQYXJ0aWN1bGFybHk6CgogIC0gVEVTVF9FUlJOTyBp
cyBvbmx5IHNldCB3aGVuIHRoZSBzeXNjYWxsIGlzIGV4ZWN1dGVkIHVzaW5nIHRo
ZQogICAgVEVTVCgpIG1hY3JvLiBUaGUgdGVzdHMgZ2F2ZSBiYWQgZXJyb3IgbWVz
c2FnZXMgYmVjYXVzZSBvZiB0aGF0LgoKICAtIFRoZSBlbmQgb2YgdGhlIHRlc3Qg
d2FzIGRlYWQgY29kZTsgbW92ZWQgdGhlIFRQQVNTIGNvZGUgdG8gcGFzcyBhdAog
ICAgdGhlIGVuZCBvZiBmaWxlLgoKICAtIFRoZSB0ZXN0IGFzc3VtZXMgc3RkLiBp
bnB1dCBpcyBhIHBpcGU7IHJlZmxlY3QgdGhpcyBpbiB0aGUgcnVudGVzdAogICAg
ZmlsZQoKU2lnbmVkLW9mZi1ieTogSmlyaSBQYWxlY2VrIDxqcGFsZWNla0B3ZWIu
ZGU+Ci0tLQogcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDIgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNl
L3NwbGljZTAyLmMgfCAgIDE2ICsrKysrKy0tLS0tLS0tLS0KIDIgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwppbmRleCA5
YjdiMmNhLi4zM2JlZmYwIDEwMDY0NAotLS0gYS9ydW50ZXN0L3N5c2NhbGxzCisr
KyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTEwMzMsNyArMTAzMyw3IEBAIHNvY2tp
b2N0bDAxIHNvY2tpb2N0bDAxCiAKICNzcGxpY2UgdGVzdAogc3BsaWNlMDEgc3Bs
aWNlMDEKLXNwbGljZTAyIGVjaG8gIlRlc3Qgc3BsaWNlMDIoKSIgPiBzcGxpY2Uw
Mi10ZW1wOyBzcGxpY2UwMiBzcGxpY2UwMi10ZW1wCitzcGxpY2UwMiBzZXEgMSAx
MDAwMDAwMCB8IHNwbGljZTAyIHNwbGljZTAyLXRlbXAKIAogdGVlMDEgdGVlMDEK
IApkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zcGxpY2Uv
c3BsaWNlMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3BsaWNlL3Nw
bGljZTAyLmMKaW5kZXggMzIxZDAwMi4uMTZiZmY4NiAxMDA2NDQKLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zcGxpY2Uvc3BsaWNlMDIuYworKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NwbGljZS9zcGxpY2UwMi5jCkBAIC0x
MDgsNyArMTA4LDYgQEAgdm9pZCBzZXR1cCgpIHsKIAogaW50IG1haW4oaW50IGFj
LCBjaGFyICoqYXYpIHsKIAlpbnQgZmQgPSAwOwotCWludCByZXQgPSAwOwogCQog
ICAgICAgICBzZXR1cCgpOwogCkBAIC0xMTgsMjYgKzExNywyMyBAQCBpbnQgbWFp
bihpbnQgYWMsIGNoYXIgKiphdikgewogCX0KIAlmZD1vcGVuKGF2WzFdLCBPX1dS
T05MWSB8IE9fQ1JFQVQgfCBPX1RSVU5DLCAwNjQ0KTsKIAlpZihmZCA8IDAgKSB7
Ci0gICAgICAgICAgIHRzdF9yZXNtKFRGQUlMLCAiJXMgZmFpbGVkIC0gZXJybm8g
PSAlZCA6ICVzIiwgVENJRCwgVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJO
TykpOworCQl0c3RfcmVzbShURkFJTCwgIm9wZW4oJXMpIGZhaWxlZCAtIGVycm5v
ID0gJWQgOiAlcyIsIGF2WzFdLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKIAkg
ICBjbGVhbnVwKCk7CiAJICAgdHN0X2V4aXQoKTsKIAl9CiAJCQkKICAgICAgICAg
ZG8gewotCSAgICByZXQgPSBzcGxpY2UoU1RESU5fRklMRU5PLCBOVUxMLCBmZCwg
TlVMTCwgU1BMSUNFX1NJWkUsIDApOwotCSAgICBpZiAocmV0IDwgMCkgewotICAg
ICAgICAgICAgCXRzdF9yZXNtKFRGQUlMLCAiJXMgZmFpbGVkIC0gZXJybm8gPSAl
ZCA6ICVzIixUQ0lELCBURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5PKSk7
CisJCQkJCVRFU1Qoc3BsaWNlKFNURElOX0ZJTEVOTywgTlVMTCwgZmQsIE5VTEws
IFNQTElDRV9TSVpFLCAwKSk7CisJICAgIGlmIChURVNUX1JFVFVSTiA8IDApIHsK
KyAgICAgICAgICAgIAl0c3RfcmVzbShURkFJTCwgInNwbGljZSBmYWlsZWQgLSBl
cnJubyA9ICVkIDogJXMiLCBURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5P
KSk7CiAJICAgICAgICBjbGVhbnVwKCk7CiAJCXRzdF9leGl0KCk7CiAJICAgIH0g
ZWxzZQotICAgICAgICAgICAgaWYgKHJldCA8IFNQTElDRV9TSVpFKXsKKyAgICAg
ICAgICAgIGlmIChURVNUX1JFVFVSTiA9PSAwKXsKKwkJCQkJCQl0c3RfcmVzbShU
UEFTUywgInNwbGljZSgpIHN5c3RlbSBjYWxsIFBhc3NlZCIpOwogCSAgICAgICAg
Y2xlYW51cCgpOwogCSAgICAgICAgdHN0X2V4aXQoKTsKIAkgICAgfQogCX0gd2hp
bGUoMSk7Ci0KLQljbG9zZShmZCk7Ci0gICAgICAgIHRzdF9yZXNtKFRQQVNTLCAi
c3BsaWNlKCkgc3lzdGVtIGNhbGwgUGFzc2VkIik7Ci0gICAgICAgIHRzdF9leGl0
KCk7CiB9CiAKLS0gCjEuNi4yCgo=

------------D3cboU09gUBdcXPwsQELZL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
------------D3cboU09gUBdcXPwsQELZL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------------D3cboU09gUBdcXPwsQELZL--


