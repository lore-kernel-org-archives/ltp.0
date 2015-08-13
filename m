Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1ZPiSD-0003Pw-O9
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 02:41:17 +0000
Received: from mail-oi0-f48.google.com ([209.85.218.48])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZPiSB-0007mt-LO
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2015 02:41:17 +0000
Received: by oio137 with SMTP id 137so19758160oio.0
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Aug 2015 19:41:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439432306-2918-1-git-send-email-liwang@redhat.com>
References: <1439432306-2918-1-git-send-email-liwang@redhat.com>
Date: Thu, 13 Aug 2015 10:41:09 +0800
Message-ID: <CAEemH2dFKTJecMomJBomQ61OsbA8jSybivXeHcDFmJDKpn7jSA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Subject: Re: [LTP] [PATCH] mem/thp: skip thp02/thp03 if system not support
	hugepage
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8498003089580045467=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8498003089580045467==
Content-Type: multipart/alternative; boundary=001a113b11688eee6f051d28440d

--001a113b11688eee6f051d28440d
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Aug 13, 2015 at 10:18 AM, Li Wang <liwang@redhat.com> wrote:

> Sometimes we get fails on system which not support hugepage:
>
> thp02       1  TBROK  :  mem.c:1035: cannot find "Hugepagesize:" in
> /proc/meminfo
> thp02       2  TBROK  :  mem.c:1035: Remaining cases broken
>
> thp03       1  TBROK  :  mem.c:1035: cannot find "Hugepagesize:" in
> /proc/meminfo
> thp03       2  TBROK  :  mem.c:1035: Remaining cases broken
>
> Maybe skip the cases are better than TBROK them.
>


After thinking over this patch, I feel the subject is not good to explain,
to be precisely,

"mem/thp: skip the case thp02/thp03 if THP is disable" is better than
previous.

Since this regression case should rely on the THP enable but hupepage.



>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/thp/thp02.c | 3 +++
>  testcases/kernel/mem/thp/thp03.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/testcases/kernel/mem/thp/thp02.c
> b/testcases/kernel/mem/thp/thp02.c
> index 1470ae6..41d9192 100644
> --- a/testcases/kernel/mem/thp/thp02.c
> +++ b/testcases/kernel/mem/thp/thp02.c
> @@ -121,6 +121,9 @@ static void do_mremap(void)
>
>  void setup(void)
>  {
> +       if (access(PATH_THP, F_OK) == -1)
> +               tst_brkm(TCONF, NULL, "THP is not enabled");
> +
>         tst_sig(FORK, DEF_HANDLER, cleanup);
>         TEST_PAUSE;
>
> diff --git a/testcases/kernel/mem/thp/thp03.c
> b/testcases/kernel/mem/thp/thp03.c
> index 8f62d0c..42f9025 100644
> --- a/testcases/kernel/mem/thp/thp03.c
> +++ b/testcases/kernel/mem/thp/thp03.c
> @@ -113,6 +113,9 @@ static void thp_test(void)
>
>  void setup(void)
>  {
> +       if (access(PATH_THP, F_OK) == -1)
> +               tst_brkm(TCONF, NULL, "THP is not enabled");
> +
>         hugepage_size = read_meminfo("Hugepagesize:") * KB;
>         unaligned_size = hugepage_size * 4 - 1;
>         page_size = SAFE_SYSCONF(NULL, _SC_PAGESIZE);
> --
> 1.8.3.1
>
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com

--001a113b11688eee6f051d28440d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Aug 13, 2015 at 10:18 AM, Li Wang <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Sometimes we get fails on=
 system which not support hugepage:<br>
<br>
thp02=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 TBROK=C2=A0 :=C2=A0 mem.c:1035: can=
not find &quot;Hugepagesize:&quot; in /proc/meminfo<br>
thp02=C2=A0 =C2=A0 =C2=A0 =C2=A02=C2=A0 TBROK=C2=A0 :=C2=A0 mem.c:1035: Rem=
aining cases broken<br>
<br>
thp03=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 TBROK=C2=A0 :=C2=A0 mem.c:1035: can=
not find &quot;Hugepagesize:&quot; in /proc/meminfo<br>
thp03=C2=A0 =C2=A0 =C2=A0 =C2=A02=C2=A0 TBROK=C2=A0 :=C2=A0 mem.c:1035: Rem=
aining cases broken<br>
<br>
Maybe skip the cases are better than TBROK them.<br></blockquote><div><br><=
/div><div><br>After thinking over this patch, I feel the subject is not goo=
d to explain, to be precisely, <br><br>&quot;mem/thp: skip the case thp02/t=
hp03 if THP is disable&quot; is better than previous. <br><br>Since this re=
gression case should rely on the THP enable but hupepage.<br><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redh=
at.com</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/mem/thp/thp02.c | 3 +++<br>
=C2=A0testcases/kernel/mem/thp/thp03.c | 3 +++<br>
=C2=A02 files changed, 6 insertions(+)<br>
<br>
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/th=
p02.c<br>
index 1470ae6..41d9192 100644<br>
--- a/testcases/kernel/mem/thp/thp02.c<br>
+++ b/testcases/kernel/mem/thp/thp02.c<br>
@@ -121,6 +121,9 @@ static void do_mremap(void)<br>
<br>
=C2=A0void setup(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(PATH_THP, F_OK) =3D=3D -1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brkm(TCONF, NUL=
L, &quot;THP is not enabled&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_sig(FORK, DEF_HANDLER, cleanup);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_PAUSE;<br>
<br>
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/th=
p03.c<br>
index 8f62d0c..42f9025 100644<br>
--- a/testcases/kernel/mem/thp/thp03.c<br>
+++ b/testcases/kernel/mem/thp/thp03.c<br>
@@ -113,6 +113,9 @@ static void thp_test(void)<br>
<br>
=C2=A0void setup(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(PATH_THP, F_OK) =3D=3D -1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brkm(TCONF, NUL=
L, &quot;THP is not enabled&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hugepage_size =3D read_meminfo(&quot;Hugepagesi=
ze:&quot;) * KB;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unaligned_size =3D hugepage_size * 4 - 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 page_size =3D SAFE_SYSCONF(NULL, _SC_PAGESIZE);=
<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.3.1<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" rel=3D"no=
referrer" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/lt=
p-list</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div>Regards,<br></div>Li Wang<br></div><div>Email: <a href=3D"mai=
lto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a><br></div></d=
iv></div></div></div></div>
</div></div>

--001a113b11688eee6f051d28440d--


--===============8498003089580045467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8498003089580045467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8498003089580045467==--

