Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sulfurfff@gmail.com>) id 1USW4j-0007nz-UB
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 17:23:17 +0000
Received: from mail-wg0-f46.google.com ([74.125.82.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1USW4j-0002kO-5q
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 17:23:17 +0000
Received: by mail-wg0-f46.google.com with SMTP id e11so1838205wgh.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Apr 2013 10:23:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Apr 2013 12:23:10 -0500
Message-ID: <CANXECd6HvF8LTCfkhjv_nn_gC1zgOJ_u_4401k_LptG9WUuzYA@mail.gmail.com>
From: =?UTF-8?Q?Ismael_Farf=C3=A1n?= <sulfurfff@gmail.com>
Subject: [LTP] Is running from a read-only path supported?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hello guys,

First of, thanks for your effort writing all this bunch of tests, It's
really helpful.

We are running LTP to test the correct behavior of a FileSystem
mounted in /mnt, however I installed ltp in /read/only/NFS/export/ltp.

I've already changed ltprun [1] so that it writes the failed log in
TMP (which should point to /mnt) instead of LTPBIN, but there are a
bunch of tests creating files in "." instead of TMPDIR, and for what
I've seen "." is actually LTPBIN for some tests which in our case is
read-only.

Also, I can't pass a base directory to run on to many of the tests,
take [2] as example where I patched it to write to TMPDIR.


Question:
Is running form a read-only path supported?


How can I make it create files only is /mnt instead of random places
trough the LTPDIR and /tmp?


Thanks




[1]

:~/ltp-full-20130109$ git diff runltp
diff --git a/runltp b/runltp
index 04cc690..8819548 100755
--- a/runltp
+++ b/runltp
@@ -740,7 +740,7 @@ main()
     fi

     [ ! -z "$QUIET_MODE" ] && { echo "INFO: Test start time: $(date)" ; }
-    PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES
$DURATION -a $$ \
+    PAN_COMMAND="${LTPROOT}/bin/ltp-pan $QUIET_MODE -e -S $INSTANCES
$DURATION -a ${TMP}.$$
     -n $$ $PRETTY_PRT -f ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE"
     echo "COMMAND:    $PAN_COMMAND"
     if [ ! -z "$TAG_RESTRICT_STRING" ] ; then
@@ -833,7 +833,7 @@ main()
        fi
     # Some tests need to run inside the "bin" directory.
     cd "${LTPROOT}/testcases/bin"
-    "${LTPROOT}/bin/ltp-pan" $QUIET_MODE -e -S $INSTANCES $DURATION
-a $$ -n $$ $PRETTY_PRT
+    "${LTPROOT}/bin/ltp-pan" $QUIET_MODE -e -S $INSTANCES $DURATION
-a ${TMP}.$$ -n $$ $PRET

     if [ $? -eq 0 ]; then
       echo "INFO: ltp-pan reported all tests PASS"





[2]

:~/ltp-full-20130109$ git diff testcases/kernel/syscalls/dup/dup07.c
diff --git a/testcases/kernel/syscalls/dup/dup07.c
b/testcases/kernel/syscalls/dup/dup
index c9ddaf0..008e154 100644
--- a/testcases/kernel/syscalls/dup/dup07.c
+++ b/testcases/kernel/syscalls/dup/dup07.c
@@ -48,7 +48,9 @@ int local_flag;
 #define PASSED 1
 #define FAILED 0

-char testfile[40] = "";
+char testfile[240] = "";
+char *tmpdir = NULL;
+

 /*--------------------------------------------------------------------*/
 int main(int ac, char **av)
@@ -63,6 +65,7 @@ int main(int ac, char **av)
        int lc;
        char *msg;

+
        /*
         * parse standard options
         */
@@ -71,11 +74,22 @@ int main(int ac, char **av)
                tst_exit();
        }

+       tmpdir = getenv("TMPDIR");
+       if (tmpdir == NULL){
+               printf("INFO: Couldn't get the environment variable TMPDIR the"
+                       "files will be created in the current directory\n");
+       }
+
        local_flag = PASSED;

        for (lc = 0; TEST_LOOPING(lc); lc++) {

-               sprintf(testfile, "dup07.%d", getpid());
+               if (tmpdir == NULL) {
+                       sprintf(testfile, "dup07.%d", getpid());
+               } else {
+                       sprintf(testfile, "%s/dup07.%d", tmpdir, getpid());
+               }
+
                if ((rdoret = creat(testfile, 0444)) == -1) {
                        tst_resm(TFAIL, "Unable to creat file '%s'", testfile);
                        local_flag = FAILED;



--
Do not let me induce you to satisfy my curiosity, from an expectation,
that I shall gratify yours. What I may judge proper to conceal, does
not concern myself alone.

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
