Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <padhy.sivasankar@gmail.com>) id 1VO38F-0003KT-NK
	for ltp-list@lists.sourceforge.net; Mon, 23 Sep 2013 10:12:43 +0000
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VO38E-0002SB-4I
	for ltp-list@lists.sourceforge.net; Mon, 23 Sep 2013 10:12:43 +0000
Received: by mail-pd0-f177.google.com with SMTP id y10so3032412pdj.22
	for <ltp-list@lists.sourceforge.net>;
	Mon, 23 Sep 2013 03:12:36 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 23 Sep 2013 19:12:35 +0900
Message-ID: <CAK67bL80qDJnZqSw7J5rG3gV8+NuVHfp7uPsmAqVFVo5n4waEA@mail.gmail.com>
From: siva sankar padhy <padhy.sivasankar@gmail.com>
Subject: [LTP] [PATCH] Unzip command validation irrespective of verbose
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2023513770862008048=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2023513770862008048==
Content-Type: multipart/alternative; boundary=047d7bacc48e5f86bc04e70a420c

--047d7bacc48e5f86bc04e70a420c
Content-Type: text/plain; charset=ISO-8859-1

*Hi All,*

I have faced a problem while running LTP on my ARM board. The below command
is failing.
unzip01 unzip_tests.sh $LTPROOT/testcases/data/tst_unzip_file.zip
As i observed the "unzip" binary on my board uses a string "inflating" to
show the verbose message for compression of files.
The test case is is expecting "unzip" binary to use a string "extracting"
to show the verbose message for compression of files.
In unzip_tests.sh the code has been written to compare the verbose message
to PASS/FAIL the test case.
hence it is PASS in my x86 but FAIL in my ARM board.

*So i have added this patch which will compare the directory tree output
structure not the verbose message.*

Please find the patch below and please revert for any suggestion and
concerns.
This is my first patch. So please regret for any wrong formatting of make
the patch review. :)

*I will eagerly wait for your valuable reply ASAP.*
*
*
*Regards,*
*Siva*

From 32c9bfda270a55a708c92c2a35fe6bd28d4d777b Mon Sep 17 00:00:00 2001
From: siva padhy <siva.padhy@lge.com>
Date: Mon, 23 Sep 2013 14:37:54 +0530
Subject: [PATCH] Unzip command validation irrespective of verbose

This patch is the fix for the unzip command testing.
unzip_tests.sh compares the verbose output of "unzip" command to check the
unzip functionality.
That may fail in some scenario,where the verbose text differs like
"inflatted" and "extracted".
This patch will do the following things:

1.Store the desired directory tree output structure in tst_unzip.out.exp
2.unzip the zip file
3.execute the ls -R command and store the created directory output
structure in tst_unzip.out
4.Find the difference between tst_unzip.out and tst_unzip.out.exp

Change-Id: I6add048bfe03bca1f466ab843e010d833ecf1a46
Signed-off-by: siva padhy <siva.padhy@lge.com>
---
 testcases/commands/unzip/unzip_tests.sh |   74
++++++++++++++++---------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/testcases/commands/unzip/unzip_tests.sh
b/testcases/commands/unzip/unzip_tests.sh
index 9a7a7b5..b245c66 100755
--- a/testcases/commands/unzip/unzip_tests.sh
+++ b/testcases/commands/unzip/unzip_tests.sh
@@ -96,23 +96,29 @@ init()
        chk_ifexists INIT unzip     || return $RC
        chk_ifexists INIT mkdir     || return $RC
        chk_ifexists INIT awk       || return $RC
+       chk_ifexists INIT ls        || return $RC

-       # create expected output files. tst_unzip.exp
+       # create expected directory tree. tst_unzip.out.exp
        cat > $PWD/tst_unzip.out.exp <<-EOF
