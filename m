Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UboJ6-000700-9h
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:40:32 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UboJ4-0002MO-IZ
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:40:32 +0000
Date: Mon, 13 May 2013 04:40:20 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1284641591.353244.1368434420898.JavaMail.root@redhat.com>
In-Reply-To: <51909CD7.9050408@casparzhang.com>
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
	<51909CD7.9050408@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] mm/ksm: set the merge_across_nodes knob
 before testing
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Monday, May 13, 2013 3:57:11 PM
> Subject: Re: [LTP] [PATCH 1/3] mm/ksm: set the merge_across_nodes knob before testing
> 
> On 05/10/2013 05:13 PM, Zhouping Liu wrote:
> > +		/*
> > +		 * Save the current value of merge_across_nodes knob,
> > +		 * and make it perform as the default behavior.
> > +		 */
> 
> This comment is unnecessary. it's not difficult to know it's a
> save/recover operation. I think you can remove it or give a short
> comment of where does this new sysfile come from (e.g. kernel ver/commit
> id, etc)

OK, as merge_across_nodes is new for us, I think we should give some useful
comments, so I updated the comment like below:

+       /*
+        * kernel commit 90bd6fd introduced a new KSM sysfs knob
+        * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
+        * will prevent KSM pages being merged across numa nodes,
+        * which will cause the case fail, so we need to make sure
+        * it is enabled before testing.
+        */ 
+       if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+               SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+                               "%d", &merge_across_nodes);
+               SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+       }
+

and the comment message only appear once in ksm01.c, removed it from ksm0[2|3|4].c.

please review V2.

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
