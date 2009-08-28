Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <adilger@sun.com>) id 1MgxoZ-0002WR-0y
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:32:11 +0000
Received: from sca-es-mail-1.sun.com ([192.18.43.132])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.69) id 1MgxoS-0003PE-A6
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 09:32:10 +0000
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id
	n7S9TfqN011933 for <ltp-list@lists.sourceforge.net>;
	Fri, 28 Aug 2009 02:29:58 -0700 (PDT)
MIME-version: 1.0
Content-disposition: inline
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
	(Sun Java(tm) System Messaging Server 7u2-7.04 64bit (built Jul 2
	2009)) id <0KP200J00YCJZK00@fe-sfbay-10.sun.com> for
	ltp-list@lists.sourceforge.net; 
	Fri, 28 Aug 2009 02:29:41 -0700 (PDT)
Date: Fri, 28 Aug 2009 03:29:47 -0600
From: Andreas Dilger <adilger@sun.com>
In-reply-to: <20090827101646.12497.73776.sendpatchset@subratamodak.linux.ibm.com>
Message-id: <20090828092947.GF4197@webber.adilger.int>
References: <20090827101646.12497.73776.sendpatchset@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Updated fsx.c program
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, Eric Sandeen <esandeen@redhat.com>
Cc: Dave Jones <davej@redhat.com>, linux-ext4@vger.kernel.org, LTP List <ltp-list@lists.sourceforge.net>

On Aug 27, 2009  15:46 +0530, Subrata Modak wrote:
> >On Tue, 2009-08-25 at 23:25 -0600, Andreas Dilger wrote:
> >I've done some work to merge some of the existing fsx.c mods into a
> > single version.  Over & above the version that is in the LTP, I've
> > included AKPM's O_DIRECT fixes (with a twist), the BSD mmap page and
> > segfault handling, and per-write fsync.
> > 
> > The twist for the O_DIRECT feature is that it will randomly open file
> > descriptors with O_DIRECT, and if you use the Lustre-inspired multi-fd
> > support fsx will be testing concurrent buffered and O_DIRECT and mmap
> > IO on the same file.
> 
> The following patch will integrate your new fsx.c program in LTP, by replacing
> (http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/fs/fsx-linux/fsx-linux.c)
> the existing one. Would you mind providing a Sign-off for the below Patch ?
> 
> Patch-prepared-for-ltp-by: Subrata Modak <subrata@linux.vnet.ibm.com>

Signed-off-by: Andreas Dilger <adilger@sun.com>

> @@ -1,5 +1,4 @@
>  /*
> - * Copyright (C) 1991, NeXT Computer, Inc.  All Rights Reserverd.
>   * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
>   *
>   * @APPLE_LICENSE_HEADER_START@

This hunk should be removed from this patch.  This copyright was recently
re-added into LTP from the very original fsx implementation, from looking
at the commit logs.

> +static const char *my_basename(const char *path)
> +{
> +	char *c = strrchr(path, '/');
> +
> +	return c ? c++ : path;
> +}

I think you can also remove this function for the LTP version.  We need
to be able to run fsx on very old distros that our customers still use,
where basename() isn't declared properly, but this was recently removed
in the LTP version (presumably because it is used only on modern distros).

> +int do_fallocate(int fd, int flags, loff_t offset, loff_t maxlen)
> +{
> +#ifdef FALLOC_FL_KEEP_SIZE
> +	return fallocate(fd, flags, offset, maxlen);
> +#else
> +#define FALLOC_FL_KEEP_SIZE 0x01
> +#ifdef __i386__
> +#define __NR_fallocate		324
> +	return syscall(__NR_fallocate, fd, flags, offset, maxlen);
> +#elif defined (__powerpc__)
> +#define __NR_fallocate          309
> +	return syscall(__NR_fallocate, fd, flags, offset >> 32,
> +		       offset & 0xffffffff, maxlen >> 32, maxlen & 0xffffffff);
> +#else  /* !__i386__ && !__powerpc__ */
> +	errno = ENOSYS;
> +	return -1;
> +#endif /* __i386__ */
> +#endif /* FALLOC_FL_KEEP_SIZE */
> +}

As an FYI (largely to Eric Sandeen) the fallocate support is only
for the initial file data.  I was thinking of adding the ability
to add OP_FALLOC operations (both keep size and extend size) to
give better stress testing of falloc.  Sadly, I ran out of time
for implementing that.  Did you ever do something similar?

> +void
> +segv(int sig)
> +{
> +	if (jmpbuf_good) {
> +	    jmpbuf_good = 0;
> +	    longjmp(jmpbuf, 1);

Can you please fix the indenting here to use tabs...

Cheers, Andreas
--
Andreas Dilger
Sr. Staff Engineer, Lustre Group
Sun Microsystems of Canada, Inc.


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
