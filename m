Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZKqdo-0007bK-N2
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 16:25:08 +0000
Received: from mail-qk0-f178.google.com ([209.85.220.178])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZKqdm-0002Tl-OD
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 16:25:08 +0000
Received: by qkbm65 with SMTP id m65so19813373qkb.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2015 09:25:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1851015047.604153.1438242662396.JavaMail.zimbra@redhat.com>
References: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
	<CANKSX+ETp0jdXp+zSUtUPn8SWUQaCh1bETYzcpF_C8kZpPtGdQ@mail.gmail.com>
	<20150729152949.GA6478@rei.suse.de>
	<1186607709.563342.1438184803657.JavaMail.zimbra@redhat.com>
	<20150729155005.GC3427@rei.suse.de>
	<CANKSX+EukvUBmjMf7TMxTzcsMXmzfGb+FYqrdo7vKnEiLb6wyg@mail.gmail.com>
	<20150729194515.GA7009@rei.suse.de>
	<CANKSX+FRJcg3xmc2BbWiDzmSqT2NC+hQib-UsWA4yoWTq8fB3g@mail.gmail.com>
	<1851015047.604153.1438242662396.JavaMail.zimbra@redhat.com>
Date: Thu, 30 Jul 2015 21:55:01 +0530
Message-ID: <CANKSX+F8j2Fn5q+wo01BUUngC+xLNWP+6TC7+Kc-7e=D0MUwEw@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: Re: [LTP] LTP make failed
Reply-To: srikanth007m@gmail.com
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Can i know the purpose of running this memtester to rule out the HW or
kernel issue? Its been running since 5hrs without any issues.

On Thu, Jul 30, 2015 at 1:21 PM, Li Wang <liwang@redhat.com> wrote:
>
> ----- Original Message -----
>> Can you tell me what kind of steps you followed to cross compile LTP
>> for arm? Does it make any difference from the configure what i am
>> using and you.
>>
>> memtest suite? can you point me to the location
>
> http://pyropus.ca/software/memtester/
>
> ---
> Li Wang
>
>>
>> On Thu, Jul 30, 2015 at 1:15 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
>> > Hi!
>> >> FYI, Here is my host configuration.
>> >> Linux srikanth-linux 3.15.0-031500rc2-generic #201404201435 SMP Sun
>> >> Apr 20 18:36:18 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>> >>
>> >> @Cyril - libkerntest.a got generated with your suggested changes. Does
>> >> that make any difference between INTERNAL_LIB to LIB? Should i need to
>> >> change any other files to unblock the compilation?
>> >
>> > The only difference between INTERNAL_LIB and LIB is one ifneq and
>> > variable assigment in the lib.mk. So if that does not work for you, you
>> > either hit bug in make, libc, kernel or hardware. Changing it from
>> > INTERNAL_LIB to LIB only works around that bug.
>> >
>> > I've just recompiled LTP for arm without a problem. In your case I would
>> > try to run memtest over night on your machine first. Otherwise you may
>> > spend hours trying to catch something that in reality is a hardware bug.
>> >
>> > --
>> > Cyril Hrubis
>> > chrubis@suse.cz
>>
>>
>>
>> --
>> Thanks & Regards,
>> M.Srikanth Kumar.
>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>



-- 
Thanks & Regards,
M.Srikanth Kumar.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
