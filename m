Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MYzF7-0000Ri-16
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 09:26:37 +0000
Received: from mail-ew0-f210.google.com ([209.85.219.210])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYzF4-00071X-MH
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 09:26:36 +0000
Received: by ewy6 with SMTP id 6so738189ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Aug 2009 02:26:28 -0700 (PDT)
Message-ID: <4A7AA1BE.9050901@petalogix.com>
Date: Thu, 06 Aug 2009 11:26:22 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] utimes01
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi All,

Can you please run utimes01 test? I see there on x86 and Microblaze this
fault.
There is different errno value.

Thanks,
Michal

EXPECT: return value(ret)=-1 errno=13 (Permission denied)
RESULT: return value(ret)=-1 errno=1 (Operation not permitted)

[root@monstr utimes]# ./utimes01
utimes01    0  TINFO  :  (case00) START
utimes01    0  TINFO  :  E:0,1000 <=> R:0,1000
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
utimes01    0  TINFO  :  (case00) END => OK
utimes01    0  TINFO  :  (case01) START
utimes01    0  TINFO  :  E:1000,0 <=> R:1000,0
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
utimes01    0  TINFO  :  (case01) END => OK
utimes01    0  TINFO  :  (case02) START
EXPECT: return value(ret)=-1 errno=13 (Permission denied)
RESULT: return value(ret)=-1 errno=1 (Operation not permitted)
utimes01    0  TINFO  :  (case02) END => NG
utimes01    0  TINFO  :  (case03) START
EXPECT: return value(ret)=-1 errno=2 (No such file or directory)
RESULT: return value(ret)=-1 errno=2 (No such file or directory)
utimes01    0  TINFO  :  (case03) END => OK
utimes01    0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=14 (Bad address)
utimes01    0  TINFO  :  (case04) END => OK
utimes01    1  TFAIL  :  utimes01 failed - errno = 0 : Success
utimes01    0  TINFO  :  NG

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
