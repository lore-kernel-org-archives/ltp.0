Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Pv9g4-0006iS-3g
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 14:38:52 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pv9g3-0004jh-3D
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 14:38:52 +0000
Message-ID: <4D6FA7E9.5070200@redhat.com>
Date: Thu, 03 Mar 2011 22:38:33 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4D6F3AC9.4040608@redhat.com>
In-Reply-To: <4D6F3AC9.4040608@redhat.com>
Content-Type: multipart/mixed; boundary="------------010206080200050404050506"
Subject: [LTP] [PATCH v2] fork13 output too large
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
--------------010206080200050404050506
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fork13 is a test prog backported from upstream mainline:
5fdee8c4a5e1800489ce61963208f8cc55e42ea1. However, it produces flooding
outputs that may cause syscall output log too large (30GB+!!); also
10e+7 times fork is too time consuming, 10e+6 should be valid enough
to reproduce the issue and it takes less time (~3min); if the test
fails, it would put an error msg, this might cause flood error msg in
output log as well, so I make it break the iteration when a failure
occurs.

v2: removed more flooding outputs, return immediately when failure occurs.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/syscalls                        |    2 +-
 testcases/kernel/syscalls/fork/fork13.c |   38
++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 14 deletions(-)

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
index 7c72352..d9dc8b8 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -86,15 +86,14 @@ int main(int argc, char* argv[])

 void check(void)
 {
-	int lc;
+	long lc;
+	int fail = 0;
 	pid_t last_pid = 0;
 	pid_t pid;
 	int child_exit_code, distance, reaped, status;

 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
-		if (lc % PIDMAX == 0)
-			tst_resm(TINFO, "Iter: %d", lc/PIDMAX);
 		child_exit_code = lc % RETURN;
 		switch (pid = fork()) {
 		case -1:
@@ -103,31 +102,44 @@ void check(void)
 			exit(child_exit_code);
 		default:
 			if (lc > 0) {
-				tst_resm(TINFO, "last_pid = %d pid = %d",
-					last_pid, pid);
+				if (lc % PIDMAX == 0)
+					tst_resm(TINFO, "Iter: %ld", lc/PIDMAX);
 				distance = pid_distance(last_pid, pid);
-				if (distance == 0)
+				if (distance == 0) {
 					tst_resm(TFAIL,
 						"Unexpected pid sequence: "
 						"previous fork: pid=%d, "
 						"current fork: pid=%d for "
-						"iteration=%d.", last_pid, pid,
+						"iteration=%ld.", last_pid, pid,
 						lc);
+					fail++;
+					break;
+				}
 			}
 			last_pid = pid;

 			reaped = wait(&status);
-			if (reaped != pid)
+			if (reaped != pid) {
 				tst_resm(TFAIL,
 					"Wait return value: expected pid=%d, "
-					"got %d, iteration %d.", pid, reaped,
+					"got %d, iteration %ld.", pid, reaped,
 					lc);
-			else if (WEXITSTATUS(status) != child_exit_code)
+				fail++;
+				break;
+			}
+			else if (WEXITSTATUS(status) != child_exit_code) {
 				tst_resm(TFAIL, "Unexpected exit status %x, "
-					"iteration %d.", WEXITSTATUS(status),
+					"iteration %ld.", WEXITSTATUS(status),
 					lc);
+				fail++;
+				break;
+			}
 		}
 	}
+	if (fail)
+		tst_resm(TFAIL, "%ld pids forked, failure occured", lc);
+	else
+		tst_resm(TPASS, "%ld pids forked, all passed", lc);
 }

 void setup(void)
@@ -171,9 +183,9 @@ void cleanup(void)
 	TEST_CLEANUP;
 }

-/* The distance mod 32768 between two pids, where the first pid is
+/* The distance mod PIDMAX between two pids, where the first pid is
    expected to be smaller than the second. */
 int pid_distance(pid_t first, pid_t second)
 {
-	return (second + 32768 - first) % 32768;
+	return (second + PIDMAX - first) % PIDMAX;
 }
-- 
1.7.4.1



--------------010206080200050404050506
Content-Type: text/plain;
 name="0001-fork13-output-too-large.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-fork13-output-too-large.patch"

