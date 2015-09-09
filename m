Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZfPM-0007O8-Am
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 13:27:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZfPL-0005yw-Ah
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2015 13:27:28 +0000
Date: Wed, 9 Sep 2015 15:26:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150909132641.GA13764@rei.suse.cz>
References: <dde73925917fe3524a598d859fdb66ca95711fc3.1441798744.git.jstancek@redhat.com>
	<20150909123737.GA13664@rei.suse.cz>
	<559206696.7848057.1441803641337.JavaMail.zimbra@redhat.com>
	<20150909130934.GA13918@rei.suse.cz>
	<870837936.7873040.1441805002410.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <870837936.7873040.1441805002410.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] mprotect04: fix powerpc crash when copying
 exec_func
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > I'm seeing this on RHEL6.7 kernel, I haven't tried latest upstream yet.
> > 
> > Ah, you are right, the memory is not touched in the write_null()
> > function at all.
> 
> Right, I got confused by "access_ok(VERIFY_READ, buf, count)"
> in vfs_write(), but after reading code and comments it's clear it
> only checks if range _may_ be valid:
>  * access_ok: - Checks if a user space pointer is valid
>  ...
>  * Returns true (nonzero) if the memory block may be valid, false (zero)
>  * if it is definitely invalid.
>  *
>  * Note that, depending on architecture, this function probably just
>  * checks that the pointer is in the user space range - after calling
>  * this function, memory access functions may still return -EFAULT.

I do not have further questions. Acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
