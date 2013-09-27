Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <padhy.sivasankar@gmail.com>) id 1VPOxo-000473-LX
	for ltp-list@lists.sourceforge.net; Fri, 27 Sep 2013 03:43:32 +0000
Received: from mail-pb0-f50.google.com ([209.85.160.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VPOxn-0001jX-Et
	for ltp-list@lists.sourceforge.net; Fri, 27 Sep 2013 03:43:32 +0000
Received: by mail-pb0-f50.google.com with SMTP id uo5so1997467pbc.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 26 Sep 2013 20:43:25 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 Sep 2013 12:43:25 +0900
Message-ID: <CAK67bL8u742otAZLwk9u8_EBJ6hoW31iEgWx8eWtpxLZB0GoBQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============5906318328906280731=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5906318328906280731==
Content-Type: multipart/alternative; boundary=047d7bea3f64ef385a04e7554933

--047d7bea3f64ef385a04e7554933
Content-Type: text/plain; charset=ISO-8859-1

*Hi All,*

I have faced a problem while running unzip test case on my ARM board.
I am using* ltp-full-20130904 release.*
As i observed the unzip test case is failing due to mismatch in the verbose
message.
test case expects "extracting" but on my board the unzip binary shows
"inflating"
So  this is a patch for* unzip_file.zip.*This checks the created directory
structure rather than verbose message.

This is my first patch. So please regret for any wrong formatting of make
the patch review. :)
*I will eagerly wait for your valuable reply ASAP. Please find the patch
below.*
*
*
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

--047d7bea3f64ef385a04e7554933
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><b>Hi All,</b><br><div class=3D"gmail_quote"><div dir=3D"l=
tr"><div><div><br></div><div>I have faced a problem while running unzip tes=
t case on my ARM board.</div><div>I am using<b> ltp-full-20130904 release.<=
/b></div>
<div>As i observed the unzip test case is failing due to mismatch in the ve=
rbose message.</div><div>test case expects &quot;extracting&quot; but on my=
 board the unzip binary shows &quot;inflating&quot;</div><div>So =A0this is=
 a patch for<b> unzip_file.zip.</b>This checks the created directory struct=
ure rather than verbose message.</div>
<div><br></div><div>This is my first patch. So please regret for any wrong =
formatting of make the patch review. :)<br></div><div><b>I will eagerly wai=
t for your valuable reply ASAP. Please find the patch below.</b><br></div>
<div><b><br></b></div><div>Change-Id: I6add048bfe03bca1f466ab843e010d833ecf=
1a46<br></div><div>Signed-off-by: siva padhy &lt;<a href=3D"mailto:siva.pad=
hy@lge.com" target=3D"_blank">siva.padhy@lge.com</a>&gt;</div>
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
</div><div>
- =A0 =A0extracting: tst_unzip.dir/d.0/d.1/d.2/f.1</div>
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
iv>=A0 =A0 =A0 =A0 return $RC</div><div>=A0}</div></div><div><br></div><div=
><br><span style=3D"color:rgb(102,0,204)">Regards,</span><br style=3D"color=
:rgb(102,0,204)">

<span style=3D"color:rgb(102,0,204)">Siva Sankar Padhy</span><br style=3D"c=
olor:rgb(102,0,204)"></div>
</div>
</div><br></div>

--047d7bea3f64ef385a04e7554933--


--===============5906318328906280731==
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
--===============5906318328906280731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5906318328906280731==--

