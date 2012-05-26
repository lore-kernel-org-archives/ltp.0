Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SYHmC-00034U-FP
	for ltp-list@lists.sourceforge.net; Sat, 26 May 2012 14:15:28 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SYHmB-0001zX-P1
	for ltp-list@lists.sourceforge.net; Sat, 26 May 2012 14:15:28 +0000
Received: by obhx4 with SMTP id x4so3596503obh.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 26 May 2012 07:15:22 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 26 May 2012 07:15:21 -0700
Message-ID: <CAGH67wQmnoUVOftT8=hL_T7Tv28WdGaQpmL09YQ5LWWqf=9U2w@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=f46d0444ec2d8c4b7d04c0f11df1
Subject: [LTP] [PATCH] Fix the fork/11-1 conformance testcase
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
To: LTP list <ltp-list@lists.sourceforge.net>

--f46d0444ec2d8c4b7d04c0f11df1
Content-Type: text/plain; charset=ISO-8859-1

The testcase tests to see whether or not locks are successfully
inherited across forking processes, as the requirements for fork state
that they should not be. The problem is that the test tests the negative
case for ftrylockfile (!= 0) instead of the positive case, which creates
an erroneous test failure as OUTPUT goes to /dev/stdout and the test
hangs.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
index ffff125..632b0db 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
@@ -85,7 +85,7 @@ void * threaded(void * arg)
        int ret;
        ret = ftrylockfile(stdout);

-       if (ret != 0)
+       if (ret == 0)
        {
                FAILED("The child process is owning the file lock.");
        }
@@ -168,4 +168,4 @@ int main(int argc, char * argv[])
 #endif

        PASSED;
-}
\ No newline at end of file
+}

--f46d0444ec2d8c4b7d04c0f11df1
Content-Type: application/octet-stream; 
	name="0001-Fix-the-fork-11-1-conformance-testcase.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-the-fork-11-1-conformance-testcase.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2orgofq0

RnJvbSA1ODU1MzdmN2ZhNDZiZTgyNGQyNmI5MGQxMjI0NzI0NDdmNTdjZmZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHYXJyZXR0IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29tPgpE
YXRlOiBTYXQsIDI2IE1heSAyMDEyIDA3OjAxOjQzIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gRml4
IHRoZSBmb3JrLzExLTEgY29uZm9ybWFuY2UgdGVzdGNhc2UKTUlNRS1WZXJzaW9uOiAxLjAKQ29u
dGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5PSItLS0tLS0tLS0tLS0xLjcuMTAu
MSIKClRoaXMgaXMgYSBtdWx0aS1wYXJ0IG1lc3NhZ2UgaW4gTUlNRSBmb3JtYXQuCi0tLS0tLS0t
LS0tLS0tMS43LjEwLjEKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04OyBm
b3JtYXQ9Zml4ZWQKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKClRoZSB0ZXN0Y2Fz
ZSB0ZXN0cyB0byBzZWUgd2hldGhlciBvciBub3QgbG9ja3MgYXJlIHN1Y2Nlc3NmdWxseQppbmhl
cml0ZWQgYWNyb3NzIGZvcmtpbmcgcHJvY2Vzc2VzLCBhcyB0aGUgcmVxdWlyZW1lbnRzIGZvciBm
b3JrIHN0YXRlCnRoYXQgdGhleSBzaG91bGQgbm90IGJlLiBUaGUgcHJvYmxlbSBpcyB0aGF0IHRo
ZSB0ZXN0IHRlc3RzIHRoZSBuZWdhdGl2ZQpjYXNlIGZvciBmdHJ5bG9ja2ZpbGUgKCE9IDApIGlu
c3RlYWQgb2YgdGhlIHBvc2l0aXZlIGNhc2UsIHdoaWNoIGNyZWF0ZXMKYW4gZXJyb25lb3VzIHRl
c3QgZmFpbHVyZSBhcyBPVVRQVVQgZ29lcyB0byAvZGV2L3N0ZG91dCBhbmQgdGhlIHRlc3QKaGFu
Z3MuCgpTaWduZWQtb2ZmLWJ5OiBHYXJyZXR0IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29tPgot
LS0KIHRlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2Vz
L2ZvcmsvMTEtMS5jIHwgICAgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKCi0tLS0tLS0tLS0tLS0tMS43LjEwLjEKQ29udGVudC1UeXBlOiB0
ZXh0L3gtcGF0Y2g7IG5hbWU9IjAwMDEtRml4LXRoZS1mb3JrLTExLTEtY29uZm9ybWFuY2UtdGVz
dGNhc2UucGF0Y2giCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKQ29udGVudC1EaXNw
b3NpdGlvbjogYXR0YWNobWVudDsgZmlsZW5hbWU9IjAwMDEtRml4LXRoZS1mb3JrLTExLTEtY29u
Zm9ybWFuY2UtdGVzdGNhc2UucGF0Y2giCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9z
aXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvZm9yay8xMS0xLmMgYi90ZXN0Y2Fz
ZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9mb3JrLzExLTEu
YwppbmRleCBmZmZmMTI1Li42MzJiMGRiIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9mb3JrLzExLTEuYworKysgYi90ZXN0
Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9mb3JrLzEx
LTEuYwpAQCAtODUsNyArODUsNyBAQCB2b2lkICogdGhyZWFkZWQodm9pZCAqIGFyZykKIAlpbnQg
cmV0OwogCXJldCA9IGZ0cnlsb2NrZmlsZShzdGRvdXQpOwogCi0JaWYgKHJldCAhPSAwKQorCWlm
IChyZXQgPT0gMCkKIAl7CiAJCUZBSUxFRCgiVGhlIGNoaWxkIHByb2Nlc3MgaXMgb3duaW5nIHRo
ZSBmaWxlIGxvY2suIik7CiAJfQpAQCAtMTY4LDQgKzE2OCw0IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICogYXJndltdKQogI2VuZGlmCiAKIAlQQVNTRUQ7Ci19ClwgTm8gbmV3bGluZSBhdCBl
bmQgb2YgZmlsZQorfQoKLS0tLS0tLS0tLS0tLS0xLjcuMTAuMS0tCgoK
--f46d0444ec2d8c4b7d04c0f11df1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--f46d0444ec2d8c4b7d04c0f11df1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--f46d0444ec2d8c4b7d04c0f11df1--

