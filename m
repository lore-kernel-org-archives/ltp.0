Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bphilips@suse.de>) id 1MZXcY-0003JI-GB
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 22:09:06 +0000
Date: Fri, 7 Aug 2009 14:53:46 -0700
From: Brandon Philips <bphilips@suse.de>
Message-ID: <20090807215346.GB4184@jenkins.home.ifup.org>
References: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
	<20090721044529.GB9807@jenkins.home.ifup.org>
	<f5a7b3810907210622o1539087al1eca42cc900e9a02@mail.gmail.com>
	<f5a7b3810908070059x33ffce53n6b00e999232101e2@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3810908070059x33ffce53n6b00e999232101e2@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] mq_send/5-1.c: Fix race conditions in the test
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>

On 13:29 Fri 07 Aug 2009, naresh kamboju wrote:
> I have noticed issues for patch applied on 12-Dec-2008.
> Because it is fixing the mq_send/5-1.c problem, but at the same time
> patch is affecting the building of few test cases in the same
> directory.
> I have listed the build log before and after the patch.
> So I have modified the patch such a way that it should not affect
> other test cases.

Acked-by: Brandon Philips <bphilips@suse.de>

Thanks for doing this.

Cheers,

	Brandon

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
