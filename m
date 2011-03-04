Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvXt8-0002km-LZ
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:29:58 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvXt7-0008BU-R3
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:29:58 +0000
Received: by wwb29 with SMTP id 29so427971wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 08:29:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110304170932.19819907@regolo>
References: <20110304170932.19819907@regolo>
Date: Fri, 4 Mar 2011 08:29:51 -0800
Message-ID: <AANLkTin_4rBGj5O-ZgTdu2C8nV6Lc9-pa9ig8NsAowAd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] kill05: fix regression
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

On Fri, Mar 4, 2011 at 8:09 AM, Cristian Greco <cristian@regolo.cc> wrote:
> Hi,
>
> this should fix a regression in kill05.
>
> Why did tst_resm/tst_exit get replaced by perror/exit in 84f181fd?

    Because it's a child process and child processes should _not_ use
libltp for sanity and to avoid introducing determinism, test bugs, and
for cluttering up output (remember: you have to communicate to the
user which process is actually doing the work, they're sharing file
descriptors potentially, etc).
    The proposed fix doesn't make sense though because do_master_child
always exits when the flow is executed correctly (i.e. there aren't
any early return statements from do_master_child, etc. Is it not
resuming the stack appropriately after it gets signaled? What's the
call flow exactly for the failure?
Thanks,
-Garrett

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
