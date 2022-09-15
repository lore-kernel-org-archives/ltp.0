Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B53ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 20:51:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00A703CAC1E
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 22:51:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5FB3CA493
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 22:51:36 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 479352011D0
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 22:51:36 +0200 (CEST)
Received: by mail-vs1-xe2b.google.com with SMTP id j7so15212314vsr.13
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=Cf1esHTmkpjXbfVzcOBIWIWeMmu1geS07ZOfQHqtT0c=;
 b=oXFfxi08rhNhr43SeQ8sw/7aGU34u/ZZljYfTUI6nCFrt67bbaLeMN7rqmMZZrQOQB
 jeFYzosIRTJL21yS1Qn5ekuvcGFYnevQlAa3lfosOtVITUdXlsGsT2DAee/ts9hWDKSh
 blR4Yw+jSIjCNtsYCJd/8MGnW05wOJX/BmXfPg7ONqzqjcCRzD1tUcqvUR4HP5oz8465
 Vc/Ob01N/L3D9eK6nxDd9iV/biX7AqGlfvUt9xvpqRGe+4R6cj0CAxYgkIumf9qRILTB
 +pKbUrRaqqH6j9mzmFrUM/lZxlhhHNF+0DqrozEoBoAiYzkZ08GpvDlg8DTwb1r5EAXR
 GtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=Cf1esHTmkpjXbfVzcOBIWIWeMmu1geS07ZOfQHqtT0c=;
 b=uG/Br8rStQBNuu+cas2qgZuOpRxS0iqrsVK5qTivqmDDCrvEwif62Pr5sVAaVAXRfs
 DqN7Px0NxJ8d8MJeoJ7p3hYssKCaPx4M7eJtffLjQ0ynJgfPUF0OdC7rPbBMxbb1Wg8G
 mhHZV58yEvV2+pRimimbbU9FM7s5yY+PI9+6iheoxBQ4pDYCbxxf+8B7iy0uJjq3SPpL
 bCyq/X+cp36C6eXtedZHrdrmw2ADD5fH/zt8intyP4vS+AvX/ketSI8VBs+S+/kVqD+R
 GDxI14wPOUjanXxVTRRD+ae7lGXYS/nhKJ0vfmW/WcUgNYEHYhE/05xXEGPWNT6qrt9g
 KLaw==
X-Gm-Message-State: ACrzQf3gf6ANxMM8mh7omqCqwfuxFWO5cgWANsZ35OHPgYOCeqa1pVTF
 QCG0n/g+WfrAKvoTHAVLvMr8CUyAYeL8CSnDoz5NuQ==
X-Google-Smtp-Source: AMsMyM5iBNaNqe3c2ogqAcB0xSlq+A7LD1MhMEdkp0/UX6JBcQKCu9+HguK0SqSFP25DSsTF5F4ZUBneIqnIH4tkHY4=
X-Received: by 2002:a67:b24a:0:b0:398:c6c7:b0d7 with SMTP id
 s10-20020a67b24a000000b00398c6c7b0d7mr876568vsh.80.1663275094989; Thu, 15 Sep
 2022 13:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220913202839.1807979-1-edliaw@google.com>
 <YyGisrbDIgVa/0QA@yuki>
 <YyHYvCr0PISg6ISY@pevik> <YyHcNcTUNG+gU3rq@pevik>
In-Reply-To: <YyHcNcTUNG+gU3rq@pevik>
Date: Thu, 15 Sep 2022 13:51:08 -0700
Message-ID: <CAG4es9Wi8oGf1OmNUqg41wv51Qmb9gewZrifUQW-wOPL0ZKNhA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1999256036=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1999256036==
Content-Type: multipart/alternative; boundary="00000000000033c32905e8bd696e"

--00000000000033c32905e8bd696e
Content-Type: text/plain; charset="UTF-8"

Hey Petr, Cyril,

I'm second-guessing how to handle the off_t and int comparisons in
mem/mmapstress01 and 10.  Would it have been better to do the following?

diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c
b/testcases/kernel/mem/mmapstress/mmapstress01.c
index f425c223d..934e83006 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress01.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
@@ -143,7 +143,6 @@ int main(int argc, char *argv[])
        pid_t pid;
        uchar_t *buf = NULL;
        unsigned int seed;
-       int pagesize = sysconf(_SC_PAGE_SIZE);
        float alarmtime = 0;
        struct sigaction sa;
        unsigned i;
@@ -154,8 +153,10 @@ int main(int argc, char *argv[])
        time_t t;
 #ifdef LARGE_FILE
        off64_t bytes_left;
+       off64_t pagesize = sysconf(_SC_PAGE_SIZE);
 #else /* LARGE_FILE */
        off_t bytes_left;
+       off_t pagesize = sysconf(_SC_PAGE_SIZE);
 #endif /* LARGE_FILE */
        const char *filename = "mmapstress01.out";

@@ -310,7 +311,7 @@ int main(int argc, char *argv[])
                anyfail();
        }
        for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-               write_cnt = MIN(pagesize, (int)bytes_left);
