From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2016 14:45:21 +0100
Subject: [LTP] test.sh and ROD redirection
In-Reply-To: <20160125111654.GA30655@rei.lan>
References: <20160121135150.GA18731@rei.lan> <56A1F33A.4000807@oracle.com>
 <20160125111654.GA30655@rei.lan>
Message-ID: <20160125134520.GE30655@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Another option would be inventing our special syntax for redirecting for
> ROD. Use for example % and threat it like > i.e. split $@ on % and
> redirect the output to whatever is found after % which shouldn't be
> much more complicated than separating last parameter from $@...

What about this one:

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 074be74..ef2af14 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -214,7 +214,29 @@ ROD_SILENT()
 
 ROD()
 {
-	$@
+	local cmd
+	local arg
+	local file
+	local flag
+
+	for arg; do
+		if [ "$arg" == ">" ]; then
+			flag=1
+			continue
+		fi
+
+		if [ -n "$flag" ]; then
+			break
+		fi
+		cmd="$cmd $arg"
+	done
+
+	if [ -n "$flag" ]; then
+		$cmd > $arg
+	else
+		$@
+	fi
+
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "$@ failed"
 	fi


It's called as: 'ROD echo a \> b', the reason for choosing \> is that
the error message will contain '>' instead of some strange char as %.

I.e. doing 'ROD echo a \> /proc/cpuinfo' yields:

test.sh: line 235: /proc/cpuinfo: Permission denied
foo 1 TBROK : echo b > /proc/cpuinfo failed

-- 
Cyril Hrubis
chrubis@suse.cz
