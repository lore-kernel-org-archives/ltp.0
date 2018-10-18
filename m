From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 16:42:11 +0200
Subject: [LTP] [PATCH v2 1/1] net: Fix missing ping6
Message-ID: <20181018144211.8298-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ping6 is needed for some tst_net.sh based tests (and for
netns_helper.sh, but it handles the dependency itself).

iputils commit ebad35f ("ping: merge `ping6` command into `ping`") [1],
released in s20150815 stopped providing ping6 and left it on
distributions (see also [2]).
Some distros don't create it (or didn't create it in the past [3]),
use workaround and warn about it (as it's also a bug which should
be fixed).

NOTE: Unfortunately we cannot use 'ping -${TST_IPVER}' as ping got '-6'
switch (as a part of support for IPv6) was in commit 25aaaf4 ("Allow ping
to use IPv6 addresses") [4], released in s20150815 (previous versions
supported only ping6).

[1] https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d
[2] https://bugzilla.redhat.com/show_bug.cgi?id=617934#c22
[3] https://bugzilla.opensuse.org/show_bug.cgi?id=1017616
[4] https://github.com/iputils/iputils/commit/25aaaf4c58b485a5d9ec758a1f170cc5ec4073c4

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
Hi Alexey,

used a bit strange syntax, but it handles aliases.


Kind regards,
Petr
---
 testcases/lib/tst_net.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index a4467da7c..29080f92b 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -756,3 +756,11 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 if [ -n "$TST_USE_LEGACY_API" ]; then
 	tst_net_remote_tmpdir
 fi
+
+if ! tst_cmd_available ping6; then
+	ping6()
+	{
+		ping -6 $@
+	}
+	tst_res_ TINFO "ping6 binary/symlink is missing, using workaround. Please, report missing ping6 to your distribution."
+fi
-- 
2.19.1

