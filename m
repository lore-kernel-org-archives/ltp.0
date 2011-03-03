Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PvC93-0000cJ-EU
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 17:16:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvC92-0004Oi-BZ
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 17:16:57 +0000
Message-ID: <4D6FCCF7.2010101@redhat.com>
Date: Fri, 04 Mar 2011 01:16:39 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <20110120143028.4df7ab81@regolo>
	<AANLkTikt-TBmgTSqcRT4OY21udzxpuq-s0yGqirMrWFr@mail.gmail.com>
In-Reply-To: <AANLkTikt-TBmgTSqcRT4OY21udzxpuq-s0yGqirMrWFr@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------070208030300040704000507"
Subject: [LTP] [PATCH] syscalls: acct01: fix testcases [was: Re: [PATCH] Add
 tst_require_root to acct01 testcase.]
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070208030300040704000507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/21/2011 04:28 PM, Garrett Cooper wrote:
> On Thu, Jan 20, 2011 at 5:30 AM, Cristian Greco <cristian@regolo.cc> wrote:
>> > Hi,
>> >
>> > [ please keep CC as I'm not currently subscribed to the list ]
>> >
>> > please find attached a small fix to check for root privileges in
>> > acct(2) testcase (syscalls/acct/acct01.c).
>     Thanks for spotting the issue. I've fixed it, added a few more
> testcases, and discovered what appears to be a kernel bug on 2.6.34
> (acct("/tmp/does/not/exist") should fail with == -1 and errno ==
> ENOTDIR) :)...
> Cheers,
> -Garrett

a follow-up fix for http://article.gmane.org/gmane.linux.ltp/13576 .
In fact, it's not a kernel bug of ENOTDIR's failure. ENOTDIR means that
you setup a string as directory in argument, but it is actually a file.
The patch fixes this failure. The result of given path
/tmp/does/not/exist should be expected as ENOENT.

And also, there is a mistake in EPERM case, to restore the permissions,
SAFE_SETUID should be used instead of SAFE_SETGID, else it will never
recover the permissions.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/acct/acct01.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c
b/testcases/kernel/syscalls/acct/acct01.c
index 5314f4f..324d423 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -96,26 +96,36 @@ int main(int argc, char *argv[])

 	setup();

+	/* EISDIR */
 	if (acct("/") == -1 && errno == EISDIR)
 		tst_resm(TPASS, "Failed with EISDIR as expected");
 	else
 		tst_brkm(TFAIL|TERRNO, cleanup,
 		    "didn't fail as expected; expected EISDIR");

+	/* EACCES */
 	if (acct("/dev/null") == -1 && errno == EACCES)
 		tst_resm(TPASS, "Failed with EACCES as expected");
 	else
 		tst_brkm(TFAIL|TERRNO, cleanup,
 		    "didn't fail as expected; expected EACCES");

-	if (acct("/tmp/does/not/exist") == -1 && errno == ENOTDIR)
+	/* ENOENT */
+	if (acct("/tmp/does/not/exist") == -1 && errno == ENOENT)
+		tst_resm(TPASS, "Failed with ENOENT as expected");
+	else
+		tst_brkm(TBROK|TERRNO, cleanup,
+		    "didn't fail as expected; expected ENOENT");
+
+	/* ENOTDIR */
+	if (acct("/etc/fstab/") == -1 && errno == ENOTDIR)
 		tst_resm(TPASS, "Failed with ENOTDIR as expected");
 	else
 		tst_brkm(TFAIL|TERRNO, cleanup,
 		    "didn't fail as expected; expected ENOTDIR");

+	/* EPERM */
 	sprintf(tmpbuf, "./%s.%d", TCID, getpid());
-
 	fd = SAFE_CREAT(cleanup, tmpbuf, 0777);
 	SAFE_CLOSE(cleanup, fd);

@@ -123,25 +133,17 @@ int main(int argc, char *argv[])
 		tst_brkm(TBROK|TERRNO, cleanup, "acct failed unexpectedly");

 	pwent = SAFE_GETPWNAM(cleanup, "nobody");
-
 	SAFE_SETEUID(cleanup, pwent->pw_uid);

 	if (acct(tmpbuf) == -1 && errno == EPERM)
-		tst_resm(TPASS, "acct failed as expected with EPERM");
+		tst_resm(TPASS, "Failed with EPERM as expected");
 	else
 		tst_brkm(TBROK|TERRNO, cleanup,
-		    "acct didn't fail as expected with EPERM");
-
-	SAFE_SETEGID(cleanup, 0);
+		    "didn't fail as expected; expected EPERM");

