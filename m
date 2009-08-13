Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbeVr-0000Sp-8A
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 17:54:55 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbeVo-0003lI-TB
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 17:54:55 +0000
Message-ID: <4A845364.6070308@canonical.com>
Date: Thu, 13 Aug 2009 12:54:44 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
References: <4A833919.9040603@canonical.com>
	<1250183880.6656.21.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1250183880.6656.21.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------090409070804020109090308"
Subject: Re: [LTP] Add option to skip tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090409070804020109090308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

You were not providing the full path.  Here's a new version that should
let you either provide absolute or relative path (including no patch
assuming the file is in LTPROOT).  See if this works better for you.


Add a -S option to runltp that allows the user to specify a SKIPFILE of
tests to skip.

Signed-off-by: Paul Larson <paul.larson@canonical.com>
---

--------------090409070804020109090308
Content-Type: text/x-patch;
 name="runltp-skipfile-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="runltp-skipfile-2.patch"

diff --git a/runltp b/runltp
index c26f4ab..15da5ab 100755
--- a/runltp
+++ b/runltp
@@ -141,6 +141,7 @@ usage()
     -q              Print less verbose output to screen.
     -r LTPROOT      Fully qualified path where testsuite is installed.
     -s PATTERN      Only run test cases which match PATTERN.
+    -S SKIPFILE     Skip tests specified in SKIPFILE
     -t DURATION     Execute the testsuite for given duration. Examples:
                       -t 60s = 60 seconds
                       -t 45m = 45 minutes
@@ -193,7 +194,7 @@ main()
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     version_date=`head -n 1 $LTPROOT/ChangeLog`
 
-    while getopts a:c:C:d:D:f:ehi:g:l:m:Nno:pqr:s:t:T:vw:x:b:B: arg
+    while getopts a:c:C:d:D:f:ehi:g:l:m:Nno:pqr:s:S:t:T:vw:x:b:B: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -353,6 +354,12 @@ main()
         r)  LTPROOT=$OPTARG;;
     
         s)  TAG_RESTRICT_STRING=$OPTARG;;
+
+	S)  case $OPTARG in
+            /*)
+                SKIPFILE=$OPTARG;;
+            *)
+                SKIPFILE="$LTPROOT/$OPTARG";;
     
         t)  # In case you want to specify the time 
             # to run from the command line 
@@ -630,6 +637,14 @@ main()
         mv -f ${TMP}/alltests ${TMP}/alltests.orig
 	    grep $TAG_RESTRICT_STRING ${TMP}/alltests.orig > ${TMP}/alltests #Not worth checking return codes for this case
     fi
+
+    # Blacklist or skip tests if a SKIPFILE was specified with -S
+    if [ -n "$SKIPFILE" ]
+    then
+        for file in $( cat $SKIPFILE ); do
+            sed -i "/$file/d" ${TMP}/alltests
+        done
+    fi
     
     # check for required users and groups
     ${LTPROOT}/IDcheck.sh &>/dev/null || \

--------------090409070804020109090308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------090409070804020109090308
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090409070804020109090308--

