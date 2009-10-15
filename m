Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyFP6-00051F-NE
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:45:20 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyFOy-0005Xt-Vr
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:45:20 +0000
Received: by pzk26 with SMTP id 26so327785pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 18:45:07 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 18:40:00 -0700
Message-ID: <364299f40910141840t15b6489s38e232575652677f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [Issue 15] ima testcases issues
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
To: LTP list <ltp-list@lists.sourceforge.net>

    The ima testcases should check and see whether or not the /sys
directory that they're testing in exists before continuing. Otherwise
there's a lot of unnecessary noise that shows up in the logs:

mkdir: cannot create directory `/sys/kernel/security': No such file or directory

Usage: mount -V                 : print version

       mount -h                 : print this help

       mount                    : list mounted filesystems

       mount -l                 : idem, including volume labels

So far the informational part. Next the mounting.

The command is `mount [-t fstype] something somewhere'.

Details found in /etc/fstab may be omitted.

       mount -a [-t|-O] ...     : mount all stuff from /etc/fstab

       mount device             : mount device at the known place

       mount directory          : mount known device here

       mount -t type dev dir    : ordinary mount command

Note that one does not really mount a device, one mounts

a filesystem (of the given type) found on the device.

One can also mount an already visible directory tree elsewhere:

       mount --bind olddir newdir

or move a subtree:

       mount --move olddir newdir

A device can be given by name, say /dev/hda1 or /dev/cdrom,

or by label, using  -L label  or by uuid, using  -U uuid .

Other options: [-nfFrsvw] [-o options] [-p passwdfd].

For many more details, say  man 8 mount .

setup       1  TBROK  :  setup: cannot mount securityfs

setup       0  TINFO  :  CLEAN: removing /tmp/ltp-JJyTa10956/ima

Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
