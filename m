From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 12 Apr 2017 00:25:00 +0300
Subject: [LTP] [PATCH v2 2/2] dns-stress: check answer from dns server
In-Reply-To: <1491945900-13627-1-git-send-email-alexey.kodanev@oracle.com>
References: <1491945900-13627-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1491945900-13627-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add basic checks for query status and whether 'dig' received
an answer from dns server. In case of any errors, print
what was actually received.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: no changes

 testcases/network/stress/dns/dns-stress-lib.sh |   41 ++++++++++++++++++++++++
 testcases/network/stress/dns/dns-stress01-rmt  |   18 ++++++----
 testcases/network/stress/dns/dns-stress02-rmt  |   20 +++++++----
 3 files changed, 65 insertions(+), 14 deletions(-)
 create mode 100644 testcases/network/stress/dns/dns-stress-lib.sh

diff --git a/testcases/network/stress/dns/dns-stress-lib.sh b/testcases/network/stress/dns/dns-stress-lib.sh
new file mode 100644
index 0000000..d85f6e3
--- /dev/null
+++ b/testcases/network/stress/dns/dns-stress-lib.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+. test.sh
+
+TST_CLEANUP=tst_rmdir
+
+dns_check_answer()
+{
+	local fname="$1"
+
+	if ! grep -q 'status: NOERROR' $fname; then
+		cat $fname
+		tst_brkm TFAIL "unexpected query status"
+	fi
+	if ! grep -q 'QUERY: 1, ANSWER: 1' $fname; then
+		cat $fname
+		tst_brkm TFAIL "unexpected number of query/answer"
+	fi
+}
+
+dns_check_send_requests()
+{
+	[ $num -eq $connect_quantity ] && return
+	tst_brkm TFAIL "some requests failed: $num/$connect_quantity"
+}
+
+tst_tmpdir
diff --git a/testcases/network/stress/dns/dns-stress01-rmt b/testcases/network/stress/dns/dns-stress01-rmt
index fcdb595..71b7d8d 100644
--- a/testcases/network/stress/dns/dns-stress01-rmt
+++ b/testcases/network/stress/dns/dns-stress01-rmt
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -22,7 +21,7 @@
 TCID=dns-stress01-rmt
 TST_TOTAL=1
 
-. test.sh
+. dns-stress-lib.sh
 
 # Check the arguments
 if [ $# -ne 7 ]; then
@@ -49,21 +48,26 @@ case $ip_ver in
 esac
 
 # Check the connectivity first
-dig @$srv_ipaddr -p $port node${min_id}.${domain} $record > /dev/null || \
+dig @$srv_ipaddr -p $port node${min_id}.${domain} $record > ans.log 2>&1 || \
 	tst_brkm TBROK "Failed to connect $srv_ipaddr"
+dns_check_answer ans.log
 
 # Loop for a large number of name lookup queries
 num=0
 id=$min_id
 while [ $num -lt $connect_quantity ]; do
-	dig @$srv_ipaddr -p $port node${id}.${domain} $record > /dev/null
+	dig @$srv_ipaddr -p $port node${id}.${domain} $record \
+		> /dev/null || break
 	id=$(($id + 1))
 	[ $id -gt $max_id ] && id=$min_id
 	num=$(($num + 1))
 done
 
 # Check the connectivity again
-dig @$srv_ipaddr -p $port node${min_id}.${domain} $record > /dev/null || \
-	tst_brkm TBROK "Failed to connect $srv_ipaddr. dns server seems down."
+dig @$srv_ipaddr -p $port node${id}.${domain} $record > ans.log 2>&1 || \
+	tst_brkm TBROK "Failed to connect $srv_ipaddr"
+dns_check_answer ans.log
+
+dns_check_send_requests
 
 tst_exit
diff --git a/testcases/network/stress/dns/dns-stress02-rmt b/testcases/network/stress/dns/dns-stress02-rmt
index 829f257..58fd60f 100644
--- a/testcases/network/stress/dns/dns-stress02-rmt
+++ b/testcases/network/stress/dns/dns-stress02-rmt
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2006
 #
 # This program is free software; you can redistribute it and/or
@@ -22,7 +21,7 @@
 TCID=dns-stress02-rmt
 TST_TOTAL=1
 
-. test.sh
+. dns-stress-lib.sh
 
 if [ $# -ne 7 ]; then
 	tst_brkm TBROK "Usage: $0 ip_ver srv_ipaddr port net \
@@ -52,21 +51,28 @@ case $ip_ver in
 esac
 
 # Check the connectivity first
-dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${min_id} $record > /dev/null || \
+dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${min_id} $record \
+	> ans.log 2>&1 || \
 	tst_brkm TBROK "Failed to connect $srv_ipaddr"
+dns_check_answer ans.log
 
 # Loop for a large number of reverse name lookup queries
 num=0
 id=$min_id
 while [ $num -lt $connect_quantity ]; do
-	dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${id} $record > /dev/null
+	dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${id} $record \
+		> /dev/null || break
 	id=$(($id + 1))
 	[ $id -gt $max_id ] && id=$min_id
 	num=$(($num + 1))
 done
 
 # Check the connectivity again
-dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${min_id} $record > /dev/null || \
-	tst_brkm TBROK "Failed to connect $srv_ipaddr. dns server seems down."
+dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${min_id} $record \
+	> ans.log 2>&1 || \
+	tst_brkm TBROK "Failed to connect $srv_ipaddr"
+dns_check_answer ans.log
+
+dns_check_send_requests
 
 tst_exit
-- 
1.7.1

