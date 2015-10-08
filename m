From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 8 Oct 2015 19:29:41 +0800
Subject: [LTP] [PATCH v8 7/7] ipv6_lib: Add it into default
In-Reply-To: <1444303781-18441-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <20151007132856.GD2608@rei.suse.cz>
 <1444303781-18441-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <1444303781-18441-7-git-send-email-zenglg.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 scenario_groups/default | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scenario_groups/default b/scenario_groups/default
index 3a55702..60b1b27 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -32,3 +32,4 @@ dma_thread_diotest
 cpuacct
 can
 cpuhotplug
+ipv6_lib
-- 
1.9.3

