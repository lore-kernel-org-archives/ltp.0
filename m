Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MDYAj-0005x9-8o
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 06:17:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDYAg-0007Ki-CO
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 06:17:29 +0000
Message-ID: <4A2CABFB.3010207@cn.fujitsu.com>
Date: Mon, 08 Jun 2009 14:13:15 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] chmod05: fix to modify the group ownership before
 do dir chmod
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net

Refer to the manpage:

  # man 2 chmod
  If the calling process is not privileged (Linux: does not have the
  CAP_FSETID capability), and the group of the file does not match
  the effective group ID of the process or one of its supplementary
  group IDs, the S_ISGID bit will be turned off, but this will not
  cause an error to be returned.

So, if we want S_ISGID bit be turned off after chmod(), we can not have
the CAP_FSETID capability and not match the effective group ID. The 'bin'
group always has the CAP_FSETID capability, so we can not change the own
of the TESTDIR to 'bin' group, instead, 'nobody' can be used.

This patch fixed the problem by change gid of chown to 'nobody' group and
change the gid of setegid() to 'bin' group.

Signed-off-by: Wei Yongjun <yjwei@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chmod/chmod05.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 4504aaa..c6f1225 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -177,7 +177,7 @@ int main(int ac, char **av)
 			if ((PERMS & ~S_ISGID) != dir_mode) {
 				tst_resm(TFAIL, "%s: Incorrect modes 0%03o, "
 					 "Expected 0%03o", TESTDIR, dir_mode,
-					 PERMS);
+					 PERMS & ~S_ISGID);
 			} else {
 				tst_resm(TPASS,
 					 "Functionality of chmod(%s, %#o) successful",
@@ -241,12 +241,12 @@ void setup()
 				strerror(errno));
 	}
 
-	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
+	if (chown(TESTDIR, nobody_u->pw_uid, nobody_u->pw_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
 				strerror(errno));
 
-	/* change to nobody:nobody */
-	if (setegid(nobody_u->pw_gid) == -1 ||
+	/* change to nobody:bin */
+	if (setegid(bin_group->gr_gid) == -1 ||
 		 seteuid(nobody_u->pw_uid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't switch to nobody:nobody: %s",
 				strerror(errno));
-- 
1.6.0.2.530.g67faa





------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