+	SAFE_SETEUID(cleanup, 0);
 	SAFE_UNLINK(cleanup, tmpbuf);

-	if (acct(tmpbuf) == -1 && errno == ENOENT)
-		tst_resm(TPASS, "acct failed as expected with ENOENT");
-	else
-		tst_brkm(TBROK|TERRNO, cleanup,
-		    "acct didn't fail as expected with ENOENT");
-
 	cleanup();
 	tst_exit();
 }
-- 
1.7.4.1


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------070208030300040704000507
Content-Type: text/plain;
 name="0002-syscalls-acct01-fix-testcases.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0002-syscalls-acct01-fix-testcases.patch"

RnJvbSA1YzhkMGExZTgzYzg0MzBhOTQ1MTFhNGFiYzRmMDg2MzYyY2Q5NTY2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29t
PgpEYXRlOiBGcmksIDQgTWFyIDIwMTEgMDE6MDE6NTUgKzA4MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gc3lzY2FsbHM6IGFjY3QwMTogZml4IHRlc3RjYXNlcwoKYSBmb2xsb3ctdXAgZml4
IGZvciBodHRwOi8vYXJ0aWNsZS5nbWFuZS5vcmcvZ21hbmUubGludXgubHRwLzEzNTc2IC4K
SW4gZmFjdCwgaXQncyBub3QgYSBrZXJuZWwgYnVnIG9mIEVOT1RESVIncyBmYWlsdXJlLiBF
Tk9URElSIG1lYW5zIHRoYXQKeW91IHNldHVwIGEgc3RyaW5nIGFzIGRpcmVjdG9yeSBpbiBh
cmd1bWVudCwgYnV0IGl0IGlzIGFjdHVhbGx5IGEgZmlsZS4gClRoZSBwYXRjaCBmaXhlcyB0
aGlzIGZhaWx1cmUuIFRoZSByZXN1bHQgb2YgZ2l2ZW4gcGF0aAovdG1wL2RvZXMvbm90L2V4
aXN0IHNob3VsZCBiZSBleHBlY3RlZCBhcyBFTk9FTlQuCgpBbmQgYWxzbywgdGhlcmUgaXMg
YSBtaXN0YWtlIGluIEVQRVJNIGNhc2UsIHRvIHJlc3RvcmUgdGhlIHBlcm1pc3Npb25zLApT
QUZFX1NFVFVJRCBzaG91bGQgYmUgdXNlZCBpbnN0ZWFkIG9mIFNBRkVfU0VUR0lELCBlbHNl
IGl0IHdpbGwgbmV2ZXIKcmVjb3ZlciB0aGUgcGVybWlzc2lvbnMuCgpTaWduZWQtb2ZmLWJ5
OiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvYWNjdC9hY2N0MDEuYyB8ICAgMjggKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FjY3QvYWNj
dDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FjY3QvYWNjdDAxLmMKaW5kZXgg
NTMxNGY0Zi4uMzI0ZDQyMyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9hY2N0L2FjY3QwMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYWNjdC9h
Y2N0MDEuYwpAQCAtOTYsMjYgKzk2LDM2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCiAKIAlzZXR1cCgpOwogCisJLyogRUlTRElSICovCiAJaWYgKGFjY3QoIi8iKSA9
PSAtMSAmJiBlcnJubyA9PSBFSVNESVIpIAogCQl0c3RfcmVzbShUUEFTUywgIkZhaWxlZCB3
aXRoIEVJU0RJUiBhcyBleHBlY3RlZCIpOwogCWVsc2UKIAkJdHN0X2Jya20oVEZBSUx8VEVS
Uk5PLCBjbGVhbnVwLAogCQkgICAgImRpZG4ndCBmYWlsIGFzIGV4cGVjdGVkOyBleHBlY3Rl
ZCBFSVNESVIiKTsKIAorCS8qIEVBQ0NFUyAqLwogCWlmIChhY2N0KCIvZGV2L251bGwiKSA9
PSAtMSAmJiBlcnJubyA9PSBFQUNDRVMpCiAJCXRzdF9yZXNtKFRQQVNTLCAiRmFpbGVkIHdp
dGggRUFDQ0VTIGFzIGV4cGVjdGVkIik7CiAJZWxzZQogCQl0c3RfYnJrbShURkFJTHxURVJS
Tk8sIGNsZWFudXAsCiAJCSAgICAiZGlkbid0IGZhaWwgYXMgZXhwZWN0ZWQ7IGV4cGVjdGVk
IEVBQ0NFUyIpOwogCi0JaWYgKGFjY3QoIi90bXAvZG9lcy9ub3QvZXhpc3QiKSA9PSAtMSAm
JiBlcnJubyA9PSBFTk9URElSKQorCS8qIEVOT0VOVCAqLworCWlmIChhY2N0KCIvdG1wL2Rv
ZXMvbm90L2V4aXN0IikgPT0gLTEgJiYgZXJybm8gPT0gRU5PRU5UKQorCQl0c3RfcmVzbShU
UEFTUywgIkZhaWxlZCB3aXRoIEVOT0VOVCBhcyBleHBlY3RlZCIpOworCWVsc2UKKwkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLAorCQkgICAgImRpZG4ndCBmYWlsIGFzIGV4
cGVjdGVkOyBleHBlY3RlZCBFTk9FTlQiKTsKKworCS8qIEVOT1RESVIgKi8KKwlpZiAoYWNj
dCgiL2V0Yy9mc3RhYi8iKSA9PSAtMSAmJiBlcnJubyA9PSBFTk9URElSKQogCQl0c3RfcmVz
bShUUEFTUywgIkZhaWxlZCB3aXRoIEVOT1RESVIgYXMgZXhwZWN0ZWQiKTsKIAllbHNlCiAJ
CXRzdF9icmttKFRGQUlMfFRFUlJOTywgY2xlYW51cCwKIAkJICAgICJkaWRuJ3QgZmFpbCBh
cyBleHBlY3RlZDsgZXhwZWN0ZWQgRU5PVERJUiIpOwogCisJLyogRVBFUk0gKi8KIAlzcHJp
bnRmKHRtcGJ1ZiwgIi4vJXMuJWQiLCBUQ0lELCBnZXRwaWQoKSk7Ci0KIAlmZCA9IFNBRkVf
Q1JFQVQoY2xlYW51cCwgdG1wYnVmLCAwNzc3KTsKIAlTQUZFX0NMT1NFKGNsZWFudXAsIGZk
KTsKIApAQCAtMTIzLDI1ICsxMzMsMTcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKIAkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiYWNjdCBmYWlsZWQg
dW5leHBlY3RlZGx5Iik7CiAKIAlwd2VudCA9IFNBRkVfR0VUUFdOQU0oY2xlYW51cCwgIm5v
Ym9keSIpOwotCiAJU0FGRV9TRVRFVUlEKGNsZWFudXAsIHB3ZW50LT5wd191aWQpOwogCiAJ
aWYgKGFjY3QodG1wYnVmKSA9PSAtMSAmJiBlcnJubyA9PSBFUEVSTSkKLQkJdHN0X3Jlc20o
VFBBU1MsICJhY2N0IGZhaWxlZCBhcyBleHBlY3RlZCB3aXRoIEVQRVJNIik7CisJCXRzdF9y
ZXNtKFRQQVNTLCAiRmFpbGVkIHdpdGggRVBFUk0gYXMgZXhwZWN0ZWQiKTsKIAllbHNlCiAJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwKLQkJICAgICJhY2N0IGRpZG4ndCBm
YWlsIGFzIGV4cGVjdGVkIHdpdGggRVBFUk0iKTsKLQotCVNBRkVfU0VURUdJRChjbGVhbnVw
LCAwKTsKKwkJICAgICJkaWRuJ3QgZmFpbCBhcyBleHBlY3RlZDsgZXhwZWN0ZWQgRVBFUk0i
KTsKIAorCVNBRkVfU0VURVVJRChjbGVhbnVwLCAwKTsKIAlTQUZFX1VOTElOSyhjbGVhbnVw
LCB0bXBidWYpOwogCi0JaWYgKGFjY3QodG1wYnVmKSA9PSAtMSAmJiBlcnJubyA9PSBFTk9F
TlQpCi0JCXRzdF9yZXNtKFRQQVNTLCAiYWNjdCBmYWlsZWQgYXMgZXhwZWN0ZWQgd2l0aCBF
Tk9FTlQiKTsKLQllbHNlCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwKLQkJ
ICAgICJhY2N0IGRpZG4ndCBmYWlsIGFzIGV4cGVjdGVkIHdpdGggRU5PRU5UIik7Ci0KIAlj
bGVhbnVwKCk7CiAJdHN0X2V4aXQoKTsKIH0KLS0gCjEuNy40LjEKCg==
--------------070208030300040704000507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--------------070208030300040704000507
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070208030300040704000507--

