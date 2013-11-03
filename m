Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nexus226@gmail.com>) id 1VcsKv-0007U5-Jm
	for ltp-list@lists.sourceforge.net; Sun, 03 Nov 2013 07:43:05 +0000
Received: from mail-we0-f174.google.com ([74.125.82.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VcsKu-0007y1-KW
	for ltp-list@lists.sourceforge.net; Sun, 03 Nov 2013 07:43:05 +0000
Received: by mail-we0-f174.google.com with SMTP id u56so968334wes.19
	for <ltp-list@lists.sourceforge.net>;
	Sun, 03 Nov 2013 00:42:58 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 3 Nov 2013 16:42:58 +0900
Message-ID: <CAEcr6y0DwkrBXqCqcpm2S1QAN=J1jJXnpcmPjXtAehEi5k8c2A@mail.gmail.com>
From: Honggyu Kim <nexus226@gmail.com>
Subject: [LTP] [PATCH] acct01: fix TBROK to TCONF if acct not implemented
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5869908032731899098=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5869908032731899098==
Content-Type: multipart/alternative; boundary=001a1134ccb2c0288804ea40f2b7

--001a1134ccb2c0288804ea40f2b7
Content-Type: text/plain; charset=ISO-8859-1

acct system call is avaliable only when the kernel option is on.
When it fails, acct returns -1 and sets errno correspondingly.
ENOSYS is set when the system call is not implemented.
Currently, ENOSYS is not checked when the TEST_FILES argument is passed.
It just goes to TBROK regardless of the implementation.
This patch modifies to check errno ENOSYS, and marks as TCONF in that case.

Signed-off-by: Honggyu Kim <nexus226@gmail.com>
---
 testcases/kernel/syscalls/acct/acct01.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c
b/testcases/kernel/syscalls/acct/acct01.c
index c38d4db..0fe973b 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -103,8 +103,15 @@ static void setup(void)
  fd = SAFE_CREAT(cleanup, TEST_FILE5, 0777);
  SAFE_CLOSE(cleanup, fd);

- if (acct(TEST_FILE5) == -1)
- tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
+ if (acct(TEST_FILE5) == -1) {
+ if (errno == ENOSYS) {
+ tst_brkm(TCONF, cleanup,
+ "BSD process accounting is not configured in "
+ "this kernel");
+ } else {
+ tst_brkm(TBROK | TERRNO, cleanup, "acct failed unexpectedly");
+ }
+ }

  /* turn off acct, so we are in a known state */
  if (acct(NULL) == -1) {
-- 
1.7.9.5

--001a1134ccb2c0288804ea40f2b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>acct system call is avaliable only when the kernel op=
tion is on.<br></div><div>When it fails, acct returns -1 and sets errno cor=
respondingly.</div><div>ENOSYS is set when the system call is not implement=
ed.</div>
<div>Currently, ENOSYS is not checked when the TEST_FILES argument is passe=
d.</div><div>It just goes to TBROK regardless of the implementation.</div><=
div>This patch modifies to check errno ENOSYS, and marks as TCONF in that c=
ase.</div>
<div><br></div><div>Signed-off-by: Honggyu Kim &lt;<a href=3D"mailto:nexus2=
26@gmail.com">nexus226@gmail.com</a>&gt;</div><div>---</div><div>=A0testcas=
es/kernel/syscalls/acct/acct01.c | =A0 11 +++++++++--</div><div>=A01 file c=
hanged, 9 insertions(+), 2 deletions(-)</div>
<div><br></div><div>diff --git a/testcases/kernel/syscalls/acct/acct01.c b/=
testcases/kernel/syscalls/acct/acct01.c</div><div>index c38d4db..0fe973b 10=
0644</div><div>--- a/testcases/kernel/syscalls/acct/acct01.c</div><div>
+++ b/testcases/kernel/syscalls/acct/acct01.c</div><div>@@ -103,8 +103,15 @=
@ static void setup(void)</div><div>=A0<span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>fd =3D SAFE_CREAT(cleanup, TEST_FILE5, 0777);<=
/div>
<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>SA=
FE_CLOSE(cleanup, fd);</div><div>=A0</div><div>-<span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>if (acct(TEST_FILE5) =3D=3D -1)</div>=
<div>-<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>tst=
_brkm(TBROK | TERRNO, cleanup, &quot;acct failed unexpectedly&quot;);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if (=
acct(TEST_FILE5) =3D=3D -1) {</div><div>+<span class=3D"Apple-tab-span" sty=
le=3D"white-space:pre">		</span>if (errno =3D=3D ENOSYS) {</div><div>+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">			</span>tst_brkm(TCON=
F, cleanup,</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">				</span> =
&quot;BSD process accounting is not configured in &quot;</div><div>+<span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">				</span> &quot;this ke=
rnel&quot;);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>} e=
lse {</div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
		</span>tst_brkm(TBROK | TERRNO, cleanup, &quot;acct failed unexpectedly&q=
uot;);</div>
<div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>}</=
div><div>+<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>=
}</div><div>=A0</div><div>=A0<span class=3D"Apple-tab-span" style=3D"white-=
space:pre">	</span>/* turn off acct, so we are in a known state */</div>
<div>=A0<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if=
 (acct(NULL) =3D=3D -1) {</div><div>--=A0</div><div>1.7.9.5</div><div><br><=
/div></div>

--001a1134ccb2c0288804ea40f2b7--


--===============5869908032731899098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
--===============5869908032731899098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5869908032731899098==--

