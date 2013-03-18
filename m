Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UHPtl-0002Dk-Vs
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 02:34:06 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHPtk-0002eF-MU
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 02:34:05 +0000
Date: Sun, 17 Mar 2013 22:33:58 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1167919494.9250965.1363574038668.JavaMail.root@redhat.com>
In-Reply-To: <1555759857.19404682.1363363797191.JavaMail.root@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Saturday, March 16, 2013 12:09:57 AM
> Subject: Re: [LTP] [PATCH v2 3/7] numa_helper: added a new function is_numa()
> 
> 
> 
> ----- Original Message -----
> > From: "Zhouping Liu" <zliu@redhat.com>
> > To: "LTP List" <ltp-list@lists.sourceforge.net>
> > Sent: Friday, 15 March, 2013 4:03:08 PM
> > Subject: [LTP] [PATCH v2 3/7] numa_helper: added a new function
> > is_numa()
> > 
> > Added a new function is_numa(), which is desinged to judge
> > whether a system contains more than 1 available numa nodes
> > or not, and lots of cases need it.
> > 
> > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> > ---
> >  testcases/kernel/include/numa_helper.h |  1 +
> >  testcases/kernel/lib/numa_helper.c     | 25
> >  +++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/testcases/kernel/include/numa_helper.h
> > b/testcases/kernel/include/numa_helper.h
> > index 8e82d7b..251fd54 100644
> > --- a/testcases/kernel/include/numa_helper.h
> > +++ b/testcases/kernel/include/numa_helper.h
> > @@ -34,5 +34,6 @@ unsigned long get_max_node(void);
> >  int get_allowed_nodes_arr(int flag, int *num_nodes, int **nodes);
> >  int get_allowed_nodes(int flag, int count, ...);
> >  void nh_dump_nodes();
> > +int is_numa(void (*cleanup_fn)(void));
> >  
> >  #endif
> > diff --git a/testcases/kernel/lib/numa_helper.c
> > b/testcases/kernel/lib/numa_helper.c
> > index 4ab8e3c..f9a4c3a 100644
> > --- a/testcases/kernel/lib/numa_helper.c
> > +++ b/testcases/kernel/lib/numa_helper.c
> > @@ -265,3 +265,28 @@ void nh_dump_nodes()
> >  	print_node_info(NH_CPUS);
> >  	print_node_info(NH_MEMS | NH_CPUS);
> >  }
> > +
> > +/*
> > + * is_numa - judge a system is NUMA system or not
> > + * NOTE: the function is designed to try to find more than
> > + *       1 available node, at least each node contains memory.
> > + * WARN: Don't use this func in child, as it calls tst_brkm()
> > + * RETURNS:
> > + *     0 - it's not a NUMA system
> > + *     1 - it's a NUMA system
> > + */
> > +int is_numa(void (*cleanup_fn)(void))
> > +{
> > +	int ret;
> > +	int numa_nodes = 0;
> > +	int *nodes = NULL;
> > +
> > +	ret = get_allowed_nodes_arr(NH_MEMS, &numa_nodes, &nodes);
> 
> If you don't need node ids, you can pass NULL:
>         ret = get_allowed_nodes_arr(NH_MEMS, &numa_nodes, NULL);
> Otherwise you should free 'nodes' variable.

OK, I will free 'nodes' variable in V3.

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
