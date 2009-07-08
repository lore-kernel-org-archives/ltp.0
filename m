Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MOQNE-0002bW-QM
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 06:11:20 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOQNB-0004dH-0p
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 06:11:20 +0000
Received: by fxm4 with SMTP id 4so4002706fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 23:11:03 -0700 (PDT)
Message-ID: <4A5436D4.6070201@petalogix.com>
Date: Wed, 08 Jul 2009 08:04:04 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] IDcheck.sh - awk problem
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
To: LTP <ltp-list@lists.sourceforge.net>, yanegomi@gmail.com

Hi All,

There will be good to prevent missing /etc/passwd for installing to
different folder.

export DESTDIR=`pwd`/nfs
mkdir -p nfs
make install

Thanks,
Michal


Checking for required user/group ids

awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
bin => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
daemon => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
nobody => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
bin => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
daemon => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
nobody => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
sys => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
users => 2
'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
nobody => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
nobody => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
bin => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
bin => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
such file or directory)
daemon => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
daemon => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
users => 2
awk: cmd. line:1: fatal: cannot open file
`/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
such file or directory)
sys => 2
Required users/groups exist.


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
