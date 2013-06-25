Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrT0Q-0004VX-MP
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 13:09:58 +0000
Date: Tue, 25 Jun 2013 15:11:16 +0200
From: chrubis@suse.cz
Message-ID: <20130625131112.GE31268@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
	<20130624115313.GA1638@rei>
	<CA+icZUXgSW5Ha8ZQSepZXQzFx35nrR96AQ7SZun5zRrHFN_j-w@mail.gmail.com>
	<20130625124803.GC31268@rei>
	<CA+icZUUWAWObVLtPXug1YFFOUhB9P-5W88SbN4CebzOC-yGCwg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUUWAWObVLtPXug1YFFOUhB9P-5W88SbN4CebzOC-yGCwg@mail.gmail.com>
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
> >
> > What was the error message, same as previous?
> >
> 
> Here we go.
> 
> ...
> mount: wrong fs type, bad option, bad superblock on /dev/loop1,
>        missing codepage or helper program, or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> 
> FATAL: can't mount block device /dev/loop1.
> mke2fs 1.42 (29-Nov-2011)
> mkfs.ext4: Device size reported to be zero.  Invalid partition specified, or
>         partition table wasn't reread after running fdisk, due to
>         a modified partition being busy and in use.  You may need to reboot
>         to re-read your partition table.
> 
> 102400+0 records in
> 102400+0 records out
> 102400000 bytes (102 MB) copied, 0.542412 s, 189 MB/s
> ...
> 
> # dmesg | tail
> ...
> [ 1179.820940] EXT4-fs (loop1): VFS: Can't find ext4 filesystem

Hmm, it seems like something went wrong with the loop device setup (as
if no device was attached but the error was silently ignored).

(And I wonder why the messages seems to be in reverse order, the
messages from dd should have been first, then mkfs and then mount).

Could you try again without the &> /dev/null redirection and report
if there is error in the losetup step?

Also what is output of the 'losetup -a' added right before the mkfs
command?

diff --git a/runltp b/runltp
index a8bf404..1e9e637 100755
--- a/runltp
+++ b/runltp
@@ -996,12 +996,13 @@ create_block()
             return 1
         else
             ##attach the created file to loop dev.
-            losetup $LOOP_DEV ${TMP}/test.img &>/dev/null
+            losetup $LOOP_DEV ${TMP}/test.img
             if [ $? -ne 0 ]; then
                 echo "losetup failed to create block device"
                 return 1
             else
-                mkfs.ext4 $LOOP_DEV &>/dev/null
+                losetup -a
+		mkfs.ext4 $LOOP_DEV &>/dev/null
                 [ $? -ne 0 ] && (echo "creating a ext4 block device failed" && return 1)
                 #set the values in alltests which require block device.
                 DEVICE=$LOOP_DEV
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
