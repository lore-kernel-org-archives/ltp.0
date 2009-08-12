Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbLiN-0000ge-Re
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:50:35 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbLiE-0004au-HF
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:50:30 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1MbLi8-0005q4-5j
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 22:50:20 +0100
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbLi7-0006mh-Vx
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 22:50:20 +0100
Message-ID: <4A833919.9040603@canonical.com>
Date: Wed, 12 Aug 2009 16:50:17 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090500070109050906000709"
Subject: [LTP] Add option to skip tests
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090500070109050906000709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

One problem that LTP has long suffered is that certain tests are known
to be broken, sometimes for long periods of time.  In an ideal world, I
think it best that these should be skipped, or at least removed from the
default list of tests to run, but this isn't always practical due to a
number of reasons.  Of course, another option is that a 'whitelist' of
tests to run can be created and passed to runltp, but this becomes hard
to maintain as there are often new tests that you may want to keep up
with, and with each release of LTP, the list would have to be reexamined.

So I wanted to see what people thought about a simple option, -S, to
specify a list of tests that you want to blacklist from the current run.
 This is handy if you have an automated testing environment with an
architecture that doesn't always get great attention and a list of tests
that you know to be broken on that arch.

The skipfile is simply a list of test names, one per line.

Thanks,
Paul Larson
---

Add a -S option to runltp that allows the user to specify a SKIPFILE of
tests to skip.

Signed-off-by: Paul Larson <paul.larson@canonical.com>
---

--------------090500070109050906000709
Content-Type: text/x-patch;
 name="runltp-skipfile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="runltp-skipfile.patch"

diff --git a/runltp b/runltp
index c26f4ab..746a1ec 100755
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
@@ -353,6 +354,8 @@ main()
         r)  LTPROOT=$OPTARG;;
     
         s)  TAG_RESTRICT_STRING=$OPTARG;;
+
+	S)  SKIPFILE=$OPTARG;;
     
         t)  # In case you want to specify the time 
             # to run from the command line 
@@ -630,6 +633,14 @@ main()
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

--------------090500070109050906000709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------090500070109050906000709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090500070109050906000709--

