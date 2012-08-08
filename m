Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sz6zE-0002oO-Uk
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 14:11:48 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz6zE-0004Xq-5Y
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 14:11:48 +0000
Received: by yenm1 with SMTP id m1so780065yen.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 07:11:42 -0700 (PDT)
Message-ID: <5022738E.4010201@casparzhang.com>
Date: Wed, 08 Aug 2012 22:11:26 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
	<6e0436fef24c3f2fc48066a4a08594704e657950.1343703178.git.caspar@casparzhang.com>
	<CAGH67wQHxhA0XwEjjA+E9NRE-Mh6bh2DmuLXz4ory5XZPTN4DQ@mail.gmail.com>
	<5022315D.1090709@casparzhang.com>
	<11850AA3-DB90-4525-B168-AF39B8B4B373@gmail.com>
In-Reply-To: <11850AA3-DB90-4525-B168-AF39B8B4B373@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls/numa: check syscall availability
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/08/2012 05:46 PM, Garrett Cooper wrote:
> On Aug 8, 2012, at 2:29 AM, Caspar Zhang wrote:
>
>> On 07/31/2012 11:57 AM, Garrett Cooper wrote:
>>> On Mon, Jul 30, 2012 at 7:53 PM, Caspar Zhang <caspar@casparzhang.com> wrote:
>>>>
>>>> some NUMA related syscalls: mbind, get_mempolicy are not supported on
>>>> some arches (e.g. i386), I use TEST macro to test the syscall in setup()
>>>> function, if the syscall is not implemented on the system, a TCONF
>>>> message will given like this:
>>>>
>>>> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch
>>>
>>>      Using TEST isn't necessary to be honest: the syscall wrapper
>>> handles the (if you add a comment as to why things are being done in a
>>> single line, untested, that should be ok).
>>> Thanks!
>>> -Garrett
>>>
>>
>> Hi Garrett, sorry I'm kind of not catching you :-( what's your suggestion of correcting/improving this message?
>
> 	I'd remove "TEST(..)" from the line and just use the syscall function call.
> 	If you want, we can make syscall more explicit as far as a custom wrapper goes.

OK, I'll remove TEST() and resend the patch.

Thanks,
Caspar

> Cheers!
> -Garrett
>



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