+               write_cnt = MIN(pagesize, bytes_left);
                if ((c = write(fd, buf, write_cnt)) != write_cnt) {
                        if (c == -1) {
                                perror("write error");
diff --git a/testcases/kernel/mem/mmapstress/mmapstress10.c
b/testcases/kernel/mem/mmapstress/mmapstress10.c
index 53f02c1f6..1756f7081 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress10.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress10.c
@@ -171,7 +171,6 @@ int main(int argc, char *argv[])
        pid_t wr_pid = 0;
        uchar_t *buf = NULL;
        unsigned int seed;
-       int pagesize = sysconf(_SC_PAGE_SIZE);
        float alarmtime = 0;
        struct sigaction sa;
        unsigned i;
@@ -182,8 +181,10 @@ int main(int argc, char *argv[])
        time_t t;
 #ifdef LARGE_FILE
        off64_t bytes_left;
+       off64_t pagesize = sysconf(_SC_PAGE_SIZE);
 #else /* LARGE_FILE */
        off_t bytes_left;
+       off_t pagesize = sysconf(_SC_PAGE_SIZE);
 #endif /* LARGE_FILE */

        progname = *argv;
@@ -360,7 +361,7 @@ int main(int argc, char *argv[])
        }

        for (bytes_left = filesize; bytes_left; bytes_left -= c) {
-               write_cnt = MIN(pagesize, (int)bytes_left);
+               write_cnt = MIN(pagesize, bytes_left);
                if ((c = write(fd, (char *)buf, write_cnt)) != write_cnt) {
                        if (c == -1) {
                                perror("write error");

Thanks,
Edward

--00000000000033c32905e8bd696e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey Petr, Cyril,</div><div dir=3D"ltr"><br></div><div=
 dir=3D"ltr">I&#39;m second-guessing how to handle the off_t and int compar=
isons in mem/mmapstress01 and 10.=C2=A0 Would it have been better to do the=
 following?</div><div dir=3D"ltr"><div><br></div><div>diff --git a/testcase=
s/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mm=
apstress01.c<br>index f425c223d..934e83006 100644<br>--- a/testcases/kernel=
/mem/mmapstress/mmapstress01.c<br>+++ b/testcases/kernel/mem/mmapstress/mma=
pstress01.c<br>@@ -143,7 +143,6 @@ int main(int argc, char *argv[])<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 pid_t pid;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 uchar_t =
*buf =3D NULL;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int seed;<br>- =C2=
=A0 =C2=A0 =C2=A0 int pagesize =3D sysconf(_SC_PAGE_SIZE);<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 float alarmtime =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct=
 sigaction sa;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned i;<br>@@ -154,8 +153=
,10 @@ int main(int argc, char *argv[])<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time=
_t t;<br>=C2=A0#ifdef LARGE_FILE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 off64_t byt=
es_left;<br>+ =C2=A0 =C2=A0 =C2=A0 off64_t pagesize =3D sysconf(_SC_PAGE_SI=
ZE);<br>=C2=A0#else /* LARGE_FILE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 off_t b=
ytes_left;<br>+ =C2=A0 =C2=A0 =C2=A0 off_t pagesize =3D sysconf(_SC_PAGE_SI=
ZE);<br>=C2=A0#endif /* LARGE_FILE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 const =
char *filename =3D &quot;mmapstress01.out&quot;;<br><br>@@ -310,7 +311,7 @@=
 int main(int argc, char *argv[])<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 anyfail();<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 for (bytes_left =3D filesize; bytes_left; bytes_left -=3D=
 c) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cnt =3D M=
IN(pagesize, (int)bytes_left);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 write_cnt =3D MIN(pagesize, bytes_left);<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((c =3D write(fd, buf, write_cnt)) !=
=3D write_cnt) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c =3D=3D -1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 perror(&quot;write error&quot;);<br>diff --git a/testcases/ke=
rnel/mem/mmapstress/mmapstress10.c b/testcases/kernel/mem/mmapstress/mmapst=
ress10.c<br>index 53f02c1f6..1756f7081 100644<br>--- a/testcases/kernel/mem=
/mmapstress/mmapstress10.c<br>+++ b/testcases/kernel/mem/mmapstress/mmapstr=
ess10.c<br>@@ -171,7 +171,6 @@ int main(int argc, char *argv[])<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 pid_t wr_pid =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 uch=
ar_t *buf =3D NULL;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int seed;<br>- =
=C2=A0 =C2=A0 =C2=A0 int pagesize =3D sysconf(_SC_PAGE_SIZE);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 float alarmtime =3D 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str=
uct sigaction sa;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned i;<br>@@ -182,8 +=
181,10 @@ int main(int argc, char *argv[])<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
ime_t t;<br>=C2=A0#ifdef LARGE_FILE<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 off64_t =
bytes_left;<br>+ =C2=A0 =C2=A0 =C2=A0 off64_t pagesize =3D sysconf(_SC_PAGE=
_SIZE);<br>=C2=A0#else /* LARGE_FILE */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 off_=
t bytes_left;<br>+ =C2=A0 =C2=A0 =C2=A0 off_t pagesize =3D sysconf(_SC_PAGE=
_SIZE);<br>=C2=A0#endif /* LARGE_FILE */<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 progname =3D *argv;<br>@@ -360,7 +361,7 @@ int main(int argc, char *argv[]=
)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (=
bytes_left =3D filesize; bytes_left; bytes_left -=3D c) {<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cnt =3D MIN(pagesize, (int)byt=
es_left);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_cnt =
=3D MIN(pagesize, bytes_left);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if ((c =3D write(fd, (char *)buf, write_cnt)) !=3D write_cnt=
) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (c =3D=3D -1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 perror(&quot;write error&quot;);</div><div><br></div><div>Thanks,</div>=
<div>Edward</div></div></div>

--00000000000033c32905e8bd696e--

--===============1999256036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1999256036==--
