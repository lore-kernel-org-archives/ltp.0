Return-Path: <SRS0=3a48=N4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05417C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:43:14 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F88960BD3
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 10:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F88960BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B555A3C2BE9
	for <ltp@archiver.kernel.org>; Mon,  6 Sep 2021 12:43:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 535B03C2642
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 12:43:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D201C600A01
 for <ltp@lists.linux.it>; Mon,  6 Sep 2021 12:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630924979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNyUJiN/uUHx5KVMxcI+wKmH+Kud14mM0ZfdLGfta+4=;
 b=ZNvsxN6OK5F8xD7gMPcq24VrZG2GWqVLQrfTa98nxz/BdNTTum/SfHHAVW9dOEzwGAgI1i
 n958wsEpGHBhHMHUiGU1XJ8Qi9RH0IyT6+2ftM0Da+/pA/AUZEx3q03RyR6oaNsrf0iIj6
 J3T+BgpLt/hT3uXK+bdxNVW0koBG86s=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-BCu6ciuxN4qJMu46Lw3MdQ-1; Mon, 06 Sep 2021 06:42:57 -0400
X-MC-Unique: BCu6ciuxN4qJMu46Lw3MdQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 n202-20020a25d6d3000000b005991fd2f912so7930576ybg.20
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 03:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bNyUJiN/uUHx5KVMxcI+wKmH+Kud14mM0ZfdLGfta+4=;
 b=uUNeyXFA733AcvU4uqt8Lr2fHGwbA3kcGbBsYGNEfFKzS2o9wXYB8cddsfBwWPmAS7
 jcniu8Y48YRFTpyQ6pbrMX3uud49yPONubNEOPdu/ykxhc55nM7R8uLqkI3OBvYdwkUq
 q40j3InPfAxSW7Tazci6FuNCGSI4M/ZZEkxsmaB5dAp7PbaRFENbEhegvn733Nj8mSsf
 yyRa19YPy5Ay/887jvjvmKQJ2jpsiyE01L+HeA5J952jehKLTwUartKhLf+U37i1qPw0
 GHzvIjvyTC3UnjFqPNztCZyA6MakZxLzr7cJMr66/h+nt7hum6nKxCrEE/d+0suY8zEu
 mAQA==
X-Gm-Message-State: AOAM530AraRD0BinDbUDe9k6eioQlSoCX8x7Zdep5NHjuDyg0nRp15Qc
 YR1kwERh9EJwOjtQYF1qw/erzn9wy258btjuQiDrvE9pCqy2ed52j/3aStxs8YH9o+GkRs38fuO
 XR2/1aQXQ2rIpzaf3CE0KYwXEHBY=
X-Received: by 2002:a25:6902:: with SMTP id e2mr16242990ybc.526.1630924977370; 
 Mon, 06 Sep 2021 03:42:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0aODdnBWOp8pp0AN263355VVRzH9X7p4JII10Iv/hxqAVURSD8xLzbjyzoobQtPyX0i9OrsC1NtlzzcIDlHo=
X-Received: by 2002:a25:6902:: with SMTP id e2mr16242975ybc.526.1630924977197; 
 Mon, 06 Sep 2021 03:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210906060020.3219023-1-liwang@redhat.com>
 <YTXYixG37nBTzhXk@yuki>
 <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
 <YTXviHdUSqTaR1hx@yuki>
In-Reply-To: <YTXviHdUSqTaR1hx@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Sep 2021 18:42:45 +0800
Message-ID: <CAEemH2f3CJH7girY25U8idTWtAoM-RC7zCZ6KGQae9OCHrU=sw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
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
Content-Type: multipart/mixed; boundary="===============1947049920=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210906104245.6axBAO4r-v55YFjyGI92oq4FOOn2RIjy2ynHQuC-rZc@z>

--===============1947049920==
Content-Type: multipart/alternative; boundary="000000000000ebeff005cb514f93"

--000000000000ebeff005cb514f93
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 6, 2021 at 6:37 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Theoretically, this is correct, but I'm fearing that the process might
> > cost more time on performing with different system loads.
> >
> > This means 'diff_us <= 2000000' is an unreliable condition to
> > many virtual machines. That largely depends on the system
> > scheduler at that moment as well.
>
> Right, I guess that we can relax the upper bound, it can be even a
> minute and it would still be a good sanity check.
>

Yes, I'd relax it to 30 sec to see how it performs in real scenarios.

Patch v3 is on the way.

-- 
Regards,
Li Wang

--000000000000ebeff005cb514f93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 6, 2021 at 6:37 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Theoretically, this is correct, but I&#39;m fearing that the process m=
ight<br>
&gt; cost more time on performing with different system loads.<br>
&gt; <br>
&gt; This means &#39;diff_us &lt;=3D 2000000&#39; is an unreliable conditio=
n to<br>
&gt; many virtual machines. That largely depends on the system<br>
&gt; scheduler at that moment as well.<br>
<br>
Right, I guess that we can relax the upper bound, it can be even a<br>
minute and it would still be a good sanity check.<br></blockquote><div><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">Yes, I&#39;d r=
elax it to 30 sec to see how it performs in real scenarios.</div></div><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Patc=
h v3 is on the way.</div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></d=
iv></div></div>

--000000000000ebeff005cb514f93--


--===============1947049920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1947049920==--

