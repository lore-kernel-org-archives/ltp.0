Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SzOx2-0001CR-HX
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 09:22:44 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzOwz-00059F-AO
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 09:22:44 +0000
Date: Thu, 9 Aug 2012 05:22:33 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1024699575.2373526.1344504153517.JavaMail.root@redhat.com>
In-Reply-To: <c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall
 availability
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

Caspar,

I think what Garrett meant was something like this:
/* check if syscall is supported, syscall() here is macro from linux_syscall_numbers.h */
syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);

linux_syscall_numbers.h defines a macro "syscall", which checks for ENOSYS.

Regards,
Jan

----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 9 August, 2012 8:15:39 AM
> Subject: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall availability
> 
> 
> some NUMA related syscalls: mbind, get_mempolicy are not supported on
> some arches (e.g. i386), this patch checks the syscalls' availability
> in
> setup() function, if the syscall is not implemented on the system, a
> TCONF message will be given like this:
> 
> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not
> supported on your arch
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  .../syscalls/get_mempolicy/get_mempolicy01.c       |   10 ++++++++++
>  testcases/kernel/syscalls/mbind/mbind01.c          |    9 +++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
