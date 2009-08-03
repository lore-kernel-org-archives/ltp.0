Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MXxnV-00080R-FY
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:41:53 +0000
Received: from [89.31.47.178] (helo=monstr.eu)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXxnU-00040P-5k
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:41:53 +0000
From: michal.simek@petalogix.com
Date: Mon,  3 Aug 2009 15:24:18 +0200
Message-Id: <d80b0b476cd86f178e44984647a040bb7d458d75.1249304223.git.monstr@monstr.eu>
In-Reply-To: <b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
In-Reply-To: <0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
References: <0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
Subject: [LTP] [PATCH 3/4] fcntl24, 25,
	26: F_SETLEASE and F_WRLCK cannot work on ramfs
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

From: Michal Simek <monstr@monstr.eu>

The same reason as was in previous patch for tmpfs

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 testcases/kernel/syscalls/fcntl/fcntl24.c |    8 ++++++++
 testcases/kernel/syscalls/fcntl/fcntl25.c |    8 ++++++++
 testcases/kernel/syscalls/fcntl/fcntl26.c |    8 ++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl24.c b/testcases/kernel/syscalls/fcntl/fcntl24.c
index 1a524bb..af0e814 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl24.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl24.c
@@ -139,6 +139,14 @@ int main(int ac, char **av)
 			 "Cannot do fcntl on a file located on an TMPFS filesystem");
 	}
 
+	/*
+	 * check if the current filesystem is ramfs
+	 */
+	if (tst_is_cwd_ramfs()) {
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do fcntl on a file located on an RAMFS filesystem");
+	}
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl25.c b/testcases/kernel/syscalls/fcntl/fcntl25.c
index 9957dc4..6e2adc6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl25.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl25.c
@@ -140,6 +140,14 @@ int main(int ac, char **av)
 			 "Cannot do fcntl on a file located on an TMPFS filesystem");
 	}
 
+	/*
+	 * check if the current filesystem is ramfs
+	 */
+	if (tst_is_cwd_ramfs()) {
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do fcntl on a file located on an RAMFS filesystem");
+	}
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
diff --git a/testcases/kernel/syscalls/fcntl/fcntl26.c b/testcases/kernel/syscalls/fcntl/fcntl26.c
index 5c4f4e4..df22063 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl26.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl26.c
@@ -140,6 +140,14 @@ int main(int ac, char **av)
 			 "Cannot do fcntl on a file located on an TMPFS filesystem");
 	}
 
+	/*
+	 * check if the current filesystem is ramfs
+	 */
+	if (tst_is_cwd_ramfs()) {
+		tst_brkm(TCONF, cleanup,
+			 "Cannot do fcntl on a file located on an RAMFS filesystem");
+	}
+
 	/* set the expected errnos... */
 	TEST_EXP_ENOS(exp_enos);
 
-- 
1.5.5.1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
