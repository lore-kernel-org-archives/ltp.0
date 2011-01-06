Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PajJu-0008Jr-Is
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 06:27:34 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PajJs-00067v-U4
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 06:27:34 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p066RQtL025517
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 01:27:27 -0500
Date: Thu, 6 Jan 2011 01:27:26 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <118966330.150220.1294295246942.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <166765907.150217.1294295241229.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_150219_1538396030.1294295246941"
Subject: [LTP] [PATCH] oom: additonal fixes
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

------=_Part_150219_1538396030.1294295246941
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

There are some bugs for the latest oom series and some cleanup.
- oom01: with overcommit=2 is looping due to no check for return
  from mmap.
- oom03: should not check for cpuset since it is a non-NUMA test.
- oom02/oom04: fix cpuset prefix.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/lib/oom.c |   20 +++++++++++++-------
 testcases/kernel/mem/oom/lib/oom.h |    4 ++--
 testcases/kernel/mem/oom/oom01.c   |   10 ++--------
 testcases/kernel/mem/oom/oom02.c   |    4 ++--
 testcases/kernel/mem/oom/oom03.c   |    4 ++--
 testcases/kernel/mem/oom/oom04.c   |    8 ++++----
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/mem/oom/lib/oom.c b/testcases/kernel/mem/oom/lib/oom.c
index f0f1dac..ba37a7f 100644
--- a/testcases/kernel/mem/oom/lib/oom.c
+++ b/testcases/kernel/mem/oom/lib/oom.c
@@ -22,7 +22,10 @@ void oom(int testcase, int mempolicy, int lite)
 {
 	pid_t pid;
 	int status;
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
 	unsigned long nmask = 2;
+#endif
 
 	switch(pid = fork()) {
 	case -1:
@@ -55,24 +58,24 @@ void oom(int testcase, int mempolicy, int lite)
 	}
 }
 
