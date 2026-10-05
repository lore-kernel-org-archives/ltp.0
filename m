Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA7BCA5FE2
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 06:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791180272; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=S++okTIxAZj7rnELr1lbtyKzGciLUhfOxBcYZ4/XiMU=;
 b=EO9aWNyhTQd5P4u4Xn0CT8uxtMwVSY2PS2BuHodc+0fPxEwoxJqH1hvnFBtjvLpIV8R52
 yNA8mlr0jWu1gZcc+QuiOIKv033r4JMiMZ0B/6z/1emfvdAg+QCpDnq8h0yIsVEm/AEu16W
 PCfWPa+uaRQ+XWJOGCp0tE19Ig4BTZo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 741823E4A8B
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 08:04:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADC483CD5F1
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 08:04:06 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B3AF860035F
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 08:03:59 +0200 (CEST)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
 by Atcsqr.andestech.com with ESMTPS id 69563ppC011161
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Mon, 5 Oct 2026 14:03:52 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Mon, 5 Oct
 2026 14:03:51 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 Oct
 2026 14:03:51 +0800
To: <ltp@lists.linux.it>
Date: Mon, 5 Oct 2026 14:03:45 +0800
Message-ID: <20261005060345.1019330-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 69563ppC011161
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix typo
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Victor Cheng-Yen Yang <cyyang772@andestech.com>

Wrong -> correct:
- git -> Git
- github -> GitHub
- seperate/seperated -> separate/separated
- existance -> existence
- occured/occurence -> occurred/occurrence
- begining -> beginning
- comparision/comparisions -> comparison/comparisons
- non-existant/nonexistant -> non-existent/nonexistent
- postion -> position
- paramters -> parameters
- distict -> distinct
- writen -> written

Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 doc/developers/test_case_tutorial.rst                  |  2 +-
 doc/maintainers/ltp_release_procedure.rst              |  2 +-
 doc/maintainers/patch_review.rst                       |  2 +-
 testcases/cve/cve-2017-2671.c                          |  2 +-
 testcases/kernel/containers/mqns/mqns_03.c             |  6 +++---
 .../kernel/device-drivers/agp/kernel_space/str_agp.h   |  4 ++--
 .../kernel/device-drivers/agp/kernel_space/tagp.c      |  2 +-
 .../kernel/device-drivers/agp/kernel_space/tagp.h      |  2 +-
 .../dev_sim_framework/kernel_space/str_mod.h           |  4 ++--
 .../dev_sim_framework/kernel_space/tmod.c              |  2 +-
 .../dev_sim_framework/kernel_space/tmod.h              |  2 +-
 .../kernel/device-drivers/drm/kernel_space/str_drm.h   |  4 ++--
 .../kernel/device-drivers/tbio/tbio_kernel/str_tbio.h  |  4 ++--
 .../kernel/device-drivers/tbio/tbio_kernel/tbio.h      |  2 +-
 testcases/kernel/io/direct_io/diotest2.c               |  2 +-
 testcases/kernel/io/direct_io/diotest4.c               |  8 ++++----
 testcases/kernel/io/direct_io/diotest5.c               |  2 +-
 testcases/kernel/io/direct_io/diotest_routines.c       |  2 +-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c     |  2 +-
 testcases/kernel/mem/mem/mem02.c                       |  2 +-
 testcases/kernel/mem/mmapstress/mmapstress07.c         |  2 +-
 testcases/kernel/mem/mmapstress/mmapstress08.c         |  2 +-
 testcases/kernel/mem/mtest05/mmstress.c                |  2 +-
 testcases/kernel/mem/mtest06/shmat1.c                  |  4 ++--
 testcases/kernel/syscalls/close_range/close_range02.c  |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl21.c              |  2 +-
 testcases/kernel/syscalls/listmount/listmount04.c      |  2 +-
 testcases/kernel/syscalls/llseek/llseek03.c            |  6 +++---
 testcases/kernel/syscalls/sigrelse/sigrelse01.c        | 10 +++++-----
 testcases/realtime/func/prio-preempt/prio-preempt.c    |  2 +-
 31 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
