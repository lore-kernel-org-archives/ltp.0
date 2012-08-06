Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SyJn6-0001qE-Bf
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 09:40:00 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SyJn4-0005HW-5U
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 09:40:00 +0000
Date: Mon, 6 Aug 2012 05:39:50 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1121805817.413044.1344245990666.JavaMail.root@redhat.com>
In-Reply-To: <2fbaeedd90ff07905a440eff5a3877bc7bf40f4c.1344234636.git.caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 1/2] numa_helper: move to libkerntest
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

Hi Caspar,

I found one small issue during my testing, but I suppose this can be fixed
in follow-up patch without need to resend whole series.

When I do "make clean" from LTP root, kernel/lib is not cleaned:
# ll testcases/kernel/lib/
total 36
-rw-r--r--. 1 root root 9704 Aug  6 05:27 libkerntest.a
-rw-rw-r--. 1  501  501 1051 Aug  6 03:21 Makefile
-rw-rw-r--. 1  501  501 6424 Aug  6 03:21 numa_helper.c
-rw-r--r--. 1 root root 9456 Aug  6 05:27 numa_helper.o

Regards,
Jan

----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Monday, 6 August, 2012 8:30:50 AM
> Subject: [LTP] [PATCH v2 1/2] numa_helper: move to libkerntest
> 
> 
> libnuma_helper could be used by testcases both under syscalls/ and
> mem/,
> it's better to add a new common lib in their parent dir, so I created
> libkerntest under testcases/kernel/lib/, and put numa_helper to it.
> In
> the future, we can add more APIs to it.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/include/lib.mk                  |   37 +++
>  testcases/kernel/include/numa_helper.h           |   37 +++
>  testcases/kernel/lib/Makefile                    |   29 +++
>  testcases/kernel/lib/numa_helper.c               |  266
>  ++++++++++++++++++++++
>  testcases/kernel/syscalls/get_mempolicy/Makefile |    2 +-
>  testcases/kernel/syscalls/mbind/Makefile         |    2 +-
>  testcases/kernel/syscalls/move_pages/Makefile    |    2 +-
>  testcases/kernel/syscalls/numa/Makefile          |   22 --
>  testcases/kernel/syscalls/numa/Makefile.inc      |   27 ---
>  testcases/kernel/syscalls/numa/lib/Makefile      |   26 --
>  testcases/kernel/syscalls/numa/lib/numa_helper.c |  266
>  ----------------------
>  testcases/kernel/syscalls/numa/lib/numa_helper.h |   37 ---
>  12 files changed, 372 insertions(+), 381 deletions(-)
>  create mode 100644 testcases/kernel/include/lib.mk
>  create mode 100644 testcases/kernel/include/numa_helper.h
>  create mode 100644 testcases/kernel/lib/Makefile
>  create mode 100644 testcases/kernel/lib/numa_helper.c
>  delete mode 100644 testcases/kernel/syscalls/numa/Makefile
>  delete mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
>  delete mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
>  delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
>  delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h
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
