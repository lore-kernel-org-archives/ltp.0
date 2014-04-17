Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WajNK-0004Ef-RX
	for ltp-list@lists.sourceforge.net; Thu, 17 Apr 2014 10:16:58 +0000
Date: Thu, 17 Apr 2014 12:16:12 +0200
From: chrubis@suse.cz
Message-ID: <20140417101611.GA14819@rei.suse.cz>
References: <20140416190028.GA2093@ls3530.fritz.box>
	<20140417093329.GA6558@rei.suse.cz>
	<trinity-7fc052ce-4544-4fa4-afc0-9b68430ef693-1397729289569@3capp-gmx-bs62>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <trinity-7fc052ce-4544-4fa4-afc0-9b68430ef693-1397729289569@3capp-gmx-bs62>
Subject: Re: [LTP] [PATCH] fix fanotify syscall check on compat kernel
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
To: Helge Deller <deller@gmx.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hi!
> > I think that the x32 ABI should be handled here as well (as in the
> > fallocate.h). Mike can you confirm?
> 
> Yes, I think so.
> I even thought of changing the #if to C-Coding like 
>   if ((sizeof(void*) == 8)
>     call 64bit_syscall
>    else
>     call 32bit_syscall_wrapper;

That would be still wrong on the x32 ABI where pointers are 32 bit but
syscalls get 64 bit parameters.

> I'm not sure if this can avoid the ifdefs though...

We should probably move the ifdef condition from the fallocate.h header
to some generic top-level header and use it in the syscall wrappers.

Something like:

#define LTP_USE_64_ABI __WORDSIZE == 64 || ....

Then we can use as:

#if LTP_USE_64_ABI
 ...
#else
 ...
#endif

> > Also I've been unable to make the testcases work with -m32 on x86_64
> > both with and without the patch and even when using glibc wrappers from
> > sys/fallocate.h, in all cases the error is EINVAL which suggets that the
> > parameters are passed wrongly somewhere on the way.
> 
> Does it work on the same kernel with -m64 ?
> In any case, for the tests to work the kernel needs to have been compiled with the
> kernel option CONFIG_FANOTIFY_ACCESS_PERMISSIONS set. In my initial tests this
> option wasn't set and I got EINVAL too.

It does work when compiled natively, i.e. without passing the -m32 to
the compiler commandline.

Something is wrong but I haven't yet found what.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
