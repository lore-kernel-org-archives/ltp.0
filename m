Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UGCwW-00026Y-7U
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 18:31:56 +0000
Date: Thu, 14 Mar 2013 19:32:33 +0100
From: chrubis@suse.cz
Message-ID: <20130314183233.GF8894@rei.suse.cz>
References: <20130314165143.GD8894@rei.suse.cz>
	<507561236.18941341.1363282016883.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <507561236.18941341.1363282016883.JavaMail.root@redhat.com>
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

Hi!
> We added numa_helper library to be able to get number of nodes, as well
> as list of nodes (with memory, cpu or both). numa_max_node() > 0 doesn't
> tell you how many nodes you have.
> 
> Here's sample use to get just node count:
> ----------------------------------------------------------------
> #include <stdio.h>
> #include "numa_helper.h"
> 
> const char *TCID="test";
> int main()
> {
>         int num_nodes;
>         int ret = get_allowed_nodes_arr(NH_MEMS | NH_CPUS, &num_nodes, NULL);
>         printf("ret: %d, nodes:%d\n", ret, num_nodes);
>         return 0;
> }
> ----------------------------------------------------------------
> 
> We could add a simple function to numa_helper, but I'm not sure what
> it would return as default, some tests care about nodes with memory.

Maybe we misunderstand about what I see as a problem here. This patch
adds integer variable to the lib/mem.c library and that variable is then
only used within the tests. That just looks like wrong desing to me.

The code snippet "numa_max_node() > 0" was take from one of the tests
that initializes the variable in question (the pattern seems to repeat
in them). So I wasn't proposing any functional changes in the code just
requesting cleaner desing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
