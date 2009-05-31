Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MAqhH-0007Wa-Nh
	for ltp-list@lists.sourceforge.net; Sun, 31 May 2009 19:27:55 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MAqhG-00089c-8G
	for ltp-list@lists.sourceforge.net; Sun, 31 May 2009 19:27:55 +0000
Received: by fxm25 with SMTP id 25so6962980fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Sun, 31 May 2009 12:27:52 -0700 (PDT)
Message-ID: <4A22DA33.5050601@petalogix.com>
Date: Sun, 31 May 2009 21:27:47 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A1E5847.6030807@petalogix.com>
	<200905290912.31947.vapier@gentoo.org>
	<4A2142A0.2040301@petalogix.com>
	<200905301816.32273.vapier@gentoo.org>
In-Reply-To: <200905301816.32273.vapier@gentoo.org>
Subject: Re: [LTP] Installing outside LTP source
Reply-To: michal.simek@petalogix.com
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
Cc: LTP <ltp-list@lists.sourceforge.net>, Jiri Palecek <jpalecek@web.de>

Mike Frysinger wrote:
> On Saturday 30 May 2009 10:28:48 Michal Simek wrote:
>   
>> Mike Frysinger wrote:
>>     
>>> On Thursday 28 May 2009 05:24:23 Michal Simek wrote:
>>>       
>>>> I would to ask you if someone works or worked on moving LTP to Kbuild.
>>>>         
>>> the Subject line doesnt really seem to line up with this question.  what
>>> exactly do you want to do and why do you think Kbuild is the solution ?
>>> saying "let's switch to Kbuild!" without any rhyme or reason sounds like
>>> a lot of work for no gain.
>>>       
>> I wanted to wrote two emails instead of one - that's why was there 2
>> different things.
>> 1. disable compilation "verbose" mode and turn on it with V=1.
>>     
>
> meh.  `make -s` seems to work fine enough for me.  most people arent reviewing 
> the output for warnings and similar issues, so i dont really see much point of 
> having quiet output in LTP.
>   
People don't do it because that warnings are hidden in huge log. It will
be good to run
sparse too.
>   
>> 2. Move all binaries outside of LTP source code O=/path
>>     
>
> you mean out-of-tree compilation.  you can use lndir to get the same 
> functionality, but it isnt really an optimal method.
>
>   
>> 3. I use only some parts of LTP for my testing and it will be good to
>> enable/disable just tests which you want to use.
>>     
>
> you can run `make` in only the dirs you care about.  how deep do you actually 
> want to get ?  having Kconfig entries for every single test (i.e. 
> kernel/syscalls/{getsid,pipe}0{1,2} .....) is crazy.
>   
Yes, I agree that make no sense to add all syscalls test for example to
Kconfig but
I can imagine tests for noMMU as are currently wrote in Makefile. For
example will be good for all to know
why are some tests exclude for noMMU.
Maybe any handling for older glibc with missing some syscalls to prevent
build failure.
Setup global cflags and cross compiler.
If you look to runtest for testing description, make sense to me have
all that filenames as Kconfig option and
enable/disable that tests.

>   
>> 4. If is possible clean all Makefiles
>>     
>
> dont really know what that means
>   
this point depended on descriptions below. I think we talked about once
in past.

There are a lot of additions like CFLAGS, LDLIBS.
CFLAGS += -I../../../../include -Wall
LDLIBS += -L../../../../lib -lltp

I think that install and clean parts could be possible to clean too and
have Makefiles with
one or two lines  like  test-y +=test_name

Is it possible to do with Kbuild? That the same question as I had in
previous email.

>   
>> I don't have much experience with Kbuild I had just quick look.  I looked at
>> uClinux distribution
>>     
>
> the uClinux distro is really an example you should look at.  the kconfig comes 
> from the kernel, but all of the Makefiles are custom done.
yes, but for example in LTP we don't need to use many custom Makefiles
(There are some like ebizzy, boost, preempt-test and some others)
the rest are LTP specific Makefiles.

Michal

>   the features it 
> has arent terribly relevant.
> -mike
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
