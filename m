Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKSbl-0004xv-BA
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 14:45:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKSbj-0003bo-Tj
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 14:45:25 +0000
Date: Wed, 29 Jul 2015 16:45:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150729144508.GB3427@rei.suse.de>
References: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
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
> make[2]: Leaving directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib'
> make -C ../../../../../testcases/kernel/mem/lib -f
> "/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib/Makefile"
> all
> make[2]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib'
> make -C /local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib
> -f
> "/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib/Makefile"
> all
> make[3]: Entering directory
> `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib'
> if [ -z "numa_helper.o" ] ; then \
>                 echo "Cowardly refusing to create empty archive"; \
>                 exit 1; \
>         fi
> arm-linux-gnueabi-ar -rc "lib/libipc_hugetlb.a" numa_helper.o
> arm-linux-gnueabi-ar: lib/libipc_hugetlb.a: No such file or directory

Something is wrong on your system. It fails because ar cannot find
directory lib/ to place the libipc_hugetlb.a to. However in correct
build the path to the libipc_hugetlb.a does not contain the lib/
directory at all.

Can you send how you invoked configure and it's output and also output
with paraell make disabled?

Also please make sure that the lines are not wrapped by your email
client.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
