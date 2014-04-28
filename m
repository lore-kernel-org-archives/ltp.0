Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WenUu-0001Ev-Cr
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 15:29:36 +0000
Date: Mon, 28 Apr 2014 17:28:41 +0200
From: chrubis@suse.cz
Message-ID: <20140428152841.GA6054@rei>
References: <5357D79C.40706@oracle.com> <20140423151426.GA15663@rei.suse.cz>
	<535E3447.6020003@oracle.com> <20140428133250.GA4956@rei>
	<535E72CC.9070109@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <535E72CC.9070109@oracle.com>
Subject: Re: [LTP] posix_fallocate
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> >> OK, I will add it to syscalls. What I would want is to make a wrapper,
> >> then substitute all calls of fallocate with it. And decision which
> >> function to call decided inside wrapper using command line option. So
> >> they would be called this way:
> >>
> >> ...
> >> fallocate01 fallocate01
> >> fallocate02 fallocate02
> >> fallocate03 fallocate03
> >>
> >> posix_fallocate01 fallocate01 -x
> >> posix_fallocate02 fallocate02 -x
> >> posix_fallocate03 fallocate03 -x
> >> ...
> > Or you can recompile the the binaries with -DUSE_POSIX_FALLOCATE and use
> > #ifdefs to choose which do you call.
> >
> > Looking at the testcases you will probable need to ifdef a few test
> > assertions (these where mode is not 0) too.
> 
> Just in one place in fallocate01, where it tests "FALLOC_FL_KEEP_SIZE" 
> mode. Still it would probably be better to have a  wrapper at least for 
> posix_fallocate, e.g. to preserve the way the code checks for errors, 
> because it returns error number and doesn't set "errno".

Ah, missed that in the manual page.

Creating wrapper that sets errno and returns -1 in case of
posix_fallocate() sounds reasonably.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
