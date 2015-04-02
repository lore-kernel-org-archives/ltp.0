Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ydc48-0004rG-TN
	for ltp-list@lists.sourceforge.net; Thu, 02 Apr 2015 10:09:36 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 072C0AD4F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  2 Apr 2015 10:09:29 +0000 (UTC)
Date: Thu, 2 Apr 2015 12:09:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150402100925.GB28953@rei>
References: <20150323094302.GA6349@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150323094302.GA6349@rei>
Subject: Re: [LTP] LTP release
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> It's about the time we start to prepare for next release. I will
> (hopefully) start runing latest git code and look for unexpected
> failures during this week. Everybody please try to run the latest
> git code and report any problems.

I've seen email from Jan that the release is green from his side.
(haven't got it because we had an email outgate in the SUSE and it seems
some emails were lost :(, if you get errors for my suse email account do
not hestitate to resend).

What is the status from the rest of you?

From my side, I've fixed a few problem I've found but there are still
two things I want to fix before the release.

One is aligment bug causing aiocp with O_DIRECT exit with EINVAL on
s390x with 4096 block size. That should be fixed with block size
autodetection for O_DIRECT.

And the second is with the rewrite of the exec* testcases (without the p
in the name). The problem is that the machinery that runs tests in SUSE
does not execute the testcases in the $LTPROOT/testcases/bin directory,
and these testcases fail to find the child binary. Solution I have in
mind is to create a function similar to tst_dataroot() that will fill a
buffer with a path to the binary (so that the tests works both in git
checkout and executed from installed tree). Is anybody opposed to this
idea?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