index 7e9d05892..5b740cdd3 100644
--- a/doc/developers/test_case_tutorial.rst
+++ b/doc/developers/test_case_tutorial.rst
@@ -800,7 +800,7 @@ master.
     5d93b84d8 Add statx and other syscall numbers
     5ca627b78 tutorial: Add a step-by-step C test tutorial
 
-So we have told git to show all the commits which don't exist in ``master``, but
+So we have told Git to show all the commits which don't exist in ``master``, but
 are in ``HEAD``, where ``HEAD`` is the top of the current branch. The current
 branch is ``tutorial-rebase2`` which I just created. I have already done one
 ``rebase`` and submitted a patch for review, so my original branch was just called
diff --git a/doc/maintainers/ltp_release_procedure.rst b/doc/maintainers/ltp_release_procedure.rst
index f52943727..14f06ed37 100644
--- a/doc/maintainers/ltp_release_procedure.rst
+++ b/doc/maintainers/ltp_release_procedure.rst
@@ -30,7 +30,7 @@ lists (see below).
 Have a look at `this release letter <https://lore.kernel.org/ltp/ZGNiQ1sMGvPU_ETp@yuki/>`_
 to get the idea how it should look.
 
-Tag the git and push changes to github
+Tag the git and push changes to GitHub
 --------------------------------------
 
 .. code-block:: bash
diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
index 0665e492e..6d620e154 100644
--- a/doc/maintainers/patch_review.rst
+++ b/doc/maintainers/patch_review.rst
@@ -122,7 +122,7 @@ Commit messages should have
 * Check also mailing lists for other reviewers / testers tags, notes and failure
   reports
 * ``Fixes: hash`` if it fixes particular LTP commit
-* ``Fixes: #N`` if it fixes github issue number N, so it's automatically closed
+* ``Fixes: #N`` if it fixes GitHub issue number N, so it's automatically closed
 * LTP documentation should be kept up to date.
 
 After patch is accepted or rejected, set correct state and archive in the
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 2e30a46a9..21497c91c 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -16,7 +16,7 @@
  * lock.
  *
  * This test repeatedly 'connects' a ping socket correctly then calls
- * connect() with AF_UNSPEC in two seperate threads to trigger the race
+ * connect() with AF_UNSPEC in two separate threads to trigger the race
  * condition. If the bug is present, then the test will most likely crash the
  * system.
  *
diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index ac8311559..ed27cec74 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -14,12 +14,12 @@
  *
  * - mq_open() /MQ1
  * - mount mqueue inside the temporary folder
- * - check for /MQ1 existance
+ * - check for /MQ1 existence
  * - creat() /MQ2 inside the temporary folder
  * - umount
  * - mount mqueue inside the temporary folder
- * - check /MQ1 existance
- * - check /MQ2 existance
+ * - check /MQ1 existence
+ * - check /MQ2 existence
  * - umount
  */
 