-       Archive:  $1
-    creating: tst_unzip.dir/
-    creating: tst_unzip.dir/d.0/
-    extracting: tst_unzip.dir/d.0/f.0
-    extracting: tst_unzip.dir/d.0/f.1
-    extracting: tst_unzip.dir/d.0/f.2
-    creating: tst_unzip.dir/d.0/d.1/
-    extracting: tst_unzip.dir/d.0/d.1/f.0
-    extracting: tst_unzip.dir/d.0/d.1/f.1
-    extracting: tst_unzip.dir/d.0/d.1/f.2
-    creating: tst_unzip.dir/d.0/d.1/d.2/
-    extracting: tst_unzip.dir/d.0/d.1/d.2/f.0
-    extracting: tst_unzip.dir/d.0/d.1/d.2/f.1
-    extracting: tst_unzip.dir/d.0/d.1/d.2/f.2
+       $PWD/tst_unzip.dir/:
+       d.0
+
+       $PWD/tst_unzip.dir/d.0:
+       d.1
+       f.0
+       f.1
+       f.2
+
+       $PWD/tst_unzip.dir/d.0/d.1:
+       d.2
+       f.0
+       f.1
+       f.2
+
+       $PWD/tst_unzip.dir/d.0/d.1/d.2:
+       f.0
+       f.1
+       f.2
        EOF

        return $RC
@@ -140,39 +146,37 @@ test01()

        tst_resm TINFO "Test #1: unzip command un-compresses a .zip file."

-       unzip "${zipfile}" > "$PWD/tst_unzip.out" || RC=$?
+       unzip "${zipfile}" || RC=$?
        if [ $RC -ne 0 ]
        then
                tst_res TFAIL "$PWD/tst_unzip.out" \
                        "Test #1: unzip command failed. Return value = $RC.
Details:"
                return $RC
        else
-               sort -o "$PWD/tst_unzip.out" "$PWD/tst_unzip.out"
-               sort -o "$PWD/tst_unzip.out.exp" "$PWD/tst_unzip.out.exp"
-
-               diff -iwB "$PWD/tst_unzip.out" "$PWD/tst_unzip.out.exp" >\
-                         "$PWD/tst_unzip.out.err" || RC=$?
-
-               if [ $RC -ne 0 ]
+               tst_resm TINFO "Test #1: check if \"$PWD/tst_unzip.dir\"
exits."
+               if ! [ -d $PWD/tst_unzip.dir ]
                then
-                       tst_res TFAIL "$PWD/tst_unzip.out.err" \
-                               "Test #1: unzip output differs from
expected output. Details"
+                       tst_resm TFAIL  "Test #1: unzip did not uncompress
the .zip file"
+                       $((RC+1))
                else
-                       tst_resm TINFO "Test #1: check if
\"$PWD/tst_unzip.dir\" exits."
-                       if ! [ -d $PWD/tst_unzip.dir ]
+                       ls -R $PWD/tst_unzip.dir/ > "$PWD/tst_unzip.out" ||
RC=$?
+                       if [ $RC -ne 0 ]
                        then
-                               tst_resm TFAIL \
-                                       "Test #1: unzip did not uncompress
the .zip file"
-                               $((RC+1))
+                               tst_res TFAIL "Test #1: ls command failed"
+                               return $RC
                        else
-                               tst_resm TINFO \
-                                       "Test #1: \"$PWD/tst_unzip.dir\"
was created by unzip"
-                               tst_resm TPASS \
-                                  "Test #1: unzip can uncompress .zip file
correctly."
+                               diff -iwB "$PWD/tst_unzip.out"
"$PWD/tst_unzip.out.exp" > "$PWD/tst_unzip.out.err" || RC=$?
+                               if [ $RC -ne 0 ]
+                               then
+                                       tst_res TFAIL
"$PWD/tst_unzip.out.err" \
+                                               "Test #1: unzip output
differs from expected output. Details"
+                               else
+                                       tst_resm TINFO "Test #1:
\"$PWD/tst_unzip.dir\" was created by unzip"
+                                       tst_resm TPASS "Test #1: unzip can
uncompress .zip file correctly."
+                               fi
                        fi
                fi
        fi
