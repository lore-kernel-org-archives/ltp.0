Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Sw3a7-0006MZ-L8
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 03:57:15 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sw3a5-0003j8-6Y
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 03:57:15 +0000
Received: by obcva7 with SMTP id va7so10397484obc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jul 2012 20:57:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6e0436fef24c3f2fc48066a4a08594704e657950.1343703178.git.caspar@casparzhang.com>
References: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
	<6e0436fef24c3f2fc48066a4a08594704e657950.1343703178.git.caspar@casparzhang.com>
Date: Mon, 30 Jul 2012 20:57:07 -0700
Message-ID: <CAGH67wQHxhA0XwEjjA+E9NRE-Mh6bh2DmuLXz4ory5XZPTN4DQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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

On Mon, Jul 30, 2012 at 7:53 PM, Caspar Zhang <caspar@casparzhang.com> wrote:
>
> some NUMA related syscalls: mbind, get_mempolicy are not supported on
> some arches (e.g. i386), I use TEST macro to test the syscall in setup()
> function, if the syscall is not implemented on the system, a TCONF
> message will given like this:
>
> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch

    Using TEST isn't necessary to be honest: the syscall wrapper
handles the (if you add a comment as to why things are being done in a
single line, untested, that should be ok).
Thanks!
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
