Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE5AC433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 04:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4DCB3C9B4E
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 05:51:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A77F3C9767
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 05:51:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E14D91401118
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 05:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644382292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOWNkovvQYvWKFxmq/ez3KQoYG/Uti3x111h3npykOA=;
 b=fsfO6SK/HcFWu06ptgC+zHVZ4ZVDoYzeiyTBZJth3tbyAxTKWUIOJqs8fURwtGy0pRLOBL
 sCKm1+lHPs1qqRDtxpjNnLHOI/abGjEhTSj6HGy4X1ZLsDBTukZq8CgFc2gFV44PvpRaRz
 03uGQ1POsL8Ey0C26RwtzvQQlqHCnZo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-vO7_iuJ1M4eHpPE0625BXA-1; Tue, 08 Feb 2022 23:51:30 -0500
X-MC-Unique: vO7_iuJ1M4eHpPE0625BXA-1
Received: by mail-yb1-f198.google.com with SMTP id
 x1-20020a25a001000000b0061c64ee0196so2470670ybh.9
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 20:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qOWNkovvQYvWKFxmq/ez3KQoYG/Uti3x111h3npykOA=;
 b=SYGw3zfFPeg0f2v40AvwduYNPkY3ZLgqdsPl3OU4eEBjn/G00pC8XQcIRVtY/zfc3c
 61gOmzHD/T9YaukRra4hYRtk3fDKl7S/wjFKfW4joiJopBbS98G/wDqvjrxoyCeCauGC
 oYuwF+sU3CUPWK/HPm7mpZBHKm3VCANRHgHPQmRwPjklJva+ToQ2rO5Uf+2DVzeuWj2M
 +Nf1asFN5fGaZ9auXduhcsjLZigaxzNEKJiw5C13LX/qBZs+P4Iqy6O+Jjw+pQjjXv4O
 RyTmenq8wvLaUA8OAUOZdKoXbBR1wgR8rJdE9H3o1692RYgbFLNBih6BgMq8H9lYIi9v
 1+3Q==
X-Gm-Message-State: AOAM532mTJVJm7aRJRSRX62rdp2URwQHzPIwFp5ZNrYfmAV7dpqTYcnK
 DZINNmS21f9O1iRk9r2df1zJLPsArSv1btYkkZkn7dcYhMxl5X7hYdQ4NFZ+nk8CizGbrRXFCAK
 2LNqBYjp5r7huHmcBaD5mgyDDCDs=
X-Received: by 2002:a81:8d4c:: with SMTP id w12mr471290ywj.208.1644382289606; 
 Tue, 08 Feb 2022 20:51:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeh3Q2J/cVn0GBt6lNX0TCLrmzqMt/rMJFkIAIFYDRVLk4ilSBCn9J1hDbGBwS5/W/ND72mOC2JfF4DtcCYJI=
X-Received: by 2002:a81:8d4c:: with SMTP id w12mr471278ywj.208.1644382289339; 
 Tue, 08 Feb 2022 20:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-3-rpalethorpe@suse.com>
In-Reply-To: <20220208140322.6842-3-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Feb 2022 12:51:16 +0800
Message-ID: <CAEemH2fjSLAdY4xO7WMekGX=3sPFjt0xVknNxJedk1-agsb3zQ@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] API/cgroup: Shorten cgroup to cg in most
 symbols
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
Content-Type: multipart/mixed; boundary="===============0074402774=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0074402774==
Content-Type: multipart/alternative; boundary="0000000000003b3cc005d78e96fd"

--0000000000003b3cc005d78e96fd
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe via ltp <
ltp@lists.linux.it> wrote:

> With the current naming it is common to have 'group' repeated 3 or
> even 4 times in one line. This causes a number of readability
> problems. Renaming it to cg reduces the amount of repetition.
>
> The one place it is not renamed is in tst_test because it won't cause
> repetition there. Meanwhile it is easier to search the internet for
> 'linux cgroup' than 'linux cg'.
>
> Li Wang suggested renaming tst_cg to tst_cg_test because it is
> consistent with tst_cg_drain. However I think tst_cg is used so often
> that it is more important to have shorter lines.
>

To be honest, I only wanted that tst_cg_test pointer :).

But I have no objection to renaming 'tst_cgroup_*' to 'tst_cg_*'
for the whole APIs. (Though I don't like it)

Let's hear more voices from peers.

-- 
Regards,
Li Wang

--0000000000003b3cc005d78e96fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 8, 2022 at 10:04 PM Richard Palethorpe =
via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">With th=
e current naming it is common to have &#39;group&#39; repeated 3 or<br>
even 4 times in one line. This causes a number of readability<br>
problems. Renaming it to cg reduces the amount of repetition.<br>
<br>
The one place it is not renamed is in tst_test because it won&#39;t cause<b=
r>
repetition there. Meanwhile it is easier to search the internet for<br>
&#39;linux cgroup&#39; than &#39;linux cg&#39;.<br>
<br>
Li Wang suggested renaming tst_cg to tst_cg_test because it is<br>
consistent with tst_cg_drain. However I think tst_cg is used so often<br>
that it is more important to have shorter lines.<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">To be hone=
st, I only wanted that tst_cg_test pointer :).</div><div class=3D"gmail_def=
ault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">But I have no objection to renaming &#39;tst_cgroup_*=
&#39; to &#39;tst_cg_*&#39;</div><div class=3D"gmail_default" style=3D"font=
-size:small">for the whole APIs. (Though I don&#39;t like it)</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmai=
l_default" style=3D"font-size:small">Let&#39;s hear more voices from peers.=
</div></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--0000000000003b3cc005d78e96fd--


--===============0074402774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0074402774==--

