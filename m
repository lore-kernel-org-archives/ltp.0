Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NkqXJ-0003c4-Hf
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 03:06:41 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkqXI-0000mB-3f
	for ltp-list@lists.sourceforge.net; Fri, 26 Feb 2010 03:06:41 +0000
Received: by iwn6 with SMTP id 6so5840353iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 19:06:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
References: <41c7690d1002240410y3f132792he5460c69891a0976@mail.gmail.com>
	<364299f41002241314u28cec7e9h7334685f6f82a8a@mail.gmail.com>
	<41c7690d1002242240m787a1e8bj4640341ec09ff61c@mail.gmail.com>
	<364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
Date: Fri, 26 Feb 2010 08:36:31 +0530
Message-ID: <41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On 2/25/10, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Feb 25, 2010 at 1:33 AM, Rishikesh K Rajak
> <risrajak@linux.vnet.ibm.com> wrote:
>> On Thu, Feb 25, 2010 at 02:39:37PM +0530, Silesh C V wrote:
>>> >>
>>> >>    The end goal is to have these tests fit directly into LTP without
>>> >> having to fudge around writing a secondary driver, thus maintaining
>>> >> two pieces of dependent code [which is of course more complicated than
>>> >> one piece of code], and thus is more of a pain to maintain longterm.
>>> >> There's a lot of code in the repository like this that was ported and
>>> >> subsequently not properly adapted to the existing infrastructure, thus
>>> >> creating additional headache for maintainers and end-users.
>>> >
>>> > Ok -- I take that back. I have no idea wtf is going on in this
>>> > directory nor the ultimate intent of the tests in here, apart from
>>> > being a lot of ad hoc pain in the arse-ness.
>>>
>>> The README in testcases/kernel/device-drivers/ says that these tests
>>> should not be run with the other tests, and they have to be built
>>> separately. I agree that this is because they have a kernel space part
>>> also. But this prevents us from  building  device_driver tests that
>>> have only user space part (as in RTC tests), along with the overall
>>> build. And these tests does not belong in any other directory other
>>> than kernel/device-drivers. So as long as other tests are there we
>>> will have to live with building new device driver tests separately.I
>>> can re-send  the patch with Garrett's suggestions  incorporated.
>>>
>>> Subrata, suggestions ?
>>
>> Hi Silesh,
>>
>> How about porting this on new makefile infrastructure ? I think this is
>> time where we can look back and can make one piece of code as garret
>> said is correct. Please see your fesibility. Let me know if you still
>> want this to be integrated. Before that can you please little more
>> descriptive with your patch e,g: what it is doing.
>>
>> And also it is always good if you include more documentation for each
>> function as coding style suggests.
>
> Regardless of whether or not this can fit within the new makefile
> infrastructure -- please at least consider adding in the bits to use
> tst_res(3).

OK.Coming in the next patch.

It will make maintenance considerably easier in the long
> run. I can port a Makefile over in < 30 mins -- it's the C code that
> I'd have to fumble around with as I'm not the original developer, I
> may not understand all the nuances of what's trying to be tested, etc.
>
> More documentation would be extremely helpful, in particular pointers
> to additional reference material so that someone who has _zero_
> understanding in how the rtc driver typically works in Linux can at
> least look up additional materials to develop a better understanding
> of what's going on...

OK. Coming in the next patch.
>
>>> >
>>> > I've learned enough to keep my hands off this because it looks like a
>>> > mess.
>
> Thanks,
> -Garrett
>

Thanks,
Silesh

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