diff --git a/testcases/kernel/device-drivers/agp/kernel_space/str_agp.h b/testcases/kernel/device-drivers/agp/kernel_space/str_agp.h
index 0ca5e0b43..60fb8a69d 100644
--- a/testcases/kernel/device-drivers/agp/kernel_space/str_agp.h
+++ b/testcases/kernel/device-drivers/agp/kernel_space/str_agp.h
@@ -18,12 +18,12 @@
  */
 
 /*
- * Remember that you want to seperate your header
+ * Remember that you want to separate your header
  * files between what is needed in kernel space
  * only, and what will also be needed by a user
  * space program that is using this module. For
  * that reason keep all structures that will need
- * kernel space pointers in a seperate header file
+ * kernel space pointers in a separate header file
  * from where ioctl flags aer kept
  *
  * author: Kai Zhao
diff --git a/testcases/kernel/device-drivers/agp/kernel_space/tagp.c b/testcases/kernel/device-drivers/agp/kernel_space/tagp.c
index 496c8a7db..ee553b0eb 100644
--- a/testcases/kernel/device-drivers/agp/kernel_space/tagp.c
+++ b/testcases/kernel/device-drivers/agp/kernel_space/tagp.c
@@ -342,7 +342,7 @@ struct agp_bridge_driver test_driver = {
 };
 
 /*
- * test functions can go here or in a seperate file,
+ * test functions can go here or in a separate file,
  * remember that the makefile will have to be  modified
  * as well as the header file will need the function
  * prototypes if the test calls go in another file
diff --git a/testcases/kernel/device-drivers/agp/kernel_space/tagp.h b/testcases/kernel/device-drivers/agp/kernel_space/tagp.h
index b7b630367..3806d0413 100644
--- a/testcases/kernel/device-drivers/agp/kernel_space/tagp.h
+++ b/testcases/kernel/device-drivers/agp/kernel_space/tagp.h
@@ -63,7 +63,7 @@
 #define TEST_GENERIC_MASK_MEMORY		_IO(MAG_NUM, 21)
 
 /* memory between the kernel and user space is
- seperated, so that if a structure is needed
+ separated, so that if a structure is needed
  to be passed between kernel and user space
  a call must be made to copy_to_user or copy
  from user. Use this structure to streamline
diff --git a/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/str_mod.h b/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/str_mod.h
index dc74d6f2a..bba27dfbe 100644
--- a/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/str_mod.h
+++ b/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/str_mod.h
@@ -17,12 +17,12 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
 
- * Remember that you want to seperate your header
+ * Remember that you want to separate your header
  * files between what is needed in kernel space
  * only, and what will also be needed by a user
  * space program that is using this module. For
  * that reason keep all structures that will need
- * kernel space pointers in a seperate header file
+ * kernel space pointers in a separate header file
  * from where ioctl flags aer kept
  *
  * author: Sean Ruyle
diff --git a/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.c b/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.c
index cadec4ac5..092337305 100644
--- a/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.c
+++ b/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.c
@@ -199,7 +199,7 @@ static int tmod_ioctl(struct inode *ino, struct file *f,
 }
 
 /*
- * test functions can go here or in a seperate file,
+ * test functions can go here or in a separate file,
  * remember that the makefile will have to be  modified
  * as well as the header file will need the function
  * prototypes if the test calls go in another file
diff --git a/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.h b/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.h
index 8b2d8073c..46ae42276 100644
--- a/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.h
+++ b/testcases/kernel/device-drivers/dev_sim_framework/kernel_space/tmod.h
@@ -44,7 +44,7 @@
 #define LTP_OTHER		_IO(MAG_NUM, 2)
 
 /* memory between the kernel and user space is
- seperated, so that if a structure is needed
+ separated, so that if a structure is needed
  to be passed between kernel and user space
  a call must be made to copy_to_user or copy
  from user. Use this structure to streamline
diff --git a/testcases/kernel/device-drivers/drm/kernel_space/str_drm.h b/testcases/kernel/device-drivers/drm/kernel_space/str_drm.h
index 9ad232c09..39e64f0ed 100644
--- a/testcases/kernel/device-drivers/drm/kernel_space/str_drm.h
+++ b/testcases/kernel/device-drivers/drm/kernel_space/str_drm.h
@@ -17,12 +17,12 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
 
- * Remember that you want to seperate your header
+ * Remember that you want to separate your header
  * files between what is needed in kernel space
  * only, and what will also be needed by a user
  * space program that is using this module. For
  * that reason keep all structures that will need
- * kernel space pointers in a seperate header file
+ * kernel space pointers in a separate header file
  * from where ioctl flags aer kept
  *
  * author: Kai Zhao
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h b/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h
index dc74d6f2a..bba27dfbe 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/str_tbio.h
@@ -17,12 +17,12 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  *
 
- * Remember that you want to seperate your header
+ * Remember that you want to separate your header
  * files between what is needed in kernel space
  * only, and what will also be needed by a user
  * space program that is using this module. For
  * that reason keep all structures that will need
- * kernel space pointers in a seperate header file
+ * kernel space pointers in a separate header file
  * from where ioctl flags aer kept
  *
  * author: Sean Ruyle
diff --git a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
index 4cf0f462f..dfbb1014f 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
+++ b/testcases/kernel/device-drivers/tbio/tbio_kernel/tbio.h
@@ -51,7 +51,7 @@ int TBIO_MAJOR;
 #define LTP_TBIO_ADD_PAGE	_IO(MAG_NUM,7)
 
 /* memory between the kernel and user space is
- seperated, so that if a structure is needed
+ separated, so that if a structure is needed
  to be passed between kernel and user space
  a call must be made to copy_to_user or copy
  from user. Use this structure to streamline
diff --git a/testcases/kernel/io/direct_io/diotest2.c b/testcases/kernel/io/direct_io/diotest2.c
index db47ee8ef..63910bd53 100644
--- a/testcases/kernel/io/direct_io/diotest2.c
+++ b/testcases/kernel/io/direct_io/diotest2.c
@@ -116,7 +116,7 @@ int runtest(int fd_r, int fd_w, int iter, off_t offset, int action)
 			return (-1);
 		}
 		if (bufcmp(buf1, buf2, bufsize) != 0) {
-			tst_resm(TFAIL, "read/write comparision failed");
+			tst_resm(TFAIL, "read/write comparison failed");
 			return (-1);
 		}
 	}
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index 3f37a8a4f..407c2aab7 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -42,7 +42,7 @@
  *	[13] write to file not open for writing
  *	[14] read, write with non-aligned buffer
  *	[15] read, write buffer in read-only space
- *	[16] read, write in non-existant space
+ *	[16] read, write in non-existent space
  *	[17] read, write for file with O_SYNC
  *
  * USAGE
@@ -499,7 +499,7 @@ int main(int argc, char *argv[])
 	close(fd);
 	total++;
 
-	/* Test-16: read, write in non-existant space */
+	/* Test-16: read, write in non-existent space */
 	offset = 4096;
 	count = bufsize;
 	if ((buf1 =
@@ -511,9 +511,9 @@ int main(int argc, char *argv[])
 			 "open(%s, O_DIRECT|O_RDWR) failed", filename);
 	}
 	ret = runtest_f(fd, buf1, offset, count, EFAULT, 16,
-		      " nonexistant space");
+		      " nonexistent space");
 	testcheck_end(ret, &failed, &fail_count,
-				"read, write in non-existant space");
+				"read, write in non-existent space");
 	total++;
 	close(fd);
 
