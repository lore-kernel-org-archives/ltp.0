Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mz1rx-0004hj-Aj
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 05:30:21 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mz1rn-0004cp-4i
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 05:30:21 +0000
Received: by pzk37 with SMTP id 37so2238563pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Oct 2009 22:30:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910162226h3266a625j96b408bf3632f530@mail.gmail.com>
References: <364299f40910162226h3266a625j96b408bf3632f530@mail.gmail.com>
Date: Fri, 16 Oct 2009 22:30:05 -0700
Message-ID: <364299f40910162230u4a9ed97et6336d1191e1ec54b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Issue with autoconf not honoring linux/types.h
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Fri, Oct 16, 2009 at 10:26 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> Hi Mike,
> =A0 =A0Looking at the configure log, autoconf is incorrectly pruning
> linux/types.h from the list of headers, and as such linux/taskstats.h
> fails to compile successfully.
> =A0 =A0Do you have any idea how I should fix this noise?
> AC_DEFAULT_INCLUDES didn't help.
> =A0 =A0The log snippet and the m4 file (minus the comments) are attached.
> Thanks,
> -Garrett
>
> ### ltp-taskstats.m4 ###
>
> AC_DEFUN([LTP_CHECK_TASKSTATS],
> _LTP_CHECK_TASKSTATS_FREEPAGES
> )
>
> AC_DEFUN([_LTP_CHECK_TASKSTATS_FREEPAGES],[
> AC_INCLUDES_DEFAULT([
> #include <linux/types.h>
> ])
> AC_CHECK_HEADERS_ONCE([linux/taskstats.h],[
> =A0 =A0AC_CHECK_MEMBERS([struct taskstats.freepages_count, struct
> taskstats.nvcsw, struct taskstats.read_bytes],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [],[],[dnl
> #include <linux/taskstats.h>
> ])
> ])
> ])

AHA. AC_CHECK_HEADERS_ONCE was the culprit. Fixed now 8-).
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
