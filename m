From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jan 2017 15:02:59 +0100
Subject: [LTP] [PATCH v2 2/2] network: Fix using local for some non-bash
	shells
In-Reply-To: <20170123140259.20053-1-pvorel@suse.cz>
References: <20170123140259.20053-1-pvorel@suse.cz>
Message-ID: <20170123140259.20053-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fix 'local: fd00:1:1:1::1: bad variable name' for ipneigh01.sh
in dash.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index f423ddc62..99bab1621 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -29,8 +29,8 @@ do_setup()
 
 do_test()
 {
-	local arp_show_cmd=$1
-	local arp_del_cmd=$2
+	local arp_show_cmd="$1"
+	local arp_del_cmd="$2"
 
 	local entry_name
 	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
-- 
2.11.0

