From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Mar 2020 10:36:22 +0100
Subject: [LTP] [PATCH 2/2] xinetd: Fix pattern for NetKit telnet
In-Reply-To: <20200324093622.21091-1-pvorel@suse.cz>
References: <20200324093622.21091-1-pvorel@suse.cz>
Message-ID: <20200324093622.21091-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/xinetd/xinetd_tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index b7c6273ba..f7f5db7bc 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -92,7 +92,7 @@ xinetd_test()
 
 	for a in $check_addr; do
 		p=$(echo $pattern | sed "s/ADDR/$a/")
-		echo '' | telnet $a 2>&1 | grep -qi "$p"
+		echo '' | telnet $a 2>&1 | grep -qiE "$p"
 		[ $? -ne 0 ] && \
 			tst_brk TFAIL "not expected output for 'telnet $a'"
 	done
@@ -103,7 +103,7 @@ do_test()
 {
 	case $1 in
 	1) xinetd_test $1 "disabled" \
-			"telnet: connect to address ADDR: Connection refused";;
+			"telnet: (connect to address ADDR|Unable to connect to remote host): Connection refused";;
 	2) xinetd_test $1 "enabled" \
 			"Connection closed by foreign host";;
 	esac
-- 
2.25.1