diff --git a/testcases/kernel/io/direct_io/diotest5.c b/testcases/kernel/io/direct_io/diotest5.c
index ac66f2a04..18d0733e2 100644
--- a/testcases/kernel/io/direct_io/diotest5.c
+++ b/testcases/kernel/io/direct_io/diotest5.c
@@ -138,7 +138,7 @@ int runtest(int fd_r, int fd_w, int iter, off_t offset, int action)
 			return (-1);
 		}
 		if (vbufcmp(iov1, iov2, nvector) != 0) {
-			tst_resm(TFAIL, "readv/writev comparision failed");
+			tst_resm(TFAIL, "readv/writev comparison failed");
 			return (-1);
 		}
 	}
diff --git a/testcases/kernel/io/direct_io/diotest_routines.c b/testcases/kernel/io/direct_io/diotest_routines.c
index 793572c37..dd524423f 100644
--- a/testcases/kernel/io/direct_io/diotest_routines.c
+++ b/testcases/kernel/io/direct_io/diotest_routines.c
@@ -47,7 +47,7 @@
 
 #include "diotest_routines.h"
 
-/* **** Routines for buffer actions, comparisions **** */
+/* **** Routines for buffer actions, comparisons **** */
 
 /*
  * fillbuf: Fill buffer of given size with given character value
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
index 9e23c253f..0e3754e7b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap24.c
@@ -7,7 +7,7 @@
 /*\
  * Kernel has bug in mremap for some architecture. mremap() can cause
  * crashes on architectures with holes in the address space (like ia64)
- * and on powerpc with it's distict page size slices.
+ * and on powerpc with it's distinct page size slices.
  *
  * This test perform mremap() with normal and hugepages around powerpc
  * slice boundary.
diff --git a/testcases/kernel/mem/mem/mem02.c b/testcases/kernel/mem/mem/mem02.c
index 42e55f7ac..3c62362a0 100644
--- a/testcases/kernel/mem/mem/mem02.c
+++ b/testcases/kernel/mem/mem/mem02.c
@@ -33,7 +33,7 @@
 	< successful.
 	< In the case of valloc, allocate memory and free it (do this for
 	< several iterations). Check if valloc returns unaligned pointers.
-	< If valloc causes a SIGSEGV, that means a failure has occured.
+	< If valloc causes a SIGSEGV, that means a failure has occurred.
 >BUGS:	<
 ======================================================================*/
 
