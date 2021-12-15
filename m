Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1488AC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:37:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC8493C8F4A
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:37:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 136B33C0B90
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:36:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2B0F6003CC
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:36:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639553813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mU8WwqxTnkRLqIg3xB2fHU38mPw/+I3cEwR/eUhzOts=;
 b=WtVkuoYKcasoyj189A+jhzHYGgU0ffeckJDjK6ZIsWoVfrvOkkDHx66gEFJHneV9lepHTd
 6+A4KwIfthnN0Oeob7Bv5nixsNRZxvXHv0otehWQAFLTxwCfJceAU4zfFhNMlrGuYT5Q2G
 Zc09vPHZTfq8hx9plqSuGJP6uaJ9I8g=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-MM7PJbcFNoKAbZVB49foyw-1; Wed, 15 Dec 2021 02:36:50 -0500
X-MC-Unique: MM7PJbcFNoKAbZVB49foyw-1
Received: by mail-yb1-f198.google.com with SMTP id
 d27-20020a25addb000000b005c2355d9052so41457134ybe.3
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 23:36:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mU8WwqxTnkRLqIg3xB2fHU38mPw/+I3cEwR/eUhzOts=;
 b=RdF7KOUXPuLZDoWhBK5HZrhMyAHU9gIu6UY8NI0TMCAFRL8JpJeEJ3tUCa8uu1XlcP
 D8ngoxaovMW3s86kj6A5ONsM+h0IiBzl6XolZockKpNEZFllyYBKejQYIpwDkh6/qGAU
 DAtv3TV44PDZ9O0f04A+wDzR7Q+dFMbWbVe94OE/HxHj5/KqPrw2lY9eh1cnP+94TNx4
 b7V10X01P2FqEWxY5Sq0E8t86cJcaTzatx1Vs7ya8g7NnzAKQvzyn7fB6RDIXxUJSr8U
 WpI/ezNOO9zAQj92uWJhCMITUikvHhcDN7L6/ks1Gfm60CGx8qgEDGu3Wl8QRPgN6a4b
 ShTw==
X-Gm-Message-State: AOAM530Yy0hKnN/rBVj6eS1yfqFdU/ETJIPNMScquXx5rRoEfcVoRt9o
 Y8uKMHVOk0+eyw5tgFR95GFZaG/zzJZ8oliRLKhw25IRjZxBhqU9mW/wtkHN4oo+ob0gfG4E2+A
 ubs3+Yai/mGdno43BCB/3PXa2rmM=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr4258554ybe.32.1639553810181; 
 Tue, 14 Dec 2021 23:36:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBWh6c5d3v4tGuzA6JSEbCBAFkydZ0NezcDmZDgD6N6PAPnYREtZScgIPAj3fk63JINyFH6q2LpRHCJCFZohY=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr4258532ybe.32.1639553809909; 
 Tue, 14 Dec 2021 23:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-3-pvorel@suse.cz>
 <BYAPR13MB25037C7B8DE0850EFB25DDE5FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjKkic5F0j4c3bD@pevik> <YbjNExvj1vjnjb93@pevik>
 <BYAPR13MB250371A7DC839014B8219104FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjoeQ/lVsf01JJx@pevik>
In-Reply-To: <YbjoeQ/lVsf01JJx@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Dec 2021 15:36:34 +0800
Message-ID: <CAEemH2dxxVjetF_jKaZ_Xh5kzNOG0-Ym2_LaKBPwVSLkZo6qDA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============2057218565=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2057218565==
Content-Type: multipart/alternative; boundary="0000000000006e235005d32a5e96"

--0000000000006e235005d32a5e96
Content-Type: text/plain; charset="UTF-8"

Hi Tim, Petr,

On Wed, Dec 15, 2021 at 2:54 AM Petr Vorel <pvorel@suse.cz> wrote:


>
> > Would it be useful to add a bit of code to tst_test.sh to handle
> > floating point?  The shell construct of '$((timeout * LTP_TIMEOUT_MUL))'
> > can't handle floating point, but floating point could be done pretty
> easily
> > with a callout to awk or bc.
>
> > I'm willing to look at this and submit a patch.  But does the shell
> > test system try to avoid dependencies on other utility programs (like
> awk or bc)?
>
> > Maybe rounding timeouts up is preferred behavior anyway, so
> > this is not needed.  What do you think?
>
> [ Cc Joerg, Li and Cyril, who were involved in shell timeout ]
> We spent quite a lot of time before we end-up with ceiling, I'd have to
> search
> for the reasons. We also didn't think that it's a big problem to not being
> precise on shell. But feel free to improve things. Just, generally we
> prefer to
>

Yeah, I agree with this.

To be honest, I personally have no thoughts to make the shell
to handle float point, and by now I don't see any person request
that, for most situations we just use an round up number
to satisfy ourselves.

But anyway, I have no objection to improving that. Feel
free to submit a patch :).



> wrote small C code instead adding new dependencies (bc etc) or trying to
> make
> shell portable. Actually writing C parser would be few lines of code.
>

+1

For patch itself:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000006e235005d32a5e96
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Tim, Petr,</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 15, 2021 at 2:54 AM Petr Vorel=
 &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Would it be useful to add a bit of code to tst_test.sh to handle<br>
&gt; floating point?=C2=A0 The shell construct of &#39;$((timeout * LTP_TIM=
EOUT_MUL))&#39;<br>
&gt; can&#39;t handle floating point, but floating point could be done pret=
ty easily<br>
&gt; with a callout to awk or bc.<br>
<br>
&gt; I&#39;m willing to look at this and submit a patch.=C2=A0 But does the=
 shell<br>
&gt; test system try to avoid dependencies on other utility programs (like =
awk or bc)?<br>
<br>
&gt; Maybe rounding timeouts up is preferred behavior anyway, so<br>
&gt; this is not needed.=C2=A0 What do you think?<br>
<br>
[ Cc Joerg, Li and Cyril, who were involved in shell timeout ]<br>
We spent quite a lot of time before we end-up with ceiling, I&#39;d have to=
 search<br>
for the reasons. We also didn&#39;t think that it&#39;s a big problem to no=
t being<br>
precise on shell. But feel free to improve things. Just, generally we prefe=
r to<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">Yeah, I agree with this.</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">To be honest, I personally have no thoughts to make th=
e shell</div><div class=3D"gmail_default" style=3D"font-size:small">to hand=
le float point, and by now I don&#39;t see any person request</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">that, for most situations we=
 just use an round up number</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">to satisfy=C2=A0ourselves.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">But anyway, I have no objection to improving that. Feel</di=
v><div class=3D"gmail_default" style=3D"font-size:small">free to submit a p=
atch :).</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
wrote small C code instead adding new dependencies (bc etc) or trying to ma=
ke<br>
shell portable. Actually writing C parser would be few lines of code.<br></=
blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">+1</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">For patch itself=
:</div><div class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: =
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<=
/div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--0000000000006e235005d32a5e96--


--===============2057218565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2057218565==--

