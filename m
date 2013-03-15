Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UGXCm-0007BW-NF
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 16:10:04 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGXCl-0002fY-9h
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 16:10:04 +0000
Date: Fri, 15 Mar 2013 12:09:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1555759857.19404682.1363363797191.JavaMail.root@redhat.com>
In-Reply-To: <5de33faa5b15f22e96d68d1b543eb4bcfc64cfb7.1363358877.git.zliu@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 3/7] numa_helper: added a new function is_numa()
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Friday, 15 March, 2013 4:03:08 PM
> Subject: [LTP] [PATCH v2 3/7] numa_helper: added a new function is_numa()
> 
> Added a new function is_numa(), which is desinged to judge
> whether a system contains more than 1 available numa nodes
> or not, and lots of cases need it.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  testcases/kernel/include/numa_helper.h |  1 +
>  testcases/kernel/lib/numa_helper.c     | 25
>  +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/testcases/kernel/include/numa_helper.h
> b/testcases/kernel/include/numa_helper.h
> index 8e82d7b..251fd54 100644
> --- a/testcases/kernel/include/numa_helper.h
> +++ b/testcases/kernel/include/numa_helper.h
> @@ -34,5 +34,6 @@ unsigned long get_max_node(void);
>  int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
>  int get_allowed_nodes(int flag, int count, ...);
>  void nh_dump_nodes();
> +int is_numa(void (*cleanup_fn)(void));
>  
>  #endif
> diff --git a/testcases/kernel/lib/numa_helper.c
> b/testcases/kernel/lib/numa_helper.c
> index 4ab8e3c..f9a4c3a 100644
> --- a/testcases/kernel/lib/numa_helper.c
> +++ b/testcases/kernel/lib/numa_helper.c
> @@ -265,3 +265,28 @@ void nh_dump_nodes()
>  	print_node_info(NH_CPUS);
>  	print_node_info(NH_MEMS | NH_CPUS);
>  }
> +
> +/*
> + * is_numa - judge a system is NUMA system or not
> + * NOTE: the function is designed to try to find more than
> + *       1 available node, at least each node contains memory.
> + * WARN: Don't use this func in child, as it calls tst_brkm()
> + * RETURNS:
> + *     0 - it's not a NUMA system
> + *     1 - it's a NUMA system
> + */
> +int is_numa(void (*cleanup_fn)(void))
> +{
> +	int ret;
> +	int numa_nodes = 0;
> +	int *nodes = NULL;
> +
> +	ret = get_allowed_nodes_arr(NH_MEMS, &numa_nodes, &nodes);

If you don't need node ids, you can pass NULL:
        ret = get_allowed_nodes_arr(NH_MEMS, &numa_nodes, NULL);
Otherwise you should free 'nodes' variable.

> +	if (ret < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup_fn, "get_allowed_nodes_arr");
> +
> +	if (numa_nodes > 1)
> +		return 1;
> +	else
> +		return 0;
> +}
> --
> 1.7.11.7
> 
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_d2d_mar
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
