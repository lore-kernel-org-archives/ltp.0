Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrSds-00005E-KD
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 12:46:40 +0000
Date: Tue, 25 Jun 2013 14:48:04 +0200
From: chrubis@suse.cz
Message-ID: <20130625124803.GC31268@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
	<20130624115313.GA1638@rei>
	<CA+icZUXgSW5Ha8ZQSepZXQzFx35nrR96AQ7SZun5zRrHFN_j-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUXgSW5Ha8ZQSepZXQzFx35nrR96AQ7SZun5zRrHFN_j-w@mail.gmail.com>
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
> > There are certain testcases that needs a separate filesystem partition
> > to play with, if you don't pass physical disk partition to the runtest
> > script a loopback device is created, formatted and mounted.
> >
> >> 10240+0 records in
> >> 10240+0 records out
> >> 10240000 bytes (10 MB) copied, 0.260004 s, 39.4 MB/s
> >> ^C
> >>
> >> root# dmesg | tail
> >>
> >> [   78.095907] EXT4-fs (loop1): VFS: Can't find ext4 filesystem <--- ???
> >
> > This simply looks like the 10MB image is not enough for the ext4 journal
> > for some reason.
> >
> > Try following patch that increases the size to 100MB.
> >
> > diff --git a/runltp b/runltp
> > index a8bf404..7955f44 100755
> > --- a/runltp
> > +++ b/runltp
> > @@ -984,7 +984,7 @@ main()
> >  create_block()
> >  {
> >      #create a block device with ext4 filesystem.
> > -    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=10240 &>/dev/null
> > +    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=102400 &>/dev/null
> >      if [ $? -ne 0 ]; then
> >          echo "Failed to create loopback device image, please check disk space and re-run"
> >          return 1
> > --
> 
> Hmm, that did not help.

What was the error message, same as previous?

> How much disc-space someone need on the partition where LTP resides
> (where the tests are performed)?

Not much, I do not know the precise number but about gigabyte should be
enough (and far less when you omit aio and fs stress tests).

> $ LANG=C LC_ALL=C df -T
> Filesystem     Type     1K-blocks      Used Available Use% Mounted on
> rootfs         rootfs    17753424  12825524   4003024  77% /
> udev           devtmpfs   1960968         4   1960964   1% /dev
> tmpfs          tmpfs       788020       888    787132   1% /run
> /dev/sda2      fuseblk  465546236 107358584 358187652  24% /host
> /dev/loop0     ext4      17753424  12825524   4003024  77% /
> none           tmpfs         5120         0      5120   0% /run/lock
> none           tmpfs      1970048       156   1969892   1% /run/shm
> 
> Can I use a different partition where I have more disc-space available?

LTP uses TMPDIR env variable for that (and defaults to /tmp/ when TMPDIR
is not set).

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
