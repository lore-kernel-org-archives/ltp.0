Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MXwyp-0004mj-Pv
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 12:49:31 +0000
Received: from an-out-0708.google.com ([209.85.132.245])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXwyk-0007SN-I5
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 12:49:31 +0000
Received: by an-out-0708.google.com with SMTP id c38so1545059ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Aug 2009 05:49:20 -0700 (PDT)
Message-ID: <4A76D6DD.4020401@petalogix.com>
Date: Mon, 03 Aug 2009 14:23:57 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] clone01 -c 10 on x86
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

can you please to run clone01 syscall test on any x86 machine? I am
getting fault there when I run it 10 times for example.
The same problem I have on Microblaze.

 ./clone01  -c 10
clone01     1  TPASS  :  clone() returned 22738
clone01     1  TPASS  :  clone() returned 22740
clone01     1  TPASS  :  clone() returned 22742
clone01     1  TPASS  :  clone() returned 22748
clone01     1  TPASS  :  clone() returned 22750
clone01     1  TPASS  :  clone() returned 22752
clone01     1  TPASS  :  clone() returned 22754
clone01     1  TFAIL  :  clone() returned 134919589, errno = 22755
[monstr@monstr clone]$ clone01     1  TPASS  :  clone() returned 22744
clone01     1  TPASS  :  clone() returned 22746

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
