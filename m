Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkaKp-0000Ax-5m
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:48:43 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkaKo-0005Aj-7P
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:48:43 +0000
Received: by pwi5 with SMTP id 5so4846361pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 01:48:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100225093304.GA23984@linux.vnet.ibm.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2010 01:48:35 -0800
Message-ID: <364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][RESEND] RTC Device Driver Tests
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
To: Silesh C V <saileshcv@gmail.com>, Garrett Cooper <yanegomi@gmail.com>, subrata@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On Thu, Feb 25, 2010 at 1:33 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Feb 25, 2010 at 02:39:37PM +0530, Silesh C V wrote:
>> >>
>> >> =A0 =A0The end goal is to have these tests fit directly into LTP with=
out
>> >> having to fudge around writing a secondary driver, thus maintaining
>> >> two pieces of dependent code [which is of course more complicated than
>> >> one piece of code], and thus is more of a pain to maintain longterm.
>> >> There's a lot of code in the repository like this that was ported and
>> >> subsequently not properly adapted to the existing infrastructure, thus
>> >> creating additional headache for maintainers and end-users.
>> >
>> > Ok -- I take that back. I have no idea wtf is going on in this
>> > directory nor the ultimate intent of the tests in here, apart from
>> > being a lot of ad hoc pain in the arse-ness.
>>
>> The README in testcases/kernel/device-drivers/ says that these tests
>> should not be run with the other tests, and they have to be built
>> separately. I agree that this is because they have a kernel space part
>> also. But this prevents us from =A0building =A0device_driver tests that
>> have only user space part (as in RTC tests), along with the overall
>> build. And these tests does not belong in any other directory other
>> than kernel/device-drivers. So as long as other tests are there we
>> will have to live with building new device driver tests separately.I
>> can re-send =A0the patch with Garrett's suggestions =A0incorporated.
>>
>> Subrata, suggestions ?
>
> Hi Silesh,
>
> How about porting this on new makefile infrastructure ? I think this is
> time where we can look back and can make one piece of code as garret
> said is correct. Please see your fesibility. Let me know if you still
> want this to be integrated. Before that can you please little more
> descriptive with your patch e,g: what it is doing.
>
> And also it is always good if you include more documentation for each
> function as coding style suggests.

Regardless of whether or not this can fit within the new makefile
infrastructure -- please at least consider adding in the bits to use
tst_res(3). It will make maintenance considerably easier in the long
run. I can port a Makefile over in < 30 mins -- it's the C code that
I'd have to fumble around with as I'm not the original developer, I
may not understand all the nuances of what's trying to be tested, etc.

More documentation would be extremely helpful, in particular pointers
to additional reference material so that someone who has _zero_
understanding in how the rtc driver typically works in Linux can at
least look up additional materials to develop a better understanding
of what's going on...

>> >
>> > I've learned enough to keep my hands off this because it looks like a =
mess.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
