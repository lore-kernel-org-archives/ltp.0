Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZF1oT-0006kD-Ei
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 15:08:05 +0000
Date: Tue, 14 Jul 2015 17:06:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150714150634.GB8286@rei.suse.de>
References: <1436856423-5444-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
	<20150714142401.GA8286@rei.suse.de>
	<912685955.17420609.1436885866542.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <912685955.17420609.1436885866542.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] lib/safe_macros.c: fix safe_write() and
 safe_pwrite()
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
> > Ok, this was wrong because with len_strict == 1 and rval == -1 we will
> > cast -1 to (size_t) which will yield 2^64 - 1. In practice this was
> > working fine since nobody would call write with such large buffer...
> > 
> > Newertless it's better as it is now, but commit message could have been
> > better since as far as I can see the len_strict flag was working fine.
> > 
> > Because when len_strict == 1 the result was computed as:
> > 
> > if ((0 && whatever) || rval != nbyte) -> if (0 || rval != nbyte) -> if (rval
> > != nbyte)
> > 
> > which worked fine for all practical purposes. Or am I missing something?
> 
> Also, when len_strict == 0 and less bytes were written than requested,
> it would report TBROK. With len_strict == 0 it should TBROK only when
> rval is -1.

Ah, that is what I missed. The commit message should said that the lengh
was checked in all cases...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
