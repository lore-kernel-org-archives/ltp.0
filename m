Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Sw725-0007ND-64
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 07:38:21 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sw71z-00023S-BB
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 07:38:21 +0000
Date: Tue, 31 Jul 2012 03:38:08 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <402709823.5725690.1343720288429.JavaMail.root@redhat.com>
In-Reply-To: <ba9ec47929d3aa8783905c1e9061536e515ca9f6.1343703433.git.caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
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

Hi Caspar,

------- snip --------
+	ret = get_allowed_nodes(NH_MEMS|NH_CPUS, 2, &nd1, &nd2);

+	switch (ret) {

+	case 0:

+		tst_resm(TINFO, "get node%lu.", nd2);

+		return nd2;

+	case -3:

+		/*

+		 * for unbalanced NUMA systems, at least 1 available node is

+		 * required.

+		 */

+		ret = get_allowed_nodes(NH_MEMS|NH_CPUS, 1, &nd1);

+		switch (ret) {

+		case 0:

+			tst_resm(TINFO, "get node%lu.", nd1);

+			return nd1;

+		case -3:

+			tst_brkm(TCONF, cleanup_fn, "require a NUMA system "

+				    "that has at least one node with both "

+				    "memory and cpu available.");

+		default:

+			tst_brkm(TBROK|TERRNO, cleanup_fn,

+				    "3rd get_allowed_nodes");

+		}

+	}

+	tst_brkm(TBROK|TERRNO, cleanup_fn, "2nd get_allowed_nodes");
------- snip --------

I'm not sure I follow this snippet.
So if there are 2+ nodes, it takes second one. If there is just one, it will take that one.
Can't it take always first one?

Regards,
Jan


----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, 31 July, 2012 4:57:19 AM
> Subject: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
> 
> 
> This patch makes the tests in mem/ dir use numa_helper in
> libkerntest.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/cpuset/Makefile           |    1 +
>  testcases/kernel/mem/cpuset/cpuset01.c         |   16 +++---
>  testcases/kernel/mem/hugetlb/Makefile.inc      |    1 +
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 +
>  testcases/kernel/mem/include/mem.h             |    2 +-
>  testcases/kernel/mem/ksm/Makefile              |    1 +
>  testcases/kernel/mem/ksm/ksm02.c               |    9 ++--
>  testcases/kernel/mem/ksm/ksm04.c               |    9 ++--
>  testcases/kernel/mem/lib/Makefile              |    1 +
>  testcases/kernel/mem/lib/mem.c                 |   61
>  +++++++++++++++++------
>  testcases/kernel/mem/oom/Makefile              |    1 +
>  testcases/kernel/mem/oom/oom02.c               |    4 --
>  testcases/kernel/mem/oom/oom04.c               |    4 --
>  testcases/kernel/mem/swapping/Makefile         |    1 +
>  testcases/kernel/mem/thp/Makefile              |    1 +
>  testcases/kernel/mem/tunable/Makefile          |    1 +
>  16 files changed, 71 insertions(+), 43 deletions(-)
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
