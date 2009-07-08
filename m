Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOYSJ-0004FW-EU
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 14:49:07 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOYSD-0006ns-88
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 14:49:07 +0000
Received: by yxe33 with SMTP id 33so7106839yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 07:49:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A5436D4.6070201@petalogix.com>
References: <4A5436D4.6070201@petalogix.com>
Date: Wed, 8 Jul 2009 07:19:43 -0700
Message-ID: <364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] IDcheck.sh - awk problem
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
To: michal.simek@petalogix.com
Cc: LTP <ltp-list@lists.sourceforge.net>

On Tue, Jul 7, 2009 at 11:04 PM, Michal Simek<michal.simek@petalogix.com> wrote:
> Hi All,
>
> There will be good to prevent missing /etc/passwd for installing to
> different folder.
>
> export DESTDIR=`pwd`/nfs
> mkdir -p nfs
> make install
>
> Thanks,
> Michal
>
>
> Checking for required user/group ids
>
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> bin => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> daemon => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> nobody => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> bin => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> daemon => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> nobody => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> sys => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> users => 2
> 'nobody' user id and group found.
> 'bin' user id and group found.
> 'daemon' user id and group found.
> Users group found.
> Sys group found.
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> nobody => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> nobody => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> bin => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> bin => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/group' for reading (No
> such file or directory)
> daemon => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> daemon => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> users => 2
> awk: cmd. line:1: fatal: cannot open file
> `/home/projects/xils/ltp-microblaze.git/nfs/etc/passwd' for reading (No
> such file or directory)
> sys => 2
> Required users/groups exist.

That's part of the reason why I wanted it to be reviewed before it was
committed, and I halfway expected Mike to provide that assistance but
he didn't... *sigh*.

Does the /etc/passwd // /etc/group file exist?

Thanks,
-Garrett

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
