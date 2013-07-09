Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <juz4m@hotmail.com>) id 1UwTis-0007qi-VT
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 08:56:35 +0000
Received: from dub0-omc1-s5.dub0.hotmail.com ([157.55.0.204])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwTiq-0002YH-Ou
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 08:56:34 +0000
Message-ID: <DUB116-W436268875AA46AD93621D0F3790@phx.gbl>
From: Benoit M <juz4m@hotmail.com>
Date: Tue, 9 Jul 2013 08:56:26 +0000
MIME-Version: 1.0
Subject: [LTP] [PATCH] flock/flock03.c: When compiling with UCLINUX=1:
 undefined symbol `FILENAME`
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6011340034990973458=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============6011340034990973458==
Content-Type: multipart/alternative;
	boundary="_368936f4-ec42-480d-95da-dd23a75fce78_"

--_368936f4-ec42-480d-95da-dd23a75fce78_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

flock/flock03.c: When compiling with UCLINUX=3D1: undefined symbol `FILENAM=
E`. Did you mean `FILE_NAME`=2C as it is defined at the top of the file?
(The patch also removes some trailing white-spaces in empty lines)
--- testcases/kernel/syscalls/flock/flock03.c | 10 +++++----- 1 file change=
d=2C 5 insertions(+)=2C 5 deletions(-)
diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/s=
yscalls/flock/flock03.cindex bacf4f6..a7a1cd9 100644--- a/testcases/kernel/=
syscalls/flock/flock03.c+++ b/testcases/kernel/syscalls/flock/flock03.c@@ -=
86=2C13 +86=2C13 @@ int main(int argc=2C char **argv)                      =
           "file=2C errno %d"=2C errno)=3B                 pid =3D FORK_OR_=
VFORK()=3B-+                if (pid =3D=3D -1)                        tst_b=
rkm(TFAIL=2C cleanup=2C "fork() failed=2C errno %d"=2C                     =
            errno)=3B                if (pid =3D=3D 0) { #ifdef UCLINUX-   =
                    if (self_exec(argv[0]=2C "ds"=2C fd=2C FILENAME) < 0)+ =
                      if (self_exec(argv[0]=2C "ds"=2C fd=2C FILE_NAME) < 0=
)                                tst_brkm(TFAIL=2C cleanup=2C "self_exec fa=
iled=2C "                                         "errno &d"=2C errno)=3B #=
else@@ -161=2C7 +161=2C7 @@ static void childfunc(int fd)        }         =
TEST(flock(fd2=2C LOCK_EX | LOCK_NB))=3B-+        if (TEST_RETURN =3D=3D -1=
) {                fprintf(stderr=2C "CHILD: Unable to lock file after "   =
                     "unlocking: %s\n"=2C strerror(TEST_ERRNO))=3B@@ -169=
=2C10 +169=2C10 @@ static void childfunc(int fd)        } else {           =
     fprintf(stderr=2C "CHILD: Locking after unlock passed\n")=3B        }-=
+        close(fd)=3B        close(fd2)=3B-+        exit(0)=3B } -- 1.8.3
--Benoit Marcot 		 	   		  =

--_368936f4-ec42-480d-95da-dd23a75fce78_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'><div><span style=3D"font-size: 1=
2pt=3B">flock/flock03.c: When compiling with UCLINUX=3D1: undefined symbol<=
/span></div><div>&nbsp=3B`FILENAME`. Did you mean `FILE_NAME`=2C as it is d=
efined at the top of the</div><div>&nbsp=3Bfile?</div><div><br></div><div>(=
The patch also removes some trailing white-spaces in empty lines)</div><div=
><br></div><div>---</div><div>&nbsp=3Btestcases/kernel/syscalls/flock/flock=
03.c | 10 +++++-----</div><div>&nbsp=3B1 file changed=2C 5 insertions(+)=2C=
 5 deletions(-)</div><div><br></div><div>diff --git a/testcases/kernel/sysc=
alls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c</div><div>=
index bacf4f6..a7a1cd9 100644</div><div>--- a/testcases/kernel/syscalls/flo=
ck/flock03.c</div><div>+++ b/testcases/kernel/syscalls/flock/flock03.c</div=
><div>@@ -86=2C13 +86=2C13 @@ int main(int argc=2C char **argv)</div><div>&=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B"file=2C errno %d"=2C errno)=3B</div><div>&nbsp=3B</div><div>&nbsp=3B &n=
bsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B pid =3D FORK_O=
R_VFORK()=3B</div><div>-</div><div>+</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B if (pid =3D=3D -1)</div><div>&n=
bsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B tst_brkm(TFAIL=2C cleanup=2C "fork() failed=
=2C errno %d"=2C</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3Berrno)=3B</div><div>&nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B if (pid =3D=3D 0) {</div><=
div>&nbsp=3B#ifdef UCLINUX</div><div>- &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B if (self_exe=
c(argv[0]=2C "ds"=2C fd=2C FILENAME) &lt=3B 0)</div><div>+ &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=
 &nbsp=3B if (self_exec(argv[0]=2C "ds"=2C fd=2C FILE_NAME) &lt=3B 0)</div>=
<div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=
 tst_brkm(TFAIL=2C cleanup=2C "self_exec failed=2C "</div><div>&nbsp=3B &nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=
 &nbsp=3B &nbsp=3B &nbsp=3B"errno &amp=3Bd"=2C errno)=3B</div><div>&nbsp=3B=
#else</div><div>@@ -161=2C7 +161=2C7 @@ static void childfunc(int fd)</div>=
<div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B }</div><div>&nbsp=3B</div><div>&nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B TEST(flock(fd2=2C LOCK_EX | LOCK_NB))=3B</=
div><div>-</div><div>+</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B if (TE=
ST_RETURN =3D=3D -1) {</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B fprintf(stderr=2C "CHILD: Unable to lock fil=
e after "</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B "unlocking: %s\n"=2C s=
trerror(TEST_ERRNO))=3B</div><div>@@ -169=2C10 +169=2C10 @@ static void chi=
ldfunc(int fd)</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B } else {</div>=
<div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B fprintf(stderr=2C "CHILD: Locking after unlock passed\n")=3B</div><div>=
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B }</div><div>-</div><div>+</div><div>&nb=
sp=3B &nbsp=3B &nbsp=3B &nbsp=3B close(fd)=3B</div><div>&nbsp=3B &nbsp=3B &=
nbsp=3B &nbsp=3B close(fd2)=3B</div><div>-</div><div>+</div><div>&nbsp=3B &=
nbsp=3B &nbsp=3B &nbsp=3B exit(0)=3B</div><div>&nbsp=3B}</div><div>&nbsp=3B=
</div><div>--&nbsp=3B</div><div>1.8.3</div><div><br></div><div>--</div><div=
>Benoit Marcot</div> 		 	   		  </div></body>
</html>=

--_368936f4-ec42-480d-95da-dd23a75fce78_--


--===============6011340034990973458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
--===============6011340034990973458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6011340034990973458==--

