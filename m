Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MTBlj-0005MR-C0
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 09:36:19 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTBlc-0006Dy-CI
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 09:36:19 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id n6L9Wmho007507
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 19:32:48 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6L9YjOa401712
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 19:34:46 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6L9YjC6031694
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 19:34:45 +1000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary="=-WxTLhz2oLe5lwtUbz2La"
Date: Tue, 21 Jul 2009 15:05:50 +0530
Message-Id: <1248168950.13756.7.camel@munipradeep-laptop>
Mime-Version: 1.0
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
To: sharyath@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net


--=-WxTLhz2oLe5lwtUbz2La
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Sharyathi,

This is the forwarded mail containing the patch for chmod05 in new LTP
provided by Wei Yongjun <yjwei@cn.fujitsu.com>.
Is this the functionality you are also looking for and trying to fix?

Thanks
Muni

--=-WxTLhz2oLe5lwtUbz2La
Content-Disposition: inline
Content-Description: Forwarded message - [LTP] [PATCH 1/2] chmod05: fix to
	modify the group ownership before do dir chmod
Content-Type: message/rfc822

Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from imap.linux.ibm.com ([unix socket]) by imap.linux.ibm.com
	(Cyrus v2.3.7-Invoca-RPM-2.3.7-7) with LMTPA; Mon, 08 Jun 2009 02:25:52
	-0400
X-Sieve: CMU Sieve 2.3
Received: by imap.linux.ibm.com (Postfix, from userid 101) id D5CE927DC1A1;
	Mon,  8 Jun 2009 02:25:52 -0400 (EDT)
X-Spam-TestScore: none
X-Spam-TokenSummary: Bayes not run.
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on imap.linux.ibm.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled 
	version=3.1.7
X-Spam-Relay-Country: US ** ** CN ** ** **
Received: from smtp.linux.ibm.com (smtp.linux.ibm.com [9.26.4.197]) by
	imap.linux.ibm.com (Postfix) with ESMTP id AB65F27DC1B8 for
	<mpradeep@imap.linux.ibm.com>; Mon,  8 Jun 2009 02:24:40 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1]) by
	smtp.linux.ibm.com (Postfix) with ESMTP id 26D4AC79FF for
	<mpradeep@linux.ibm.com>; Mon,  8 Jun 2009 02:24:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at linux.ibm.com
Received: from BLDGATE.BOULDER.IBM.COM (bldgate.boulder.ibm.com
	[9.17.210.138]) by smtp.linux.ibm.com (Postfix) with ESMTP id
	BB519C7A07
	for <mpradeep@linux.ibm.com>; Mon,  8 Jun 2009 02:24:39 -0400 (EDT)
Received: by BLDGATE.BOULDER.IBM.COM (IBM VM SMTP Level 530) via spool
	with SMTP id 1439 ; Mon, 08 Jun 2009 00:24:35 MDT
Received: by bldgate.vnet.ibm.com (xagent2 6.0.8) via xagsmtp3 with spool
	id 5469 for mpradeep@linux.vnet.ibm.com; Mon, 08 Jun 2009 00:24:35 -0600
	(MDT)
Received: from d03relay03.boulder.ibm.com [9.17.195.228] by
	BLDGATE.BOULDER.IBM.COM (IBM VM SMTP Level 530) via TCP with ESMTP ;
	Mon, 08 Jun 2009 00:19:37 MDT
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com
	[9.17.195.85]) by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2)
	with ESMTP id n586JaRR187142;	Mon, 8 Jun 2009 00:19:36 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])	by
	d03av05.boulder.ibm.com (8.13.1/8.13.3) with ESMTP id n586Jage001113;
	Mon, 8 Jun 2009 00:19:36 -0600
Received: from e34.co.us.ibm.com ([9.17.249.44])	by d03av05.boulder.ibm.com
	(8.13.1/8.12.11) with ESMTP id n586JaTn001101	(version=TLSv1/SSLv3
	cipher=DHE-RSA-AES256-SHA bits=256 verify=OK); Mon, 8 Jun 2009 00:19:36
	-0600
Received: from lists.sourceforge.net (lists.sourceforge.net
	[216.34.181.88]) by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id
	n586GZjT018352 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
	verify=NO);	Mon, 8 Jun 2009 00:16:35 -0600
Received: from localhost ([127.0.0.1]
	helo=sfs-ml-2.v29.ch3.sourceforge.com) by 3yr0jf1.ch3.sourceforge.com
	with esmtp (Exim 4.69)	(envelope-from
	<ltp-list-bounces@lists.sourceforge.net>)	id 1MDYAk-0005xG-Ac;
	Mon, 08 Jun 2009 06:17:30 +0000
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)	by 3yr0jf1.ch3.sourceforge.com with esmtp
	(Exim
	4.69)	(envelope-from <yjwei@cn.fujitsu.com>) id 1MDYAj-0005x9-8o	for
	ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 06:17:29 +0000
X-ACL-Warn: 
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)	by
	3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)	id
	1MDYAg-0007Ki-CO	for
	ltp-list@lists.sourceforge.net; Mon, 08 Jun 2009 06:17:29 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])	by
	song.cn.fujitsu.com (Postfix) with ESMTP id 22CF4170148; Mon, 8 Jun 2009
	14:38:32 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])	by
	tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id n586StUk011019; Mon, 8
	Jun 2009 14:28:55 +0800
Received: from [127.0.0.1] (unknown [10.167.141.76])	by fnst.cn.fujitsu.com
	(Postfix) with ESMTP id F3CCBD403C; Mon, 8 Jun 2009 14:17:04 +0800 (CST)
Message-ID: <4A2CABFB.3010207@cn.fujitsu.com>
Date: Mon, 08 Jun 2009 14:13:15 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To: Subrata Modak <subrata@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net
X-Headers-End: 1MDYAg-0007Ki-CO
Subject: [LTP] [PATCH 1/2] chmod05: fix to modify the group ownership
	before do dir chmod
X-BeenThere: ltp-list@lists.sourceforge.net
X-Mailman-Version: 2.1.9
Precedence: list
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
X-Xagent-From: yjwei@cn.fujitsu.com
X-Xagent-To: mpradeep@linux.vnet.ibm.com
X-Xagent-Gateway: bldgate.vnet.ibm.com (XAGENTU at BLDGATE)
Content-Transfer-Encoding: 7bit

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

--=-WxTLhz2oLe5lwtUbz2La
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
--=-WxTLhz2oLe5lwtUbz2La
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-WxTLhz2oLe5lwtUbz2La--


