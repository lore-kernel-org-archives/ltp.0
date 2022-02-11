Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BADCC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:10:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8158F3C9F0C
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 08:10:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0068A3C9C7F
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:10:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E68E7601DAC
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644563409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1bm+NluOQqskIE1Vy/7/fn5Q8i6+igdjaF0iI1fTE0c=;
 b=JfdNFHoPyvr7jpbTK1T82HDt36wLBE8a9ur6QlX/qbfxxc/ObBn1wVTUfQGbsINPQfd0MT
 g9VyNaej3EfDsBI6IotONA99Rs+1Jd1ghcy9DXAsEDy1jtZB9PWqJd50Tl9xGU3C9ouQA9
 oL4DNSsfZM2d1tpl7xe45MljdubJf0s=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-xxTs7JCFOVCfNzv-uq0WcA-1; Fri, 11 Feb 2022 02:10:07 -0500
X-MC-Unique: xxTs7JCFOVCfNzv-uq0WcA-1
Received: by mail-yb1-f199.google.com with SMTP id
 f32-20020a25b0a0000000b0061dad37dcd6so16957234ybj.16
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 23:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1bm+NluOQqskIE1Vy/7/fn5Q8i6+igdjaF0iI1fTE0c=;
 b=5PSYO5bAQjfoh4PPAHBzZTNPBuG3aPax8V/mA7QaZK+R0WKAchTM7WmPw5aCkLYC8U
 RgH4OGtCQf4VKqNtjgwl8u1wtdOhOGrYEVxDUElUbYEl0jeLYkOZRDkwqs9OwrVLzt4F
 IiaqtzlzIEd5C7yT569mFwby1/dB/9T48QP25Nb/+hiX7VKENvSCBIdpTsn3OXS9Hkxo
 srJScKXB13GqIdIYErGV/K5YsqJr7BEyn79/niiR1hOW7XhOrul9qQL4KZFGYXqHfbWm
 beuJvB8WoKfbuLIJ5cjRsuCivl5zcT4jYewtWCU+1rvldfVUR3CKZeBEJ7hRjCKYoO+v
 AilA==
X-Gm-Message-State: AOAM530FLawu+fp0tSSLnD76QhOdRO6vRvTqYCgb+sn7EYVT4i0vZbbc
 3b4p+afrTIzkhRGDniHJyWHI42dF3xs/W3RQ/zM4cF8Jx5Bj0hyKrTn6m9O+3uYKg/7MgyWn9hX
 zSqtnHWeRiaeosiilOu8Aq2snO7o=
X-Received: by 2002:a81:ed01:: with SMTP id k1mr385185ywm.25.1644563406985;
 Thu, 10 Feb 2022 23:10:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHMhifC+gPrwTQE76/2YIcS5FNsHgwhYcg6lrgRLQMX1rp40z3xI+IVjmu9UgGqC2m2MxmGBN4LoHFNRiaUZ4=
X-Received: by 2002:a81:ed01:: with SMTP id k1mr385161ywm.25.1644563406754;
 Thu, 10 Feb 2022 23:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
 <CAASaF6yu935ZQYvEb6MW-pf+jO8EnfbQ-QCQacqKqFUuYROAYQ@mail.gmail.com>
In-Reply-To: <CAASaF6yu935ZQYvEb6MW-pf+jO8EnfbQ-QCQacqKqFUuYROAYQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Feb 2022 15:09:54 +0800
Message-ID: <CAEemH2cnV=L2vOP4nvtNa0E3z-UZ6r88r438b2C0hkcg+4FwBg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1969269385=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1969269385==
Content-Type: multipart/alternative; boundary="000000000000abae5705d7b8c158"

