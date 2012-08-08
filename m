Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Sz2qz-0002go-LS
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:47:01 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz2qw-00057V-26
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 09:47:01 +0000
Received: by pbcwy7 with SMTP id wy7so1108576pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 02:46:52 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1278)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <5022315D.1090709@casparzhang.com>
Date: Wed, 8 Aug 2012 02:46:55 -0700
Message-Id: <11850AA3-DB90-4525-B168-AF39B8B4B373@gmail.com>
References: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
	<6e0436fef24c3f2fc48066a4a08594704e657950.1343703178.git.caspar@casparzhang.com>
	<CAGH67wQHxhA0XwEjjA+E9NRE-Mh6bh2DmuLXz4ory5XZPTN4DQ@mail.gmail.com>
	<5022315D.1090709@casparzhang.com>
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Aug 8, 2012, at 2:29 AM, Caspar Zhang wrote:

> On 07/31/2012 11:57 AM, Garrett Cooper wrote:
>> On Mon, Jul 30, 2012 at 7:53 PM, Caspar Zhang <caspar@casparzhang.com> wrote:
>>> 
>>> some NUMA related syscalls: mbind, get_mempolicy are not supported on
>>> some arches (e.g. i386), I use TEST macro to test the syscall in setup()
>>> function, if the syscall is not implemented on the system, a TCONF
>>> message will given like this:
>>> 
>>> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch
>> 
>>     Using TEST isn't necessary to be honest: the syscall wrapper
>> handles the (if you add a comment as to why things are being done in a
>> single line, untested, that should be ok).
>> Thanks!
>> -Garrett
>> 
> 
> Hi Garrett, sorry I'm kind of not catching you :-( what's your suggestion of correcting/improving this message?

	I'd remove "TEST(..)" from the line and just use the syscall function call.
	If you want, we can make syscall more explicit as far as a custom wrapper goes.
Cheers!
-Garrett
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