diff --git a/testcases/kernel/mem/mmapstress/mmapstress07.c b/testcases/kernel/mem/mmapstress/mmapstress07.c
index 101c159a0..b7c9c00f6 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress07.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress07.c
@@ -249,7 +249,7 @@ int main(int argc, char **argv)
 #else /* LARGE_FILE */
 	if (lseek(rofd, sparseoff, SEEK_SET) == -1) {
 #endif /* LARGE_FILE */
-		CLEANERROR("couldn't lseek to begining to verify contents");
+		CLEANERROR("couldn't lseek to beginning to verify contents");
 		anyfail();	/* LTP Port */
 	}
 	if (munmap(mapaddr, holesize + 2 * pagesize) == -1) {
diff --git a/testcases/kernel/mem/mmapstress/mmapstress08.c b/testcases/kernel/mem/mmapstress/mmapstress08.c
index d4937271c..432f08d02 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress08.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress08.c
@@ -74,7 +74,7 @@ extern long sysconf(int name);
 		local_flag = FAILED;
 		anyfail();
 	}
-	/* The brk is now at the begining of a page. */
+	/* The brk is now at the beginning of a page. */
 
 	if ((munmap_begin = mmapaddr = (caddr_t) sbrk(0)) == (caddr_t) - 1) {
 		ERROR("couldn't find top of brk");
diff --git a/testcases/kernel/mem/mtest05/mmstress.c b/testcases/kernel/mem/mtest05/mmstress.c
index 60d49417b..b70b073c8 100644
--- a/testcases/kernel/mem/mtest05/mmstress.c
+++ b/testcases/kernel/mem/mtest05/mmstress.c
@@ -201,7 +201,7 @@ static void *thread_fault(void *args)
 			 * (pages_num / NUMTHREAD)
 			 * local_args[PAGESIZ]);
 	char read_from_addr = 0;	/* address to which read from page is done   */