-
        return $RC
 }

Regards,
Siva Sankar Padhy

--047d7bacc48e5f86bc04e70a420c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><b>Hi All,</b></div><div><br></div><div>I have f=
aced a problem while running LTP on my ARM board. The below command is fail=
ing.</div><div><span style=3D"color:rgb(0,176,80);font-family:&#39;Courier =
New&#39;;font-size:10.5pt;line-height:115%">unzip01 unzip_tests.sh
$LTPROOT/testcases/data/tst_unzip_file.zip</span></div><div>As i observed t=
he &quot;unzip&quot; binary on my board uses a string &quot;inflating&quot;=
 to show the verbose message for compression of files.</div><div>The test c=
ase is is expecting &quot;unzip&quot; binary to use a string &quot;extracti=
ng&quot; to show the verbose message for compression of files.</div>
<div>In unzip_tests.sh the code has been written to compare the verbose mes=
sage to PASS/FAIL the test case.</div><div>hence it is PASS in my x86 but F=
AIL in my ARM board.</div><div><br></div><div><b>So i have added this patch=
 which will compare the directory tree output structure not the verbose mes=
sage.</b></div>
<div><br></div><div>Please find the patch below and please revert for any s=
uggestion and concerns.</div><div>This is my first patch. So please regret =
for any wrong formatting of make the patch review. :)</div><div><br></div>
<div><b>I will eagerly wait for your valuable reply ASAP.</b></div><div><b>=
<br></b></div><div><b>Regards,</b></div><div><b>Siva</b></div><div><br></di=
v><div>From 32c9bfda270a55a708c92c2a35fe6bd28d4d777b Mon Sep 17 00:00:00 20=
01</div>
<div>From: siva padhy &lt;<a href=3D"mailto:siva.padhy@lge.com">siva.padhy@=
lge.com</a>&gt;</div><div>Date: Mon, 23 Sep 2013 14:37:54 +0530</div><div>S=
ubject: [PATCH] Unzip command validation irrespective of verbose</div><div>
<br></div><div>This patch is the fix for the unzip command testing.</div><d=
iv>unzip_tests.sh compares the verbose output of &quot;unzip&quot; command =
to check the unzip functionality.</div><div>That may fail in some scenario,=
where the verbose text differs like &quot;inflatted&quot; and &quot;extract=
ed&quot;.</div>
<div>This patch will do the following things:</div><div><br></div><div>1.St=
ore the desired directory tree output structure in tst_unzip.out.exp</div><=
div>2.unzip the zip file</div><div>3.execute the ls -R command and store th=
e created directory output structure in tst_unzip.out</div>
<div>4.Find the difference between tst_unzip.out and tst_unzip.out.exp</div=
><div><br></div><div>Change-Id: I6add048bfe03bca1f466ab843e010d833ecf1a46</=
div><div>Signed-off-by: siva padhy &lt;<a href=3D"mailto:siva.padhy@lge.com=
">siva.padhy@lge.com</a>&gt;</div>
<div>---</div><div>=A0testcases/commands/unzip/unzip_tests.sh | =A0 74 ++++=
++++++++++++---------------</div><div>=A01 file changed, 39 insertions(+), =
35 deletions(-)</div><div><br></div><div>diff --git a/testcases/commands/un=
zip/unzip_tests.sh b/testcases/commands/unzip/unzip_tests.sh</div>
<div>index 9a7a7b5..b245c66 100755</div><div>--- a/testcases/commands/unzip=
/unzip_tests.sh</div><div>+++ b/testcases/commands/unzip/unzip_tests.sh</di=
v><div>@@ -96,23 +96,29 @@ init()</div><div>=A0 =A0 =A0 =A0 chk_ifexists IN=
IT unzip =A0 =A0 || return $RC</div>
<div>=A0 =A0 =A0 =A0 chk_ifexists INIT mkdir =A0 =A0 || return $RC</div><di=
v>=A0 =A0 =A0 =A0 chk_ifexists INIT awk =A0 =A0 =A0 || return $RC</div><div=
>+ =A0 =A0 =A0 chk_ifexists INIT ls =A0 =A0 =A0 =A0|| return $RC</div><div>=
<br></div><div>- =A0 =A0 =A0 # create expected output files. tst_unzip.exp<=
/div>
<div>+ =A0 =A0 =A0 # create expected directory tree. tst_unzip.out.exp</div=
><div>=A0 =A0 =A0 =A0 cat &gt; $PWD/tst_unzip.out.exp &lt;&lt;-EOF</div><di=
v>- =A0 =A0 =A0 Archive: =A0$1</div><div>- =A0 =A0creating: tst_unzip.dir/<=
/div><div>- =A0 =A0creating: tst_unzip.dir/d.0/</div>
<div>- =A0 =A0extracting: tst_unzip.dir/d.0/f.0</div><div>- =A0 =A0extracti=
ng: tst_unzip.dir/d.0/f.1</div><div>- =A0 =A0extracting: tst_unzip.dir/d.0/=
f.2</div><div>- =A0 =A0creating: tst_unzip.dir/d.0/d.1/</div><div>- =A0 =A0=
extracting: tst_unzip.dir/d.0/d.1/f.0</div>
<div>- =A0 =A0extracting: tst_unzip.dir/d.0/d.1/f.1</div><div>- =A0 =A0extr=
acting: tst_unzip.dir/d.0/d.1/f.2</div><div>- =A0 =A0creating: tst_unzip.di=
r/d.0/d.1/d.2/</div><div>- =A0 =A0extracting: tst_unzip.dir/d.0/d.1/d.2/f.0=
</div><div>- =A0 =A0extracting: tst_unzip.dir/d.0/d.1/d.2/f.1</div>
<div>- =A0 =A0extracting: tst_unzip.dir/d.0/d.1/d.2/f.2</div><div>+ =A0 =A0=
 =A0 $PWD/tst_unzip.dir/:</div><div>+ =A0 =A0 =A0 d.0</div><div>+</div><div=
