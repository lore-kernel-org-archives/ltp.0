Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkPcm-0002Hh-IT
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 22:22:32 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkPcl-00037U-Pf
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 22:22:32 +0000
Received: by pvf33 with SMTP id 33so862210pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Feb 2010 14:22:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B853B55020000E80005EF2F@sinclair.provo.novell.com>
References: <4B8502D7020000E80005EEE6@sinclair.provo.novell.com>
	<364299f41002241316h549d84c6j366b7fff764e9b71@mail.gmail.com>
	<4B85364D020000E80005EF28@sinclair.provo.novell.com>
	<364299f41002241325g6a18ea10s60fea894ab2d7302@mail.gmail.com>
	<4B853B55020000E80005EF2F@sinclair.provo.novell.com>
Date: Wed, 24 Feb 2010 14:22:26 -0800
Message-ID: <364299f41002241422h5a2b76b6t681015c0c7cb1197@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] swapon03 cleanup
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Feb 24, 2010 at 1:44 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>> On 2/24/2010 at 02:25 PM, in message
> <364299f41002241325g6a18ea10s60fea894ab2d7302@mail.gmail.com>, Garrett Co=
oper
> <yanegomi@gmail.com> wrote:
>> On Wed, Feb 24, 2010 at 1:23 PM, Murlin Wenzel <mwenzel@novell.com> wrot=
e:
>>>>>> On 2/24/2010 at 02:16 PM, in message
>>> <364299f41002241316h549d84c6j366b7fff764e9b71@mail.gmail.com>, Garrett =
Cooper
>>> <yanegomi@gmail.com> wrote:
>>>> On Wed, Feb 24, 2010 at 9:43 AM, Murlin Wenzel <mwenzel@novell.com> wr=
ote:
>>>>> This cleans up existing swap files in swapon03 test in failing test c=
ase.
>>>> Otherwise, deleted swap files would still exist in /proc/swaps.
>>>>>
>>>>> Signed-off-by: Murlin Ray Wenzel mwenzel@novell.com
>>>>
>>>> Why not implement this as part of cleanup?
>>>> Thanks,
>>>> -Garrett
>>>
>>> I can look at doing that. =A0I just grabbed the closest place that work=
ed for
>> me. =A0BTW I'm still looking at a possible kernel bug where you can't al=
locate
>> the maximum number of swap files.
>>
>> What kernel version are you working with?
>> -Garrett
>
> I'm testing on 2.6.32.7, but I've been told that the same problem doesn't=
 happen on 2.6.33 and it shouldn't happen on some as yet unknown previous v=
ersions.

    If they changed the maximum number of swap files, then this would
be the cause for the problem as it's set to 30 since 2.6.18. See
include/swaponoff.h .
HTH,
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
