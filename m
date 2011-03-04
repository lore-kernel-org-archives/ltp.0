Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvXng-0002SG-62
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:24:20 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvXnf-00082w-A7
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 16:24:20 +0000
Received: by wwb29 with SMTP id 29so3155909wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 08:24:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110304163712.7fd3b975@regolo>
References: <20110304163712.7fd3b975@regolo>
Date: Fri, 4 Mar 2011 08:24:13 -0800
Message-ID: <AANLkTimt_VmfCqt0zsneBY7xnn2V0vTHgKaWKNEvHuOp@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fstat05: fix regression on arches which get
	SIGSEGV
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

On Fri, Mar 4, 2011 at 7:37 AM, Cristian Greco <cristian@regolo.cc> wrote:
> Hi,
>
> this should fix a regression for fstat05 on some architectures.

Committed -- thanks!
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
