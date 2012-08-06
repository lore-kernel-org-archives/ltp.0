Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SyLxp-00073T-Ed
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 11:59:13 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SyLxl-000752-PO
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 11:59:13 +0000
Received: by pbcwy7 with SMTP id wy7so1466653pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Aug 2012 04:58:59 -0700 (PDT)
Message-ID: <501FB17B.4040900@casparzhang.com>
Date: Mon, 06 Aug 2012 19:58:51 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1121805817.413044.1344245990666.JavaMail.root@redhat.com>
In-Reply-To: <1121805817.413044.1344245990666.JavaMail.root@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/06/2012 05:39 PM, Jan Stancek wrote:
> Hi Caspar,
>
> I found one small issue during my testing, but I suppose this can be fixed
> in follow-up patch without need to resend whole series.
>
> When I do "make clean" from LTP root, kernel/lib is not cleaned:
> # ll testcases/kernel/lib/
> total 36
> -rw-r--r--. 1 root root 9704 Aug  6 05:27 libkerntest.a
> -rw-rw-r--. 1  501  501 1051 Aug  6 03:21 Makefile
> -rw-rw-r--. 1  501  501 6424 Aug  6 03:21 numa_helper.c
> -rw-r--r--. 1 root root 9456 Aug  6 05:27 numa_helper.o
>
> Regards,
> Jan

I'll fix it soon. thanks!

Caspar

>
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "LTP List" <ltp-list@lists.sourceforge.net>
>> Sent: Monday, 6 August, 2012 8:30:50 AM
>> Subject: [LTP] [PATCH v2 1/2] numa_helper: move to libkerntest
>>
>>
>> libnuma_helper could be used by testcases both under syscalls/ and
>> mem/,
>> it's better to add a new common lib in their parent dir, so I created
>> libkerntest under testcases/kernel/lib/, and put numa_helper to it.
>> In
>> the future, we can add more APIs to it.
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>   testcases/kernel/include/lib.mk                  |   37 +++
>>   testcases/kernel/include/numa_helper.h           |   37 +++
>>   testcases/kernel/lib/Makefile                    |   29 +++
>>   testcases/kernel/lib/numa_helper.c               |  266
>>   ++++++++++++++++++++++
>>   testcases/kernel/syscalls/get_mempolicy/Makefile |    2 +-
>>   testcases/kernel/syscalls/mbind/Makefile         |    2 +-
>>   testcases/kernel/syscalls/move_pages/Makefile    |    2 +-
>>   testcases/kernel/syscalls/numa/Makefile          |   22 --
>>   testcases/kernel/syscalls/numa/Makefile.inc      |   27 ---
>>   testcases/kernel/syscalls/numa/lib/Makefile      |   26 --
>>   testcases/kernel/syscalls/numa/lib/numa_helper.c |  266
>>   ----------------------
>>   testcases/kernel/syscalls/numa/lib/numa_helper.h |   37 ---
>>   12 files changed, 372 insertions(+), 381 deletions(-)
>>   create mode 100644 testcases/kernel/include/lib.mk
>>   create mode 100644 testcases/kernel/include/numa_helper.h
>>   create mode 100644 testcases/kernel/lib/Makefile
>>   create mode 100644 testcases/kernel/lib/numa_helper.c
>>   delete mode 100644 testcases/kernel/syscalls/numa/Makefile
>>   delete mode 100644 testcases/kernel/syscalls/numa/Makefile.inc
>>   delete mode 100644 testcases/kernel/syscalls/numa/lib/Makefile
>>   delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.c
>>   delete mode 100644 testcases/kernel/syscalls/numa/lib/numa_helper.h
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond.
>> Discussions
>> will include endpoint security, mobile security and the latest in
>> malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>



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
