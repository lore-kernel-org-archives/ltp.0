Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VC7XN-00088q-N1
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 12:29:21 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VC7XM-00086v-EV
	for ltp-list@lists.sourceforge.net; Wed, 21 Aug 2013 12:29:21 +0000
Date: Wed, 21 Aug 2013 08:29:14 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <212598736.1836601.1377088154292.JavaMail.root@redhat.com>
In-Reply-To: <1377086098-32691-3-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <52122141.3020005@oracle.com>
	<1377086098-32691-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2 3/3] lib/numa_helper.c: fix nodemask_size
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>, jstancek@redhat.com
> Sent: Wednesday, 21 August, 2013 1:54:58 PM
> Subject: [PATCH V2 3/3] lib/numa_helper.c: fix nodemask_size
> 
> Now nodemask_size is rounded up to the next multiple
> of sizeof(nodemask_t).

Hi,

Why multiple of nodemask_t? It can be quite large.

> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/lib/numa_helper.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/lib/numa_helper.c
> b/testcases/kernel/lib/numa_helper.c
> index 4157816..9151583 100644
> --- a/testcases/kernel/lib/numa_helper.c
> +++ b/testcases/kernel/lib/numa_helper.c
> @@ -60,7 +60,7 @@ unsigned long get_max_node(void)
>  #if HAVE_NUMA_H
>  static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long
>  max_node)
>  {
> -	unsigned long nodemask_size = max_node / 8 + 1;
> +	unsigned long nodemask_size = ALIGN(max_node, sizeof(nodemask_t)*8) / 8;

Because mask is passed as parameter, we should respect max_node and
clear only up to byte which holds max_node. So I think we should align
to next byte only:

        unsigned long nodemask_size = ALIGN(max_node, 8) / 8;

>  	int i;
>  	char fn[64];
>  	struct stat st;
> @@ -76,7 +76,7 @@ static void get_nodemask_allnodes(nodemask_t * nodemask,
> unsigned long max_node)
>  static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long
>  max_node)
>  {
>  #if MPOL_F_MEMS_ALLOWED
> -	unsigned long nodemask_size = max_node / 8 + 1;
> +	unsigned long nodemask_size = ALIGN(max_node, sizeof(nodemask_t)*8) / 8;

Same as above:
        unsigned long nodemask_size = ALIGN(max_node, 8) / 8;

>  	memset(nodemask, 0, nodemask_size);
>  	/*
>  	 * avoid numa_get_mems_allowed(), because of bug in getpol()
> @@ -165,7 +165,7 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int
> **nodes)
>  
>  #if HAVE_NUMA_H
>  	unsigned long max_node = get_max_node();
> -	unsigned long nodemask_size = max_node / 8 + 1;
> +	unsigned long nodemask_size = ALIGN(max_node, sizeof(nodemask_t)*8) / 8;

This function allocates the nodemask, so we can align to as much as we need.
I'd expect this to be same as in migrate_pages, align to next long:

        unsigned long nodemask_size = ALIGN(max_node / 8, sizeof(long));

Regards,
Jan

>  
>  	nodemask = malloc(nodemask_size);
>  	if (nodes)
> --
> 1.7.1
> 
> 

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
