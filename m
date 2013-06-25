Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrTDS-0006Uy-1M
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 13:23:26 +0000
Date: Tue, 25 Jun 2013 15:24:54 +0200
From: chrubis@suse.cz
Message-ID: <20130625132453.GF31268@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
	<20130624115313.GA1638@rei>
	<CA+icZUXgSW5Ha8ZQSepZXQzFx35nrR96AQ7SZun5zRrHFN_j-w@mail.gmail.com>
	<20130625124803.GC31268@rei>
	<CA+icZUUWAWObVLtPXug1YFFOUhB9P-5W88SbN4CebzOC-yGCwg@mail.gmail.com>
	<20130625131112.GE31268@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130625131112.GE31268@rei>
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
> > >
> > > What was the error message, same as previous?
> > >
> > 
> > Here we go.
> > 
> > ...
> > mount: wrong fs type, bad option, bad superblock on /dev/loop1,
> >        missing codepage or helper program, or other error
> >        In some cases useful info is found in syslog - try
> >        dmesg | tail  or so
> > 
> > FATAL: can't mount block device /dev/loop1.
> > mke2fs 1.42 (29-Nov-2011)
> > mkfs.ext4: Device size reported to be zero.  Invalid partition specified, or
> >         partition table wasn't reread after running fdisk, due to
> >         a modified partition being busy and in use.  You may need to reboot
> >         to re-read your partition table.
> > 
> > 102400+0 records in
> > 102400+0 records out
> > 102400000 bytes (102 MB) copied, 0.542412 s, 189 MB/s
> > ...
> > 
> > # dmesg | tail
> > ...
> > [ 1179.820940] EXT4-fs (loop1): VFS: Can't find ext4 filesystem
> 
> Hmm, it seems like something went wrong with the loop device setup (as
> if no device was attached but the error was silently ignored).
> 
> (And I wonder why the messages seems to be in reverse order, the
> messages from dd should have been first, then mkfs and then mount).

Hmm, if I remeber correctly there dash that is used as /bin/sh on Debian
(and supposedly on Ubuntu) that does not understand the &> syntax so the
messages may be reversed because the commands are executed on background
(instead of the output redirected to /dev/null).

Try to remove all '&> /dev/null' from the script and try again.

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
