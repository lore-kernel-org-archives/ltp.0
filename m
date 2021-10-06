Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E01C433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 14:59:35 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E7860FDC
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 14:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5E7860FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C71903C9F77
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 16:59:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 965883C65BE
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 16:59:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 40EF11401112
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 16:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633532357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52bswEnKMAJ8cCM69EAS0zDZFRQ69+L4Wg0ZRytQwnI=;
 b=HQvTeLfU54RBbcpCSVTImfc2wpjrRg4WmdGQI5rCoQhuk1zbmEk/Ngp4lVmaP1q0/Kuygn
 /6w9TotADZ9zJBUz66Db2Fl7lOdnTfZrCjhT9LeiUSq76ty6tXxvyQrdzEVWS+MigfOPfT
 wVws1uXALHv0zGyKw/Zd80gUh9mrgc8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-sGkuKJM2P8SkELZYc94IEA-1; Wed, 06 Oct 2021 10:59:16 -0400
X-MC-Unique: sGkuKJM2P8SkELZYc94IEA-1
Received: by mail-ot1-f72.google.com with SMTP id
 a19-20020a9d3e13000000b0054d67e67b64so1606647otd.22
 for <ltp@lists.linux.it>; Wed, 06 Oct 2021 07:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=52bswEnKMAJ8cCM69EAS0zDZFRQ69+L4Wg0ZRytQwnI=;
 b=tKZ/GBwnzT3+GS4WAvvE4nnDUWbCbcs+spMMRfLvjY2Wr5XPCa1JmyF6TP3FittM3C
 aOEBWqTalTYkCHTkngKXrWilhySfZeYs9yOBIfYmG/Hhr3pMu30ON5BaVwbKLXc4j8i7
 /ANKjC4Tb+d/rE3ShR83yENJLy2SEcYkc9jQqIoG5VfVJv/qTqOkXJ7TT5x0aMEjwujd
 Xbkz9zm7VmKXx2Xw121hE6K/3B31jgMbrJbVwglvttx+g2ut0R2feVBaLRUdKymdzH/A
 li1VxP9VFncrkCkd8wAT7e3QXrFsnnZOayqK9oK9StjTBhv/i0pO5xUXTAdcNiGayKs4
 XCAw==
X-Gm-Message-State: AOAM5301kmqHs1XNz9M9UBjdLQbimOuDBmbH46LIDTOaRCQTiPex4TBT
 rlw0qpgvl9pC0NjAgUS5Z+r29WB+0wfTa3CQnFaFWNyVSgWCgU7PAFyyCb5QTYQjIp1R34rTCa3
 QUxas7zQ7ATI5vK9E2dGgVn4l06A=
X-Received: by 2002:aca:eb4f:: with SMTP id j76mr2866690oih.66.1633532355420; 
 Wed, 06 Oct 2021 07:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCQnCcgKk1Bmydg+SUSvUbRUkw2nDk7tH+3D/TvOZvr361JjPcX4fc7p7IPlDPuDVeoL/JdAfcXMVNBwnPfmk=
X-Received: by 2002:aca:eb4f:: with SMTP id j76mr2866669oih.66.1633532355116; 
 Wed, 06 Oct 2021 07:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <281d8fbf1a7df4d85aea6bbd3ff74982923309c5.1633527038.git.jstancek@redhat.com>
 <YV2zMeb3ILLRPNsL@yuki>
In-Reply-To: <YV2zMeb3ILLRPNsL@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Oct 2021 16:58:59 +0200
Message-ID: <CAASaF6yhMEvy8zFOvNvZWFvEQG-_LpwpBc3WgACWOOROObV+zg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix: remove pthread_kill/6-1
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
Content-Type: multipart/mixed; boundary="===============0948649760=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0948649760==
Content-Type: multipart/alternative; boundary="000000000000c19b1305cdb063bb"

