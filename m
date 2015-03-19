Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bamv2005@gmail.com>) id 1YYcDc-0007xM-Qm
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 15:18:44 +0000
Received: from mail-la0-f46.google.com ([209.85.215.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YYcDa-0006og-L3
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 15:18:44 +0000
Received: by lagg8 with SMTP id g8so64875008lag.1
	for <ltp-list@lists.sourceforge.net>;
	Thu, 19 Mar 2015 08:18:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1627971631.32976127.1426764822909.JavaMail.zimbra@redhat.com>
References: <1426742198-17967-1-git-send-email-bamvor.zhangjian@huawei.com>
	<1426742198-17967-2-git-send-email-bamvor.zhangjian@huawei.com>
	<1627971631.32976127.1426764822909.JavaMail.zimbra@redhat.com>
Date: Thu, 19 Mar 2015 23:18:36 +0800
Message-ID: <CAOijeYJLRL5318aXUdAXQZ-MigqUgBSCuh6WeAgm4h4ALi45wg@mail.gmail.com>
From: Bamvor Zhang <bamv2005@gmail.com>
Subject: Re: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct
	kernel_sigaction
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5101808499363714219=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, bintian wang <bintian.wang@huawei.com>, Dingtianhong <dingtianhong@huawei.com>, apinski@cavium.com, yangyingliang@huawei.com

--===============5101808499363714219==
Content-Type: multipart/alternative; boundary=001a1134788ab7e66e0511a5b62a

--001a1134788ab7e66e0511a5b62a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015=E5=B9=B43=E6=9C=8819=E6=97=A5 19:34=E4=BA=8E "Jan Stancek" <jstancek@r=
edhat.com>=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
>
>
> ----- Original Message -----
> > From: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
> > To: ltp-list@lists.sourceforge.net
> > Cc: "bintian wang" <bintian.wang@huawei.com>, yangyingliang@huawei.com,
apinski@cavium.com, dingtianhong@huawei.com
> > Sent: Thursday, 19 March, 2015 6:16:36 AM
> > Subject: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct
kernel_sigaction
> >
> > From: Yang Yingliang <yangyingliang@huawei.com>
> >
> > In ILP32, the sigaction struct is the same as AARCH64.
> > To allow for this to work, we use a long long fields and
> > then add extra casts when converting between the user
> > exposed struct and the kernel exposed struct.
> > The modify is came from a patch of glibc,
> > the commit is 9266f4b060f6("Add kernel_sigaction.h for AARCH64 ILP32").
> >
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  include/lapi/rt_sigaction.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
> > index 46f6a50..2b1365a 100644
> > --- a/include/lapi/rt_sigaction.h
> > +++ b/include/lapi/rt_sigaction.h
> > @@ -34,9 +34,9 @@
> >  #define INVAL_SA_PTR ((void *)-1)
> >
> >  struct kernel_sigaction {
> > -     __sighandler_t k_sa_handler;
> > -     unsigned long sa_flags;
> > -     void (*sa_restorer) (void);
> > +     unsigned long long k_sa_handler;
> > +     unsigned long long sa_flags;
> > +     unsigned long long sa_restorer;
>
> Isn't this going to break i386? (long is 4, long long is 8).
It might be. We just test on the aarch64 platform in different abi(ilp32
and lp64). Sorry for this. I will work on it tomorrow.

regards

bamvor
>
> Regards,
> Jan
>
> >       sigset_t sa_mask;
> >  };
> >
> > @@ -159,7 +159,7 @@ static int ltp_rt_sigaction(int signum, const struc=
t
> > sigaction *act,
> >       if (act =3D=3D INVAL_SA_PTR) {
> >               kact_p =3D INVAL_SA_PTR;
> >       } else if (act) {
> > -             kact.k_sa_handler =3D act->sa_handler;
> > +             kact.k_sa_handler =3D (unsigned long
long)(uintptr_t)act->sa_handler;
> >               memcpy(&kact.sa_mask, &act->sa_mask, sizeof(sigset_t));
> >               kact.sa_flags =3D act->sa_flags;
> >               kact.sa_restorer =3D NULL;
> > @@ -203,12 +203,12 @@ static int ltp_rt_sigaction(int signum, const
struct
> > sigaction *act,
> >
> >       if (ret >=3D 0) {
> >               if (oact && (oact !=3D INVAL_SA_PTR)) {
> > -                     oact->sa_handler =3D koact.k_sa_handler;
> > +                     oact->sa_handler =3D
(void*)(uintptr_t)koact.k_sa_handler;
> >                       memcpy(&oact->sa_mask, &koact.sa_mask,
> >                               sizeof(sigset_t));
> >                       oact->sa_flags =3D koact.sa_flags;
> >  #ifdef HAVE_SA_RESTORER
> > -                     oact->sa_restorer =3D koact.sa_restorer;
> > +                     oact->sa_restorer =3D
(void*)(uintptr_t)koact.sa_restorer;
> >  #endif
> >               }
> >       }
> > --
> > 1.8.4.5
> >
> >
> >
---------------------------------------------------------------------------=
---
> > Dive into the World of Parallel Programming The Go Parallel Website,
> > sponsored
> > by Intel and developed in partnership with Slashdot Media, is your hub
for
> > all
> > things parallel software development, from weekly thought leadership
blogs to
> > news, videos, case studies, tutorials and more. Take a look and join th=
e
> > conversation now. http://goparallel.sourceforge.net/
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
>
>
---------------------------------------------------------------------------=
---
> Dive into the World of Parallel Programming The Go Parallel Website,
sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub
for all
> things parallel software development, from weekly thought leadership
blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

--001a1134788ab7e66e0511a5b62a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
2015=E5=B9=B43=E6=9C=8819=E6=97=A5 19:34=E4=BA=8E &quot;Jan Stancek&quot; &=
lt;<a href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt;=E5=86=
=99=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----- Original Message -----<br>
&gt; &gt; From: &quot;Zhang Jian(Bamvor)&quot; &lt;<a href=3D"mailto:bamvor=
.zhangjian@huawei.com">bamvor.zhangjian@huawei.com</a>&gt;<br>
&gt; &gt; To: <a href=3D"mailto:ltp-list@lists.sourceforge.net">ltp-list@li=
sts.sourceforge.net</a><br>
&gt; &gt; Cc: &quot;bintian wang&quot; &lt;<a href=3D"mailto:bintian.wang@h=
uawei.com">bintian.wang@huawei.com</a>&gt;, <a href=3D"mailto:yangyingliang=
@huawei.com">yangyingliang@huawei.com</a>, <a href=3D"mailto:apinski@cavium=
.com">apinski@cavium.com</a>, <a href=3D"mailto:dingtianhong@huawei.com">di=
ngtianhong@huawei.com</a><br>
&gt; &gt; Sent: Thursday, 19 March, 2015 6:16:36 AM<br>
&gt; &gt; Subject: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct kernel=
_sigaction<br>
&gt; &gt;<br>
&gt; &gt; From: Yang Yingliang &lt;<a href=3D"mailto:yangyingliang@huawei.c=
om">yangyingliang@huawei.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; In ILP32, the sigaction struct is the same as AARCH64.<br>
&gt; &gt; To allow for this to work, we use a long long fields and<br>
&gt; &gt; then add extra casts when converting between the user<br>
&gt; &gt; exposed struct and the kernel exposed struct.<br>
&gt; &gt; The modify is came from a patch of glibc,<br>
&gt; &gt; the commit is 9266f4b060f6(&quot;Add kernel_sigaction.h for AARCH=
64 ILP32&quot;).<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Yang Yingliang &lt;<a href=3D"mailto:yangyingliang=
@huawei.com">yangyingliang@huawei.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 include/lapi/rt_sigaction.h | 12 ++++++------<br>
&gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigact=
ion.h<br>
&gt; &gt; index 46f6a50..2b1365a 100644<br>
&gt; &gt; --- a/include/lapi/rt_sigaction.h<br>
&gt; &gt; +++ b/include/lapi/rt_sigaction.h<br>
&gt; &gt; @@ -34,9 +34,9 @@<br>
&gt; &gt;=C2=A0 #define INVAL_SA_PTR ((void *)-1)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 struct kernel_sigaction {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0__sighandler_t k_sa_handler;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0unsigned long sa_flags;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0void (*sa_restorer) (void);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned long long k_sa_handler;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned long long sa_flags;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0unsigned long long sa_restorer;<br>
&gt;<br>
&gt; Isn&#39;t this going to break i386? (long is 4, long long is 8).<br>
It might be. We just test on the aarch64 platform in different abi(ilp32 an=
d lp64). Sorry for this. I will work on it tomorrow.</p>
<p dir=3D"ltr">regards</p>
<p dir=3D"ltr">bamvor<br>
&gt;<br>
&gt; Regards,<br>
&gt; Jan<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sigset_t sa_mask;<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt; @@ -159,7 +159,7 @@ static int ltp_rt_sigaction(int signum, const=
 struct<br>
&gt; &gt; sigaction *act,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (act =3D=3D INVAL_SA_PTR) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kact_p =3D =
INVAL_SA_PTR;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (act) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kact.k_sa_handle=
r =3D act-&gt;sa_handler;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kact.k_sa_handle=
r =3D (unsigned long long)(uintptr_t)act-&gt;sa_handler;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(&amp=
;kact.sa_mask, &amp;act-&gt;sa_mask, sizeof(sigset_t));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kact.sa_fla=
gs =3D act-&gt;sa_flags;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kact.sa_res=
torer =3D NULL;<br>
&gt; &gt; @@ -203,12 +203,12 @@ static int ltp_rt_sigaction(int signum, con=
st struct<br>
&gt; &gt; sigaction *act,<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &gt;=3D 0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (oact &a=
mp;&amp; (oact !=3D INVAL_SA_PTR)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0oact-&gt;sa_handler =3D koact.k_sa_handler;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0oact-&gt;sa_handler =3D (void*)(uintptr_t)koact.k_sa_handler;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0memcpy(&amp;oact-&gt;sa_mask, &amp;koact.sa_mask,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(sigset_t));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0oact-&gt;sa_flags =3D koact.sa_flags;<br>
&gt; &gt;=C2=A0 #ifdef HAVE_SA_RESTORER<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0oact-&gt;sa_restorer =3D koact.sa_restorer;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0oact-&gt;sa_restorer =3D (void*)(uintptr_t)koact.sa_restorer;<=
br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; --<br>
&gt; &gt; 1.8.4.5<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; -----------------------------------------------------------------=
-------------<br>
&gt; &gt; Dive into the World of Parallel Programming The Go Parallel Websi=
te,<br>
&gt; &gt; sponsored<br>
&gt; &gt; by Intel and developed in partnership with Slashdot Media, is you=
r hub for<br>
&gt; &gt; all<br>
&gt; &gt; things parallel software development, from weekly thought leaders=
hip blogs to<br>
&gt; &gt; news, videos, case studies, tutorials and more. Take a look and j=
oin the<br>
&gt; &gt; conversation now. <a href=3D"http://goparallel.sourceforge.net/">=
http://goparallel.sourceforge.net/</a><br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Ltp-list mailing list<br>
&gt; &gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.=
sourceforge.net</a><br>
&gt; &gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list"=
>https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
&gt; &gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Dive into the World of Parallel Programming The Go Parallel Website, s=
ponsored<br>
&gt; by Intel and developed in partnership with Slashdot Media, is your hub=
 for all<br>
&gt; things parallel software development, from weekly thought leadership b=
logs to<br>
&gt; news, videos, case studies, tutorials and more. Take a look and join t=
he<br>
&gt; conversation now. <a href=3D"http://goparallel.sourceforge.net/">http:=
//goparallel.sourceforge.net/</a><br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list">http=
s://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</p>

--001a1134788ab7e66e0511a5b62a--


--===============5101808499363714219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
--===============5101808499363714219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5101808499363714219==--

