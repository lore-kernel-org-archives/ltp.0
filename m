Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC29C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:19:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC09B3C8A8D
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 11:19:11 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189B93C093B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:19:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E3DDB1A00CB8
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:19:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639390740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7aVm8Rp5Wj3BkXFZL1Br1wymIrtIX1u7/OUVQWTAamM=;
 b=JE+vLvjzkJfeLaxXSnyp0SSxYsAJTbI/bIVjtl/dCTenekFessRd3Fxz4NxTa/UGX4nBYj
 31wJVWy5Z97lXAXKHiTAC4e365KZx3eAtvJskgJ7TXpeQeJrhfE1CmZHe37cObty/z7yzK
 MXPrY8hvFXKC0CWdOClX3CJC3vNXGdU=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-Qi0Vpiv7N32GWtvc0p1e7w-1; Mon, 13 Dec 2021 05:18:59 -0500
X-MC-Unique: Qi0Vpiv7N32GWtvc0p1e7w-1
Received: by mail-yb1-f199.google.com with SMTP id
 y17-20020a2586d1000000b005f6596e8760so29416703ybm.17
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 02:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7aVm8Rp5Wj3BkXFZL1Br1wymIrtIX1u7/OUVQWTAamM=;
 b=K+iqdhTbUOxjHhyqGYKq/34hVaoXgMBFSg4BW/RlHaJ49EPFeT8NLbgKzzb5P0s7Kr
 yKzUFwv0rtn1BOQob+E4cGYhoYvHJWHriQR4BOJGDHMBaAyI+7UlpXVr9oEp0J9EB5h4
 tj9swvZ67wchJ+uZNInvEV9ite5jFqp0a0WHd4Ueqr1mmVNDiC0sXjbt2NSkH+tEH9Xh
 si5MS15REtL/LEfyAS6Q6+OKY/iM7y98shbnxthqsdiB7rfeMUMnMsYCwtiAHE47r2Yg
 4Kgsl/zni/2gXxXe9eeVGkVCPZJiLXugVtzrUUkDY3EGu4utfBT8R4NEJk0c9ln0t2ip
 UtDQ==
X-Gm-Message-State: AOAM531TOtuCK6KibLS25dV2qgmA3Fb5p1Q4ZUrGSXU95ADAVtbxz1D2
 L9APAbUHJbe294ylmfFiJJcbtZSPoY+kLp8scB++LdDf2RjP0gc/nt1428P1Spk87ggri9B4Ep1
 cciEosG77NfC26kMfdng51Yo1S3A=
X-Received: by 2002:a25:9849:: with SMTP id k9mr33268088ybo.728.1639390738554; 
 Mon, 13 Dec 2021 02:18:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQ/eT0R8YV9z6xaKU2DA1VgC1nyb6OmDS9D4k6qdb6OTulxRyyeGs/fUy/HsGgPWj/p1SY0myhoOnmyDSwDP4=
X-Received: by 2002:a25:9849:: with SMTP id k9mr33268073ybo.728.1639390738318; 
 Mon, 13 Dec 2021 02:18:58 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
In-Reply-To: <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Dec 2021 18:18:45 +0800
Message-ID: <CAEemH2f_bkCkGiAnB3-8G07rYuVb9hZzKAKO3EMXUExDnx1Fdw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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
Content-Type: multipart/mixed; boundary="===============1201929426=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1201929426==
Content-Type: multipart/alternative; boundary="0000000000009b1e5b05d304662a"

--0000000000009b1e5b05d304662a
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 13, 2021 at 5:32 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Mon, Dec 13, 2021 at 9:04 AM Li Wang <liwang@redhat.com> wrote:
> >
> > Hi All,
> >
> > As we observed that oom tests occasionally ended with TBROK (Test
> killed) on small
> > RAM system, the reason seems test process(test_pid) get killed early
> than the expected
> > victim process so that can't report the status correctly.
> >
> > I'm thinking maybe we can purposely make the OOM ignore test
> process(test_pid)
> > and the main process? (achieve this only in mem library for OOM test)
>
> There are likely more processes that could become unintended targets
> (e.g. harness process)
>

Right, but I don't think that LTP has responsible to take care of harness
process.
(sometimes people even run LTP manually)



> (if we haven't tried already) Could we make expected victim process
> more appealing target by tweaking its oom_score/oom_score_adj ?
>

This might not be a good way.

Because OOM Killer counts the oom_score by itself algorithm for
choosing which process to kill. If we tweak that, it will interfere with
the scientificity of the OOM test. But if we only do protect the
lib-process,
we know that shouldn't be killed and the test will report correctly for us.


-- 
Regards,
Li Wang

--0000000000009b1e5b05d304662a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Dec 13, 2021 at 5:32 PM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Dec 13, 2021=
 at 9:04 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_bla=
nk">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi All,<br>
&gt;<br>
&gt; As we observed that oom tests occasionally ended with TBROK (Test kill=
ed) on small<br>
&gt; RAM system, the reason seems test process(test_pid) get killed early t=
han the expected<br>
&gt; victim process so that can&#39;t report the status correctly.<br>
&gt;<br>
&gt; I&#39;m thinking maybe we can purposely make the OOM ignore test proce=
ss(test_pid)<br>
&gt; and the main process? (achieve this only in mem library for OOM test)<=
br>
<br>
There are likely more processes that could become unintended targets<br>
(e.g. harness process)<br></blockquote><div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">Right, but I don&#39;t think that LT=
P has responsible to take care of harness process.</div><div class=3D"gmail=
_default" style=3D"font-size:small">(sometimes people even run LTP manually=
)</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
(if we haven&#39;t tried already) Could we make expected victim process<br>
more appealing target by tweaking its oom_score/oom_score_adj ?<br></blockq=
uote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sm=
all">This might not be a good way.=C2=A0</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Because OOM Killer counts the oom_score by itself=C2=A0algo=
rithm for</div><div class=3D"gmail_default" style=3D"font-size:small">choos=
ing which process to kill. If we tweak that, it will interfere with</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">the scientificity of t=
he OOM test. But if we only do protect the lib-process,=C2=A0</div></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">we know that shouldn&#=
39;t be killed and the test will report correctly for us.</div><div><br></d=
iv></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--0000000000009b1e5b05d304662a--


--===============1201929426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1201929426==--

