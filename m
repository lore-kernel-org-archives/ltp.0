Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PvAlb-0006MX-SY
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 15:48:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvAlX-0003Nv-K3
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 15:48:39 +0000
Message-ID: <4D6FB841.1060401@redhat.com>
Date: Thu, 03 Mar 2011 23:48:17 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4D6F3AC9.4040608@redhat.com> <4D6FA7E9.5070200@redhat.com>
In-Reply-To: <4D6FA7E9.5070200@redhat.com>
Content-Type: multipart/mixed; boundary="------------040707090507030408020808"
Subject: Re: [LTP] [PATCH v2] fork13 output too large
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
--------------040707090507030408020808
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oh... I sent the wrong v2 patch. here is the correct PATCH v2. Sorry for
noise...

On 03/03/2011 10:38 PM, Caspar Zhang wrote:

> 
> v2: removed more flooding outputs, return immediately when failure occurs.

fork13 is a test prog backported from upstream mainline:
5fdee8c4a5e1800489ce61963208f8cc55e42ea1. However, it produces flooding
outputs that may cause syscall output log too large (30GB+!!); also
10e+7 times fork is too time consuming, 10e+6 should be valid enough
to reproduce the issue and it takes less time (~3min); if the test
fails, it would put an error msg, this might cause flood error msg in
output log as well, so I make it return immediately when a failure
occurs.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/syscalls                        |    2 +-
 testcases/kernel/syscalls/fork/fork13.c |   29
++++++++++++++++-------------
 2 files changed, 17 insertions(+), 14 deletions(-)

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
index 7c72352..4804ea1 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -86,15 +86,13 @@ int main(int argc, char* argv[])

 void check(void)
 {
-	int lc;
+	long lc;
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
@@ -103,31 +101,36 @@ void check(void)
 			exit(child_exit_code);
 		default:
 			if (lc > 0) {
-				tst_resm(TINFO, "last_pid = %d pid = %d",
-					last_pid, pid);
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
+					return;
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
+				return;
+			}
+			else if (WEXITSTATUS(status) != child_exit_code) {
 				tst_resm(TFAIL, "Unexpected exit status %x, "
-					"iteration %d.", WEXITSTATUS(status),
+					"iteration %ld.", WEXITSTATUS(status),
 					lc);
+				return;
+			}
 		}
 	}
+	tst_resm(TPASS, "%ld pids forked, all passed", lc);
 }

 void setup(void)
@@ -171,9 +174,9 @@ void cleanup(void)
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


--------------040707090507030408020808
Content-Type: text/plain;
 name="0001-fork13-output-too-large.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-fork13-output-too-large.patch"

