Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MbWEa-0008Ee-7h
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 09:04:32 +0000
Received: from mail-qy0-f181.google.com ([209.85.221.181])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbWEN-0003ii-EH
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 09:04:24 +0000
Received: by qyk11 with SMTP id 11so539859qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Aug 2009 02:04:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200908130346.26150.vapier@gentoo.org>
References: <4A77F5D9.8030101@petalogix.com>
	<200908130346.26150.vapier@gentoo.org>
Date: Thu, 13 Aug 2009 02:04:13 -0700
Message-ID: <364299f40908130204h609050e7g702a415f2559c29e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Extended return flag
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
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>

On Thu, Aug 13, 2009 at 12:46 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Tuesday 04 August 2009 04:48:25 Michal Simek wrote:
>> I am thinking that will be good to extend return flag for function not
>> implemented (errno 38) because
>> some of tests return it when you don't have enable that option is kernel
>> config.
>> What do you think?
>
> what "return flag" are you talking about ? =A0do you mean test status like
> TINFO/TBROK/etc... ?

I was wondering about this earlier -- why wouldn't TCONF be sufficient?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
