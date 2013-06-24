Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur5JD-0007Li-25
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 11:51:47 +0000
Date: Mon, 24 Jun 2013 13:53:14 +0200
From: chrubis@suse.cz
Message-ID: <20130624115313.GA1638@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
Subject: Re: [LTP] How to run only a specific test series like for example
 IPC?
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I wanted to only run the IPC tests as I have troubles with IPC(-MSG)
> in Linux-Next.
> 
> This is what I did...
> 
> root# cd /opt/ltp/
> 
> root# ./runltp ./runtest/ipc
> 
> ...is that the correct way? Wrong?

I belive that the syntax is ./runltp -f ipc

Also there are additional tests for POSIX IPC in open_posix_testsuite
that are not executed by the runltp script.

> Unfortunately, this fails due to EXT4-fs troubles...
> ...
> mke2fs 1.42 (29-Nov-2011)
> Filesystem label=
> OS type: Linux
> Block size=1024 (log=0)
> Fragment size=1024 (log=0)
> Stride=0 blocks, Stripe width=0 blocks
> 32 inodes, 236 blocks
> 11 blocks (4.66%) reserved for the super user
> First data block=1
> 1 block group
> 8192 blocks per group, 8192 fragments per group
> 32 inodes per group
> 
> Allocating group tables: done
> Writing inode tables: done
> 
> Filesystem too small for a journal <--- ???
> Writing superblocks and filesystem accounting information: mount:
> /dev/loop1 already mounted or /tmp/ltp-p5uaFntNJE/mnt_pnt.u44xDV busy
> FATAL: can't mount block device /dev/loop1.
> root@fambox:/opt/ltp# done

There are certain testcases that needs a separate filesystem partition
to play with, if you don't pass physical disk partition to the runtest
script a loopback device is created, formatted and mounted.

> 10240+0 records in
> 10240+0 records out
> 10240000 bytes (10 MB) copied, 0.260004 s, 39.4 MB/s
> ^C
> 
> root# dmesg | tail
> 
> [   78.095907] EXT4-fs (loop1): VFS: Can't find ext4 filesystem <--- ???

This simply looks like the 10MB image is not enough for the ext4 journal
for some reason.

Try following patch that increases the size to 100MB.

diff --git a/runltp b/runltp
index a8bf404..7955f44 100755
--- a/runltp
+++ b/runltp
@@ -984,7 +984,7 @@ main()
 create_block()
 {
     #create a block device with ext4 filesystem.
-    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=10240 &>/dev/null
+    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=102400 &>/dev/null
     if [ $? -ne 0 ]; then
         echo "Failed to create loopback device image, please check disk space and re-run"
         return 1
-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
