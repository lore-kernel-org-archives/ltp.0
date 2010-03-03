Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Nmn5R-0004zx-Op
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 11:49:57 +0000
Received: from mail-pz0-f203.google.com ([209.85.222.203])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nmn5R-0005e7-1m
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 11:49:57 +0000
Received: by pzk41 with SMTP id 41so878218pzk.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 03:49:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41003030342m7bf4a44ey897b7d2ca365a318@mail.gmail.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
	<20100302085046.GA27023@linux.vnet.ibm.com>
	<f5a7b3811003020708wdd0710fv4c3e1dcf1992935c@mail.gmail.com>
	<20100303045624.GB10185@linux.vnet.ibm.com>
	<f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
	<20100303070342.GB19084@linux.vnet.ibm.com>
	<364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
	<20100303094541.GB23601@linux.vnet.ibm.com>
	<f5a7b3811003030333n4b0b4045sff5795d99cd7da00@mail.gmail.com>
	<364299f41003030342m7bf4a44ey897b7d2ca365a318@mail.gmail.com>
Date: Wed, 3 Mar 2010 17:19:51 +0530
Message-ID: <f5a7b3811003030349s2d279fcdx8b74cff2e3a875ab@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [PATCH] Synchronization required before release the lock:
	sem_post/8-1.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Mar 3, 2010 at 5:12 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Mar 3, 2010 at 3:33 AM, naresh kamboju <naresh.kernel@gmail.com> =
wrote:
>> On Wed, Mar 3, 2010 at 3:15 PM, Rishikesh K Rajak
>> <risrajak@linux.vnet.ibm.com> wrote:
>>> On Wed, Mar 03, 2010 at 01:18:50AM -0800, Garrett Cooper wrote:
>>>> Uh, hold on a sec before we call it good...
>>>
>>> oh ok, holiding on for bit.
>>>
>>> Naresh, can you please send a patch with incorporating garret's comment
>>> ?
>>>>>> + =A0 =A0 =A0 =A0/* Step 3 Implementation */
>>>>>> =A0 =A0 =A0 /* Make sure the two children has been waiting */
>>>>>> - =A0 =A0 /*do {
>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 sleep(1);
>>>>>> + =A0 =A0 do {
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sem_getvalue(sem_1, &val);
>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 //printf("val =3D %d\n", val);
>>>>>> =A0 =A0 =A0 } while (val !=3D 1);
>>>>>> - =A0 =A0 */
>>>>
>>>> Please provide another patch with a limit to this --
>>
>> Garrett,
>>
>> When sem_wait is called 'val' value will be decremented by one.
>> To ensure that sem_wait is called, we are checking 'val' value by
>> calling sem_getvalue(). in this case we don=92t need to decrement the
>> values by --. IIUC.
>> (snip)
>> OTOH,
>>>> I get annoyed
>>>> with tests that have infinite loops in them because the underlying
>>>> functionality is broken.
>> I agree with you, having infinite loops in test case is not a good.
>> However, in this patch while loop is not infinite loop. It is a
>> conditional loop with finite value.
>>
>> Please let me know if you have any issues.
>
> =A0 =A0The problem was that it wasn't failing properly as stated in the
> manpage on mips* (was decrementing past 0) and it was blocking
> indefinitely. Hence I had to yank those tests from the default run.
do you mean, after applying above patch you have noticed these kind of beha=
vior?

Thanks
naresh

> Thanks,
> -Garrett
>

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
