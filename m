From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Nov 2018 13:45:46 +0100
Subject: [LTP] [PATCH] [RFC] doc/tmp-commands.txt
Message-ID: <20181114124546.17222-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove obsolete documentation.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/tpm-commands.txt | 123 ---------------------------------------------------
 1 file changed, 123 deletions(-)
 delete mode 100644 doc/tpm-commands.txt

diff --git a/doc/tpm-commands.txt b/doc/tpm-commands.txt
deleted file mode 100644
index 59a432494..000000000
--- a/doc/tpm-commands.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-ade
----
-ar01
-
-	Construct one or more command lines which use options that do not
-	take arguments
-	For each of these invocations
-	Specify the options separately
-	Group the options together
-	Compare the behavior of the two cases
-	If they behave differently, then fail
-	If none of the cases fail, then pass
-
-ld01
-
-	 To test the basic functionality of the `ld` command.
-
-ldd01
-
-	 To test the basic functionality of the `ldd` command.
-
-nm01
-
-	To test the basic functionality of the `nm` command.
-
-objdump01
-
-	Tests the functionality of the `objdump` command.
-
-size01
-
-	To test the basic functionality of `size`.
-
-
-
-cpio
-----
-cpio_test.sh
-
-	Tests the basic functionality of `cpio` command
-
-
-
-cron
-----
-cron_test.sh
-
-	This testcase tests if crontab <filename> installs the cronjob
-	and cron schedules the job correctly.
-
-
-
-eject
------
-eject_tests.sh
-
-	Tests the basic functionality of `eject` command.
-
-
-
-fileutils
----------
-cp_tests.sh
-
-	Test basic functionality of `cp` command
-
-ln_tests.sh
-
-	Test basic functionality of `ln` command
-
-mkdir_tests.sh
-
-	Test basic functionality of `mkdir` command
-
-mv_test.sh
-
-	Test basic functionality of `mv` command
-
-
-
-gzip
-----
-gzip_tests.sh
-
-	Test basic functionality of `gzip` and `gunzip` command
-
-
-
-logrotate
----------
-logrotate_tests.sh
-
-	Test basic functionality of `logrotate` command.
-
-
-
-mail
-----
-mail_tests.sh
-
-	Test basic functionality of `mail` command.
-
-
-
-tar
----
-tar_tests.sh
-
-	Test basic functionality of `tar` command.
-
-
-tpm-tools
---------
-
-	Test basic functionality of the tpm-tools commands.
-
-
-unzip
------
-unzip_tests.sh
-
-	Test basic functionality of `unzip` command.
-
-- 
2.16.4

