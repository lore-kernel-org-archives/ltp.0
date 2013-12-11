Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vqprd-0007xf-5Z
	for ltp-list@lists.sourceforge.net; Wed, 11 Dec 2013 19:54:33 +0000
Date: Wed, 11 Dec 2013 20:53:55 +0100
From: chrubis@suse.cz
Message-ID: <20131211195354.GA31489@rei>
References: <1385545013-22647-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385545013-22647-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/2] configure: add configure check for GCC
 built-in function
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> New m4 function tries to determine if GCC has __sync_fetch_and_or built-in
> function which performs an atomic bit-wise inclusive OR operation.

The code itself is correct, but it gets me thinking if silently using
the unsafe variant if the buildins are not available is a good idea.

Because after we add the buildins everybody would start to assume that
the library is thread safe but under certain circumstances in may not.
(Currently there is status quo and nobody has said whether it is safe or
not.)

Which will lead to situation where the likehood of the failure will
slowly increase as everybody will write the test code under an
assumption that the library is thread safe...

So we should either:

1) decleare the test library thread unsafe

2) make it thread safe for everybody

3) abort the compilation if atomic operations are not found
   (which may be possible, but we need to do a research for
    the atomic memory primitives availability)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