-void testoom(int mempolicy, int lite)
+void testoom(int mempolicy, int lite, int numa)
 {
 	int fd;
 	char buf[BUFSIZ] = "";
 	char cpus[BUFSIZ] = "";
 
-	if (!mempolicy) {
+	if (numa && !mempolicy) {
 		gather_cpus(cpus);
 		tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
 
-		fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
+		fd = open(CPATH_NEW "/mems", O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		if (write(fd, "1", 1) != 1)
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
 
-		fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
+		fd = open(CPATH_NEW "/cpus", O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
@@ -137,7 +140,7 @@ void gather_cpus(char *cpus)
 	cpus[strlen(cpus) - 1] = '\0';
 }
 
-void alloc_mem(long int length, int testcase)
+int alloc_mem(long int length, int testcase)
 {
 	void *s;
 
@@ -146,7 +149,7 @@ void alloc_mem(long int length, int testcase)
 		MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	if (s == MAP_FAILED) {
 		if (testcase == OVERCOMMIT && errno == ENOMEM)
-			return;
+			return 1;
 		else
 			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
 	}
@@ -156,6 +159,8 @@ void alloc_mem(long int length, int testcase)
 		&& madvise(s, length, MADV_MERGEABLE) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
 	memset(s, '\a', length);
+
+	return 0;
 }
 
 void test_alloc(int testcase, int lite)
@@ -164,7 +169,8 @@ void test_alloc(int testcase, int lite)
 		alloc_mem(TESTMEM + MB, testcase);
 	else
 		while(1)
-			alloc_mem(LENGTH, testcase);
+			if (alloc_mem(LENGTH, testcase))
+				return;
 }
 
 void umount_mem(char *path, char *path_new)
diff --git a/testcases/kernel/mem/oom/lib/oom.h b/testcases/kernel/mem/oom/lib/oom.h
index d40bc89..e7958bf 100644
--- a/testcases/kernel/mem/oom/lib/oom.h
+++ b/testcases/kernel/mem/oom/lib/oom.h
@@ -19,10 +19,10 @@
 char overcommit[BUFSIZ];
 
 void oom(int testcase, int mempolicy, int lite);
-void testoom(int mempolicy, int lite);
+void testoom(int mempolicy, int lite, int numa);
 long count_numa(void);
 int path_exist(const char *path, ...);
-void alloc_mem(long int length, int testcase);
+int alloc_mem(long int length, int testcase);
 void test_alloc(int testcase, int lite);
 void gather_cpus(char *cpus);
 void umount_mem(char *path, char *path_new);
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 0076ada..8fb58c3 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -79,18 +79,12 @@ int main(int argc, char *argv[])
 			tst_brkm(TBROK|TERRNO, cleanup, "write");
 		oom(OVERCOMMIT, 0, 0);
 
-		tst_resm(TINFO, "start normal OOM testing.");
 		if (lseek(fd, SEEK_SET, 0) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
 		if (write(fd, "1", 1) != 1)
 			tst_brkm(TBROK|TERRNO, cleanup, "write");
-		oom(NORMAL, 0, 0);
-
-		tst_resm(TINFO, "start OOM testing for mlocked pages.");
-		oom(MLOCK, 0, 0);
-
-		tst_resm(TINFO, "start OOM testing for KSM pages.");
-		oom(KSM, 0, 0);
+		close(fd);
+		testoom(0, 0, 0);
 	}
 	cleanup();
 }
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 22b811d..38533ef 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -78,10 +78,10 @@ int main(int argc, char *argv[])
 		close(fd);
 
 		tst_resm(TINFO, "process mempolicy.");
-		testoom(1, 0);
+		testoom(1, 0, 1);
 
 		tst_resm(TINFO, "process cpuset.");
-		testoom(0, 0);
+		testoom(0, 0, 1);
 	}
 	cleanup();
 }
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index cecaa9f..12c2063 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -84,7 +84,7 @@ int main(int argc, char *argv[])
 		if (write(fd, buf, strlen(buf)) != strlen(buf))
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
-		testoom(0, 0);
+		testoom(0, 0, 0);
 
 		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
 			O_WRONLY);
@@ -93,7 +93,7 @@ int main(int argc, char *argv[])
 		if (write(fd, mem, strlen(mem)) != strlen(mem))
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
-		testoom(0, 1);
+		testoom(0, 1, 0);
 	}
 	cleanup();
 }
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 0f04591..5b403f4 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 		close(fd);
 
 		tst_resm(TINFO, "process mempolicy.");
-		testoom(1, 0);
+		testoom(1, 0, 1);
 
 		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
 			O_WRONLY);
@@ -104,7 +104,7 @@ int main(int argc, char *argv[])
 		if (write(fd, mem, strlen(mem)) != strlen(mem))
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
-		testoom(1, 1);
+		testoom(1, 1, 1);
 
 		tst_resm(TINFO, "process cpuset.");
 		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
@@ -115,7 +115,7 @@ int main(int argc, char *argv[])
 		if (write(fd, "-1", 2) != 2)
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
-		testoom(0, 0);
+		testoom(0, 0, 1);
 
 		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
 			O_WRONLY);
@@ -124,7 +124,7 @@ int main(int argc, char *argv[])
 		if (write(fd, mem, strlen(mem)) != strlen(mem))
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
-		testoom(0, 1);
+		testoom(0, 1, 1);
 	}
 	cleanup();
 }
-- 
1.7.3.2
------=_Part_150219_1538396030.1294295246941
Content-Type: text/x-patch; name=0001-oom-additonal-fixes.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-oom-additonal-fixes.patch

