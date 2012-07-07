Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SnWmG-0000M3-6m
	for ltp-list@lists.sourceforge.net; Sat, 07 Jul 2012 15:18:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SnWmE-00015J-Vv
	for ltp-list@lists.sourceforge.net; Sat, 07 Jul 2012 15:18:32 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q67FIOX5023020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Jul 2012 11:18:24 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Sat,  7 Jul 2012 23:14:38 +0800
Message-Id: <9c35b37017094c338a1aced217ef21645db4dd00.1341673870.git.zliu@redhat.com>
Subject: [LTP] [PATCH] hugetlb: add a new function get_available_hugepages
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

on some systems with small RAM, there aren't enough memory
to set as specific hugepages, such as 128 hugepages, it will
fail like this:
 [root@localhost hugemmap]# ./hugemmap01
 hugemmap01    0  TINFO  :  set nr_hugepages to 128
 hugemmap01    1  TBROK  :  nr_hugepages = 55, but expect 128
 hugemmap01    2  TBROK  :  Remaining cases broken
 hugemmap01    0  TINFO  :  set nr_hugepages to 54

we can detect whether the system has the power to get the specific
hugepages through the following commands:

 [root@localhost hugemmap]# echo 128 > /proc/sys/vm/nr_hugepages
 [root@localhost hugemmap]# cat /proc/sys/vm/nr_hugepages
 55

as we know, on this system, there are 55 available hugepages, so we
can set 55 hugepages to continue the case, but to exit the case,
and this is desinged into get_available_hugepages() functions.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c     |    1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c     |    2 ++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c     |    2 ++
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c     |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c   |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c   |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c   |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c   |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c |    2 ++
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c |    2 ++
 testcases/kernel/mem/include/mem.h                     |    2 ++
 testcases/kernel/mem/lib/mem.c                         |   13 +++++++++++++
 17 files changed, 44 insertions(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 1140d8b..5e692d2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -168,6 +168,7 @@ void setup(void)
 			 "mount failed on %s", Hopt);
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
 		 Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index 7b2fb68..c7786c6 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -193,6 +193,8 @@ void setup(void)
 		tst_brkm(TBROK|TERRNO, NULL,
 			 "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
 		 Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
index 2dff4c5..e8d0a1a 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
@@ -131,6 +131,8 @@ void setup(void)
 			 "mount failed on %s", Hopt);
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 554eaae..3f4e095 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -183,6 +183,8 @@ void setup(void)
 		tst_brkm(TBROK|TERRNO, NULL,
 			 "mount failed on %s", Hopt);
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
 		 Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 2f8db05..84a9121 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -216,6 +216,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 17f30a7..2e91d2e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -131,6 +131,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 2808797..97cb4bf 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -138,6 +138,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index ffa94ae..dc0893c 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -412,6 +412,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 7a16e4e..e0aedf8 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -136,6 +136,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 7eef7c7..19ae513 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -162,6 +162,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 35593cf..0f3c262 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -175,6 +175,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 72bae00..bf68cbb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -153,6 +153,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 51740a7..dfb234e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -140,6 +140,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 7f1bf5b..873420d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -120,6 +120,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 3f5ecf7..5c8f8a1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -141,6 +141,8 @@ void setup(void)
 	tst_tmpdir();
 
 	orig_hugepages = get_sys_tune("nr_hugepages");
+
+	hugepages = get_available_hugepages(hugepages);
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index cdc326b..3eed216 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -36,6 +36,8 @@ void testoom(int mempolicy, int lite, int numa);
 
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
 
+long get_available_hugepages(long hugepages);
+
 /*
  * memory pointer to identify per process, MB unit, and byte like
  * memory[process No.][MB unit No.][byte No.].
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index ae0adb4..4db2acf 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -842,3 +842,16 @@ void update_shm_size(size_t *shm_size)
 		*shm_size = shmmax;
 	}
 }
+
+long get_available_hugepages(long hugepages)
+{
+	long available_hugepages = 0;
+
+	set_sys_tune("nr_hugepages", hugepages, 0);
+	available_hugepages = get_sys_tune("nr_hugepages");
+	if (available_hugepages != hugepages)
+		tst_resm(TINFO, "There're %ld available hugepages",
+			    available_hugepages);
+
+	return available_hugepages;
+}
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
