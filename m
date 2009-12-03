Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDNe-0008Rk-2X
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:14:06 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDNX-00058P-27
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:14:06 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F9COf013065
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:09:12 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FDr7q037030
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:53 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB355val006872
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 00:05:57 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012258.nB1MwOQe029539@e5.ny.us.ibm.com>
References: <200912012258.nB1MwOQe029539@e5.ny.us.ibm.com>
Date: Thu, 03 Dec 2009 20:42:33 +0530
Message-Id: <1259853158.5085.42.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Remove the use of bash arrays
	from	memcg_stress_test
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-12-01 at 23:35 +0100, Jiri Palecek wrote: 
> Hello,
> 
> this patch removes the use of bash arrays from memcg_stress_test.sh, thus making the script more POSIX friendly. I changed the array into a series of variables, read and written using eval.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  .../controllers/memcg/stress/memcg_stress_test.sh  |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index 6c9cd75..7244a16 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -70,22 +70,22 @@ run_stress()
>  	do
>  		mkdir /dev/memcg/$i 2> /dev/null
>  		./memcg_process_stress $2 $3 &
> -		pid[$i]=$!
> +		eval pid$i=$!
> 
> -		echo ${pid[$i]} > /dev/memcg/$i/tasks
> +		eval echo \$pid$i > /dev/memcg/$i/tasks
>  	done
> 
>  	for i in $(seq 0 $(($1-1)))
>  	do
> -		/bin/kill -s SIGUSR1 ${pid[$i]} 2> /dev/null
> +		eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
>  	done
> 
>  	sleep $4
> 
>  	for i in $(seq 0 $(($1-1)))
>  	do
> -		/bin/kill -s SIGINT ${pid[$i]} 2> /dev/null
> -		wait ${pid[$i]}
> +		eval /bin/kill -s SIGINT \$pid$i 2> /dev/null
> +		eval wait \$pid$i
> 
>  		rmdir /dev/memcg/$i 2> /dev/null
>  	done


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
