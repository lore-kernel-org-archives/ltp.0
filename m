Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MXy9C-0001RA-9x
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 14:04:18 +0000
Received: from mail-fx0-f211.google.com ([209.85.220.211])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXy96-0000WT-TV
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 14:04:18 +0000
Received: by fxm7 with SMTP id 7so2646812fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Aug 2009 07:04:04 -0700 (PDT)
Message-ID: <4A76EE2A.201@petalogix.com>
Date: Mon, 03 Aug 2009 16:03:22 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] Fake test result
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
To: Mike Frysinger <vapier@gentoo.org>, "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>, LTP <ltp-list@lists.sourceforge.net>

Hi Subrata and Mike,

As I wrote in my previous email (no response on it - Subject getcontext,
add_key, fcntl24, fcntl25, fcntl26, open10)
there is wrong reporting PASS/FAIL for latest LTP code.

There is one broken Mike's commit "extend the test result to a bit field
so we can extend the output further"
http://developer.petalogix.com/git/gitweb.cgi?p=ltp-microblaze.git;a=commit;h=8b4a8c10b4ec8576a470b9886c7e96a084fb68e0

There is one more patch which relate with that one above -"convert errno
handling to new tst errno helpers" - mmap09.c
http://developer.petalogix.com/git/gitweb.cgi?p=ltp-microblaze.git;a=commit;h=92029c333858cefc3b2e03f84a1a74d946f81803

I am running ./runltp -q -f syscalls. Please look at tests which failed
on your arch (the new one are the best).

If you see the same problem as I, please revert these two patches.

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
