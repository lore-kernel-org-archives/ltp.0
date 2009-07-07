Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOBrB-0000rQ-Ik
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 14:41:17 +0000
Received: from mail-vw0-f178.google.com ([209.85.212.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOBr6-0002wM-RL
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 14:41:17 +0000
MIME-Version: 1.0
In-Reply-To: <4A52F0D8.7060509@st.com>
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
	<364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
	<4A52F0D8.7060509@st.com>
Date: Tue, 7 Jul 2009 02:11:55 -0700
Message-ID: <364299f40907070211o5a93d556u8f7fffe50b106afe@mail.gmail.com>
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

On Mon, Jul 6, 2009 at 11:53 PM, Francesco RUNDO<francesco.rundo@st.com> wrote:
> Hi Garrett,
>
> thanks for your comment. Below, my consideration:
>
> Garrett Cooper wrote:
>
> On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO<francesco.rundo@st.com>
> wrote:
>
>
> Hi Gowri,
>
> I've already fixed the same issue you reported. I've tested it successfully.
>
> Subrata has already merged my patch (please, find it in attachment).
>
> Please, check it before to submit another patch.
>
>
> At the end of the day, the real problem is that we're not using the
> --with- functionality in autoconf, e.g. --with-cgroups, and instead
> we're hacking a lot of noise into Makefile's.
>
> Yes, you're right but your advice can't be applicable in the system in which
> autoconf is not supported/used to build LTP (a possible scenario in the
> embedded system).

Francisco,

Very soon cross-compilation will become a reality for LTP. We've been
using cross-compilation with LTP fairly thoroughly in-house, but the
solution's not even close to perfect. The one I'm working on now with
HEAD is a lot more holistic, and hence we should be able to do away
with manual compiles [of the source tree]. Manual submake compiles
will still be possible.

So, embedded systems can go back to executing code instead of
compiling it, like they should be... exercising *cc still is a good
workout for an embedded system's process [and threading] scheduler and
management system, but you can do it if you like and it'll no longer
be a hard requirement =].

Cheers,
-Garrett

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
