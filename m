From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Aug 2019 21:07:09 +0200
Subject: [LTP] [PATCH 2/2] tst_net.sh: Rename variables to comply name policy
In-Reply-To: <20190829190709.30834-1-pvorel@suse.cz>
References: <20190829190709.30834-1-pvorel@suse.cz>
Message-ID: <20190829190709.30834-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

internal variables are lower case, with _tst_net prefix

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index eba60bd44..d5ed533b0 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -765,7 +765,7 @@ _tst_net_variable_setup()
 	# tst_net_ip_prefix -h
 	# tst_net_iface_prefix -h
 	# tst_net_vars -h
-	if [ -z "$TST_PARSE_VARIABLES" ]; then
+	if [ -z "$_tst_net_parse_variables" ]; then
 		eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
 		eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
 		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
@@ -774,7 +774,7 @@ _tst_net_variable_setup()
 
 	[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
 
-	if [ -z "$TST_PARSE_VARIABLES" ]; then
+	if [ -z "$_tst_net_parse_variables" ]; then
 		eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
 		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
 			|| echo "exit $?")
@@ -791,7 +791,7 @@ _tst_net_variable_setup()
 		tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
 		tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
 		tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
-		export TST_PARSE_VARIABLES="yes"
+		export _tst_net_parse_variables="yes"
 	fi
 
 	export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
@@ -845,9 +845,9 @@ if [ -z "$TST_USE_LEGACY_API" ] && ! tst_cmd_available ping6; then
 	{
 		ping -6 $@
 	}
-	if [ -z "$ping6_warn_printed" ]; then
+	if [ -z "$_tst_net_ping6_warn_printed" ]; then
 		tst_res_ TINFO "ping6 binary/symlink is missing, using workaround. Please, report missing ping6 to your distribution."
-		export ping6_warn_printed=1
+		export _tst_net_ping6_warn_printed=1
 	fi
 fi
 
-- 
2.22.1

