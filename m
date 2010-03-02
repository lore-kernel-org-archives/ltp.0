Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <saileshcv@gmail.com>) id 1NmOnW-0000Fv-Bf
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 09:53:50 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmOnV-00036C-F8
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 09:53:50 +0000
Received: by iwn33 with SMTP id 33so46017iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Mar 2010 01:53:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100301062917.GD3860@linux.vnet.ibm.com>
References: <364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
	<41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
	<20100226053452.GA3800@linux.vnet.ibm.com>
	<20100226085136.GA9407@linux.vnet.ibm.com>
	<20100226091119.GB9407@linux.vnet.ibm.com>
	<20100301062917.GD3860@linux.vnet.ibm.com>
Date: Tue, 2 Mar 2010 15:17:01 +0530
Message-ID: <41c7690d1003020147l3811c35dl26306923c3420e18@mail.gmail.com>
From: Silesh C V <saileshcv@gmail.com>
Subject: Re: [LTP] [PATCH-v2] RTC Device Driver Tests
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
To: risrajak@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On 3/1/10, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com> wrote:
> On Fri, Feb 26, 2010 at 02:41:19PM +0530, Rishikesh K Rajak wrote:
>> On Fri, Feb 26, 2010 at 02:21:36PM +0530, Rishikesh K Rajak wrote:
>> > > >Hi,
>> >
>> > Looks like some issue with your code, can you please relook once again ?
>>
>> I have other system Which has SLES11 and i could see it has
>>
>> mls41:/home/test/ltp-full-20100131/testcases/kernel/device-drivers/rtc #
>> ls -l /dev/rtc*
>> lrwxrwxrwx 1 root root      4 2010-02-26 13:04 /dev/rtc -> rtc0
>> crw-r--r-- 1 root root 252, 0 2010-02-26 13:04 /dev/rtc0
>> mls41:/home/test/ltp-full-20100131/testcases/kernel/device-drivers/rtc #
>>
>> And here testcase passes. So can you check what could be the reason for
>> failing on RHEL5.4 where it has only.
>>
>> [root@mx3655 ~]# ls -l /dev/rtc*
>> crw-r--r-- 1 root root 10, 135 Feb 18 06:42 /dev/rtc
>> [root@mx3655 ~]#
>>
>> Thanks for your support.
>
> HI Silesh,
>
> Any input here, so that i can push this to upstream.

Hi Rishi,

Sorry for the late reply. I was out of the office for the past few
days.AFAIK alarm not ringing usually happens because of the absence of
an IRQ line from the RTC.I should be able to make the test report a
FAIL when this happens by using select(2) so that a time out occurs. I
will send another patch soon.


Thanks,
Silesh.

>
> Thanks
> Rishi
>
>>
>> --
>> Thanks & Regards
>> Rishi
>> LTP Maintainer
>> IBM, LTC, Bangalore
>> Please join IRC #ltp @ irc.freenode.net
>>
>> ------------------------------------------------------------------------------
>> Download Intel&#174; Parallel Studio Eval
>> Try the new software tools for yourself. Speed compiling, find bugs
>> proactively, and fine-tune applications for parallel performance.
>> See why Intel Parallel Studio got high marks during beta.
>> http://p.sf.net/sfu/intel-sw-dev
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
>


-- 
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
