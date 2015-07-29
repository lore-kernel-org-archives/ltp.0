Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZKSNK-0001I2-Kt
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 14:30:30 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKSNJ-0005cH-DF
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 14:30:30 +0000
Date: Wed, 29 Jul 2015 10:30:21 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <987570123.467332.1438180221782.JavaMail.zimbra@redhat.com>
In-Reply-To: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
References: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] LTP make failed
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
To: srikanth007m@gmail.com
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "$rik@nth" <srikanth007m@gmail.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 29 July, 2015 3:32:32 PM
> Subject: [LTP] LTP make failed
> 
> Hi,
> 
> I am trying to cross compile LTP and observing some issue. Any help or
> suggestions to overcome from these errors. TIA

Hi,

please don't send html in emails to list.

> 
> 
> make[1]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/hugetlb/hugemmap'
> make -C "/local/mnt2/workspace2/LTP/ltp-full-20150420/lib" -f
> "/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/Makefile" all
> make[2]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib'
> make[3]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/tests'
> make[3]: Nothing to be done for `all'.
> make[3]: Leaving directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/tests'
> make[2]: Leaving directory `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib'
> make -C ../../../../../testcases/kernel/mem/lib -f
> "/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib/Makefile"
> all
> make[2]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib'
> make -C /local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib -f
> "/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib/Makefile"
> all
> make[3]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib'
> if [ -z "numa_helper.o" ] ; then \
> echo "Cowardly refusing to create empty archive"; \
> exit 1; \
> fi
> arm-linux-gnueabi-ar -rc "lib/libipc_hugetlb.a" numa_helper.o

So, it goes into 'testcases/kernel/lib' and tries to build libipc_hugetlb.a?
That doesn't look right.

Try building it in smaller steps, if you're using parallel make,
use just single job.

1. cd $LTP/lib
make

2.
cd $LTP/testcases/kernel/mem/hugetlb/lib
make

3.
cd $LTP/testcases/kernel/lib
make

Is the above still failing for you? If so, please share the errors.

Regards,
Jan


> arm-linux-gnueabi-ar: lib/libipc_hugetlb.a: No such file or directory
> make[3]: *** [lib/libipc_hugetlb.a] Error 1
> make[3]: Leaving directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib'
> make[2]: ***
> [/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib/libkerntest.a]
> Error 2
> make[2]: Leaving directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib'
> make[1]: *** [../../../../../testcases/kernel/mem/lib/libmem.a] Error 2
> make[1]: Leaving directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/hugetlb/hugemmap'
> make: *** [all] Error 2
> 
> Here the file is there "ib/libipc_hugetlb.a: No such file or directory" but
> still it showing the error.
> 
> --
> Thanks & Regards,
> M.Srikanth Kumar.
> 
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
