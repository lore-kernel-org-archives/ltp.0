Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGWlF-0006uI-Lv
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:41:37 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGWlD-0001DE-La
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:41:37 +0000
Date: Fri, 15 Mar 2013 11:41:29 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <302258505.8905505.1363362089669.JavaMail.root@redhat.com>
In-Reply-To: <1914766227.19199525.1363338717055.JavaMail.root@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/5] mm/oom0[3|4]: added 'OOM for CPUSET' and
 updated 'OOM with MEMCG & numa'
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
> Sent: Friday, March 15, 2013 5:11:57 PM
> Subject: Re: [LTP] [PATCH 3/5] mm/oom0[3|4]: added 'OOM for CPUSET' and updated 'OOM with MEMCG & numa'
> 
> 
> 
> ----- Original Message -----
> > From: "Zhouping Liu" <zliu@redhat.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: chrubis@suse.cz, "LTP List" <ltp-list@lists.sourceforge.net>
> > Sent: Friday, 15 March, 2013 3:52:26 AM
> > Subject: Re: [LTP] [PATCH 3/5] mm/oom0[3|4]: added 'OOM for CPUSET'
> > and updated 'OOM with MEMCG & numa'
> 
> > > We could add a simple function to numa_helper, but I'm not sure
> > > what
> > > it would return as default, some tests care about nodes with
> > > memory.
> > 
> > yes, what you care about is right, but now we only need a function,
> > which
> > can tell us the system have more than one node, we don't care about
> > the
> > nodes have
> > CPUs or memory.
> 
> What I was wondering is why that comment said "rough estimate",

because in the old version, I just used the max node id to judge a NUMA system,
which maybe is not strict.

> it looks quite accurate. Anyway, thanks for clarifying.

in the V2 version, I removed the ISNUMA variable, and added a new function is_numa(),
inside the function, the system, which has 1 more than numa node, and each node at
least contains memory, is regarded as a numa system. I think it's more reasoned,
because NUMA is mainly about memory, more case will fail if the node has no memory.
do you agree?

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
