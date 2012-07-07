Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SnWmG-0001FM-MP
	for ltp-list@lists.sourceforge.net; Sat, 07 Jul 2012 15:18:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SnWmF-00015W-UE
	for ltp-list@lists.sourceforge.net; Sat, 07 Jul 2012 15:18:32 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q67FIQRd011305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Jul 2012 11:18:26 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Sat,  7 Jul 2012 23:14:39 +0800
Message-Id: <f349fd3efe7a762358ed386c9b056f21a7493c6f.1341673870.git.zliu@redhat.com>
In-Reply-To: <9c35b37017094c338a1aced217ef21645db4dd00.1341673870.git.zliu@redhat.com>
References: <9c35b37017094c338a1aced217ef21645db4dd00.1341673870.git.zliu@redhat.com>
In-Reply-To: <9c35b37017094c338a1aced217ef21645db4dd00.1341673870.git.zliu@redhat.com>
References: <9c35b37017094c338a1aced217ef21645db4dd00.1341673870.git.zliu@redhat.com>
Subject: [LTP]  [PATCH] safe_macros: add SAFE_STRTOUL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

commit 586992b33b tried to set ULONG_MAX as SAFE_STRTOL upper bound,
but this would cause the new issue:

 [root@localhost hugeshmat]# ./hugeshmat01
 hugeshmat01    0  TINFO  :  set nr_hugepages to 128
 hugeshmat01    1  TBROK  :  converted value out of range (0 - -1) at mem.c:840
 hugeshmat01    2  TBROK  :  Remaining cases broken
 hugeshmat01    0  TINFO  :  set nr_hugepages to 0

the failure is because SAFE_STRTOL converts ULONG_MAX as long type, which
will change 'ULONG_MAX' as -1.

the patch add a new macro SAFE_STRTOUL, which is a safe mode of strtoul()

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 include/safe_macros.h          |    5 +++++
 lib/safe_macros.c              |   25 +++++++++++++++++++++++++
 testcases/kernel/mem/lib/mem.c |    2 +-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/safe_macros.h b/include/safe_macros.h
index fbfe6cd..3891e19 100644
--- a/include/safe_macros.h
+++ b/include/safe_macros.h
@@ -151,5 +151,10 @@ long safe_strtol(const char *file, const int lineno,
 #define SAFE_STRTOL(cleanup_fn, str, min, max) \
 	safe_strtol(__FILE__, __LINE__, cleanup_fn, (str), (min), (max))
 
+unsigned long safe_strtoul(const char *file, const int lineno, void (cleanup_fn)(void),
+            char *str, unsigned long min, unsigned long max);
+#define SAFE_STRTOUL(cleanup_fn, str, min, max) \
+	safe_strtoul(__FILE__, __LINE__, cleanup_fn, (str), (min), (max))
+
 #endif
 #endif
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 1b27835..4dac3a8 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -363,3 +363,28 @@ long safe_strtol(const char *file, const int lineno,
 
 	return rval;
 }
+
+
+unsigned long safe_strtoul(const char *file, const int lineno, void (cleanup_fn)(void),
+	    char *str, unsigned long min, unsigned long max)
+{
+	unsigned long rval;
+	char *endptr;
+
+	errno = 0;
+	rval = strtoul(str, &endptr, 10);
+	if ((errno == ERANGE && rval == ULONG_MAX)
+		    || (errno != 0 && rval == 0))
+		tst_brkm(TBROK|TERRNO, cleanup_fn,
+			"strtol failed at %s:%d", file, lineno);
+	if (rval > max || rval < min)
+		tst_brkm(TBROK, cleanup_fn,
+			"converted value out of range (%lu - %lu at %s:%d",
+			min, max, file, lineno);
+	if (endptr == str || (*endptr != '\0' && *endptr != '\n'))
+		tst_brkm(TBROK, cleanup_fn,
+			"Invalid value: '%s' at %s:%d", str, file, lineno);
+
+	return rval;
+}
+
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 4db2acf..f746d06 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -836,7 +836,7 @@ void update_shm_size(size_t *shm_size)
 	size_t shmmax;
 
 	read_file(PATH_SHMMAX, buf);
-	shmmax = SAFE_STRTOL(cleanup, buf, 0, ULONG_MAX);
+	shmmax = SAFE_STRTOUL(cleanup, buf, 0, ULONG_MAX);
 	if (*shm_size > shmmax) {
 		tst_resm(TINFO, "Set shm_size to shmmax: %ld", shmmax);
 		*shm_size = shmmax;
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
