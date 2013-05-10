Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UakP6-0005zP-Oo
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 10:18:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UakP5-0000VT-Dz
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 10:18:20 +0000
Date: Fri, 10 May 2013 06:18:00 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1293337679.9710631.1368181080556.JavaMail.root@redhat.com>
In-Reply-To: <518CC158.20108@cn.fujitsu.com>
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
	<518CC158.20108@cn.fujitsu.com>
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi Wanlong,

----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Friday, May 10, 2013 5:43:52 PM
> Subject: Re: [LTP] [PATCH 1/3] mm/ksm: set the merge_across_nodes knob before testing
> 
> On 05/10/2013 05:13 PM, Zhouping Liu wrote:
> > This kernel commit 90bd6fd31c809(ksm: allow trees per NUMA node)
> > introduced a new KSM sysfs knob /sys/kernel/mm/ksm/merge_across_nodes,
> > when it is set to zero, only pages from the same node are merged,
> > which is different with the previous behavior, and ksm test cases
> > sometimes will fail in NUMA system.
> > 
> > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> 
> While how about wrap the set and reset "merge_across_nodes" value to
> functions,
> so that we can reduce the dup code and dup comments?

yeah, it sounds good, but... look at the codes again:

...
 void cleanup(void)
 {
+       if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+               /* recover the old value */
+               SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+                                "%d", merge_across_nodes);

resetting "merge_across_nodes" only needs one statement.

+
        umount_mem(CPATH, CPATH_NEW);
        TEST_CLEANUP;
 }
@@ -136,6 +143,16 @@ void setup(void)
        if (access(PATH_KSM, F_OK) == -1)
                tst_brkm(TCONF, NULL, "KSM configuration is not enabled");

+       if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+               /*
+                * Save the current value of merge_across_nodes knob,
+                * and make it perform as the default behavior.
+                */
+               SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+                               "%d", &merge_across_nodes);
+               SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");

and setting the value only needs three statements, and it looks easy to understand,
I can remove the comments from ksm02.c ksm03.c ksm04.c to reduce the duplicated comments.

also "merge_across_nodes" is a long string, I can't think of a better function name to
implement set/unset merge_across_nodes, so... IMO, the current codes is good, do you think so?

+       }
+
...
 
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
