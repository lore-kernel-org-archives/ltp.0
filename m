Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZFKo-0004uC-Nb
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 04:14:22 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZFKn-0007yw-IW
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 04:14:22 +0000
Received: by wyb40 with SMTP id 40so12059318wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Jan 2011 20:14:15 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 1 Jan 2011 20:14:15 -0800
Message-ID: <AANLkTi=PvGB+oDjF8D1sVtUrXgAHUuuL8JQ+nzvTqjTa@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cdfd8f8c1e50c0498d5441a
Subject: [LTP] [PATCH] hugemmap05 issues
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
To: CAI Qian <caiqian@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

--000e0cdfd8f8c1e50c0498d5441a
Content-Type: text/plain; charset=ISO-8859-1

    Looking over the code, there are a number of flawed assumptions in
terms of how things are executed and it seems that the code is overly
complex. Before I go and do something rash though, I wanted others to
look at the code (in particular the areas I'm touching) and see
whether or not I'm just blowing something out my rear.
    As-is the code doesn't compile due to warnings.
    This is a WIP patch (please ignore the whitespace and style to a
small degree as I know gmail will fubar the formatting).
Thanks,
-Garrett

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 8893f84..2ea1363 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -97,7 +97,7 @@ static option_t options[] = {
 	{ NULL, NULL,		NULL}
 };
 static void setup(void);
-static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void cleanup(void);
 static void overcommit(void);
 static void write_bytes(void *addr);
 static void read_bytes(void *addr);
@@ -135,6 +135,7 @@ int main(int argc, char *argv[])
 		overcommit();
 	}
 	cleanup();
+	tst_exit();
 }

 static void overcommit(void)
@@ -154,8 +155,15 @@ static void overcommit(void)
 		if (shmid == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 	} else {
-		snprintf(s, BUFSIZ, "%s/hugemmap05/file", get_tmp_tstdir());
-		fd = open(s, O_CREAT | O_RDWR, 0755);
+		char *tmp_tstdir;
+
+		tmp_tstdir = get_tst_tmpdir();
+		if (tmp_tstdir == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "get_tmp_tstdir failed");
+		snprintf(s, BUFSIZ, "%s/hugemmap05/file", tmp_tstdir);
+		free(tmp_tstdir);
+
+		fd = open(s, O_CREAT|O_RDWR, 0755);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open");
 		addr = mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
@@ -195,19 +203,14 @@ static void overcommit(void)
 			return;
 		fclose(fp);
 	}
-	if (shmid != -1) {
-		tst_resm(TINFO, "shmid: 0x%x", shmid);
-		shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
-		if (shmaddr == (void *)-1)
-			tst_brkm(TBROK|TERRNO, cleanup, "shmat");
-		write_bytes(shmaddr);
-		read_bytes(shmaddr);
-        } else {
-		write_bytes(addr);
-		read_bytes(addr);
-	}
+	tst_resm(TINFO, "shmid: 0x%x", shmid);
+	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+	if (shmaddr == (void *)-1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmat");
+	write_bytes(shmaddr);
+	read_bytes(shmaddr);
 	if (opt_sysfs) {
-		tst_resm(TINFO, "check sysfs.");
+		tst_resm(TINFO, "checking sysfs.");
 		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
 				length / 2) != 0)
 			return;
@@ -221,7 +224,7 @@ static void overcommit(void)
 			!= 0)
 			return;
 	} else {
-		tst_resm(TINFO, "check /proc/meminfo.");
+		tst_resm(TINFO, "checking /proc/meminfo.");
 		fp = fopen(_PATH_MEMINFO, "r");
 		if (fp == NULL)
 			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
@@ -236,18 +239,17 @@ static void overcommit(void)
 			return;
 		fclose(fp);
 	}
