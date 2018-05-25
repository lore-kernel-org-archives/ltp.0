From: Yixin Zhang <yixin.zhang@intel.com>
Date: Fri, 25 May 2018 14:25:31 +0800
Subject: [LTP] [PATCH ltp] runltp: fix shellcheck error for sending email
Message-ID: <20180525062531.30549-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

runltp:894:11: error: Couldn't parse this test expression. [SC1073]
runltp:894:13: error: If grouping expressions inside [..], use \( ..\). [SC1026]
runltp:894:15: error: Expected test to end here (don't wrap commands in []/[[]]).
                      Fix any mentioned problems and try again. [SC1072]

Also change '-o' to '&&' according to the comment and context.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 runltp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 51357fadf..c6e5b03e8 100755
--- a/runltp
+++ b/runltp
@@ -891,7 +891,7 @@ main()
     fi
 
     if [ "$ALT_EMAIL_OUT" -eq 1 ] ; then                      ## User wants reports to be e-mailed
-       if [ [ ! "$HTMLFILE_NAME" ] -o [ ! "$OUTPUTFILE_NAME" ] -o [ ! "$LOGFILE_NAME" ] ] ; then
+       if [ -z "$HTMLFILE_NAME" ] && [ -z "$OUTPUTFILE_NAME" ] && [ -z "$LOGFILE_NAME" ]; then
           ##User does not have output/logs/html-output, nothing to be mailed in this situation
           echo "Nothing to be mailed here...."
        else
-- 
2.14.1

