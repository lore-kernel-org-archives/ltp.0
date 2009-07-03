Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMYSm-0001pq-Tj
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:25:20 +0000
Received: from an-out-0708.google.com ([209.85.132.243])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMYSm-00017z-Ff
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:25:20 +0000
Received: by an-out-0708.google.com with SMTP id c38so886693ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 19:25:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907022157.30535.vapier@gentoo.org>
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022058.43574.vapier@gentoo.org>
	<4B19CF3F-6820-48B8-BE63-8F9046C559DE@gmail.com>
	<200907022157.30535.vapier@gentoo.org>
Date: Thu, 2 Jul 2009 19:00:41 -0700
Message-ID: <364299f40907021900q5a9529favc07f84cd4ffd0d6a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Thu, Jul 2, 2009 at 6:57 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Thursday 02 July 2009 21:21:06 Garrett Cooper wrote:
>> Both sinclude and include are possible I suppose, but as far as I
>> understand that actually does an fstat, tries to open the file, etc,
>> but this completely ignores the include statement and reduces I/O a bit.
>
> yes, it'll remove a syscall or two, but i dont think that is significant in
> the larger scheme of things
>
> the problem is that i dont want these kind of ifdef things propagating as
> they'll get tweaked and go inconsistent all over the place
>
> how about include a top level .mk file that always exists and in there, you
> have the conditional config.mk include
> -mike

I couldn't agree more :)...

FWIW using include all over the place has footprint implications
(somewhere on the order of 2~3 times longer when taxing the fs a bit
more), so it could be a boon to multijob compiles to go with sinclude
/ -include.

People already complain about compiling LTP in my group -- I'm just
trying to give them less of a reason to complain :)..

Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
