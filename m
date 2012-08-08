Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sz2Zq-0001Rr-I9
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:29:18 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz2Zp-0008Mi-U2
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:29:18 +0000
Received: by yenm1 with SMTP id m1so514809yen.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 02:29:12 -0700 (PDT)
Message-ID: <5022315D.1090709@casparzhang.com>
Date: Wed, 08 Aug 2012 17:29:01 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
	<6e0436fef24c3f2fc48066a4a08594704e657950.1343703178.git.caspar@casparzhang.com>
	<CAGH67wQHxhA0XwEjjA+E9NRE-Mh6bh2DmuLXz4ory5XZPTN4DQ@mail.gmail.com>
In-Reply-To: <CAGH67wQHxhA0XwEjjA+E9NRE-Mh6bh2DmuLXz4ory5XZPTN4DQ@mail.gmail.com>
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

On 07/31/2012 11:57 AM, Garrett Cooper wrote:
> On Mon, Jul 30, 2012 at 7:53 PM, Caspar Zhang <caspar@casparzhang.com> wrote:
>>
>> some NUMA related syscalls: mbind, get_mempolicy are not supported on
>> some arches (e.g. i386), I use TEST macro to test the syscall in setup()
>> function, if the syscall is not implemented on the system, a TCONF
>> message will given like this:
>>
>> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch
>
>      Using TEST isn't necessary to be honest: the syscall wrapper
> handles the (if you add a comment as to why things are being done in a
> single line, untested, that should be ok).
> Thanks!
> -Garrett
>

Hi Garrett, sorry I'm kind of not catching you :-( what's your 
suggestion of correcting/improving this message?

Thanks,
Caspar

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
