Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1Uqk2f-00064T-0Y
	for ltp-list@lists.sourceforge.net; Sun, 23 Jun 2013 13:09:17 +0000
Received: from mail-wi0-f180.google.com ([209.85.212.180])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uqk2e-0002uP-3Q
	for ltp-list@lists.sourceforge.net; Sun, 23 Jun 2013 13:09:16 +0000
Received: by mail-wi0-f180.google.com with SMTP id c10so1772213wiw.7
	for <ltp-list@lists.sourceforge.net>;
	Sun, 23 Jun 2013 06:09:09 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 23 Jun 2013 15:09:09 +0200
Message-ID: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP] How to run only a specific test series like for example IPC?
Reply-To: sedat.dilek@gmail.com
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
To: ltp-list@lists.sourceforge.net

Hi,

I wanted to only run the IPC tests as I have troubles with IPC(-MSG)
in Linux-Next.

This is what I did...

root# cd /opt/ltp/

root# ./runltp ./runtest/ipc

...is that the correct way? Wrong?

Unfortunately, this fails due to EXT4-fs troubles...
...
mke2fs 1.42 (29-Nov-2011)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
Stride=0 blocks, Stripe width=0 blocks
32 inodes, 236 blocks
11 blocks (4.66%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
32 inodes per group

Allocating group tables: done
Writing inode tables: done

Filesystem too small for a journal <--- ???
Writing superblocks and filesystem accounting information: mount:
/dev/loop1 already mounted or /tmp/ltp-p5uaFntNJE/mnt_pnt.u44xDV busy
FATAL: can't mount block device /dev/loop1.
root@fambox:/opt/ltp# done

10240+0 records in
10240+0 records out
10240000 bytes (10 MB) copied, 0.260004 s, 39.4 MB/s
^C

root# dmesg | tail

[   78.095907] EXT4-fs (loop1): VFS: Can't find ext4 filesystem <--- ???

root# grep -i ext4 /boot/config-$(uname -r)
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set

IMPORTANT NOTE: Here, I am running Ubuntu/precise as a WUBI installation.

Regards,
- Sedat -

[1] https://wiki.ubuntu.com/WubiGuide

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
