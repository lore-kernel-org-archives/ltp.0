Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mtw9x-0004Hg-PN
	for ltp-list@lists.sourceforge.net; Sat, 03 Oct 2009 04:23:53 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mtw9r-0003RE-DP
	for ltp-list@lists.sourceforge.net; Sat, 03 Oct 2009 04:23:53 +0000
Received: by pxi9 with SMTP id 9so1649947pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 02 Oct 2009 21:23:41 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 2 Oct 2009 21:23:41 -0700
Message-ID: <364299f40910022123k700ee146q5c8a8aa5ccf535eb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=00504502cb24d5a3b00475003e5f
Subject: [LTP] [PATCH] Remove `verbose mode' from runltp*
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
To: LTP list <ltp-list@lists.sourceforge.net>

--00504502cb24d5a3b00475003e5f
Content-Type: text/plain; charset=ISO-8859-1

1. This option really doesn't buy us much in runltp*, and we've almost
already run out of options anyhow...
2. Correct some ugly indentation.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: runltp
===================================================================
RCS file: /cvsroot/ltp/ltp/runltp,v
retrieving revision 1.49
diff -u -r1.49 runltp
--- runltp	26 Aug 2009 07:00:25 -0000	1.49
+++ runltp	3 Oct 2009 04:21:33 -0000
@@ -156,7 +156,6 @@
                       -t 24h = 24 hours
                       -t 2d  = 2 days
     -T REPETITION   Execute the testsuite for REPETITION no. of times
-    -v              Print more verbose output to screen.
     -w CMDFILEADDR  Uses wget to get the user's list of testcases.
     -x INSTANCES    Run multiple instances of this testsuite.
     -b DEVICE       Some tests require an unmounted block device
@@ -182,18 +181,17 @@
     local RUN_NETEST=0
     local RUN_REPEATED=0
     local QUIET_MODE=""
-    local VERBOSE_MODE=""
     local NETPIPE=0
     local GENLOAD=0
     local MEMSIZE=0
     local DURATION=""
     local CMDFILEADDR=""
     local FAILCMDFILE=""
-	local INJECT_KERNEL_FAULT=""
-	local INJECT_KERNEL_FAULT_PERCENTAGE=""
-	local INJECT_FAULT_LOOPS_PER_TEST=""
-	local VALGRIND_CHECK=""
-	local VALGRIND_CHECK_TYPE=""
+    local INJECT_KERNEL_FAULT=""
+    local INJECT_KERNEL_FAULT_PERCENTAGE=""
+    local INJECT_FAULT_LOOPS_PER_TEST=""
+    local VALGRIND_CHECK=""
+    local VALGRIND_CHECK_TYPE=""
     local LOGFILE_NAME=""
     local LOGFILE=""
     local OUTPUTFILE_NAME=""
@@ -207,7 +205,7 @@
     local DEFAULT_FILE_NAME_GENERATION_TIME=`date +"%Y_%b_%d-%Hh_%Mm_%Ss"`
     version_date=`head -n 1 $LTPROOT/ChangeLog`

-    while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:vw:x:b:B: arg
+    while getopts a:c:C:d:D:f:F:ehi:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -398,8 +396,6 @@
         T)  # In case you want the testcases to runsequentially
RUN_REPEATED times
             RUN_REPEATED=$OPTARG;;

-        v)  VERBOSE_MODE=1;;
-
         w)  CMDFILEADDR=$OPTARG;;

         x)  # number of ltp's to run
@@ -755,11 +751,9 @@
     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
     PAN_COMMAND="${LTPROOT}/pan/ltp-pan $QUIET_MODE -e -S $INSTANCES
$DURATION -a $$ \
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE"
-    if [ ! -z "$VERBOSE_MODE" ] ; then
-      echo "COMMAND:    $PAN_COMMAND"
-      if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
-        echo "INFO: Restricted to $TAG_RESTRICT_STRING"
-      fi
+    echo "COMMAND:    $PAN_COMMAND"
+    if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
+      echo "INFO: Restricted to $TAG_RESTRICT_STRING"
     fi
     #$PAN_COMMAND #Duplicated code here, because otherwise if we
fail, only "PAN_COMMAND" gets output

Index: runltplite.sh
===================================================================
RCS file: /cvsroot/ltp/ltp/runltplite.sh,v
retrieving revision 1.5
diff -u -r1.5 runltplite.sh
--- runltplite.sh	19 May 2009 09:39:11 -0000	1.5
+++ runltplite.sh	3 Oct 2009 04:21:33 -0000
@@ -85,7 +85,6 @@
     -p              Human readable format logfiles.
     -q              Print less verbose output to screen.
     -r LTPROOT      Fully qualified path where testsuite is installed.
-    -v              Print more verbose output to screen.

     example: ./${0##*/} -i 1024 -m 128 -p -q  -l /tmp/resultlog.$$ -d ${PWD}

@@ -114,7 +113,7 @@
     local TAG_RESTRICT_STRING=""
     local PAN_COMMAND=""

-    while getopts c:d:hi:l:m:No:pqr:v arg
+    while getopts c:d:hi:l:m:No:pqr: arg
     do  case $arg in
         c)
 	    NUM_PROCS=$(($OPTARG))

--00504502cb24d5a3b00475003e5f
Content-Type: application/octet-stream; name="remove-verbose-runltp.diff"
Content-Disposition: attachment; filename="remove-verbose-runltp.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g0buquzp0

SW5kZXg6IHJ1bmx0cAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3Zzcm9vdC9sdHAvbHRwL3J1bmx0
cCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS40OQpkaWZmIC11IC1yMS40OSBydW5sdHAKLS0tIHJ1
bmx0cAkyNiBBdWcgMjAwOSAwNzowMDoyNSAtMDAwMAkxLjQ5CisrKyBydW5sdHAJMyBPY3QgMjAw
OSAwNDoyMTozMyAtMDAwMApAQCAtMTU2LDcgKzE1Niw2IEBACiAgICAgICAgICAgICAgICAgICAg
ICAgLXQgMjRoID0gMjQgaG91cnMKICAgICAgICAgICAgICAgICAgICAgICAtdCAyZCAgPSAyIGRh
eXMKICAgICAtVCBSRVBFVElUSU9OICAgRXhlY3V0ZSB0aGUgdGVzdHN1aXRlIGZvciBSRVBFVElU
SU9OIG5vLiBvZiB0aW1lcwotICAgIC12ICAgICAgICAgICAgICBQcmludCBtb3JlIHZlcmJvc2Ug
b3V0cHV0IHRvIHNjcmVlbi4gICAgICAgICAgICAgICAgICAgCiAgICAgLXcgQ01ERklMRUFERFIg
IFVzZXMgd2dldCB0byBnZXQgdGhlIHVzZXIncyBsaXN0IG9mIHRlc3RjYXNlcy4KICAgICAteCBJ
TlNUQU5DRVMgICAgUnVuIG11bHRpcGxlIGluc3RhbmNlcyBvZiB0aGlzIHRlc3RzdWl0ZS4KICAg
ICAtYiBERVZJQ0UgICAgICAgU29tZSB0ZXN0cyByZXF1aXJlIGFuIHVubW91bnRlZCBibG9jayBk
ZXZpY2UKQEAgLTE4MiwxOCArMTgxLDE3IEBACiAgICAgbG9jYWwgUlVOX05FVEVTVD0wCiAgICAg
bG9jYWwgUlVOX1JFUEVBVEVEPTAKICAgICBsb2NhbCBRVUlFVF9NT0RFPSIiCi0gICAgbG9jYWwg
VkVSQk9TRV9NT0RFPSIiCiAgICAgbG9jYWwgTkVUUElQRT0wCiAgICAgbG9jYWwgR0VOTE9BRD0w
CiAgICAgbG9jYWwgTUVNU0laRT0wCiAgICAgbG9jYWwgRFVSQVRJT049IiIKICAgICBsb2NhbCBD
TURGSUxFQUREUj0iIgogICAgIGxvY2FsIEZBSUxDTURGSUxFPSIiCi0JbG9jYWwgSU5KRUNUX0tF
Uk5FTF9GQVVMVD0iIgotCWxvY2FsIElOSkVDVF9LRVJORUxfRkFVTFRfUEVSQ0VOVEFHRT0iIgot
CWxvY2FsIElOSkVDVF9GQVVMVF9MT09QU19QRVJfVEVTVD0iIgotCWxvY2FsIFZBTEdSSU5EX0NI
RUNLPSIiCi0JbG9jYWwgVkFMR1JJTkRfQ0hFQ0tfVFlQRT0iIgorICAgIGxvY2FsIElOSkVDVF9L
RVJORUxfRkFVTFQ9IiIKKyAgICBsb2NhbCBJTkpFQ1RfS0VSTkVMX0ZBVUxUX1BFUkNFTlRBR0U9
IiIKKyAgICBsb2NhbCBJTkpFQ1RfRkFVTFRfTE9PUFNfUEVSX1RFU1Q9IiIKKyAgICBsb2NhbCBW
QUxHUklORF9DSEVDSz0iIgorICAgIGxvY2FsIFZBTEdSSU5EX0NIRUNLX1RZUEU9IiIKICAgICBs
b2NhbCBMT0dGSUxFX05BTUU9IiIKICAgICBsb2NhbCBMT0dGSUxFPSIiCiAgICAgbG9jYWwgT1VU
UFVURklMRV9OQU1FPSIiCkBAIC0yMDcsNyArMjA1LDcgQEAKICAgICBsb2NhbCBERUZBVUxUX0ZJ
TEVfTkFNRV9HRU5FUkFUSU9OX1RJTUU9YGRhdGUgKyIlWV8lYl8lZC0lSGhfJU1tXyVTcyJgCiAg
ICAgdmVyc2lvbl9kYXRlPWBoZWFkIC1uIDEgJExUUFJPT1QvQ2hhbmdlTG9nYAogCi0gICAgd2hp
bGUgZ2V0b3B0cyBhOmM6QzpkOkQ6ZjpGOmVoaTpnOmw6bTpNOk5ubzpwcXI6czpTOnQ6VDp2dzp4
OmI6QjogYXJnCisgICAgd2hpbGUgZ2V0b3B0cyBhOmM6QzpkOkQ6ZjpGOmVoaTpnOmw6bTpNOk5u
bzpwcXI6czpTOnQ6VDp3Ong6YjpCOiBhcmcKICAgICBkbyAgY2FzZSAkYXJnIGluCiAgICAgICAg
IGEpICBFTUFJTF9UTz0kT1BUQVJHCiAgICAgICAgICAgICBBTFRfRU1BSUxfT1VUPTE7OwpAQCAt
Mzk4LDggKzM5Niw2IEBACiAgICAgICAgIFQpICAjIEluIGNhc2UgeW91IHdhbnQgdGhlIHRlc3Rj
YXNlcyB0byBydW5zZXF1ZW50aWFsbHkgUlVOX1JFUEVBVEVEIHRpbWVzCiAgICAgICAgICAgICBS
VU5fUkVQRUFURUQ9JE9QVEFSRzs7CiAKLSAgICAgICAgdikgIFZFUkJPU0VfTU9ERT0xOzsKLQog
ICAgICAgICB3KSAgQ01ERklMRUFERFI9JE9QVEFSRzs7CiAgICAKICAgICAgICAgeCkgICMgbnVt
YmVyIG9mIGx0cCdzIHRvIHJ1bgpAQCAtNzU1LDExICs3NTEsOSBAQAogICAgIFsgISAteiAiJFFV
SUVUX01PREUiIF0gJiYgeyBlY2hvICJJTkZPOiBUZXN0IHN0YXJ0IHRpbWU6ICQoZGF0ZSkiIDsg
fQogICAgIFBBTl9DT01NQU5EPSIke0xUUFJPT1R9L3Bhbi9sdHAtcGFuICRRVUlFVF9NT0RFIC1l
IC1TICRJTlNUQU5DRVMgJERVUkFUSU9OIC1hICQkIFwKICAgICAtbiAkJCAkUFJFVFRZX1BSVCAt
ZiAke1RNUH0vYWxsdGVzdHMgJExPR0ZJTEUgJE9VVFBVVEZJTEUgJEZBSUxDTURGSUxFIgotICAg
IGlmIFsgISAteiAiJFZFUkJPU0VfTU9ERSIgXSA7IHRoZW4KLSAgICAgIGVjaG8gIkNPTU1BTkQ6
ICAgICRQQU5fQ09NTUFORCIKLSAgICAgIGlmIFsgISAteiAiJFRBR19SRVNUUklDVF9TVFJJTkci
IF0gOyB0aGVuCi0gICAgICAgIGVjaG8gIklORk86IFJlc3RyaWN0ZWQgdG8gJFRBR19SRVNUUklD
VF9TVFJJTkciCi0gICAgICBmaQorICAgIGVjaG8gIkNPTU1BTkQ6ICAgICRQQU5fQ09NTUFORCIK
KyAgICBpZiBbICEgLXogIiRUQUdfUkVTVFJJQ1RfU1RSSU5HIiBdIDsgdGhlbgorICAgICAgZWNo
byAiSU5GTzogUmVzdHJpY3RlZCB0byAkVEFHX1JFU1RSSUNUX1NUUklORyIKICAgICBmaQogICAg
ICMkUEFOX0NPTU1BTkQgI0R1cGxpY2F0ZWQgY29kZSBoZXJlLCBiZWNhdXNlIG90aGVyd2lzZSBp
ZiB3ZSBmYWlsLCBvbmx5ICJQQU5fQ09NTUFORCIgZ2V0cyBvdXRwdXQKICAgICAKSW5kZXg6IHJ1
bmx0cGxpdGUuc2gKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC9ydW5sdHBs
aXRlLnNoLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjUKZGlmZiAtdSAtcjEuNSBydW5sdHBsaXRl
LnNoCi0tLSBydW5sdHBsaXRlLnNoCTE5IE1heSAyMDA5IDA5OjM5OjExIC0wMDAwCTEuNQorKysg
cnVubHRwbGl0ZS5zaAkzIE9jdCAyMDA5IDA0OjIxOjMzIC0wMDAwCkBAIC04NSw3ICs4NSw2IEBA
CiAgICAgLXAgICAgICAgICAgICAgIEh1bWFuIHJlYWRhYmxlIGZvcm1hdCBsb2dmaWxlcy4gCiAg
ICAgLXEgICAgICAgICAgICAgIFByaW50IGxlc3MgdmVyYm9zZSBvdXRwdXQgdG8gc2NyZWVuLgog
ICAgIC1yIExUUFJPT1QgICAgICBGdWxseSBxdWFsaWZpZWQgcGF0aCB3aGVyZSB0ZXN0c3VpdGUg
aXMgaW5zdGFsbGVkLgotICAgIC12ICAgICAgICAgICAgICBQcmludCBtb3JlIHZlcmJvc2Ugb3V0
cHV0IHRvIHNjcmVlbi4gICAgICAgICAgICAgICAgICAgCiAKICAgICBleGFtcGxlOiAuLyR7MCMj
Ki99IC1pIDEwMjQgLW0gMTI4IC1wIC1xICAtbCAvdG1wL3Jlc3VsdGxvZy4kJCAtZCAke1BXRH0K
IApAQCAtMTE0LDcgKzExMyw3IEBACiAgICAgbG9jYWwgVEFHX1JFU1RSSUNUX1NUUklORz0iIgog
ICAgIGxvY2FsIFBBTl9DT01NQU5EPSIiCiAKLSAgICB3aGlsZSBnZXRvcHRzIGM6ZDpoaTpsOm06
Tm86cHFyOnYgYXJnCisgICAgd2hpbGUgZ2V0b3B0cyBjOmQ6aGk6bDptOk5vOnBxcjogYXJnCiAg
ICAgZG8gIGNhc2UgJGFyZyBpbgogICAgICAgICBjKSAgICAgICAKIAkgICAgTlVNX1BST0NTPSQo
KCRPUFRBUkcpKQo=
--00504502cb24d5a3b00475003e5f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--00504502cb24d5a3b00475003e5f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00504502cb24d5a3b00475003e5f--