RnJvbSBkZDliNzE4ZjMyMWQ4OWY0MWNmMTljZDgzYjY5ZDMyYjIxYWVjZTdiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
aHUsIDYgSmFuIDIwMTEgMTQ6MjE6NDcgKzA4MDAKU3ViamVjdDogW1BBVENIXSBvb206IGFkZGl0
b25hbCBmaXhlcwoKVGhlcmUgYXJlIHNvbWUgYnVncyBmb3IgdGhlIGxhdGVzdCBvb20gc2VyaWVz
IGFuZCBzb21lIGNsZWFudXAuCi0gb29tMDE6IHdpdGggb3ZlcmNvbW1pdD0yIGlzIGxvb3Bpbmcg
ZHVlIHRvIG5vIGNoZWNrIGZvciByZXR1cm4KICBmcm9tIG1tYXAuCi0gb29tMDM6IHNob3VsZCBu
b3QgY2hlY2sgZm9yIGNwdXNldCBzaW5jZSBpdCBpcyBhIG5vbi1OVU1BIHRlc3QuCi0gb29tMDIv
b29tMDQ6IGZpeCBjcHVzZXQgcHJlZml4LgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFp
YW5AcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vbGliL29vbS5jIHwg
ICAyMCArKysrKysrKysrKysrLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL2xpYi9v
b20uaCB8ICAgIDQgKystLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAxLmMgICB8ICAg
MTAgKystLS0tLS0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAyLmMgICB8ICAgIDQg
KystLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgICB8ICAgIDQgKystLQogdGVz
dGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTA0LmMgICB8ICAgIDggKysrKy0tLS0KIDYgZmlsZXMg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL2xpYi9vb20uYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L29vbS9saWIvb29tLmMKaW5kZXggZjBmMWRhYy4uYmEzN2E3ZiAxMDA2NDQKLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vb29tL2xpYi9vb20uYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9v
b20vbGliL29vbS5jCkBAIC0yMiw3ICsyMiwxMCBAQCB2b2lkIG9vbShpbnQgdGVzdGNhc2UsIGlu
dCBtZW1wb2xpY3ksIGludCBsaXRlKQogewogCXBpZF90IHBpZDsKIAlpbnQgc3RhdHVzOworI2lm
IEhBVkVfTlVNQV9IICYmIEhBVkVfTElOVVhfTUVNUE9MSUNZX0ggJiYgSEFWRV9OVU1BSUZfSCBc
CisJJiYgSEFWRV9NUE9MX0NPTlNUQU5UUwogCXVuc2lnbmVkIGxvbmcgbm1hc2sgPSAyOworI2Vu
ZGlmCiAKIAlzd2l0Y2gocGlkID0gZm9yaygpKSB7CiAJY2FzZSAtMToKQEAgLTU1LDI0ICs1OCwy
NCBAQCB2b2lkIG9vbShpbnQgdGVzdGNhc2UsIGludCBtZW1wb2xpY3ksIGludCBsaXRlKQogCX0K
IH0KIAotdm9pZCB0ZXN0b29tKGludCBtZW1wb2xpY3ksIGludCBsaXRlKQordm9pZCB0ZXN0b29t
KGludCBtZW1wb2xpY3ksIGludCBsaXRlLCBpbnQgbnVtYSkKIHsKIAlpbnQgZmQ7CiAJY2hhciBi
dWZbQlVGU0laXSA9ICIiOwogCWNoYXIgY3B1c1tCVUZTSVpdID0gIiI7CiAKLQlpZiAoIW1lbXBv
bGljeSkgeworCWlmIChudW1hICYmICFtZW1wb2xpY3kpIHsKIAkJZ2F0aGVyX2NwdXMoY3B1cyk7
CiAJCXRzdF9yZXNtKFRJTkZPLCAiQ1BVIGxpc3QgZm9yIDJuZCBub2RlIGlzICVzLiIsIGNwdXMp
OwogCi0JCWZkID0gb3BlbihDUEFUSF9ORVcgIi9jcHVzZXQubWVtcyIsIE9fV1JPTkxZKTsKKwkJ
ZmQgPSBvcGVuKENQQVRIX05FVyAiL21lbXMiLCBPX1dST05MWSk7CiAJCWlmIChmZCA9PSAtMSkK
IAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOwogCQlp
ZiAod3JpdGUoZmQsICIxIiwgMSkgIT0gMSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xl
YW51cCwgIndyaXRlICVzIiwgYnVmKTsKIAkJY2xvc2UoZmQpOwogCi0JCWZkID0gb3BlbihDUEFU
SF9ORVcgIi9jcHVzZXQuY3B1cyIsIE9fV1JPTkxZKTsKKwkJZmQgPSBvcGVuKENQQVRIX05FVyAi
L2NwdXMiLCBPX1dST05MWSk7CiAJCWlmIChmZCA9PSAtMSkKIAkJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOwogCQlpZiAod3JpdGUoZmQsIGNwdXMsIHN0
cmxlbihjcHVzKSkgIT0gc3RybGVuKGNwdXMpKQpAQCAtMTM3LDcgKzE0MCw3IEBAIHZvaWQgZ2F0
aGVyX2NwdXMoY2hhciAqY3B1cykKIAljcHVzW3N0cmxlbihjcHVzKSAtIDFdID0gJ1wwJzsKIH0K
IAotdm9pZCBhbGxvY19tZW0obG9uZyBpbnQgbGVuZ3RoLCBpbnQgdGVzdGNhc2UpCitpbnQgYWxs
b2NfbWVtKGxvbmcgaW50IGxlbmd0aCwgaW50IHRlc3RjYXNlKQogewogCXZvaWQgKnM7CiAKQEAg
LTE0Niw3ICsxNDksNyBAQCB2b2lkIGFsbG9jX21lbShsb25nIGludCBsZW5ndGgsIGludCB0ZXN0
Y2FzZSkKIAkJTUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSwgLTEsIDApOwogCWlmIChzID09IE1B
UF9GQUlMRUQpIHsKIAkJaWYgKHRlc3RjYXNlID09IE9WRVJDT01NSVQgJiYgZXJybm8gPT0gRU5P
TUVNKQotCQkJcmV0dXJuOworCQkJcmV0dXJuIDE7CiAJCWVsc2UKIAkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgIm1tYXAiKTsKIAl9CkBAIC0xNTYsNiArMTU5LDggQEAgdm9pZCBh
bGxvY19tZW0obG9uZyBpbnQgbGVuZ3RoLCBpbnQgdGVzdGNhc2UpCiAJCSYmIG1hZHZpc2Uocywg
bGVuZ3RoLCBNQURWX01FUkdFQUJMRSkgPT0gLTEpCiAJCXRzdF9icmttKFRCUk9LfFRFUlJOTywg
Y2xlYW51cCwgIm1hZHZpc2UiKTsKIAltZW1zZXQocywgJ1xhJywgbGVuZ3RoKTsKKworCXJldHVy
biAwOwogfQogCiB2b2lkIHRlc3RfYWxsb2MoaW50IHRlc3RjYXNlLCBpbnQgbGl0ZSkKQEAgLTE2
NCw3ICsxNjksOCBAQCB2b2lkIHRlc3RfYWxsb2MoaW50IHRlc3RjYXNlLCBpbnQgbGl0ZSkKIAkJ
YWxsb2NfbWVtKFRFU1RNRU0gKyBNQiwgdGVzdGNhc2UpOwogCWVsc2UKIAkJd2hpbGUoMSkKLQkJ
CWFsbG9jX21lbShMRU5HVEgsIHRlc3RjYXNlKTsKKwkJCWlmIChhbGxvY19tZW0oTEVOR1RILCB0
ZXN0Y2FzZSkpCisJCQkJcmV0dXJuOwogfQogCiB2b2lkIHVtb3VudF9tZW0oY2hhciAqcGF0aCwg
Y2hhciAqcGF0aF9uZXcpCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vbGli
L29vbS5oIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL2xpYi9vb20uaAppbmRleCBkNDBiYzg5
Li5lNzk1OGJmIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vbGliL29vbS5o
CisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9saWIvb29tLmgKQEAgLTE5LDEwICsxOSwx
MCBAQAogY2hhciBvdmVyY29tbWl0W0JVRlNJWl07CiAKIHZvaWQgb29tKGludCB0ZXN0Y2FzZSwg
aW50IG1lbXBvbGljeSwgaW50IGxpdGUpOwotdm9pZCB0ZXN0b29tKGludCBtZW1wb2xpY3ksIGlu
dCBsaXRlKTsKK3ZvaWQgdGVzdG9vbShpbnQgbWVtcG9saWN5LCBpbnQgbGl0ZSwgaW50IG51bWEp
OwogbG9uZyBjb3VudF9udW1hKHZvaWQpOwogaW50IHBhdGhfZXhpc3QoY29uc3QgY2hhciAqcGF0
aCwgLi4uKTsKLXZvaWQgYWxsb2NfbWVtKGxvbmcgaW50IGxlbmd0aCwgaW50IHRlc3RjYXNlKTsK
K2ludCBhbGxvY19tZW0obG9uZyBpbnQgbGVuZ3RoLCBpbnQgdGVzdGNhc2UpOwogdm9pZCB0ZXN0
X2FsbG9jKGludCB0ZXN0Y2FzZSwgaW50IGxpdGUpOwogdm9pZCBnYXRoZXJfY3B1cyhjaGFyICpj
cHVzKTsKIHZvaWQgdW1vdW50X21lbShjaGFyICpwYXRoLCBjaGFyICpwYXRoX25ldyk7CmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtL29vbS9vb20wMS5jCmluZGV4IDAwNzZhZGEuLjhmYjU4YzMgMTAwNjQ0Ci0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L29vbS9vb20wMS5jCkBAIC03OSwxOCArNzksMTIgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlIik7CiAJ
CW9vbShPVkVSQ09NTUlULCAwLCAwKTsKIAotCQl0c3RfcmVzbShUSU5GTywgInN0YXJ0IG5vcm1h
bCBPT00gdGVzdGluZy4iKTsKIAkJaWYgKGxzZWVrKGZkLCBTRUVLX1NFVCwgMCkgPT0gLTEpCiAJ
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJsc2VlayIpOwogCQlpZiAod3JpdGUo
ZmQsICIxIiwgMSkgIT0gMSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndy
aXRlIik7Ci0JCW9vbShOT1JNQUwsIDAsIDApOwotCi0JCXRzdF9yZXNtKFRJTkZPLCAic3RhcnQg
T09NIHRlc3RpbmcgZm9yIG1sb2NrZWQgcGFnZXMuIik7Ci0JCW9vbShNTE9DSywgMCwgMCk7Ci0K
LQkJdHN0X3Jlc20oVElORk8sICJzdGFydCBPT00gdGVzdGluZyBmb3IgS1NNIHBhZ2VzLiIpOwot
CQlvb20oS1NNLCAwLCAwKTsKKwkJY2xvc2UoZmQpOworCQl0ZXN0b29tKDAsIDAsIDApOwogCX0K
IAljbGVhbnVwKCk7CiB9CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29t
MDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jCmluZGV4IDIyYjgxMWQuLjM4
NTMzZWYgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jCisrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jCkBAIC03OCwxMCArNzgsMTAgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJY2xvc2UoZmQpOwogCiAJCXRzdF9yZXNt
KFRJTkZPLCAicHJvY2VzcyBtZW1wb2xpY3kuIik7Ci0JCXRlc3Rvb20oMSwgMCk7CisJCXRlc3Rv
b20oMSwgMCwgMSk7CiAKIAkJdHN0X3Jlc20oVElORk8sICJwcm9jZXNzIGNwdXNldC4iKTsKLQkJ
dGVzdG9vbSgwLCAwKTsKKwkJdGVzdG9vbSgwLCAwLCAxKTsKIAl9CiAJY2xlYW51cCgpOwogfQpk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgYi90ZXN0Y2FzZXMv
a2VybmVsL21lbS9vb20vb29tMDMuYwppbmRleCBjZWNhYTlmLi4xMmMyMDYzIDEwMDY0NAotLS0g
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS9vb20vb29tMDMuYwpAQCAtODQsNyArODQsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQogCQlpZiAod3JpdGUoZmQsIGJ1Ziwgc3RybGVuKGJ1ZikpICE9IHN0cmxlbihi
dWYpKQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYp
OwogCQljbG9zZShmZCk7Ci0JCXRlc3Rvb20oMCwgMCk7CisJCXRlc3Rvb20oMCwgMCwgMCk7CiAK
IAkJZmQgPSBvcGVuKE1FTUNHX1BBVEhfTkVXICIvbWVtb3J5Lm1lbXN3LmxpbWl0X2luX2J5dGVz
IiwKIAkJCU9fV1JPTkxZKTsKQEAgLTkzLDcgKzkzLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkKIAkJaWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxlbihtZW0pKSAhPSBzdHJsZW4o
bWVtKSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVm
KTsKIAkJY2xvc2UoZmQpOwotCQl0ZXN0b29tKDAsIDEpOworCQl0ZXN0b29tKDAsIDEsIDApOwog
CX0KIAljbGVhbnVwKCk7CiB9CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20v
b29tMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCmluZGV4IDBmMDQ1OTEu
LjViNDAzZjQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCkBAIC05NSw3ICs5NSw3IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJCWNsb3NlKGZkKTsKIAogCQl0c3RfcmVz
bShUSU5GTywgInByb2Nlc3MgbWVtcG9saWN5LiIpOwotCQl0ZXN0b29tKDEsIDApOworCQl0ZXN0
b29tKDEsIDAsIDEpOwogCiAJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL21lbW9yeS5tZW1z
dy5saW1pdF9pbl9ieXRlcyIsCiAJCQlPX1dST05MWSk7CkBAIC0xMDQsNyArMTA0LDcgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJaWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxl
bihtZW0pKSAhPSBzdHJsZW4obWVtKSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIndyaXRlICVzIiwgYnVmKTsKIAkJY2xvc2UoZmQpOwotCQl0ZXN0b29tKDEsIDEpOworCQl0
ZXN0b29tKDEsIDEsIDEpOwogCiAJCXRzdF9yZXNtKFRJTkZPLCAicHJvY2VzcyBjcHVzZXQuIik7
CiAJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL21lbW9yeS5tZW1zdy5saW1pdF9pbl9ieXRl
cyIsCkBAIC0xMTUsNyArMTE1LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
IAkJaWYgKHdyaXRlKGZkLCAiLTEiLCAyKSAhPSAyKQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOwogCQljbG9zZShmZCk7Ci0JCXRlc3Rvb20oMCwg
MCk7CisJCXRlc3Rvb20oMCwgMCwgMSk7CiAKIAkJZmQgPSBvcGVuKE1FTUNHX1BBVEhfTkVXICIv
bWVtb3J5Lm1lbXN3LmxpbWl0X2luX2J5dGVzIiwKIAkJCU9fV1JPTkxZKTsKQEAgLTEyNCw3ICsx
MjQsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQlpZiAod3JpdGUoZmQs
IG1lbSwgc3RybGVuKG1lbSkpICE9IHN0cmxlbihtZW0pKQogCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOwogCQljbG9zZShmZCk7Ci0JCXRlc3Rvb20o
MCwgMSk7CisJCXRlc3Rvb20oMCwgMSwgMSk7CiAJfQogCWNsZWFudXAoKTsKIH0KLS0gCjEuNy4z
LjIKCg==
------=_Part_150219_1538396030.1294295246941
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_150219_1538396030.1294295246941
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_150219_1538396030.1294295246941--

