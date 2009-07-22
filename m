Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTVgy-0001JL-0E
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 06:52:44 +0000
Received: from rv-out-0708.google.com ([209.85.198.243])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTVgp-0004Ie-Ii
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 06:52:43 +0000
Received: by rv-out-0708.google.com with SMTP id b17so852646rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 23:52:35 -0700 (PDT)
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
	<364299f40907212138rb1f671eke3aabd6587c0f925@mail.gmail.com>
	<364299f40907212201u64779636v91ff74c45c32c3f3@mail.gmail.com>
	<200907220122.33944.vapier@gentoo.org>
Message-Id: <124D1FD0-1C6A-40D0-9754-DD87A3CF27DC@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <200907220122.33944.vapier@gentoo.org>
Mime-Version: 1.0 (iPhone Mail 7A341)
Date: Tue, 21 Jul 2009 23:52:25 -0700
Subject: Re: [LTP] LTP Intermediate Release for JULY 2009 Build Failures
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "ltp-list@lists.sf.net" <ltp-list@lists.sf.net>

On Jul 21, 2009, at 10:22 PM, Mike Frysinger <vapier@gentoo.org> wrote:

> On Wednesday 22 July 2009 01:01:34 Garrett Cooper wrote:
>> On Tue, Jul 21, 2009 at 9:38 PM, Garrett Cooper wrote:
>>> On Tue, Jul 21, 2009 at 2:28 PM, Mike Frysinger wrote:
>>>> On Tuesday 21 July 2009 10:21:44 Garrett Cooper wrote:
>>>>> I was tempted to fix the format string error, but I don't know  
>>>>> what
>>>>> the potential implications are of switching the data type from
>>>>> u_int64_t to unsigned long long...
>>>>
>>>> dont do that.  just use the proper format string from inttypes.h.
>>>> uint64_t f;
>>>> printf("f = %"PRIu64"\n", f);
>>>
>>
>> -       fprintf(stdout, "[%u] wait completed on %d: count=%llu\n",
>> +       fprintf(stdout, "[%u] wait completed on %d: count=%lu64\n",
>>                getpid(), fd, cntr);
>
> umm, you sure that's right ?  seems to me it'll output the number  
> followed by
> the string "64".  i think you need to look at my example again (and  
> take
> notice of the quote marks).

Your suggestion didn't compile and unfortunately the testcase appears  
to be broken. I'll retest when I get home.
Thanks!

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
