Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWahl-0008Vj-D1
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:50:17 +0000
Received: from mail-px0-f190.google.com ([209.85.216.190])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWahk-0002J1-8U
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:50:17 +0000
Received: by pxi28 with SMTP id 28so518458pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 11:50:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A6D7367.70306@petalogix.com>
References: <20090724110008.GA11878@linux.vnet.ibm.com>
	<4A6AA306.3060107@petalogix.com>
	<364299f40907250948sb1a8cc5o7afba11ac2d83ef9@mail.gmail.com>
	<4A6D7367.70306@petalogix.com>
Date: Thu, 30 Jul 2009 11:50:10 -0700
Message-ID: <364299f40907301150x39bff3b1q7cf06d51f69aa03e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Submitting patch
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, Jyoti <jyotiv@linux.vnet.ibm.com>

Hi Michal,
    I want to straighten out some points before we get too deep into this t=
opic:

On Mon, Jul 27, 2009 at 2:29 AM, Michal Simek<michal.simek@petalogix.com> w=
rote:
> Hi Garrett,
>> On Fri, Jul 24, 2009 at 11:15 PM, Michal
>> Simek<michal.simek@petalogix.com> wrote:
>>
>>> Please fix coding style. Use tab instead of space for indentation.
>>>
>>
>>
> You wrote nice email and I have to react on it.

Thanks :). My intent wasn't to slam your idea, and I don't argue the
fact that we need a standard. It's just that whatever we use should be
a smart standard for what we're coding.

For instance, tabs / 8-space tabs don't make any sense for python code
as the implied defacto standard is 4 spaces per indent, and python
requires a certain degree of indentation.

My personal background and experience comes from the following
[style(9) from FreeBSD], where readability is compromised with a
respect for `space real estate' (from style(9) --
http://www.freebsd.org/cgi/man.cgi?query=3Dstyle&apropos=3D0&sektion=3D0&ma=
npath=3DFreeBSD+7.2-RELEASE
):

     Indentation is an 8 character tab.  Second level indents are four spac=
es.
     If you have to wrap a long statement, put the operator at the end of t=
he
     line.

	     while (cnt < 20 && this_variable_name_is_too_long &&
		 ep !=3D NULL)
		     z =3D a + really + long + statement + that + needs +
			 two + lines + gets + indented + four + spaces +
			 on + the + second + and + subsequent + lines;

     Do not add whitespace at the end of a line, and only use tabs followed=
 by
     spaces to form the indentation.  Do not use more spaces than a tab will
     produce and do not use spaces in front of tabs.

     Closing and opening braces go on the same line as the else.  Braces th=
at
     are not necessary may be left out.

which does conflict with the style guide from kernel.org. Then again
kernel.org is maintains almost purely kernel code, in which the tabs /
8-space tabs make perfect sense as the logic and branching should be
small.

>> There is nothing that states that 8-space tabs aren't appropriate in
>> the kernel.org coding / style guide:
>> http://www.kernel.org/doc/Documentation/CodingStyle
>>
>> Please stop saying that tabs are required. 8-space / tabs _are_
>> required according to the guide.
>>
> I invest a lot of time to fix testcases/kernel/syscalls. I used there
> tabs instead of spaces.
> You can use what you want but please keep in your mind.
> There should be one coding style for all source code. (for C, C++,
> Makefile, etc)
>
> If you want to use spaces instead of tab and you hate tab you can of cour=
se.
> I expect that if you replaced all tabs in every C code ltp code will
> grow up.
> I am not sure if only this change help anybody.
>
> IMHO use one tab instead of 8 spaces make more sense.

By and large, I would agree, but tab's really muck up reviewing diffs
too -- so as long as it's consistent should be used.

>> Please also thoroughly read through the document as it says 80-char
>> lines are preferred, etc. It does not say they are required.
>>
> There is not possible to have 80-char lines for every file but if you
> can use 80-chars line -
> you should do it. For large function is not possible to do it. If your
> function is large you should
> start to think how others will read it.
>> At the same time though, these guidelines do not necessarily apply to
>> userland apps, as far as the comment:
>>
>> "The answer to that is that if you need more than 3 levels of
>> indentation, you're screwed anyway, and should fix your program."
>>
>> is concerned. Yes, that's true for kernel code. No it's not
>> necessarily true for userland apps as more than 3 levels of branches
>> may be required.
>>
>> So, in conclusion, yes -- we should try to stick to the kernel.org
>> coding guidelines, but 1) we are not kernel.org and 2) we're not
>> producing kernel code, so the coding guidelines may be more of a
>> shoehorn fit than an appropriate one. It also doesn't apply to
>> anything beyond C/C++ code.
>>
> Really? But you should look at patches how they looks like. Code don't ha=
ve
> any style. If is preferable style for Cisco - it is your problem not
> mine. Your code
> present you and your coding style too. LTP contains a lot of code and I
> thought
> that will be good to clear.

Cisco code (as far as I can tell) lacks any form of style and is a
bloody hodgepodge of whatever the developer thought was best without
any form of structure, and I hate reading it ;)...

I'm fine matching my style to whatever the standard is, but we need to
decide upon a standard before we go touting that we should do it in
any particular format -- otherwise we'll confuse folks :)...

> Anyway this bring me up only troubles nothing else.
> It is up to Subrata what coding style/patches wants.
> I won't spend my time on cleaning LTP or disturb people.

Your energies are much appreciated, so please don't be discouraged by
what I'm saying too much -- I'm just suggesting that we follow
whatever Subrata / Mike decide is the standard for the project. Once
that's done, we can start cleaning up big time (and I'll gladly help);
style is important, along with documentation and usability... if one
of these points is lacking, it's generally a pain for either the end
user or a developer picking up the code later :)...

>> Mike/Subrata,
>> =A0 =A0 Can we actually write up a style guide for folks to follow that
>> applies for code, as the kernel.org guidelines don't apply that well
>> to our circumstances?
>>
> Thanks for your email -> it save me a lot of time for future.

No problem -- let's solve the problem once the big cheeses decide
what's best :).

>>>> PATCH IS CREATED FOR ltp-full-20090630.
>>>>
>>>> I am submitting a patch to kernel/fs/fs_di
>>>>
>>>> In this file data integity is performed by creating the file at
>>>> different directory depth and then by comparing with original file.
>>>>
>>>> To this I have added one more approach to perform integrity test.
>>>> 1. Creating two fragmented files each of size DiskSize/2.
>>>> 2. Then comapring against the original file.
>>>> 3. If not equal test case fails.
>>>>
>>>> My ultimate goal in creating fragmented files is that,
>>>> 1. It creates many extents (fragments for each file)
>>>> 2. FS code may behave wrong at corner cases which may come into picture
>>>> =A0 =A0after many extents gets added to the file.
>>>> 3. Data corruption chances are there
>>>> =A0 =A0 =A0i. when file metadata updation is not proper (corner cases =
when fragments are more)
>>>> =A0 =A0 =A0ii.If write and read is not matching (write operation might=
 have updated the block
>>>> =A0 =A0 =A0 =A0 number some where and read may skip that block in some=
 corner cases)
>>>> 4. In reality fragments can occur only after much usage of the disk(cr=
eate/delete file)
>>>> 5. This is good test case for bigger size disk.(it can create more ext=
ents)

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
