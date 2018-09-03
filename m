From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 Sep 2018 12:50:17 +0200
Subject: [LTP] [PATCH 1/1] runltp: Remove RHOST setup
Message-ID: <20180903105017.31106-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as RSH is deprecated. The default management link of network tests are
network namespaces. For remote management is better to setup SSH via:
TST_USE_SSH=1

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
To be honest, I'd prefer removing -N option from runltp or replace it
with info "Run network tests via network.sh script" (+ remove
scenario_groups/network).

I'm looking forward the day this crazy script is replaced with something
more convenient.


Kind regards,
Petr
---
 runltp | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/runltp b/runltp
index bbbb58771..5e2f5668d 100755
--- a/runltp
+++ b/runltp
@@ -570,30 +570,6 @@ main()
       INSTANCES="$INSTANCES -O ${TMP}"
     }
 
-    [ "$RUN_NETEST" -eq 1 ] && \
-    {
-        [ -z "$RHOST" ] || [ -z "$PASSWD" ] && \
-        {
-            [ -z "$RHOST" ] && \
-            {
-                printf "INFO: Enter RHOST = 'name of the remote host machine'"
-                printf "\n-> "
-                read RHOST
-            }
-
-            [ -z "$PASSWD" ] && \
-            {
-                printf "\nINFO: "
-                printf "Enter PASSWD = 'root passwd of the remote host machine'"
-                printf "\n-> "
-                read PASSWD
-            }
-            export RHOST=$RHOST
-            export PASSWD=$PASSWD
-            echo "WARNING: security of $RHOST may be compromised"
-        }
-    }
-
     # If user does not provide a command file select a default set of testcases
     # to execute.
     if [ -z "$CMDFILES" ] && [ -z "$CMDFILEADDR" ]; then
-- 
2.18.0

