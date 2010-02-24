Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1NkQwd-0005ks-KG
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 23:47:07 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkQwc-0001RA-Jd
	for ltp-list@lists.sourceforge.net; Wed, 24 Feb 2010 23:47:07 +0000
Message-Id: <4B855801020000E80005EF5B@sinclair.provo.novell.com>
Date: Wed, 24 Feb 2010 16:46:57 -0700
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4B8502D7020000E80005EEE6@sinclair.provo.novell.com>
	<364299f41002241316h549d84c6j366b7fff764e9b71@mail.gmail.com>
	<4B85364D020000E80005EF28@sinclair.provo.novell.com>
	<364299f41002241325g6a18ea10s60fea894ab2d7302@mail.gmail.com>
	<4B853B55020000E80005EF2F@sinclair.provo.novell.com>
	<364299f41002241422h5a2b76b6t681015c0c7cb1197@mail.gmail.com>
	<4B854698020000E80005EF39@sinclair.provo.novell.com>
	<364299f41002241433w1fc9c6ffqa57893c982bcef3c@mail.gmail.com>
In-Reply-To: <364299f41002241433w1fc9c6ffqa57893c982bcef3c@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

>>> On 2/24/2010 at 03:33 PM, in message
<364299f41002241433w1fc9c6ffqa57893c982bcef3c@mail.gmail.com>, Garrett Cooper
<yanegomi@gmail.com> wrote: 
> On Wed, Feb 24, 2010 at 2:32 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>>> On 2/24/2010 at 03:22 PM, in message
>> <364299f41002241422h5a2b76b6t681015c0c7cb1197@mail.gmail.com>, Garrett Cooper
>> <yanegomi@gmail.com> wrote:
>>> On Wed, Feb 24, 2010 at 1:44 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>>>>> On 2/24/2010 at 02:25 PM, in message
>>>> <364299f41002241325g6a18ea10s60fea894ab2d7302@mail.gmail.com>, Garrett Cooper
>>>> <yanegomi@gmail.com> wrote:
>>>>> On Wed, Feb 24, 2010 at 1:23 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>>>>>>> On 2/24/2010 at 02:16 PM, in message
>>>>>> <364299f41002241316h549d84c6j366b7fff764e9b71@mail.gmail.com>, Garrett Cooper
>>>>>> <yanegomi@gmail.com> wrote:
>>>>>>> On Wed, Feb 24, 2010 at 9:43 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>>>>>> This cleans up existing swap files in swapon03 test in failing test case.
>>>>>>> Otherwise, deleted swap files would still exist in /proc/swaps.
>>>>>>>>
>>>>>>>> Signed-off-by: Murlin Ray Wenzel mwenzel@novell.com
>>>>>>>
>>>>>>> Why not implement this as part of cleanup?
>>>>>>> Thanks,
>>>>>>> -Garrett
>>>>>>
>>>>>> I can look at doing that.  I just grabbed the closest place that worked for
>>>>> me.  BTW I'm still looking at a possible kernel bug where you can't allocate
>>>>> the maximum number of swap files.
>>>>>
>>>>> What kernel version are you working with?
>>>>> -Garrett
>>>>
>>>> I'm testing on 2.6.32.7, but I've been told that the same problem doesn't
>>> happen on 2.6.33 and it shouldn't happen on some as yet unknown previous
>>> versions.
>>>
>>>     If they changed the maximum number of swap files, then this would
>>> be the cause for the problem as it's set to 30 since 2.6.18. See
>>> include/swaponoff.h .
>>> HTH,
>>> -Garrett
>>
>> The problem is MAX_SWAPFILES reports 30 but you only get 29.
> 
> Is swap mounted :)?
> -Garrett

When I said 29 I was taking into account mounted swap partition which would make 30.

Murlin


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