>+ =A0 =A0 =A0 $PWD/tst_unzip.dir/d.0:</div><div>+ =A0 =A0 =A0 d.1</div><di=
v>+ =A0 =A0 =A0 f.0</div><div>
+ =A0 =A0 =A0 f.1</div><div>+ =A0 =A0 =A0 f.2</div><div>+</div><div>+ =A0 =
=A0 =A0 $PWD/tst_unzip.dir/d.0/d.1:</div><div>+ =A0 =A0 =A0 d.2</div><div>+=
 =A0 =A0 =A0 f.0</div><div>+ =A0 =A0 =A0 f.1</div><div>+ =A0 =A0 =A0 f.2</d=
iv><div>+</div><div>+ =A0 =A0 =A0 $PWD/tst_unzip.dir/d.0/d.1/d.2:</div>
<div>+ =A0 =A0 =A0 f.0</div><div>+ =A0 =A0 =A0 f.1</div><div>+ =A0 =A0 =A0 =
f.2</div><div>=A0 =A0 =A0 =A0 EOF</div><div><br></div><div>=A0 =A0 =A0 =A0 =
return $RC</div><div>@@ -140,39 +146,37 @@ test01()</div><div><br></div><di=
v>=A0 =A0 =A0 =A0 tst_resm TINFO &quot;Test #1: unzip command un-compresses=
 a .zip file.&quot;</div>
