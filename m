Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MY361-0007YP-Sl
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 19:21:21 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MY35t-0006nK-8n
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 19:21:20 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1660252qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Aug 2009 12:21:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OFF7000B3B.0D392BE9-ON85257607.00640FF0-85257607.00669C2B@us.ibm.com>
References: <364299f40907310138v2708c6dfmb378df4004669c4f@mail.gmail.com>
	<1249298430.7460.29.camel@subratamodak.linux.ibm.com>
	<OFF7000B3B.0D392BE9-ON85257607.00640FF0-85257607.00669C2B@us.ibm.com>
Date: Mon, 3 Aug 2009 12:21:07 -0700
Message-ID: <364299f40908031221k4b16e410xf22ea445237579b2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix C coding issues and integrate ima into LTP
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
To: Mimi Zohar <zohar@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Aug 3, 2009 at 11:40 AM, Mimi Zohar<zohar@us.ibm.com> wrote:
> Subrata Modak <subrata@linux.vnet.ibm.com> wrote on 08/03/2009 07:20:30
> AM:
>
>
>> This as well for Mimi.
>>
>> Regards--
>> Subrata
>
> Thanks for copying me.
>
>> On Fri, 2009-07-31 at 01:38 -0700, Garrett Cooper wrote:
>> > 1. None of the ima C files which required openssl/sha.h were using the
>> > HAVE_OPENSSL_SHA_H macro define.
>> > 2. Add tst_resm support.
>> > 3. Fix some missing includes in ima_mmap.c.
>> > 4. Remove an unused var.
>> > 5. Shuffle around some fields in ima_boot_aggregate.c so that it
>> > compiles with -Wunused and consumes less memory when 1. applies.
>> >
>> > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> This patch doesn't apply against either the June/July tar.
> Which ltp version was used?

It was against a spot off HEAD between June / July, as that's where I
started the makefile-infra-rework branch.

If you want another patch directly against HEAD, let me know. Or I'll
just wait a few days and sync before the first set of reviews before
the master collapse gets underway.

Thanks,
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
