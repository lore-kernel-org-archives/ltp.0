Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MN7vc-0007Qm-FL
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2009 16:17:28 +0000
Received: from rv-out-0708.google.com ([209.85.198.247])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MN7vY-00013k-6T
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2009 16:17:28 +0000
Received: by rv-out-0708.google.com with SMTP id b17so860965rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Sat, 04 Jul 2009 09:17:23 -0700 (PDT)
References: <364299f40907040039y15f642b1ue8d92b1823a12821@mail.gmail.com>
	<200907040345.22922.vapier@gentoo.org>
Message-Id: <B18763B3-319C-410E-92BB-EF7CFEAC6E7F@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <200907040345.22922.vapier@gentoo.org>
Mime-Version: 1.0 (iPhone Mail 7A341)
Date: Sat, 4 Jul 2009 09:17:01 -0700
Subject: Re: [LTP] subdir make with LTP
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Nate Straz <nate-ltp@refried.org>

On Jul 4, 2009, at 12:45 AM, Mike Frysinger <vapier@gentoo.org> wrote:

> On Saturday 04 July 2009 03:39:08 Garrett Cooper wrote:
>> Hi Mike, Nate, and Subrata,
>>    Although some people may be unhappy with this change, I was
>> thinking of `breaking' subdirectory based make operations with LTP as
>> this would overcomplicate the make system logic a great deal with a
>> bunch of cookie cutter logic that will grow stale and become a pain  
>> to
>> maintain.
>>    Is this something that would be a desired feature moving forward
>> or something we can official drop?
>>    Subdir based Make would still function by specifying srcdir= on
>> the command line, but doing a bare command like the following:
>>
>>    cd testcases/kernel/syscalls && make all
>>
>>    would fail.
>
> that would annoy me greatly as this is my primary mode of ltp usage
> -mike

Ok. I'll keep that feature then, but this will considerably increase  
noise in the Makefiles.

Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
