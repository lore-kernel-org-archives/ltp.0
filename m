From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 12:30:52 +0200
Subject: [LTP] [PATCH 1/1] netns_helper.sh: Fix parsing recent iproute2
 versions
Message-ID: <20210512103052.9646-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

iproute2 prior v5.8.0 contained snapshot date:
$ ip -V
ip utility, iproute2-ss190107

But since version v5.7.0-77-gb687d1067169 (released in v5.8.0) there is
new scheme. For releases it contains kernel version:

$ip -V
ip utility, iproute2-5.8.0

and for snapshots build from git it contains version generated with git
describe:

$ip -V
ip utility, iproute2-v5.10.0-74-g2953235e

Thus the original parsing in tst_check_iproute() leads to error:
[: too many arguments

Because function was used only on single place, move expected version
into the function and consider new format as always valid.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

there are more tests which need ip version check: mc_cmds.sh,
netns_netlink.c, netns_helper.sh.

netns_netlink.c can be checked for tuntap support with simple running
'ip tuntap' [1], mc_cmds.sh correctly detect new version with new
scheme, thus only netns_helper.sh needs to be fixed, although it's just
a warning.

Proper way would be to have C implementation to check version, which
would be reusable in both C and shell. I plan to add it after the
release but because there is git freeze due new release sending just
this quick fix.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210512100746.5907-1-pvorel@suse.cz/

 testcases/kernel/containers/netns/netns_helper.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a5b77a0aa..4dac0e306 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -47,16 +47,21 @@ IFCONF_IN6_ARG=
 
 tst_check_iproute()
 {
-	local cur_ipver="$(ip -V)"
-	local spe_ipver="$1"
+	local current_ver="$(ip -V)"
+	local expected_ver="111010"
 
-	cur_ipver=${cur_ipver##*s}
+	current_ver=${current_ver##*s}
 
-	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
+	if [ -z "$current_ver" ]; then
 		tst_brk TBROK "failed to obtain valid iproute version"
 	fi
 
-	if [ $cur_ipver -lt $spe_ipver ]; then
+	# new version scheme since v5.7.0-77-gb687d1067169
+	if echo "$current_ver" | grep -q 'iproute2-v\?[0-9]\+\.'; then
+		return
+	fi
+
+	if [ $current_ver -lt $expected_ver ]; then
 		tst_brk TCONF "too old iproute version"
 	fi
 }
-- 
2.31.1

