From: Li Wang <liwang@redhat.com>
Date: Wed,  8 May 2019 16:44:47 +0800
Subject: [LTP] [PATCH v2 2/2] libltpnuma: remove restrictions on numa node-id
In-Reply-To: <20190508084447.18191-1-liwang@redhat.com>
References: <20190508084447.18191-1-liwang@redhat.com>
Message-ID: <20190508084447.18191-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For some ppc64le systems, it has non-continuous numa nodes in
hardware configuration. So we're hitting the below warnings while
running set_mempolicy tests on that. To fix this issue, let's just
remove restrictions on numa node-id in get_mempolicy().

Error Log
---------
tst_test.c:1096: INFO: Timeout per run is 0h 50m 00s
tst_numa.c:190: INFO: Found 2 NUMA memory nodes
set_mempolicy01.c:63: PASS: set_mempolicy(MPOL_BIND) node 0
tst_numa.c:26: INFO: Node 0 allocated 16 pages
tst_numa.c:26: INFO: Node 8 allocated 0 pages
set_mempolicy01.c:82: PASS: child: Node 0 allocated 16
set_mempolicy01.c:63: PASS: set_mempolicy(MPOL_BIND) node 8
tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 8
tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 8
tst_numa.c:92: WARN: get_mempolicy(...) returned invalid node 8
...
tst_numa.c:26: INFO: Node 0 allocated 0 pages
tst_numa.c:26: INFO: Node 8 allocated 0 pages
set_mempolicy01.c:86: FAIL: child: Node 8 allocated 0, expected 16

lscpu
-----
Architecture:        ppc64le
...
CPU(s):              128
Core(s) per socket:  16
Socket(s):           2
NUMA node(s):        2
Model name:          POWER9, altivec supported
...
NUMA node0 CPU(s):   0-63
NUMA node8 CPU(s):   64-127

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 libs/libltpnuma/tst_numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libs/libltpnuma/tst_numa.c b/libs/libltpnuma/tst_numa.c
index 0ba6daf39..56c8640ff 100644
--- a/libs/libltpnuma/tst_numa.c
+++ b/libs/libltpnuma/tst_numa.c
@@ -88,8 +88,9 @@ void tst_nodemap_count_pages(struct tst_nodemap *nodes,
 		if (ret < 0)
 			tst_brk(TBROK | TERRNO, "get_mempolicy() failed");
 
-		if (node < 0 || (unsigned int)node >= nodes->cnt) {
-			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
+		if (node < 0) {
+			tst_res(TWARN,
+				"get_mempolicy(...) returned invalid node %i\n", node);
 			continue;
 		}
 
-- 
2.20.1