-	if (shmid != -1) {
-		if (shmdt(shmaddr) != 0)
-			tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
-	} else {
-		munmap(addr, (long)(length * MB));
-		close(fd);
-		unlink(s);
-	}
+	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+	if (shmaddr == (void *)-1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmat failed");
+	if (shmdt(shmaddr) != 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmdt failed");
 }

 static void cleanup(void)
 {
+	char *tmp_tstdir;
+	void *shmaddr;
 	int fd;

 	TEST_CLEANUP;
@@ -262,38 +264,49 @@ static void cleanup(void)
 	fd = open(path, O_WRONLY);
 	if (fd == -1)
 		tst_resm(TWARN|TERRNO, "open");
-	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
-	if (write(fd, nr_hugepages,
-			strlen(nr_hugepages)) != strlen(nr_hugepages))
+	tst_resm(TINFO, "restoring nr_hugepages to %s", nr_hugepages);
+	if (write(fd, nr_hugepages, strlen(nr_hugepages)) !=
+	    strlen(nr_hugepages))
 		tst_resm(TWARN|TERRNO, "write");
 	close(fd);

 	fd = open(pathover, O_WRONLY);
 	if (fd == -1)
 		tst_resm(TWARN|TERRNO, "open");
-	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
+	tst_resm(TINFO, "restoring nr_overcommit_hugepages to %s.",
 		nr_overcommit_hugepages);
 	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
 		!= strlen(nr_overcommit_hugepages))
 		tst_resm(TWARN|TERRNO, "write");
 	close(fd);

-	snprintf(buf, BUFSIZ, "%s/hugemmap05", get_tst_tmpdir());
+	tmp_tstdir = get_tst_tmpdir();
+	if (tmp_tstdir == NULL)
+		tst_brkm(TBROK|TERRNO, NULL, "tmp_tstdir failed");
+	snprintf(buf, BUFSIZ, "%s/hugemmap05", tmp_tstdir);
+	free(tmp_tstdir);
+	shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+	if (shmaddr == (void *)-1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmat");
+	else if (shmdt(shmaddr) == -1)
+		tst_resm(TBROK|TERRNO, "shmdt failed");
+	else if (shmctl(shmid, IPC_RMID, NULL) == -1)
+		tst_resm(TBROK|TERRNO,
+		    "shmctl(..., IPC_RMID, ...) failed");
 	if (umount(buf) == -1)
 		tst_resm(TWARN|TERRNO, "umount");
-	if (shmid != -1) {
-		tst_resm(TINFO|TERRNO, "shmdt");
-		shmctl(shmid, IPC_RMID, NULL);
-	}
+	tst_rmdir();

 }

 static void setup(void)
 {
 	FILE *fp;
+	char *tmp_tstdir;
 	int fd;

 	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_tmpdir();
 	TEST_PAUSE;
 	if (shmid != -1) {
 		fp = fopen(_PATH_SHMMAX, "r");
@@ -332,7 +345,7 @@ static void setup(void)
 		tst_brkm(TBROK|TERRNO, cleanup, "write");
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
-	snprintf(buf, BUFSIZ, "%ld", size);
+	snprintf(buf, BUFSIZ, "%zd", size);
 	if (write(fd, buf, strlen(buf)) != strlen(buf))
 		tst_brkm(TBROK|TERRNO, cleanup,
 			"failed to change nr_hugepages.");
@@ -356,13 +369,18 @@ static void setup(void)
 		tst_brkm(TBROK|TERRNO, cleanup, "write");
 	if (lseek(fd, 0, SEEK_SET) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
-	snprintf(buf, BUFSIZ, "%ld", size);
+	snprintf(buf, BUFSIZ, "%zd", size);
 	if (write(fd, buf, strlen(buf)) != strlen(buf))
 		tst_brkm(TBROK|TERRNO, cleanup,
 			"failed to change nr_hugepages.");
 	close(fd);

-	snprintf(buf, BUFSIZ, "%s/hugemmap05", get_tst_tmpdir());
+	tmp_tstdir = get_tst_tmpdir();
+	if (tmp_tstdir == NULL)
+		tst_brkm(TBROK|TERRNO, NULL, "tmp_tstdir failed");
+	snprintf(buf, BUFSIZ, "%s/hugemmap05", tmp_tstdir);
+	free(tmp_tstdir);
+
 	if (mkdir(buf, 0700) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
 	if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
@@ -447,4 +465,4 @@ static int checkproc(FILE *fp, char *pattern, int value)
 		return 1;
 	}
 	return 0;
-}
\ No newline at end of file
+}

--000e0cdfd8f8c1e50c0498d5441a
Content-Type: application/octet-stream; name="hugemmap05.patch"
Content-Disposition: attachment; filename="hugemmap05.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ghsjm3xt0

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1t
YXAwNS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1
LmMKaW5kZXggODg5M2Y4NC4uMmVhMTM2MyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1LmMKQEAgLTk3LDcgKzk3LDcgQEAgc3RhdGlj
IG9wdGlvbl90IG9wdGlvbnNbXSA9IHsKIAl7IE5VTEwsIE5VTEwsCQlOVUxMfQogfTsKIHN0YXRp
YyB2b2lkIHNldHVwKHZvaWQpOwotc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKSBMVFBfQVRUUklC
VVRFX05PUkVUVVJOOworc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKTsKIHN0YXRpYyB2b2lkIG92
ZXJjb21taXQodm9pZCk7CiBzdGF0aWMgdm9pZCB3cml0ZV9ieXRlcyh2b2lkICphZGRyKTsKIHN0
YXRpYyB2b2lkIHJlYWRfYnl0ZXModm9pZCAqYWRkcik7CkBAIC0xMzUsNiArMTM1LDcgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJb3ZlcmNvbW1pdCgpOwogCX0KIAljbGVh
bnVwKCk7CisJdHN0X2V4aXQoKTsKIH0KIAogc3RhdGljIHZvaWQgb3ZlcmNvbW1pdCh2b2lkKQpA
QCAtMTU0LDggKzE1NSwxNSBAQCBzdGF0aWMgdm9pZCBvdmVyY29tbWl0KHZvaWQpCiAJCWlmIChz
aG1pZCA9PSAtMSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgInNobWdldCIp
OwogCX0gZWxzZSB7Ci0JCXNucHJpbnRmKHMsIEJVRlNJWiwgIiVzL2h1Z2VtbWFwMDUvZmlsZSIs
IGdldF90bXBfdHN0ZGlyKCkpOwotCQlmZCA9IG9wZW4ocywgT19DUkVBVCB8IE9fUkRXUiwgMDc1
NSk7CisJCWNoYXIgKnRtcF90c3RkaXI7CisKKwkJdG1wX3RzdGRpciA9IGdldF90c3RfdG1wZGly
KCk7CisJCWlmICh0bXBfdHN0ZGlyID09IE5VTEwpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJnZXRfdG1wX3RzdGRpciBmYWlsZWQiKTsKKwkJc25wcmludGYocywgQlVGU0la
LCAiJXMvaHVnZW1tYXAwNS9maWxlIiwgdG1wX3RzdGRpcik7CisJCWZyZWUodG1wX3RzdGRpcik7
CisKKwkJZmQgPSBvcGVuKHMsIE9fQ1JFQVR8T19SRFdSLCAwNzU1KTsKIAkJaWYgKGZkID09IC0x
KQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOwogCQlhZGRyID0g
bW1hcChBRERSLCAobG9uZykobGVuZ3RoICogTUIpLCBQUk9URUNUSU9OLCBGTEFHUywgZmQsCkBA
IC0xOTUsMTkgKzIwMywxNCBAQCBzdGF0aWMgdm9pZCBvdmVyY29tbWl0KHZvaWQpCiAJCQlyZXR1
cm47CiAJCWZjbG9zZShmcCk7CiAJfQotCWlmIChzaG1pZCAhPSAtMSkgewotCQl0c3RfcmVzbShU
SU5GTywgInNobWlkOiAweCV4Iiwgc2htaWQpOwotCQlzaG1hZGRyID0gc2htYXQoc2htaWQsIEFE
RFIsIFNITUFUX0ZMQUdTKTsKLQkJaWYgKHNobWFkZHIgPT0gKHZvaWQgKiktMSkKLQkJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgInNobWF0Iik7Ci0JCXdyaXRlX2J5dGVzKHNobWFk
ZHIpOwotCQlyZWFkX2J5dGVzKHNobWFkZHIpOwotICAgICAgICB9IGVsc2UgewotCQl3cml0ZV9i
eXRlcyhhZGRyKTsKLQkJcmVhZF9ieXRlcyhhZGRyKTsKLQl9CisJdHN0X3Jlc20oVElORk8sICJz
aG1pZDogMHgleCIsIHNobWlkKTsKKwlzaG1hZGRyID0gc2htYXQoc2htaWQsIEFERFIsIFNITUFU
X0ZMQUdTKTsKKwlpZiAoc2htYWRkciA9PSAodm9pZCAqKS0xKQorCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJzaG1hdCIpOworCXdyaXRlX2J5dGVzKHNobWFkZHIpOworCXJlYWRf
Ynl0ZXMoc2htYWRkcik7CiAJaWYgKG9wdF9zeXNmcykgewotCQl0c3RfcmVzbShUSU5GTywgImNo
ZWNrIHN5c2ZzLiIpOworCQl0c3RfcmVzbShUSU5GTywgImNoZWNraW5nIHN5c2ZzLiIpOwogCQlp
ZiAoY2hlY2tzeXMoX1BBVEhfU1lTXzJNX0hVR0UsICJIdWdlUGFnZXNfVG90YWwiLAogCQkJCWxl
bmd0aCAvIDIpICE9IDApCiAJCQlyZXR1cm47CkBAIC0yMjEsNyArMjI0LDcgQEAgc3RhdGljIHZv
aWQgb3ZlcmNvbW1pdCh2b2lkKQogCQkJIT0gMCkKIAkJCXJldHVybjsKIAl9IGVsc2UgewotCQl0
c3RfcmVzbShUSU5GTywgImNoZWNrIC9wcm9jL21lbWluZm8uIik7CisJCXRzdF9yZXNtKFRJTkZP
LCAiY2hlY2tpbmcgL3Byb2MvbWVtaW5mby4iKTsKIAkJZnAgPSBmb3BlbihfUEFUSF9NRU1JTkZP
LCAiciIpOwogCQlpZiAoZnAgPT0gTlVMTCkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xl
YW51cCwgImZvcGVuIik7CkBAIC0yMzYsMTggKzIzOSwxNyBAQCBzdGF0aWMgdm9pZCBvdmVyY29t
bWl0KHZvaWQpCiAJCQlyZXR1cm47CiAJCWZjbG9zZShmcCk7CiAJfQotCWlmIChzaG1pZCAhPSAt
MSkgewotCQlpZiAoc2htZHQoc2htYWRkcikgIT0gMCkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgInNobWR0Iik7Ci0JfSBlbHNlIHsKLQkJbXVubWFwKGFkZHIsIChsb25nKShs
ZW5ndGggKiBNQikpOwotCQljbG9zZShmZCk7Ci0JCXVubGluayhzKTsKLQl9CisJc2htYWRkciA9
IHNobWF0KHNobWlkLCBBRERSLCBTSE1BVF9GTEFHUyk7CisJaWYgKHNobWFkZHIgPT0gKHZvaWQg
KiktMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAic2htYXQgZmFpbGVkIik7
CisJaWYgKHNobWR0KHNobWFkZHIpICE9IDApCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xl
YW51cCwgInNobWR0IGZhaWxlZCIpOwogfQogCiBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCiB7
CisJY2hhciAqdG1wX3RzdGRpcjsKKwl2b2lkICpzaG1hZGRyOwogCWludCBmZDsKIAogCVRFU1Rf
Q0xFQU5VUDsKQEAgLTI2MiwzOCArMjY0LDQ5IEBAIHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkK
IAlmZCA9IG9wZW4ocGF0aCwgT19XUk9OTFkpOwogCWlmIChmZCA9PSAtMSkKIAkJdHN0X3Jlc20o
VFdBUk58VEVSUk5PLCAib3BlbiIpOwotCXRzdF9yZXNtKFRJTkZPLCAicmVzdG9yZSBucl9odWdl
cGFnZXMgdG8gJXMuIiwgbnJfaHVnZXBhZ2VzKTsKLQlpZiAod3JpdGUoZmQsIG5yX2h1Z2VwYWdl
cywKLQkJCXN0cmxlbihucl9odWdlcGFnZXMpKSAhPSBzdHJsZW4obnJfaHVnZXBhZ2VzKSkKKwl0
c3RfcmVzbShUSU5GTywgInJlc3RvcmluZyBucl9odWdlcGFnZXMgdG8gJXMiLCBucl9odWdlcGFn
ZXMpOworCWlmICh3cml0ZShmZCwgbnJfaHVnZXBhZ2VzLCBzdHJsZW4obnJfaHVnZXBhZ2VzKSkg
IT0KKwkgICAgc3RybGVuKG5yX2h1Z2VwYWdlcykpCiAJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywg
IndyaXRlIik7CiAJY2xvc2UoZmQpOwogCiAJZmQgPSBvcGVuKHBhdGhvdmVyLCBPX1dST05MWSk7
CiAJaWYgKGZkID09IC0xKQogCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJvcGVuIik7Ci0JdHN0
X3Jlc20oVElORk8sICJyZXN0b3JlIG5yX292ZXJjb21taXRfaHVnZXBhZ2VzIHRvICVzLiIsCisJ
dHN0X3Jlc20oVElORk8sICJyZXN0b3JpbmcgbnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMgdG8gJXMu
IiwKIAkJbnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMpOwogCWlmICh3cml0ZShmZCwgbnJfb3ZlcmNv
bW1pdF9odWdlcGFnZXMsIHN0cmxlbihucl9vdmVyY29tbWl0X2h1Z2VwYWdlcykpCiAJCSE9IHN0
cmxlbihucl9vdmVyY29tbWl0X2h1Z2VwYWdlcykpCiAJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywg
IndyaXRlIik7CiAJY2xvc2UoZmQpOwogCi0Jc25wcmludGYoYnVmLCBCVUZTSVosICIlcy9odWdl
bW1hcDA1IiwgZ2V0X3RzdF90bXBkaXIoKSk7CisJdG1wX3RzdGRpciA9IGdldF90c3RfdG1wZGly
KCk7CisJaWYgKHRtcF90c3RkaXIgPT0gTlVMTCkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBO
VUxMLCAidG1wX3RzdGRpciBmYWlsZWQiKTsKKwlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzL2h1
Z2VtbWFwMDUiLCB0bXBfdHN0ZGlyKTsKKwlmcmVlKHRtcF90c3RkaXIpOworCXNobWFkZHIgPSBz
aG1hdChzaG1pZCwgQUREUiwgU0hNQVRfRkxBR1MpOworCWlmIChzaG1hZGRyID09ICh2b2lkICop
LTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgInNobWF0Iik7CisJZWxzZSBp
ZiAoc2htZHQoc2htYWRkcikgPT0gLTEpCisJCXRzdF9yZXNtKFRCUk9LfFRFUlJOTywgInNobWR0
IGZhaWxlZCIpOworCWVsc2UgaWYgKHNobWN0bChzaG1pZCwgSVBDX1JNSUQsIE5VTEwpID09IC0x
KQorCQl0c3RfcmVzbShUQlJPS3xURVJSTk8sCisJCSAgICAic2htY3RsKC4uLiwgSVBDX1JNSUQs
IC4uLikgZmFpbGVkIik7CiAJaWYgKHVtb3VudChidWYpID09IC0xKQogCQl0c3RfcmVzbShUV0FS
TnxURVJSTk8sICJ1bW91bnQiKTsKLQlpZiAoc2htaWQgIT0gLTEpIHsKLQkJdHN0X3Jlc20oVElO
Rk98VEVSUk5PLCAic2htZHQiKTsKLQkJc2htY3RsKHNobWlkLCBJUENfUk1JRCwgTlVMTCk7Ci0J
fQorCXRzdF9ybWRpcigpOwogCiB9CiAKIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiB7CiAJRklM
RSAqZnA7CisJY2hhciAqdG1wX3RzdGRpcjsKIAlpbnQgZmQ7CiAKIAl0c3Rfc2lnKEZPUkssIERF
Rl9IQU5ETEVSLCBjbGVhbnVwKTsKKwl0c3RfdG1wZGlyKCk7CiAJVEVTVF9QQVVTRTsKIAlpZiAo
c2htaWQgIT0gLTEpIHsKIAkJZnAgPSBmb3BlbihfUEFUSF9TSE1NQVgsICJyIik7CkBAIC0zMzIs
NyArMzQ1LDcgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKIAkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKIAlpZiAobHNlZWsoZmQsIDAsIFNFRUtfU0VUKSA9PSAt
MSkKIAkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibHNlZWsiKTsKLQlzbnByaW50
ZihidWYsIEJVRlNJWiwgIiVsZCIsIHNpemUpOworCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXpk
Iiwgc2l6ZSk7CiAJaWYgKHdyaXRlKGZkLCBidWYsIHN0cmxlbihidWYpKSAhPSBzdHJsZW4oYnVm
KSkKIAkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLAogCQkJImZhaWxlZCB0byBjaGFu
Z2UgbnJfaHVnZXBhZ2VzLiIpOwpAQCAtMzU2LDEzICszNjksMTggQEAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKIAkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKIAlp
ZiAobHNlZWsoZmQsIDAsIFNFRUtfU0VUKSA9PSAtMSkKIAkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAibHNlZWsiKTsKLQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVsZCIsIHNpemUp
OworCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXpkIiwgc2l6ZSk7CiAJaWYgKHdyaXRlKGZkLCBi
dWYsIHN0cmxlbihidWYpKSAhPSBzdHJsZW4oYnVmKSkKIAkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLAogCQkJImZhaWxlZCB0byBjaGFuZ2UgbnJfaHVnZXBhZ2VzLiIpOwogCWNsb3Nl
KGZkKTsKIAotCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMvaHVnZW1tYXAwNSIsIGdldF90c3Rf
dG1wZGlyKCkpOworCXRtcF90c3RkaXIgPSBnZXRfdHN0X3RtcGRpcigpOworCWlmICh0bXBfdHN0
ZGlyID09IE5VTEwpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgInRtcF90c3RkaXIg
ZmFpbGVkIik7CisJc25wcmludGYoYnVmLCBCVUZTSVosICIlcy9odWdlbW1hcDA1IiwgdG1wX3Rz
dGRpcik7CisJZnJlZSh0bXBfdHN0ZGlyKTsKKwogCWlmIChta2RpcihidWYsIDA3MDApID09IC0x
KQogCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJta2RpciIpOwogCWlmIChtb3Vu
dChOVUxMLCBidWYsICJodWdldGxiZnMiLCAwLCBOVUxMKSA9PSAtMSkKQEAgLTQ0Nyw0ICs0NjUs
NCBAQCBzdGF0aWMgaW50IGNoZWNrcHJvYyhGSUxFICpmcCwgY2hhciAqcGF0dGVybiwgaW50IHZh
bHVlKQogCQlyZXR1cm4gMTsKIAl9CiAJcmV0dXJuIDA7Ci19ClwgTm8gbmV3bGluZSBhdCBlbmQg
b2YgZmlsZQorfQo=
--000e0cdfd8f8c1e50c0498d5441a
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
--000e0cdfd8f8c1e50c0498d5441a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cdfd8f8c1e50c0498d5441a--

