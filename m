From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 15:31:46 +0200
Subject: [LTP] [PATCH v5 3/5] shell: Add timeout shell API tests
In-Reply-To: <20191011125648.GF2591@rei>
References: <20191011095442.10541-1-pvorel@suse.cz>
 <20191011095442.10541-4-pvorel@suse.cz>
 <1570797394.4238.7.camel@suse.de> <20191011125413.GA30000@dell5510>
 <20191011125648.GF2591@rei>
Message-ID: <20191011133129.GA23391@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > timeout02 1 TCONF: LTP_TIMEOUT_MUL must be number >= 1! (0)
> > BTW I wonder if TBROK shouldn't be used instead of TCONF.
> > Anybody strong opinion?

> If we fail to run a test because user passed wrong input data it has to
> be TBROK because TCONF can end up unnoticed.
+1.

I'd like to merge v5 with following diff:
Please let me know if anything else is problematic.

Kind regards,
Petr

diff --git lib/newlib_tests/shell/test_timeout.sh lib/newlib_tests/shell/test_timeout.sh
index 2cbc66412..948c7f02d 100755
--- lib/newlib_tests/shell/test_timeout.sh
+++ lib/newlib_tests/shell/test_timeout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-PATH="$(dirname $0)/../../../testcases/lib/:$PATH"
+PATH="$(dirname $0):$(dirname $0)/../../../testcases/lib/:$PATH"
 
 DATA="
 timeout01.sh||0
@@ -9,6 +9,11 @@ timeout02.sh|foo|32
 timeout02.sh|2|0
 timeout02.sh|1.1|0
 timeout02.sh|-10|32
+
+timeout01.sh|2|0
+timeout02.sh|-1.1|32
+timeout02.sh|-10.1|32
+timeout02.sh|-0.1|0
 "
 
 echo "Testing timeout in shell API"
@@ -21,7 +26,7 @@ for i in $DATA; do
 	exp_exit=$(echo $i | cut -d'|' -f3)
 
 	echo "=== $test (LTP_TIMEOUT_MUL='$timeout') ==="
-	LTP_TIMEOUT_MUL=$timeout ./$file
+	LTP_TIMEOUT_MUL=$timeout $file
 	ret=$?
 	if [ $ret -ne $exp_exit ]; then
 		echo "FAILED (exit code: $ret, expected $exp_exit)"
diff --git testcases/lib/tst_test.sh testcases/lib/tst_test.sh
index 8713c1cdd..d8071cb10 100644
--- testcases/lib/tst_test.sh
+++ testcases/lib/tst_test.sh
@@ -389,14 +389,14 @@ _tst_setup_timer()
 
 	local err="LTP_TIMEOUT_MUL must be number >= 1!"
 
-	tst_is_num "$LTP_TIMEOUT_MUL" || tst_brk TCONF "$err ($LTP_TIMEOUT_MUL)"
+	tst_is_num "$LTP_TIMEOUT_MUL" || tst_brk TBROK "$err ($LTP_TIMEOUT_MUL)"
 
 	if ! tst_is_int "$LTP_TIMEOUT_MUL"; then
 		LTP_TIMEOUT_MUL=$(echo "$LTP_TIMEOUT_MUL" | cut -d. -f1)
 		LTP_TIMEOUT_MUL=$((LTP_TIMEOUT_MUL+1))
 		tst_res TINFO "ceiling LTP_TIMEOUT_MUL to $LTP_TIMEOUT_MUL"
 	fi
-	[ "$LTP_TIMEOUT_MUL" -ge 1 ] || tst_brk TCONF "$err ($LTP_TIMEOUT_MUL)"
+	[ "$LTP_TIMEOUT_MUL" -ge 1 ] || tst_brk TBROK "$err ($LTP_TIMEOUT_MUL)"
 
 	if ! tst_is_int "$TST_TIMEOUT" || [ "$TST_TIMEOUT" -lt 1 ]; then
 		tst_brk TBROK "TST_TIMEOUT must be int >= 1! ($TST_TIMEOUT)"
