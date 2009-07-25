Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MUkQV-0004Hk-6P
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 16:48:51 +0000
Received: from wf-out-1314.google.com ([209.85.200.170])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MUkQO-0000iF-KM
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 16:48:51 +0000
Received: by wf-out-1314.google.com with SMTP id 26so619522wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 25 Jul 2009 09:48:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A6AA306.3060107@petalogix.com>
References: <20090724110008.GA11878@linux.vnet.ibm.com>
	<4A6AA306.3060107@petalogix.com>
Date: Sat, 25 Jul 2009 09:48:38 -0700
Message-ID: <364299f40907250948sb1a8cc5o7afba11ac2d83ef9@mail.gmail.com>
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

On Fri, Jul 24, 2009 at 11:15 PM, Michal
Simek<michal.simek@petalogix.com> wrote:
> Please fix coding style. Use tab instead of space for indentation.

There is nothing that states that 8-space tabs aren't appropriate in
the kernel.org coding / style guide:
http://www.kernel.org/doc/Documentation/CodingStyle

Please stop saying that tabs are required. 8-space / tabs _are_
required according to the guide.

Please also thoroughly read through the document as it says 80-char
lines are preferred, etc. It does not say they are required.

At the same time though, these guidelines do not necessarily apply to
userland apps, as far as the comment:

"The answer to that is that if you need more than 3 levels of
indentation, you're screwed anyway, and should fix your program."

is concerned. Yes, that's true for kernel code. No it's not
necessarily true for userland apps as more than 3 levels of branches
may be required.

So, in conclusion, yes -- we should try to stick to the kernel.org
coding guidelines, but 1) we are not kernel.org and 2) we're not
producing kernel code, so the coding guidelines may be more of a
shoehorn fit than an appropriate one. It also doesn't apply to
anything beyond C/C++ code.

Mike/Subrata,
    Can we actually write up a style guide for folks to follow that
applies for code, as the kernel.org guidelines don't apply that well
to our circumstances?
Thanks,
-Garrett

>> PATCH IS CREATED FOR ltp-full-20090630.
>>
>> I am submitting a patch to kernel/fs/fs_di
>>
>> In this file data integity is performed by creating the file at
>> different directory depth and then by comparing with original file.
>>
>> To this I have added one more approach to perform integrity test.
>> 1. Creating two fragmented files each of size DiskSize/2.
>> 2. Then comapring against the original file.
>> 3. If not equal test case fails.
>>
>> My ultimate goal in creating fragmented files is that,
>> 1. It creates many extents (fragments for each file)
>> 2. FS code may behave wrong at corner cases which may come into picture
>> =A0 =A0after many extents gets added to the file.
>> 3. Data corruption chances are there
>> =A0 =A0 =A0i. when file metadata updation is not proper (corner cases wh=
en fragments are more)
>> =A0 =A0 =A0ii.If write and read is not matching (write operation might h=
ave updated the block
>> =A0 =A0 =A0 =A0 number some where and read may skip that block in some c=
orner cases)
>> 4. In reality fragments can occur only after much usage of the disk(crea=
te/delete file)
>> 5. This is good test case for bigger size disk.(it can create more exten=
ts)

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
