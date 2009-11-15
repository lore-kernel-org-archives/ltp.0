Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N9TrQ-0007we-2T
	for ltp-list@lists.sourceforge.net; Sun, 15 Nov 2009 01:25:00 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9TrJ-0005lv-Mi
	for ltp-list@lists.sourceforge.net; Sun, 15 Nov 2009 01:25:00 +0000
Received: by pwi12 with SMTP id 12so2827239pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Sat, 14 Nov 2009 17:24:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40911141619n544a879ci86383a90d6693890@mail.gmail.com>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
	<1257788375.7677.72.camel@subratamodak.linux.ibm.com>
	<8368651DACC1964480F951191B94A078017CB194@svexch01.mvista.com>
	<364299f40911092316q223d2073oc610dffc7474722b@mail.gmail.com>
	<8368651DACC1964480F951191B94A078017CB30A@svexch01.mvista.com>
	<364299f40911102212l2964e871r7477ae7959b566f6@mail.gmail.com>
	<8368651DACC1964480F951191B94A078017CB3C2@svexch01.mvista.com>
	<364299f40911120142y1c598494ha4172200704d2e48@mail.gmail.com>
	<8368651DACC1964480F951191B94A078017CB58B@svexch01.mvista.com>
	<364299f40911141619n544a879ci86383a90d6693890@mail.gmail.com>
Date: Sat, 14 Nov 2009 17:18:35 -0800
Message-ID: <364299f40911141718l31c2c6fbpa4ee3293eb73b3ed@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1,
	5: pass correct valuefor 	sigset_t for mips
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Sat, Nov 14, 2009 at 4:19 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Nov 12, 2009 at 5:57 PM, Henry Yei <hyei@mvista.com> wrote:
>>> -----Original Message-----
>>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>>> Sent: Thursday, November 12, 2009 1:43 AM
>>> To: Henry Yei
>>> Cc: subrata@linux.vnet.ibm.com; LTP Mailing List
>>> Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
>>> valuefor sigset_t for mips

[...]

>>
>> Attached is the poll01 patch with last_failed_errno and associated code removed.
>
> AHA! I figured out why sigset is sized differently on mips32 for you,
> compared to other architectures.
>
> Just like there's a compat_caddr_t datatype (which is explicitly set
> to char *), there's also a compat_sigset_t as well.
>
> Let me see if I can figure out this mystery, but my guess is that
> you're using n32 based mips, most likely on an Octeon model ;) ;)...
> which would account for what you're seeing here and possibly account
> for why the test consistently hangs on our Cavium boards at work (our
> version of Linux has been hacked so bad though to take shortcuts in
> the design process instead of following proper design procedure that
> it makes me cry inside...).

    Checked in the intermediate solution until we can figure out
whether or not compat_sigset_t is required for mips32.
Thanks!
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
