Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PgCM4-0000HN-CT
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:28:24 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PgCM3-0005KK-7U
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 08:28:24 +0000
Received: by wwi18 with SMTP id 18so1488434wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 21 Jan 2011 00:28:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110120143028.4df7ab81@regolo>
References: <20110120143028.4df7ab81@regolo>
Date: Fri, 21 Jan 2011 00:28:16 -0800
Message-ID: <AANLkTikt-TBmgTSqcRT4OY21udzxpuq-s0yGqirMrWFr@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Add tst_require_root to acct01 testcase.
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
To: Cristian Greco <cristian@regolo.cc>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 20, 2011 at 5:30 AM, Cristian Greco <cristian@regolo.cc> wrote:
> Hi,
>
> [ please keep CC as I'm not currently subscribed to the list ]
>
> please find attached a small fix to check for root privileges in
> acct(2) testcase (syscalls/acct/acct01.c).

    Thanks for spotting the issue. I've fixed it, added a few more
testcases, and discovered what appears to be a kernel bug on 2.6.34
(acct("/tmp/does/not/exist") should fail with == -1 and errno ==
ENOTDIR) :)...
Cheers,
-Garrett

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
