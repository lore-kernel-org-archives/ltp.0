Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Pv2PS-0006Uc-Qo
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 06:53:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pv2PR-0004Os-NQ
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 06:53:14 +0000
Message-ID: <4D6F3AC9.4040608@redhat.com>
Date: Thu, 03 Mar 2011 14:52:57 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070606010007000801050203"
Subject: [LTP] [PATCH] fork13 output too large
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

This is a multi-part message in MIME format.
--------------070606010007000801050203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all, fork13 is a test program back-ported from upstream mainline:
5fdee8c4a5e1800489ce61963208f8cc55e42ea1, however, this test produces
too many outputs that may cause syscall output log too large (10GB+!!).
Also 10e7 times fork is too time-consuming, 10e6 forking is valid enough
to reproduce the issue and it takes less time (~5min).

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/syscalls                        |    2 +-
 testcases/kernel/syscalls/fork/fork13.c |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index d402531..3bd9c50 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -274,7 +274,7 @@ fork08 fork08
 fork09 fork09
 fork10 fork10
 fork11 fork11
-fork13 fork13 -c 2 -i 10000000
+fork13 fork13 -c 2 -i 1000000

 fpathconf01 fpathconf01

diff --git a/testcases/kernel/syscalls/fork/fork13.c
b/testcases/kernel/syscalls/fork/fork13.c
index 7c72352..e7dd192 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -103,8 +103,6 @@ void check(void)
 			exit(child_exit_code);
 		default:
 			if (lc > 0) {
-				tst_resm(TINFO, "last_pid = %d pid = %d",
-					last_pid, pid);
 				distance = pid_distance(last_pid, pid);
 				if (distance == 0)
 					tst_resm(TFAIL,
-- 
1.7.4.1


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------070606010007000801050203
Content-Type: text/plain;
 name="0002-fork13-output-too-large.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-fork13-output-too-large.patch"

RnJvbSBjMGE0OGE0YzM0N2VlN2E3NTM0Zjk2OTVlN2JjNjZhNjY0OWNiNzUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29t
PgpEYXRlOiBUaHUsIDMgTWFyIDIwMTEgMTQ6NDc6NTUgKzA4MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZm9yazEzIG91dHB1dCB0b28gbGFyZ2UKCkhpIGFsbCwgZm9yazEzIGlzIGEgdGVz
dCBwcm9ncmFtIHBvcnRlZCBmcm9tIHVwc3RyZWFtIG1haW5saW5lOgo1ZmRlZThjNGE1ZTE4
MDA0ODljZTYxOTYzMjA4ZjhjYzU1ZTQyZWExLCBob3dldmVyLCB0aGlzIHRlc3QgcHJvZHVj
ZXMKdG9vIG1hbnkgb3V0cHV0cyB0aGF0IG1heSBjYXVzZSBzeXNjYWxsIG91dHB1dCBsb2cg
dG9vIGxhcmdlICgxMEdCKyEhKS4KQWxzbyAxMGU3IHRpbWVzIGZvcmsgaXMgdG9vIHRpbWUt
Y29uc3VtaW5nLCAxMGU2IGZvcmtpbmcgaXMgdmFsaWQgZW5vdWdoCnRvIHJlcHJvZHVjZSB0
aGUgaXNzdWUgYW5kIGl0IHRha2VzIGxlc3MgdGltZSAofjVtaW4pLgoKU2lnbmVkLW9mZi1i
eTogQ2FzcGFyIFpoYW5nIDxjemhhbmdAcmVkaGF0LmNvbT4KLS0tCiBydW50ZXN0L3N5c2Nh
bGxzICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICstCiB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2ZvcmsvZm9yazEzLmMgfCAgICAyIC0tCiAyIGZpbGVzIGNoYW5nZWQsIDEg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ydW50ZXN0L3N5
c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwppbmRleCBkNDAyNTMxLi4zYmQ5YzUwIDEwMDY0
NAotLS0gYS9ydW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTI3
NCw3ICsyNzQsNyBAQCBmb3JrMDggZm9yazA4CiBmb3JrMDkgZm9yazA5CiBmb3JrMTAgZm9y
azEwCiBmb3JrMTEgZm9yazExCi1mb3JrMTMgZm9yazEzIC1jIDIgLWkgMTAwMDAwMDAKK2Zv
cmsxMyBmb3JrMTMgLWMgMiAtaSAxMDAwMDAwCiAKIGZwYXRoY29uZjAxIGZwYXRoY29uZjAx
CiAKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMTMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMTMuYwppbmRleCA3Yzcy
MzUyLi5lN2RkMTkyIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zv
cmsvZm9yazEzLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2Zvcmsx
My5jCkBAIC0xMDMsOCArMTAzLDYgQEAgdm9pZCBjaGVjayh2b2lkKQogCQkJZXhpdChjaGls
ZF9leGl0X2NvZGUpOwogCQlkZWZhdWx0OgogCQkJaWYgKGxjID4gMCkgewotCQkJCXRzdF9y
ZXNtKFRJTkZPLCAibGFzdF9waWQgPSAlZCBwaWQgPSAlZCIsCi0JCQkJCWxhc3RfcGlkLCBw
aWQpOwogCQkJCWRpc3RhbmNlID0gcGlkX2Rpc3RhbmNlKGxhc3RfcGlkLCBwaWQpOwogCQkJ
CWlmIChkaXN0YW5jZSA9PSAwKQogCQkJCQl0c3RfcmVzbShURkFJTCwKLS0gCjEuNy40LjEK
Cg==
--------------070606010007000801050203
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
--------------070606010007000801050203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070606010007000801050203--

