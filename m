From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2016 18:18:27 +0100
Subject: [LTP] test.sh and ROD redirection
In-Reply-To: <56A64CCE.8040306@oracle.com>
References: <20160121135150.GA18731@rei.lan> <56A1F33A.4000807@oracle.com>
 <20160125111654.GA30655@rei.lan> <20160125134520.GE30655@rei.lan>
 <56A64CCE.8040306@oracle.com>
Message-ID: <20160125171827.GB2763@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +			flag=1
> > +			continue
> May be break here, so we don't need the next if block.

We have to do another loop just to fetch the parameter after the \> if
there is space between \> and path. So the continue should stay.

Full version then would be:

--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -214,7 +214,35 @@ ROD_SILENT()
 
 ROD()
 {
-       $@
+       local cmd
+       local arg
+       local file
+       local flag
+
+       for arg; do
+               file="${arg#\>}"
+               if [ "$file" != "$arg" ]; then
+                       if [ -n "$file" ]; then
+                               break
+                       fi
+                       flag=1
+                       continue
+               fi
+
+               if [ -n "$flag" ]; then
+                       file="$arg"
+                       break
+               fi
+
+               cmd="$cmd $arg"
+       done
+
+       if [ -n "$file" ]; then
+               $cmd > $file
+       else
+               $@
+       fi
+
        if [ $? -ne 0 ]; then
                tst_brkm TBROK "$@ failed"
        fi



This works both with:

ROD echo a \> file
ROD echo a \>file


-- 
Cyril Hrubis
chrubis@suse.cz
