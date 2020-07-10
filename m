From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2020 19:20:39 +0200
Subject: [LTP] [PATCH v2 2/7] tst_net.sh: Use ssh in LTP_RSH
In-Reply-To: <20200710172044.21592-1-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
Message-ID: <20200710172044.21592-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for LTP_RSH (rsh fallback) it's better to use ssh instead of rsh by
default, using current user.

+ update docs.

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh        | 2 +-
 testcases/network/stress/README | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 7ba267eda..0a8b2a8ca 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -838,7 +838,7 @@ tst_default_max_pkt()
 export RHOST="$RHOST"
 export PASSWD="${PASSWD:-}"
 # Don't use it in new tests, use tst_rhost_run() from tst_net.sh instead.
-export LTP_RSH="${LTP_RSH:-rsh -n}"
+export LTP_RSH="${LTP_RSH:-ssh -nq}"
 
 # Test Links
 # IPV{4,6}_{L,R}HOST can be set with or without prefix (e.g. IP or IP/prefix),
diff --git a/testcases/network/stress/README b/testcases/network/stress/README
index bc51a4cc9..b9537b1ce 100644
--- a/testcases/network/stress/README
+++ b/testcases/network/stress/README
@@ -48,10 +48,9 @@ To run the network stress testcases, use network.sh script, located in
 testscripts directory. For documentation about using network.sh see INSTALL
 and testcases/network/README.md
 
-Unfortunately some stress tests still depend on rsh for accessing remote host, even
-you decide to use SSH or network namespaces with network.sh.
-Instead of rsh, you can use ssh to set the environment variable LTP_RSH.
-Please refer the `Environment Variable' section of this document.
+Some stress tests originally designed to be tested with rsh for accessing
+remote host are now using ssh using the current user. Old behavior (using rsh
+can be achieved with setting LTP_RSH variable).
 
 The behaviour of network stress tests is configurable with environment
 variables (See `Environment Variable' section).
@@ -146,7 +145,7 @@ Optional environment variables
 ------------------------------
 
  o LTP_RSH
-   The name of the remote shell command, namely rsh or ssh.
+   The name of the remote shell command, namely ssh (the default) or rsh.
    In ether case, the remote host must accept the login from the local host
    without password.
 
-- 
2.27.0