-	char write_to_addr[] = { 'a' };	/* character to be writen to the page    */
+	char write_to_addr[] = { 'a' };	/* character to be written to the page    */
 
     /*************************************************************/
 	/*   The way it was, args could be overwritten by subsequent uses
diff --git a/testcases/kernel/mem/mtest06/shmat1.c b/testcases/kernel/mem/mtest06/shmat1.c
index 1ab41f8d3..713d91edb 100644
--- a/testcases/kernel/mem/mtest06/shmat1.c
+++ b/testcases/kernel/mem/mtest06/shmat1.c
@@ -171,8 +171,8 @@ static void sig_handler(int signal,	/* signal number, set to handle SIGALRM
 			siglongjmp(jmpbuf, 1);
 		} else {
 			fprintf(stderr,
-				"address at which sigfault occured: [%lx]\n"
-				"address at which sigfault occured: [%lx]\n"
+				"address at which sigfault occurred: [%lx]\n"
+				"address at which sigfault occurred: [%lx]\n"
 				"address at which memory was shmat: [%p]\n",
 				(unsigned long)scp->edi,
 				(unsigned long)scp->esi, map_address);
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index f9b0cc5a0..f24651a64 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -4,7 +4,7 @@
  */
 /*\
  * - First check close_range works on a valid range.
- * - Then check close_range does not accept invalid paramters.
+ * - Then check close_range does not accept invalid parameters.
  * - Then check it accepts a large lower fd.
  * - Finally check CLOEXEC works
  *
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index 9012d3588..083055dd5 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -266,7 +266,7 @@ int main(int ac, char **av)
 
 		/*
 		 * Add a write lock to the middle of the file and a read
-		 * at the begining
+		 * at the beginning
 		 */
 		if (do_lock(F_SETLK, (short)F_WRLCK, (short)0, 10, 5) < 0)
 			tst_resm(TFAIL | TERRNO, "fcntl on file failed");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index a262ae8dd..f9c61c8f5 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -377,7 +377,7 @@ int main(int ac, char **av)
 
 		/*
 		 * Add a read lock to the middle of the file and a write
-		 * at the begining
+		 * at the beginning
 		 */
 		if (do_lock(F_SETLK, (short)F_RDLCK, (short)0, 10, 5) < 0) {
 			tst_resm(TFAIL, "fcntl on file failed, errno =%d",
diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index 561386cb4..59a5e2e37 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -129,7 +129,7 @@ static struct tcase {
 		.mnt_ids = mnt_ids,
 		.nr_mnt_ids = MNT_SIZE,
 		.exp_errno = ENOENT,
-		.msg = "non-existant mnt_id",
+		.msg = "non-existent mnt_id",
 	},
 };
 
diff --git a/testcases/kernel/syscalls/llseek/llseek03.c b/testcases/kernel/syscalls/llseek/llseek03.c
index fb46c7324..3e6749763 100644
--- a/testcases/kernel/syscalls/llseek/llseek03.c
+++ b/testcases/kernel/syscalls/llseek/llseek03.c
@@ -11,11 +11,11 @@
  *   1. llseek() succeeds to set file position in the middle of the data. The
  *      file offset is checked by reading from a file and comparing the data.
  *
- *   2. llseek() succeeds to set file postion to the end of the data, reading
- *      this postion returns 0.
+ *   2. llseek() succeeds to set file position to the end of the data, reading
+ *      this position returns 0.
  *
  *   3. llseek() succeeds to set file position after the end of the data,
- *      reading from this postion returns 0 as well.
+ *      reading from this position returns 0 as well.
  */
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index dba39cfed..431a445c2 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -347,7 +347,7 @@ static void parent(void)
 		break;
 	case HANDLE_ERR:
 		/* more than one signal tried to be handled at the same time */
-		tst_resm(TBROK, "Error occured in signal handler.");
+		tst_resm(TBROK, "Error occurred in signal handler.");
 		break;
 	default:
 		tst_resm(TBROK, "Unexpected exit code %d from child", rv);
@@ -377,11 +377,11 @@ static void child(void)
 
 	/* set alarm in case something hangs */
 	if (set_timeout() < 0) {
-		/* an error occured - put mesg in note and send it back to parent */
+		/* an error occurred - put mesg in note and send it back to parent */
 		(void)strcpy(note, mesg);
 
 	} else if (setup_sigs() < 0) {
-		/* an error occured - put mesg in note and send it back to parent */
+		/* an error occurred - put mesg in note and send it back to parent */
 		(void)strcpy(note, mesg);
 
 	} else {
@@ -481,7 +481,7 @@ static void child(void)
 
 	/*
 	 * If we are error free so far...
-	 * check the sig_array array for one occurence of
+	 * check the sig_array array for one occurrence of
 	 * each of the catchable signals.  If this is true,
 	 * then PASS, otherwise FAIL.
 	 */
@@ -589,7 +589,7 @@ static char *read_pipe(int fd)
 
 	/* set timeout alarm in case the pipe is blocked */
 	if (set_timeout() < 0) {
-		/* an error occured, message in mesg */
+		/* an error occurred, message in mesg */
 		return NULL;
 	}
 
diff --git a/testcases/realtime/func/prio-preempt/prio-preempt.c b/testcases/realtime/func/prio-preempt/prio-preempt.c
index 5dd717d1f..c6833ca56 100644
--- a/testcases/realtime/func/prio-preempt/prio-preempt.c
+++ b/testcases/realtime/func/prio-preempt/prio-preempt.c
@@ -33,7 +33,7 @@
  *
  *       where Mi is the ith pthread_mutex_t and CVi is the ith conditional
  *       variable.So, at the end of this loop, 26 threads are all waiting on
- *       seperate condvars and mutexes.
+ *       separate condvars and mutexes.
  *     - Wakes up thread at priority 10 (T1) by executing:
  *	   pthread_mutex_lock(M1);
  *	   pthread_cond_signal(CV1);
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
