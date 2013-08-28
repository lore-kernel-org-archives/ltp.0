Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VEg6j-0007sg-8y
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 13:48:25 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VEg6e-0005ip-EU
	for ltp-list@lists.sourceforge.net; Wed, 28 Aug 2013 13:48:25 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7SDmD4x013863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Aug 2013 13:48:14 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7SDmCMS003654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Aug 2013 13:48:13 GMT
Received: from abhmt102.oracle.com (abhmt102.oracle.com [141.146.116.54])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7SDmCV5003648
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Aug 2013 13:48:12 GMT
Message-ID: <521DFF99.4050000@oracle.com>
Date: Wed, 28 Aug 2013 17:48:09 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <521DF60B.9010401@oracle.com>
In-Reply-To: <521DF60B.9010401@oracle.com>
Subject: Re: [LTP] [PATCH] ltp: Fix races in mmap1
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
To: ltp-list@lists.sourceforge.net
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>


On 08/28/2013 05:07 PM, Dave Kleikamp wrote:
> Make map_address a volatile pointer so that it is dereferenced in
> read_mem() after read_lock is set.
>
> Also read_lock must protect the verbose printf that reads from map_address
> as well.
>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>
> diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
> index 7c80bb4..cd1127f 100644
> --- a/testcases/kernel/mem/mtest06/mmap1.c
> +++ b/testcases/kernel/mem/mtest06/mmap1.c
> @@ -62,7 +62,7 @@
>   } while (0)
>   
>   static int verbose_print = 0;
> -static char *map_address;
> +static char *volatile map_address;
>   static jmp_buf jmpbuf;
>   static volatile char read_lock = 0;
>   
> @@ -228,11 +228,13 @@ void *read_mem(void *ptr)
>   				tst_resm(TINFO, "page fault occurred due to "
>   					 "a read after an unmap");
>   		} else {
> -			if (verbose_print)
> +			if (verbose_print) {
> +				read_lock = 1;
>   				tst_resm(TINFO,
>   					 "read_mem(): content of memory: %s",
>   					 (char *)map_address);
> -
> +				read_lock = 0;
> +			}
>   			for (j = 0; j < args[1]; j++) {
>   				read_lock = 1;
>   				if (map_address[j] != 'a')
>
> ------------------------------------------------------------------------------
> Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
> Discover the easy way to master current and previous Microsoft technologies
> and advance your career. Get an incredible 1,500+ hours of step-by-step
> tutorial videos with LearnDevNow. Subscribe today and save!
> http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

Just in case.. To reproduce failures we need to invoke the test this 
way, for example:

   ./mmap1 -v -s 10

and then wait few minutes (it depends...)


------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
