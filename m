Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VCOu7-0003fs-Tr
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 07:01:59 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VCOu6-0001LM-CT
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 07:01:59 +0000
Date: Thu, 22 Aug 2013 03:01:52 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1462085563.2226697.1377154912029.JavaMail.root@redhat.com>
In-Reply-To: <5215AC0E.6000205@oracle.com>
References: <52122141.3020005@oracle.com>
	<1377086098-32691-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<212598736.1836601.1377088154292.JavaMail.root@redhat.com>
	<5214BEFC.504@oracle.com>
	<1748281355.1930512.1377095285040.JavaMail.root@redhat.com>
	<5215AC0E.6000205@oracle.com>
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
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net, "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Thursday, 22 August, 2013 8:13:34 AM
> Subject: Re: [PATCH V2 3/3] lib/numa_helper.c: fix nodemask_size

<snip>

> I think we cannot clear area by zeroing only few bytes of a long. Each
> byte of a long should
> be zeroed.

Agreed, that was good point.

> >> This formula may give incorrect results. For example, if max_mode = 66
> >> and sizeof(long) = 8, then
> >> ALIGN(max_node / 8, sizeof(long)) will output 8 and we will lost 2 bits.
> >> The correct output should be 16.
> >>
> >> I think as max_node contains number of bits so we should align it on
> >> sizeof(long)*8 boundary and after that divide the final result by 8.
> > Agreed, we should align on bits then divide.
> >
> > What if we align max_node? Then we can be sure that nodemask_size
> > in all functions is also aligned:
> Ok. And for convenience the same for migrate_pages fix ?

I'll leave it up to you. 
Man page says, that "bits beyond those specified by maxnode are ignored"
so both ways should work equally well in those testcases.

Regards,
Jan

> 
> 
> >
> > diff --git a/testcases/kernel/lib/numa_helper.c
> > b/testcases/kernel/lib/numa_helper.c
> > index 4157816..a2b6b4a 100644
> > --- a/testcases/kernel/lib/numa_helper.c
> > +++ b/testcases/kernel/lib/numa_helper.c
> > @@ -60,7 +60,7 @@ unsigned long get_max_node(void)
> >   #if HAVE_NUMA_H
> >   static void get_nodemask_allnodes(nodemask_t * nodemask, unsigned long
> >   max_node)
> >   {
> > -       unsigned long nodemask_size = max_node / 8 + 1;
> > +       unsigned long nodemask_size = max_node / 8;
> >          int i;
> >          char fn[64];
> >          struct stat st;
> > @@ -76,7 +76,7 @@ static void get_nodemask_allnodes(nodemask_t * nodemask,
> > unsigned long max_node)
> >   static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long
> >   max_node)
> >   {
> >   #if MPOL_F_MEMS_ALLOWED
> > -       unsigned long nodemask_size = max_node / 8 + 1;
> > +       unsigned long nodemask_size = max_node / 8;
> >          memset(nodemask, 0, nodemask_size);
> >          /*
> >           * avoid numa_get_mems_allowed(), because of bug in getpol()
> > @@ -164,8 +164,8 @@ int get_allowed_nodes_arr(int flag, int *num_nodes, int
> > **nodes)
> >                  *nodes = NULL;
> >   
> >   #if HAVE_NUMA_H
> > -       unsigned long max_node = get_max_node();
> > -       unsigned long nodemask_size = max_node / 8 + 1;
> > +       unsigned long max_node = ALIGN(get_max_node(), sizeof(long)*8);
> > +       unsigned long nodemask_size = max_node / 8;
> >   
> >          nodemask = malloc(nodemask_size);
> >          if (nodes)
> >
> > Regards,
> > Jan
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
