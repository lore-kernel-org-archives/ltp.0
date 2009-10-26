Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1N2Ocp-0003RP-Hi
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 12:24:39 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2Ocd-0004hp-IK
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 12:24:34 +0000
Message-ID: <4AE593FF.9070905@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2009 17:50:15 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4AE19E86.8070100@linux.vnet.ibm.com>
	<364299f40910230844n7650eb82y1deb56b062e809a8@mail.gmail.com>
	<364299f40910231450l36536a7blc395fa95c7bddc37@mail.gmail.com>
	<364299f40910250342w6343b8bl6af6884d25790740@mail.gmail.com>
In-Reply-To: <364299f40910250342w6343b8bl6af6884d25790740@mail.gmail.com>
Subject: Re: [LTP] [PATCH] realtime: fix broken build configuration files
 and warnings
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sf.net

Garrett Cooper wrote:
> On Fri, Oct 23, 2009 at 2:50 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Fri, Oct 23, 2009 at 8:44 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
>>> On Fri, Oct 23, 2009 at 5:16 AM, gowrishankar
>>> <gomuthuk@linux.vnet.ibm.com> wrote:
>>>> Hi Subrata,
>>>> Please accept the patch below.
>>>>
>>>> Thanks,
>>>> Gowri
>>>    I'll get back to you on this in a day Gowri... there are some
>>> things I wanted to note.
>> Hi Gowri,
>>    I've reviewed the changes and checked in the ones that were OK,
>> and definitely needed to be fixed. There are a few items that I'm
>> unsure about with your proposed changes in the Makefiles that need to
>> be discussed:
>> 1. I'm trying to make sure that out-of-build-tree functionality isn't
>> broken. In order to do that, as you see I had to use abs_builddir and
>> abs_srcdir, instead of just realtimedir.
>> 2. config.mk shouldn't be included by lib/Makefile -- otherwise I have
>> to add LDLIBS += -lrealtime to all Makefiles that require that
>> library. So by virtue of laziness and keeping things common, it's best
>> just to add the required variables and includes in lib/Makefile.
>>    This patch has been attached as realtime-makefile-fixes.diff.
>>    Now, for the other part that I don't agree with 100%, but I agree
>> needs fixing:
>>
>> Index: func/pi-tests/Makefile
>> ===================================================================
>> RCS file: /cvsroot/ltp/ltp/testcases/realtime/func/pi-tests/Makefile,v
>> retrieving revision 1.2
>> diff -u -r1.2 Makefile
>> --- func/pi-tests/Makefile      9 Oct 2009 17:56:07 -0000       1.2
>> +++ func/pi-tests/Makefile      23 Oct 2009 21:36:02 -0000
>> @@ -24,4 +24,15 @@
>>
>>  include $(top_srcdir)/include/mk/env_pre.mk
>>  include $(abs_srcdir)/../../config.mk
>> +
>> +MAKE_TARGETS           := testpi-0
>> +
>> +ifeq ($(HAVE_PI_MUTEX), yes)
>> +MAKE_TARGETS           += testpi-1 testpi-2 testpi-4 testpi-5 testpi-7
>> +endif
>> +
>> +ifeq ($(HAVE_ROBUST_MUTEX), yes)
>> +MAKE_TARGETS           += testpi-6 sbrk_mutex
>> +endif
>> +
>>
>>    I agree that these should be toggable or built appropriate to
>> whether or not the system has this kind of functionality. The method
>> used to determine whether or not a system has this functionality is
>> questionable though, and I believe all of this can be established
>> through additional autoconf tests added to the $(abs_top_srcdir)/m4 --
>> do you agree with this?
>>    Is the realtime test suite this made available as a separate
>> package outside of LTP in-house at IBM, or is it strictly available
>> with LTP?
>>    Once these build integration issues are resolved, should it be
>> enabled by default, or still remain an optional package to build and
>> execute?
>>    Should this component have a runtest file as well so it can be
>> integrated into the execution portion of LTP?
>>    Finally, I also discovered some QA issues with rt-migrate.c (diff
>> attached as well); I patterned the code to match the other tests. Do
>> you agree with the fixes?
> 
> Gowri,
>     I read more about the project and determined what the scope was,
> so I created and integrated testcases/realtime into the rest of the
> autoconf infrastructure, but as a subcomponent in LTP.
>     So if you check out LTP from HEAD as of a few moments ago, you'll
> discover that all of the issues you reported have been fixed (AFAIK)
> and all of the unnecessary autoconf-like scripts and additional
> autoconf-related files and directories have been cleaned out.
>     The directions for compiling realtime by itself are the same as
> the rest of LTP:
> 
Garrett,
First of all, thanks a lot for assisting me in getting RT tests neatly
built. Seems like, you are missing macro files:

aclocal: couldn't open directory `/test/ltp/testcases/realtime/m4': No such file 
or directory

Can you please checkin those as well.

Thanks,
Gowri


> make autotools
> ./configure
> make all
> make install
> 
>     This is only required when doing this as a subcomponent, as this
> is already handled with the same commands above issued from the
> top-level LTP source directory.
> HTH,
> -Garrett
> 


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
