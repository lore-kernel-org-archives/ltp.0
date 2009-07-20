Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MSr69-0000Hl-CZ
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 11:32:01 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSr5y-0008CQ-Lj
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 11:31:58 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n6KBPImL019485
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Jul 2009 16:55:18 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6KBPINh3719170
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Jul 2009 16:55:18 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6KBPIU0007207
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Jul 2009 21:25:18 +1000
Message-ID: <4A64541C.9090408@in.ibm.com>
Date: Mon, 20 Jul 2009 16:55:16 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
In-Reply-To: <4A486E66.5050102@cn.fujitsu.com>
Content-Type: multipart/mixed; boundary="------------060704060301010004000603"
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Wei Yongjun <yjwei@cn.fujitsu.com>, ltp-list@lists.sourceforge.net
Cc: mbeeraka@in.ibm.com

This is a multi-part message in MIME format.
--------------060704060301010004000603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi
   I was able to understand the problem...
This is what I learnt

Supplementary group IDs of a process is inherited from its parent process, so
who ever spawns the process transfer its supplementary group ids also to its
child process.

in our test case scenario checking the supplementary group IDs of root which is
spawning the test cases fchmod5 and chmod5 shows this

---------------------------------------------------------
cat test.c
---------------------------------------------------------
int main()
{
         int size = 10;
         int i, index;
         gid_t list[10];
         index = getgroups(size, list);
         for ( i =0 ;i < index; i++)
                 printf("\n list[%d]:%d", i, list[i]);
         printf("\n");
}
---------------------------------------------------------

[root@mx3350a sharyathi]# ./a.out

  list[0]:0
  list[1]:1
  list[2]:2
  list[3]:3
  list[4]:4
  list[5]:6
  list[6]:10
---------------------------------------------------------
This shows that bin->GID (1) is one of the supplementary group IDs of the process
while nobody->GID (99) is not.
So in the kernel code
--------------------------------------------------------
  if (ia_valid & ATTR_MODE) {
                 umode_t mode = attr->ia_mode;

                 if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
                         mode &= ~S_ISGID;
                 inode->i_mode = mode;
         }
--------------------------------------------------------
S_ISGID is cleared in case file attribute is nobody and not in case of GID
being bin

I was thinking of what could be the best solution as earlier solution proposed
are not fool proof
Attaching a fix I though is the best way to handle the issue

Thanks
Yeehaw



--------------060704060301010004000603
Content-Type: text/x-patch;
 name="fix_supplementary_group_id_issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_supplementary_group_id_issue.patch"

Index: ltp-full-20090430/testcases/kernel/syscalls/chmod/chmod05.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/chmod/chmod05.c	2009-04-25 23:22:44.000000000 +0530
+++ ltp-full-20090430/testcases/kernel/syscalls/chmod/chmod05.c	2009-07-20 16:34:07.000000000 +0530
@@ -240,6 +240,10 @@
 		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed: %s", TESTDIR,
 				strerror(errno));
 	}
+	
+	if(setgroups(1, &nobody_u->pw_gid) == -1)
+		tst_brkm(TBROK, cleanup, "Couldn't change supplementary group Id: %s",
+				strerror(errno));
 
 	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
Index: ltp-full-20090430/testcases/kernel/syscalls/fchmod/fchmod05.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/syscalls/fchmod/fchmod05.c	2009-07-20 16:22:56.000000000 +0530
+++ ltp-full-20090430/testcases/kernel/syscalls/fchmod/fchmod05.c	2009-07-20 16:32:26.000000000 +0530
@@ -218,6 +218,10 @@
 		tst_brkm(TBROK, cleanup, "mkdir(2) of %s failed", TESTDIR);
 	}
 
+	if(setgroups(1, &nobody_u->pw_gid) == -1)
+		tst_brkm(TBROK, cleanup, "Couldn't change supplementary group Id: %s",
+				strerror(errno));
+
 	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
 				strerror(errno));

--------------060704060301010004000603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--------------060704060301010004000603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060704060301010004000603--

