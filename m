Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3405EC4332F
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:11:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52E363CAA13
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:11:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFC673CA722
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:11:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CDFAA600F3C
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652364695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5SDXsQcnE/C++or/DkOMp20z1S7NLCMq+JCDQW/D9wc=;
 b=WVMzqU+UUtUiPYKPBurSfEs8IYFkBye5AGmBZyoSDVOtpH73jzHyyOxFfz1Rl8dAosUZZP
 OFgj2sguvxkSoAPqw7n3ZXvxIViPljPdQruIH5EwxQowsUPg+/u3HaXtZKasTsGEC2qt8p
 kg2rHX7iqBJnEk0zXhF8NruO4gaRjKs=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-0p6PKtVjNxqJkiwVsYRODw-1; Thu, 12 May 2022 10:11:34 -0400
X-MC-Unique: 0p6PKtVjNxqJkiwVsYRODw-1
Received: by mail-yb1-f197.google.com with SMTP id
 w21-20020a25df15000000b0064b401428bfso3755762ybg.22
 for <ltp@lists.linux.it>; Thu, 12 May 2022 07:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5SDXsQcnE/C++or/DkOMp20z1S7NLCMq+JCDQW/D9wc=;
 b=jrfaRYYDuQuNOmrz500NEsdpXd8ku8fNh9RIFXuP97J9f48P41l5vfkICFzkME9L3T
 j2JySGNGjCGpZb/rmIbnjruLWosFcPFdrDJFcToknspXlQe6Y4X6/cwgs7GRuEFMeAI3
 9ChlVw6KzM0tzL3L69arJa0qYvPQtw5TD3G0RFBRd/eUw2F9lkVfIXPc3k/tkY1eW9Va
 nOtGxtHBPPEvtC81MohQYkQZ9kB/gG82vS2HePxvVYyoK7Jfuuni9V+nBXQDulsUHMsW
 G+Ah007YCDVyOBfJy8J8T8YN6sncnaVne2NfX3TjVvaioXasNe45YKqCyWsYkKfPSVVd
 vguA==
X-Gm-Message-State: AOAM532wr0BDlC0gJFQs/CZerfF3OiiJ+j73WsL93yw9INE3CrhPCUj9
 MGrTlhhcf+xZefLaseVvGeKBIDTT2+CL8b5x8kMVWWTeOcLN3mIbrBnOFQLhb523iBfYJfhqK2Q
 d2MPBgjLYjcPlUYoLZN/2ErUvlOY=
X-Received: by 2002:a05:6902:20d:b0:64b:6754:fd6e with SMTP id
 j13-20020a056902020d00b0064b6754fd6emr2111257ybs.506.1652364693371; 
 Thu, 12 May 2022 07:11:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+enke3x94b0hKC4TU3sPlsG8GFqGS4n6QpX4Xv4oAsKarbLQ57Ht4Rfz7MSge6iXfV3aHySuZX6ZxzTw/dss=
X-Received: by 2002:a05:6902:20d:b0:64b:6754:fd6e with SMTP id
 j13-20020a056902020d00b0064b6754fd6emr2111233ybs.506.1652364693036; Thu, 12
 May 2022 07:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220511021636.2166562-1-liwang@redhat.com>
 <Ynt3c8ks6kkAGs/z@yuki>
 <CAEemH2ftLWEu76r7+7JHmMmHNxeZyrFaZw-BANR62v_0r4LSWg@mail.gmail.com>
 <CAF3Th=XPxhF6=g5ZcT1u3D0M9r9ACtYP76JcjGS7CJP_euhqwg@mail.gmail.com>
In-Reply-To: <CAF3Th=XPxhF6=g5ZcT1u3D0M9r9ACtYP76JcjGS7CJP_euhqwg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 12 May 2022 22:11:22 +0800
Message-ID: <CAEemH2carO+D5d5hZJcHWwp0hgy9sgEv3YMOjFi12TCXeh5o+w@mail.gmail.com>
To: Eirik Fuller <efuller@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] rtc02: loosen the compare precision with few
 seconds
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
Content-Type: multipart/mixed; boundary="===============1741951041=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1741951041==
Content-Type: multipart/alternative; boundary="0000000000009181d605ded12246"

--0000000000009181d605ded12246
Content-Type: text/plain; charset="UTF-8"

On Thu, May 12, 2022 at 10:05 PM Eirik Fuller <efuller@redhat.com> wrote:

> Sorry to chime in late, but do we care about crossing day, month, or year
> boundaries? For example, what if we write 23:59:59 and read 00:00:01 ?
>

Good question Eirik, actually we have avoided that zero clocks.
It's impossible to get time crossing day/month/year (or 00:00:xx)
in the clock unless a new bug is happening.

See:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/device-drivers/rtc/rtc02.c#L107

-- 
Regards,
Li Wang

--0000000000009181d605ded12246
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, May 12, 2022 at 10:05 PM Eirik Fuller &lt;<=
a href=3D"mailto:efuller@redhat.com">efuller@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Sor=
ry to chime in late, but do we care about crossing day, month, or year boun=
daries? For example, what if we write 23:59:59 and read 00:00:01 ?</div></b=
lockquote><div><br></div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Good question Eirik, actually we have avoided that zero clocks.</div><=
div class=3D"gmail_default" style=3D"font-size:small">It&#39;s impossible t=
o get time crossing day/month/year (or 00:00:xx)</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">in the clock unless a new bug is happenin=
g.</div></div><div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">See:</div><=
div class=3D"gmail_default" style=3D"font-size:small"><a href=3D"https://gi=
thub.com/linux-test-project/ltp/blob/master/testcases/kernel/device-drivers=
/rtc/rtc02.c#L107">https://github.com/linux-test-project/ltp/blob/master/te=
stcases/kernel/device-drivers/rtc/rtc02.c#L107</a><br></div><div class=3D"g=
mail_default" style=3D"font-size:small"></div><br></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div=
>Li Wang<br></div></div></div></div>

--0000000000009181d605ded12246--


--===============1741951041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1741951041==--