RnJvbSBiMzBmNmYxODRlMjkzNDA1ZmZkZjBmN2I4YTJkMjkzYWZjZDJmODUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29t
PgpEYXRlOiBUaHUsIDMgTWFyIDIwMTEgMjE6NDU6MjUgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBmb3JrMTMgb3V0cHV0IHRvbyBsYXJnZQoKZm9yazEzIGlzIGEgdGVzdCBwcm9nIGJhY2tw
b3J0ZWQgZnJvbSB1cHN0cmVhbSBtYWlubGluZToKNWZkZWU4YzRhNWUxODAwNDg5Y2U2MTk2
MzIwOGY4Y2M1NWU0MmVhMS4gSG93ZXZlciwgaXQgcHJvZHVjZXMgZmxvb2RpbmcKb3V0cHV0
cyB0aGF0IG1heSBjYXVzZSBzeXNjYWxsIG91dHB1dCBsb2cgdG9vIGxhcmdlICgzMEdCKyEh
KTsgYWxzbwoxMGUrNyB0aW1lcyBmb3JrIGlzIHRvbyB0aW1lIGNvbnN1bWluZywgMTBlKzYg
c2hvdWxkIGJlIHZhbGlkIGVub3VnaAp0byByZXByb2R1Y2UgdGhlIGlzc3VlIGFuZCBpdCB0
YWtlcyBsZXNzIHRpbWUgKH4zbWluKTsgaWYgdGhlIHRlc3QKZmFpbHMsIGl0IHdvdWxkIHB1
dCBhbiBlcnJvciBtc2csIHRoaXMgbWlnaHQgY2F1c2UgZmxvb2QgZXJyb3IgbXNnIGluCm91
dHB1dCBsb2cgYXMgd2VsbCwgc28gSSBtYWtlIGl0IGJyZWFrIHRoZSBpdGVyYXRpb24gd2hl
biBhIGZhaWx1cmUKb2NjdXJzLgoKU2lnbmVkLW9mZi1ieTogQ2FzcGFyIFpoYW5nIDxjemhh
bmdAcmVkaGF0LmNvbT4KLS0tCiBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAyICstCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazEz
LmMgfCAgIDM4ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9y
dW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwppbmRleCBkNDAyNTMxLi4zYmQ5
YzUwIDEwMDY0NAotLS0gYS9ydW50ZXN0L3N5c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2Fs
bHMKQEAgLTI3NCw3ICsyNzQsNyBAQCBmb3JrMDggZm9yazA4CiBmb3JrMDkgZm9yazA5CiBm
b3JrMTAgZm9yazEwCiBmb3JrMTEgZm9yazExCi1mb3JrMTMgZm9yazEzIC1jIDIgLWkgMTAw
MDAwMDAKK2ZvcmsxMyBmb3JrMTMgLWMgMiAtaSAxMDAwMDAwCiAKIGZwYXRoY29uZjAxIGZw
YXRoY29uZjAxCiAKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9y
ay9mb3JrMTMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMTMuYwpp
bmRleCA3YzcyMzUyLi5kOWRjOGI4IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2ZvcmsvZm9yazEzLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
b3JrL2ZvcmsxMy5jCkBAIC04NiwxNSArODYsMTQgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIqIGFyZ3ZbXSkKIAogdm9pZCBjaGVjayh2b2lkKQogewotCWludCBsYzsKKwlsb25nIGxj
OworCWludCBmYWlsID0gMDsKIAlwaWRfdCBsYXN0X3BpZCA9IDA7CiAJcGlkX3QgcGlkOwog
CWludCBjaGlsZF9leGl0X2NvZGUsIGRpc3RhbmNlLCByZWFwZWQsIHN0YXR1czsKIAogCWZv
ciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7CiAJCVRzdF9jb3VudCA9IDA7
Ci0JCWlmIChsYyAlIFBJRE1BWCA9PSAwKQotCQkJdHN0X3Jlc20oVElORk8sICJJdGVyOiAl
ZCIsIGxjL1BJRE1BWCk7CiAJCWNoaWxkX2V4aXRfY29kZSA9IGxjICUgUkVUVVJOOwogCQlz
d2l0Y2ggKHBpZCA9IGZvcmsoKSkgewogCQljYXNlIC0xOgpAQCAtMTAzLDMxICsxMDIsNDQg
QEAgdm9pZCBjaGVjayh2b2lkKQogCQkJZXhpdChjaGlsZF9leGl0X2NvZGUpOwogCQlkZWZh
dWx0OgogCQkJaWYgKGxjID4gMCkgewotCQkJCXRzdF9yZXNtKFRJTkZPLCAibGFzdF9waWQg
PSAlZCBwaWQgPSAlZCIsCi0JCQkJCWxhc3RfcGlkLCBwaWQpOworCQkJCWlmIChsYyAlIFBJ
RE1BWCA9PSAwKQorCQkJCQl0c3RfcmVzbShUSU5GTywgIkl0ZXI6ICVsZCIsIGxjL1BJRE1B
WCk7CiAJCQkJZGlzdGFuY2UgPSBwaWRfZGlzdGFuY2UobGFzdF9waWQsIHBpZCk7Ci0JCQkJ
aWYgKGRpc3RhbmNlID09IDApCisJCQkJaWYgKGRpc3RhbmNlID09IDApIHsKIAkJCQkJdHN0
X3Jlc20oVEZBSUwsCiAJCQkJCQkiVW5leHBlY3RlZCBwaWQgc2VxdWVuY2U6ICIKIAkJCQkJ
CSJwcmV2aW91cyBmb3JrOiBwaWQ9JWQsICIKIAkJCQkJCSJjdXJyZW50IGZvcms6IHBpZD0l
ZCBmb3IgIgotCQkJCQkJIml0ZXJhdGlvbj0lZC4iLCBsYXN0X3BpZCwgcGlkLAorCQkJCQkJ
Iml0ZXJhdGlvbj0lbGQuIiwgbGFzdF9waWQsIHBpZCwKIAkJCQkJCWxjKTsKKwkJCQkJZmFp
bCsrOworCQkJCQlicmVhazsKKwkJCQl9CiAJCQl9CiAJCQlsYXN0X3BpZCA9IHBpZDsKIAog
CQkJcmVhcGVkID0gd2FpdCgmc3RhdHVzKTsKLQkJCWlmIChyZWFwZWQgIT0gcGlkKQorCQkJ
aWYgKHJlYXBlZCAhPSBwaWQpIHsKIAkJCQl0c3RfcmVzbShURkFJTCwKIAkJCQkJIldhaXQg
cmV0dXJuIHZhbHVlOiBleHBlY3RlZCBwaWQ9JWQsICIKLQkJCQkJImdvdCAlZCwgaXRlcmF0
aW9uICVkLiIsIHBpZCwgcmVhcGVkLAorCQkJCQkiZ290ICVkLCBpdGVyYXRpb24gJWxkLiIs
IHBpZCwgcmVhcGVkLAogCQkJCQlsYyk7Ci0JCQllbHNlIGlmIChXRVhJVFNUQVRVUyhzdGF0
dXMpICE9IGNoaWxkX2V4aXRfY29kZSkKKwkJCQlmYWlsKys7CisJCQkJYnJlYWs7CisJCQl9
CisJCQllbHNlIGlmIChXRVhJVFNUQVRVUyhzdGF0dXMpICE9IGNoaWxkX2V4aXRfY29kZSkg
ewogCQkJCXRzdF9yZXNtKFRGQUlMLCAiVW5leHBlY3RlZCBleGl0IHN0YXR1cyAleCwgIgot
CQkJCQkiaXRlcmF0aW9uICVkLiIsIFdFWElUU1RBVFVTKHN0YXR1cyksCisJCQkJCSJpdGVy
YXRpb24gJWxkLiIsIFdFWElUU1RBVFVTKHN0YXR1cyksCiAJCQkJCWxjKTsKKwkJCQlmYWls
Kys7CisJCQkJYnJlYWs7CisJCQl9CiAJCX0KIAl9CisJaWYgKGZhaWwpCisJCXRzdF9yZXNt
KFRGQUlMLCAiJWxkIHBpZHMgZm9ya2VkLCBmYWlsdXJlIG9jY3VyZWQiLCBsYyk7CisJZWxz
ZQorCQl0c3RfcmVzbShUUEFTUywgIiVsZCBwaWRzIGZvcmtlZCwgYWxsIHBhc3NlZCIsIGxj
KTsKIH0KIAogdm9pZCBzZXR1cCh2b2lkKQpAQCAtMTcxLDkgKzE4Myw5IEBAIHZvaWQgY2xl
YW51cCh2b2lkKQogCVRFU1RfQ0xFQU5VUDsKIH0KIAotLyogVGhlIGRpc3RhbmNlIG1vZCAz
Mjc2OCBiZXR3ZWVuIHR3byBwaWRzLCB3aGVyZSB0aGUgZmlyc3QgcGlkIGlzCisvKiBUaGUg
ZGlzdGFuY2UgbW9kIFBJRE1BWCBiZXR3ZWVuIHR3byBwaWRzLCB3aGVyZSB0aGUgZmlyc3Qg
cGlkIGlzCiAgICBleHBlY3RlZCB0byBiZSBzbWFsbGVyIHRoYW4gdGhlIHNlY29uZC4gKi8K
IGludCBwaWRfZGlzdGFuY2UocGlkX3QgZmlyc3QsIHBpZF90IHNlY29uZCkKIHsKLQlyZXR1
cm4gKHNlY29uZCArIDMyNzY4IC0gZmlyc3QpICUgMzI3Njg7CisJcmV0dXJuIChzZWNvbmQg
KyBQSURNQVggLSBmaXJzdCkgJSBQSURNQVg7CiB9Ci0tIAoxLjcuNC4xCgo=
--------------010206080200050404050506
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
--------------010206080200050404050506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010206080200050404050506--