RnJvbSA0YzFmNmRiNWY0MWRmMmI0YzljNTU0MjNmMDVmZjM3ZDQ4NTU5Zjg1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29t
PgpEYXRlOiBUaHUsIDMgTWFyIDIwMTEgMjI6MjU6MjQgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBmb3JrMTMgb3V0cHV0IHRvbyBsYXJnZQoKZm9yazEzIGlzIGEgdGVzdCBwcm9nIGJhY2tw
b3J0ZWQgZnJvbSB1cHN0cmVhbSBtYWlubGluZToKNWZkZWU4YzRhNWUxODAwNDg5Y2U2MTk2
MzIwOGY4Y2M1NWU0MmVhMS4gSG93ZXZlciwgaXQgcHJvZHVjZXMgZmxvb2RpbmcKb3V0cHV0
cyB0aGF0IG1heSBjYXVzZSBzeXNjYWxsIG91dHB1dCBsb2cgdG9vIGxhcmdlICgzMEdCKyEh
KTsgYWxzbwoxMGUrNyB0aW1lcyBmb3JrIGlzIHRvbyB0aW1lIGNvbnN1bWluZywgMTBlKzYg
c2hvdWxkIGJlIHZhbGlkIGVub3VnaAp0byByZXByb2R1Y2UgdGhlIGlzc3VlIGFuZCBpdCB0
YWtlcyBsZXNzIHRpbWUgKH4zbWluKTsgaWYgdGhlIHRlc3QKZmFpbHMsIGl0IHdvdWxkIHB1
dCBhbiBlcnJvciBtc2csIHRoaXMgbWlnaHQgY2F1c2UgZmxvb2QgZXJyb3IgbXNnIGluCm91
dHB1dCBsb2cgYXMgd2VsbCwgc28gSSBtYWtlIGl0IHJldHVybiBpbW1lZGlhdGVseSB3aGVu
IGEgZmFpbHVyZQpvY2N1cnMuCgpTaWduZWQtb2ZmLWJ5OiBDYXNwYXIgWmhhbmcgPGN6aGFu
Z0ByZWRoYXQuY29tPgotLS0KIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDIgKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMTMu
YyB8ICAgMjkgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcnVu
dGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKaW5kZXggZDQwMjUzMS4uM2JkOWM1
MCAxMDA2NDQKLS0tIGEvcnVudGVzdC9zeXNjYWxscworKysgYi9ydW50ZXN0L3N5c2NhbGxz
CkBAIC0yNzQsNyArMjc0LDcgQEAgZm9yazA4IGZvcmswOAogZm9yazA5IGZvcmswOQogZm9y
azEwIGZvcmsxMAogZm9yazExIGZvcmsxMQotZm9yazEzIGZvcmsxMyAtYyAyIC1pIDEwMDAw
MDAwCitmb3JrMTMgZm9yazEzIC1jIDIgLWkgMTAwMDAwMAogCiBmcGF0aGNvbmYwMSBmcGF0
aGNvbmYwMQogCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zvcmsv
Zm9yazEzLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazEzLmMKaW5k
ZXggN2M3MjM1Mi4uNDgwNGVhMSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mb3JrL2ZvcmsxMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9y
ay9mb3JrMTMuYwpAQCAtODYsMTUgKzg2LDEzIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFy
KiBhcmd2W10pCiAKIHZvaWQgY2hlY2sodm9pZCkKIHsKLQlpbnQgbGM7CisJbG9uZyBsYzsK
IAlwaWRfdCBsYXN0X3BpZCA9IDA7CiAJcGlkX3QgcGlkOwogCWludCBjaGlsZF9leGl0X2Nv
ZGUsIGRpc3RhbmNlLCByZWFwZWQsIHN0YXR1czsKIAogCWZvciAobGMgPSAwOyBURVNUX0xP
T1BJTkcobGMpOyBsYysrKSB7CiAJCVRzdF9jb3VudCA9IDA7Ci0JCWlmIChsYyAlIFBJRE1B
WCA9PSAwKQotCQkJdHN0X3Jlc20oVElORk8sICJJdGVyOiAlZCIsIGxjL1BJRE1BWCk7CiAJ
CWNoaWxkX2V4aXRfY29kZSA9IGxjICUgUkVUVVJOOwogCQlzd2l0Y2ggKHBpZCA9IGZvcmso
KSkgewogCQljYXNlIC0xOgpAQCAtMTAzLDMxICsxMDEsMzYgQEAgdm9pZCBjaGVjayh2b2lk
KQogCQkJZXhpdChjaGlsZF9leGl0X2NvZGUpOwogCQlkZWZhdWx0OgogCQkJaWYgKGxjID4g
MCkgewotCQkJCXRzdF9yZXNtKFRJTkZPLCAibGFzdF9waWQgPSAlZCBwaWQgPSAlZCIsCi0J
CQkJCWxhc3RfcGlkLCBwaWQpOwogCQkJCWRpc3RhbmNlID0gcGlkX2Rpc3RhbmNlKGxhc3Rf
cGlkLCBwaWQpOwotCQkJCWlmIChkaXN0YW5jZSA9PSAwKQorCQkJCWlmIChkaXN0YW5jZSA9
PSAwKSB7CiAJCQkJCXRzdF9yZXNtKFRGQUlMLAogCQkJCQkJIlVuZXhwZWN0ZWQgcGlkIHNl
cXVlbmNlOiAiCiAJCQkJCQkicHJldmlvdXMgZm9yazogcGlkPSVkLCAiCiAJCQkJCQkiY3Vy
cmVudCBmb3JrOiBwaWQ9JWQgZm9yICIKLQkJCQkJCSJpdGVyYXRpb249JWQuIiwgbGFzdF9w
aWQsIHBpZCwKKwkJCQkJCSJpdGVyYXRpb249JWxkLiIsIGxhc3RfcGlkLCBwaWQsCiAJCQkJ
CQlsYyk7CisJCQkJCXJldHVybjsKKwkJCQl9CiAJCQl9CiAJCQlsYXN0X3BpZCA9IHBpZDsK
IAogCQkJcmVhcGVkID0gd2FpdCgmc3RhdHVzKTsKLQkJCWlmIChyZWFwZWQgIT0gcGlkKQor
CQkJaWYgKHJlYXBlZCAhPSBwaWQpIHsKIAkJCQl0c3RfcmVzbShURkFJTCwKIAkJCQkJIldh
aXQgcmV0dXJuIHZhbHVlOiBleHBlY3RlZCBwaWQ9JWQsICIKLQkJCQkJImdvdCAlZCwgaXRl
cmF0aW9uICVkLiIsIHBpZCwgcmVhcGVkLAorCQkJCQkiZ290ICVkLCBpdGVyYXRpb24gJWxk
LiIsIHBpZCwgcmVhcGVkLAogCQkJCQlsYyk7Ci0JCQllbHNlIGlmIChXRVhJVFNUQVRVUyhz
dGF0dXMpICE9IGNoaWxkX2V4aXRfY29kZSkKKwkJCQlyZXR1cm47CisJCQl9CisJCQllbHNl
IGlmIChXRVhJVFNUQVRVUyhzdGF0dXMpICE9IGNoaWxkX2V4aXRfY29kZSkgewogCQkJCXRz
dF9yZXNtKFRGQUlMLCAiVW5leHBlY3RlZCBleGl0IHN0YXR1cyAleCwgIgotCQkJCQkiaXRl
cmF0aW9uICVkLiIsIFdFWElUU1RBVFVTKHN0YXR1cyksCisJCQkJCSJpdGVyYXRpb24gJWxk
LiIsIFdFWElUU1RBVFVTKHN0YXR1cyksCiAJCQkJCWxjKTsKKwkJCQlyZXR1cm47CisJCQl9
CiAJCX0KIAl9CisJdHN0X3Jlc20oVFBBU1MsICIlbGQgcGlkcyBmb3JrZWQsIGFsbCBwYXNz
ZWQiLCBsYyk7CiB9CiAKIHZvaWQgc2V0dXAodm9pZCkKQEAgLTE3MSw5ICsxNzQsOSBAQCB2
b2lkIGNsZWFudXAodm9pZCkKIAlURVNUX0NMRUFOVVA7CiB9CiAKLS8qIFRoZSBkaXN0YW5j
ZSBtb2QgMzI3NjggYmV0d2VlbiB0d28gcGlkcywgd2hlcmUgdGhlIGZpcnN0IHBpZCBpcwor
LyogVGhlIGRpc3RhbmNlIG1vZCBQSURNQVggYmV0d2VlbiB0d28gcGlkcywgd2hlcmUgdGhl
IGZpcnN0IHBpZCBpcwogICAgZXhwZWN0ZWQgdG8gYmUgc21hbGxlciB0aGFuIHRoZSBzZWNv
bmQuICovCiBpbnQgcGlkX2Rpc3RhbmNlKHBpZF90IGZpcnN0LCBwaWRfdCBzZWNvbmQpCiB7
Ci0JcmV0dXJuIChzZWNvbmQgKyAzMjc2OCAtIGZpcnN0KSAlIDMyNzY4OworCXJldHVybiAo
c2Vjb25kICsgUElETUFYIC0gZmlyc3QpICUgUElETUFYOwogfQotLSAKMS43LjQuMQoK
--------------040707090507030408020808
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
--------------040707090507030408020808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040707090507030408020808--