--000000000000c19b1305cdb063bb
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 6, 2021 at 4:31 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> > index 2289b9bfbb2e..fa74c312bebb 100644
> > ---
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> > +++
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/assertions.xml
> > @@ -16,10 +16,6 @@
> >    <assertion id="5" tag="ref:XSH6:33594:33595 pt:THR">
> >      No signal shall be sent if the pthread_kill() function fails.
> >    </assertion>
> > -  <assertion id="6" tag="ref:XSH6:33598:33599 pt:THR">
> > -    [ESRCH] No thread could be found corresponding to that specified by
> > -    the given thread ID.
> > -  </assertion>
> >    <assertion id="7" tag="ref:XSH6:33600:33600 pt:THR">
> >      [EINVAL] The value of the sig argument is an invalid or unsupported
> >      signal number.
> > diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> > index 03dc3d5a718a..8cfa3d8b6ba3 100644
> > ---
> a/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> > +++
> b/testcases/open_posix_testsuite/conformance/interfaces/pthread_kill/coverage.txt
> > @@ -6,6 +6,5 @@ Assertion     Status
> >  3            YES
> >  4            IMPLICITLY tested by assertions 6 and 7.
> >  5            IMPLICITLY tested by assertions 6 and 7.
> > -6            YES
> >  7            YES
> >  8            WON'T test. No way to interrupt the pthread_kill() call.
>
>
> Shouldn't we just flip the YES to WON'T test in the coverage?
>

I dropped it because it seemed pointless to keep around wrong assertions.
I don't have strong opinion here, I can change it to WON'T.



>
> I'm not sure how to maintain the assertions or coverage files to be
> honest.
>
> Otherwise it looks good. The ESRCH return was always a recommendation
> and not an requirement.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
>

--000000000000c19b1305cdb063bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 6, 2021 at 4:31 PM Cyril Hrubis &=
lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pth=
read_kill/assertions.xml b/testcases/open_posix_testsuite/conformance/inter=
faces/pthread_kill/assertions.xml<br>
&gt; index 2289b9bfbb2e..fa74c312bebb 100644<br>
&gt; --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_ki=
ll/assertions.xml<br>
&gt; +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_ki=
ll/assertions.xml<br>
&gt; @@ -16,10 +16,6 @@<br>
&gt;=C2=A0 =C2=A0 &lt;assertion id=3D&quot;5&quot; tag=3D&quot;ref:XSH6:335=
94:33595 pt:THR&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 No signal shall be sent if the pthread_kill() func=
tion fails.<br>
&gt;=C2=A0 =C2=A0 &lt;/assertion&gt;<br>
&gt; -=C2=A0 &lt;assertion id=3D&quot;6&quot; tag=3D&quot;ref:XSH6:33598:33=
599 pt:THR&quot;&gt;<br>
&gt; -=C2=A0 =C2=A0 [ESRCH] No thread could be found corresponding to that =
specified by<br>
&gt; -=C2=A0 =C2=A0 the given thread ID.<br>
&gt; -=C2=A0 &lt;/assertion&gt;<br>
&gt;=C2=A0 =C2=A0 &lt;assertion id=3D&quot;7&quot; tag=3D&quot;ref:XSH6:336=
00:33600 pt:THR&quot;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [EINVAL] The value of the sig argument is an inval=
id or unsupported<br>
&gt;=C2=A0 =C2=A0 =C2=A0 signal number.<br>
&gt; diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pth=
read_kill/coverage.txt b/testcases/open_posix_testsuite/conformance/interfa=
ces/pthread_kill/coverage.txt<br>
&gt; index 03dc3d5a718a..8cfa3d8b6ba3 100644<br>
&gt; --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_ki=
ll/coverage.txt<br>
&gt; +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_ki=
ll/coverage.txt<br>
&gt; @@ -6,6 +6,5 @@ Assertion=C2=A0 =C2=A0 =C2=A0Status<br>
&gt;=C2=A0 3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 YES<br>
&gt;=C2=A0 4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IMPLICITLY tested by =
assertions 6 and 7.<br>
&gt;=C2=A0 5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IMPLICITLY tested by =
assertions 6 and 7.<br>
&gt; -6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 YES<br>
&gt;=C2=A0 7=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 YES<br>
&gt;=C2=A0 8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WON&#39;T test. No wa=
y to interrupt the pthread_kill() call.<br>
<br>
<br>
Shouldn&#39;t we just flip the YES to WON&#39;T test in the coverage?<br></=
blockquote><br></div><div class=3D"gmail_quote">I dropped it because it see=
med pointless to keep around wrong assertions.</div><div class=3D"gmail_quo=
te"><div style=3D"font-family:monospace" class=3D"gmail_default">I don&#39;=
t have strong opinion here, I can change it to WON&#39;T.<br></div><br></di=
v><div class=3D"gmail_quote"></div><div class=3D"gmail_quote"><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I&#39;m not sure how to maintain the assertions or coverage files to be<br>
honest.<br>
<br>
Otherwise it looks good. The ESRCH return was always a recommendation<br>
and not an requirement.<br>
<br>
-- <br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a><br=
>
<br>
</blockquote></div></div>

--000000000000c19b1305cdb063bb--


--===============0948649760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0948649760==--

