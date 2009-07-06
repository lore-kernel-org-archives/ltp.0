Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNrzE-0006Nh-GM
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:28:16 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNryz-00034g-SX
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 17:28:16 +0000
MIME-Version: 1.0
In-Reply-To: <4A51E253.200@st.com>
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
Date: Mon, 6 Jul 2009 10:28:00 -0700
Message-ID: <364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sf.net

On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO<francesco.rundo@st.com> wrote:
> Hi Gowri,
>
> I've already fixed the same issue you reported. I've tested it successfully.
>
> Subrata has already merged my patch (please, find it in attachment).
>
> Please, check it before to submit another patch.

At the end of the day, the real problem is that we're not using the
--with- functionality in autoconf, e.g. --with-cgroups, and instead
we're hacking a lot of noise into Makefile's.

Also, you could have called SUBDIRS += once, like so:

+SUBDIRS += cgroup cpuctl memctl io-throttle freezer cpuset

I can tell at first glance that that Makefile is a mess anyhow,
because it's referencing _hardcoded_ /proc references and as such will
fail to cross-compile properly if the target or the host are setup
differently from one another, in the following two scenarios:

1. host has cgroups support and target doesn't. host will force the
cgroups testcases to compile, and we'll either run into make failures,
or CONF (if the source is setup properly).
2. target has cgroups support and host doesn't. target will miss out
on cgroups testcases.

Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
