Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMZVn-0004hz-MI
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:32:31 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMZVi-0000UR-U8
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:32:31 +0000
MIME-Version: 1.0
In-Reply-To: <20090703031736.GK19135@count0.beaverton.ibm.com>
References: <20090702091341.GG19135@count0.beaverton.ibm.com>
	<364299f40907021918wb3f95e7w6fd24ec8208e7c0@mail.gmail.com>
	<20090703031736.GK19135@count0.beaverton.ibm.com>
Date: Thu, 2 Jul 2009 20:32:25 -0700
Message-ID: <364299f40907022032h1a940b6btf833954ed322bf90@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC][PATCH] Use prefix and other autoconf variables
	uniformly
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, Jul 2, 2009 at 8:17 PM, Matt Helsley<matthltc@us.ibm.com> wrote:
> On Thu, Jul 02, 2009 at 07:18:58PM -0700, Garrett Cooper wrote:
>> =A0 =A0 I understand what you're trying to accomplish, but part of the
>> point behind the current design with the Makefile system was in fact
>> for it to be run without intervention from autotools. Hence, the
>> directions noted in INSTALL / the help target up at the top.
>> Thanks,
>> -Garrett
>
> Suitable default files should fix the non-autotools path and allow the
> autotools path to use prefix and the other variables. Does that seem
> fine to you?

    Well, it's not just my call, but the rule of thumb in my book is
as long as default behavior can be maintained while maintaining as
much logical backwards compatibility as possible, it's definitely a
win-win.
With best regards,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