<div><br></div><div>- =A0 =A0 =A0 unzip &quot;${zipfile}&quot; &gt; &quot;$=
PWD/tst_unzip.out&quot; || RC=3D$?</div><div>+ =A0 =A0 =A0 unzip &quot;${zi=
pfile}&quot; || RC=3D$?</div><div>=A0 =A0 =A0 =A0 if [ $RC -ne 0 ]</div><di=
v>=A0 =A0 =A0 =A0 then</div>
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res TFAIL &quot;$PWD/tst_unzip.out=
&quot; \</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Te=
st #1: unzip command failed. Return value =3D $RC. Details:&quot;</div><div=
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $RC</div><div>
=A0 =A0 =A0 =A0 else</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 sort -o &quot;=
$PWD/tst_unzip.out&quot; &quot;$PWD/tst_unzip.out&quot;</div><div>- =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 sort -o &quot;$PWD/tst_unzip.out.exp&quot; &quot;$PWD/=
tst_unzip.out.exp&quot;</div><div>
-</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff -iwB &quot;$PWD/tst_unzip.ou=
t&quot; &quot;$PWD/tst_unzip.out.exp&quot; &gt;\</div><div>- =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;$PWD/tst_unzip.out.err&quot; || R=
C=3D$?</div><div>-</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $RC -ne 0 ]=
</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TINFO &quot;Test #1: check if \=
&quot;$PWD/tst_unzip.dir\&quot; exits.&quot;</div><div>+ =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 if ! [ -d $PWD/tst_unzip.dir ]</div><div>=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 then</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts=
t_res TFAIL &quot;$PWD/tst_unzip.out.err&quot; \</div>
<div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Te=
st #1: unzip output differs from expected output. Details&quot;</div><div>+=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL =A0&quot;Test #=
1: unzip did not uncompress the .zip file&quot;</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $((RC+1))</div><div>=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 else</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 tst_resm TINFO &quot;Test #1: check if \&quot;$PWD/tst_unzi=
p.dir\&quot; exits.&quot;</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if ! [ -d $PWD/tst_unzip.dir ]</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ls -R $PWD/tst_unzip.dir=
/ &gt; &quot;$PWD/tst_unzip.out&quot; || RC=3D$?</div><div>+ =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $RC -ne 0 ]</div><div>=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 then</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL \</div>
<div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &quot;Test #1: unzip did not uncompress the .zip file&quot;</div><d=
iv>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $((RC+1))<=
/div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst=
_res TFAIL &quot;Test #1: ls command failed&quot;</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $=
RC</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else</div><div=
>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TIN=
FO \</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &quot;Test #1: \&quot;$PWD/tst_unzip.dir\&quot; was cre=
ated by unzip&quot;</div>
<div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm=
 TPASS \</div><div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0&quot;Test #1: unzip can uncompress .zip file correctly.&quo=
t;</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
diff -iwB &quot;$PWD/tst_unzip.out&quot; &quot;$PWD/tst_unzip.out.exp&quot;=
 &gt; &quot;$PWD/tst_unzip.out.err&quot; || RC=3D$?</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $RC=
 -ne 0 ]</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 then</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_res TFAIL &quot;$PWD/tst_unzip.out.err&quot=
; \</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Test #1: unzip output differs from e=
xpected output. Details&quot;</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else</di=
v><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 tst_resm TINFO &quot;Test #1: \&quot;$PWD/tst_unzip.dir\&quot; =
was created by unzip&quot;</div><div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS &quot;Test #1: unzip=
 can uncompress .zip file correctly.&quot;</div>
<div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi</div>=
<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi</div><div>=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 fi</div><div>=A0 =A0 =A0 =A0 fi</div><div>-</div><d=
iv>=A0 =A0 =A0 =A0 return $RC</div><div>=A0}</div></div><div>=A0<br><span s=
tyle=3D"color:rgb(102,0,204)">Regards,</span><br style=3D"color:rgb(102,0,2=
04)">
<span style=3D"color:rgb(102,0,204)">Siva Sankar Padhy</span><br style=3D"c=
olor:rgb(102,0,204)"></div>
</div>

--047d7bacc48e5f86bc04e70a420c--


--===============2023513770862008048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
--===============2023513770862008048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2023513770862008048==--