--000000000000abae5705d7b8c158
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 3:03 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Fri, Feb 11, 2022 at 7:48 AM Li Wang <liwang@redhat.com> wrote:
> >
> >
> >
> > On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha <mdoucha@suse.cz> wrote:
> >>
> >> When the main test process crashes or gets killed e.g. by OOM killer,
> >> the watchdog process currently does not clean up any remaining child
> >> processes. Fix this by sending SIGKILL to the test process group when
> >> the watchdog process gets notified that the main test process has exited
> >> for any reason.
> >
> >
> >>
> >> --- a/lib/tst_test.c
> >> +++ b/lib/tst_test.c
> >> @@ -1399,6 +1399,13 @@ static void sigint_handler(int sig
> LTP_ATTRIBUTE_UNUSED)
> >>         }
> >>  }
> >>
> >> +static void sigchild_handler(int sig LTP_ATTRIBUTE_UNUSED)
> >> +{
> >> +       /* If the test process is dead, send SIGKILL to its children */
> >> +       if (kill(test_pid, 0))
> >> +               kill(-test_pid, SIGKILL);
> >> +}
> >> +
> >>  unsigned int tst_timeout_remaining(void)
> >>  {
> >>         static struct timespec now;
> >> @@ -1481,6 +1488,7 @@ static int fork_testrun(void)
> >>                 tst_disable_oom_protection(0);
> >>                 SAFE_SIGNAL(SIGALRM, SIG_DFL);
> >>                 SAFE_SIGNAL(SIGUSR1, SIG_DFL);
> >> +               SAFE_SIGNAL(SIGCHLD, SIG_DFL);
> >>                 SAFE_SIGNAL(SIGINT, SIG_DFL);
> >>                 SAFE_SETPGID(0, 0);
> >>                 testrun();
> >> @@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[],
> struct tst_test *self)
> >>
> >>         SAFE_SIGNAL(SIGALRM, alarm_handler);
> >>         SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> >> +       SAFE_SIGNAL(SIGCHLD, sigchild_handler);
> >
> >
> > Do we really need setup this signal handler for SIGCHILD?
>
>  I had same question.
>
> >
> > Since we have already called 'SAFE_WAITPID(test_pid, &status, 0)'
> > in the library process (lib_pid) which rely on SIGCHILD as well.
> > And even this handler will be called everytime when test exit normally.
> >
> > Maybe better just add a kill function to cleanup the remain
> > descendants if main test process exit with abonormal status.
> >
> > e.g.
> >
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1503,6 +1503,8 @@ static int fork_testrun(void)
> >         if (WIFEXITED(status) && WEXITSTATUS(status))
> >                 return WEXITSTATUS(status);
> >
> > +       kill(-test_pid, SIGKILL);
>
> Could we skip the call if forks_child == 0 ?
>

+1 Obviously yes!


-- 
Regards,
Li Wang

--000000000000abae5705d7b8c158
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 3:03 PM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Feb 11, 2022=
 at 7:48 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_bla=
nk">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha &lt;<a href=3D"mailto:m=
doucha@suse.cz" target=3D"_blank">mdoucha@suse.cz</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; When the main test process crashes or gets killed e.g. by OOM kill=
er,<br>
&gt;&gt; the watchdog process currently does not clean up any remaining chi=
ld<br>
&gt;&gt; processes. Fix this by sending SIGKILL to the test process group w=
hen<br>
&gt;&gt; the watchdog process gets notified that the main test process has =
exited<br>
&gt;&gt; for any reason.<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; --- a/lib/tst_test.c<br>
&gt;&gt; +++ b/lib/tst_test.c<br>
&gt;&gt; @@ -1399,6 +1399,13 @@ static void sigint_handler(int sig LTP_ATTR=
IBUTE_UNUSED)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +static void sigchild_handler(int sig LTP_ATTRIBUTE_UNUSED)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the test process is dead, send S=
IGKILL to its children */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (kill(test_pid, 0))<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kill(-test=
_pid, SIGKILL);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 unsigned int tst_timeout_remaining(void)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0static struct timespec now;<br>
&gt;&gt; @@ -1481,6 +1488,7 @@ static int fork_testrun(void)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_d=
isable_oom_protection(0);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_=
SIGNAL(SIGALRM, SIG_DFL);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_=
SIGNAL(SIGUSR1, SIG_DFL);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNA=
L(SIGCHLD, SIG_DFL);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_=
SIGNAL(SIGINT, SIG_DFL);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_=
SETPGID(0, 0);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0testr=
un();<br>
&gt;&gt; @@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[], =
struct tst_test *self)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGALRM, alarm_handle=
r);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGUSR1, heartbeat_ha=
ndler);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGCHLD, sigchild_handler)=
;<br>
&gt;<br>
&gt;<br>
&gt; Do we really need setup this signal handler for SIGCHILD?<br>
<br>
=C2=A0I had same question.<br>
<br>
&gt;<br>
&gt; Since we have already called &#39;SAFE_WAITPID(test_pid, &amp;status, =
0)&#39;<br>
&gt; in the library process (lib_pid) which rely on SIGCHILD as well.<br>
&gt; And even this handler will be called everytime when test exit normally=
.<br>
&gt;<br>
&gt; Maybe better just add a kill function to cleanup the remain<br>
&gt; descendants if main test process exit with abonormal status.<br>
&gt;<br>
&gt; e.g.<br>
&gt;<br>
&gt; --- a/lib/tst_test.c<br>
&gt; +++ b/lib/tst_test.c<br>
&gt; @@ -1503,6 +1503,8 @@ static int fork_testrun(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WIFEXITED(status) &amp;&amp; WEXI=
TSTATUS(status))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return WE=
XITSTATUS(status);<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0kill(-test_pid, SIGKILL);<br>
<br>
Could we skip the call if forks_child =3D=3D 0 ?<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">+1 Obvious=
ly yes!</div></div><div><br></div></div><div><br></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--000000000000abae5705d7b8c158--


--===============1969269385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1969269385==--

