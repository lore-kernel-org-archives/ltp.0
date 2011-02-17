Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <michal.simek@petalogix.com>) id 1Pq34h-0003P2-61
	for ltp-list@lists.sourceforge.net; Thu, 17 Feb 2011 12:35:11 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Pq34e-0007jq-VX
	for ltp-list@lists.sourceforge.net; Thu, 17 Feb 2011 12:35:11 +0000
Received: by ewy28 with SMTP id 28so890451ewy.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Feb 2011 04:35:02 -0800 (PST)
Message-ID: <4D5D0EDD.8040400@petalogix.com>
Date: Thu, 17 Feb 2011 13:04:45 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] RPC tests in LTP
Reply-To: michal.simek@petalogix.com
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

I would like to use RPC testsuite on Microblaze.
I briefly looked at it and seems that it is designed for desktops not embedded systems.
Have someone tried to use it on embedded systems?

My idea is server on x86 and client on Microblaze.
We don't have native compiler for Microblaze.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
