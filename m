Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxsvW-0002LA-TU
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 01:45:18 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxsvP-0006jk-5k
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 01:45:18 +0000
Received: by pzk26 with SMTP id 26so9519005pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 18:45:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091013074414.22414.46233.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
	<20091013074414.22414.46233.sendpatchset@localhost.localdomain>
Date: Tue, 13 Oct 2009 18:38:12 -0700
Message-ID: <364299f40910131838n1bcf8ed4u1ff121c87987d366@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch 5/6] Modified master script to pass appropriate
	arguments
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

On Tue, Oct 13, 2009 at 12:44 AM, Poornima Nayak
<mpnayak@linux.vnet.ibm.com> wrote:
> Modified master script to pass appropriate arguments for cpu consolidation
> test cases.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Sorry for not commenting sooner.

You could use a while loop with an initial value and increment in the
loop instead of `for i in $(seq {0,1} $max)'; that's guaranteed to
work better with systems that don't have seq(1) ;)...

Thanks!
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
