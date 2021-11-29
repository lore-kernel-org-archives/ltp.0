Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6F6C433F5
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 05:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF00D3C5587
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 06:47:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB6373C04C3
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 06:47:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF8FD140013F
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 06:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638164861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uh9N8mlul4CaKLu1WPN3yzF0ybJVV4oz48IHoOl8fhc=;
 b=f8v/9Sq8HmUMBA6dyaN4u1/ddNDtLN9f/psn3sPjOZqy6fu57R4oRFV/UAdhIpakdUjyIu
 ALTRVGVe1xH23PGPLxG77M0jpkXfg8o73WXtBjMKtcIwnTsSA9iWdrbg1XMrcoUJu0q74j
 pTVUgOCIYzqJl9S4ItfN2x+p0UOCZXI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-nAcYgLnrPKioQ9BWrVbvRA-1; Mon, 29 Nov 2021 00:47:37 -0500
X-MC-Unique: nAcYgLnrPKioQ9BWrVbvRA-1
Received: by mail-yb1-f198.google.com with SMTP id
 g25-20020a25b119000000b005c5e52a0574so21437548ybj.5
 for <ltp@lists.linux.it>; Sun, 28 Nov 2021 21:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uh9N8mlul4CaKLu1WPN3yzF0ybJVV4oz48IHoOl8fhc=;
 b=8Af6GZPRM/Hy96PfetkgyGizMK3oAnhkA2k+MDdoxroikCWJBgLoP5xvgnmWYYaHm5
 mSp+DlFHW/CjpfTj7hm4H9850sT2oFUQLxGYx9KDEWcKbFSdGS7741sqktTiNPX7q64a
 SJzR7DjE8XAAECXhjbL/dm4l8p7ND6iFf8TviNK7RuZP2BZ0aPUkqSdiHnMH9XbsXs5Z
 WbRSXYnuWDFEj5djH8iwn+6KjqIasrN2FAgLcB5HIRpwWWGnRi0N/l8JYHrztpP5f2sL
 V9orAONfZmfBgEV7aeUccVipBoN9O3SO6x9Vi3cD5g4nLXmOORayLYmd1+GuFHuRBkZ6
 zAhw==
X-Gm-Message-State: AOAM5328Bb5zi5vwk5vXAsFGe2KwGHSzUREoWXo4CeXddASUAICTNvoO
 qxVWfew6qJbbW8t3+PPYqyrsVANdeD0EF6r2wcCSt9Ch+55HQLSUO6MBxDU/EzVGfuB+2GgxS+J
 /eL+c8uMm9MlSiLozOPfel7gd4Wk=
X-Received: by 2002:a25:38d6:: with SMTP id
 f205mr34835185yba.208.1638164856842; 
 Sun, 28 Nov 2021 21:47:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2QSikLZ3I0aX2GftdKU5gTqW6+g5uvAFqTgKHTH0E9GK9Y55yLGwL+izAiVKXcNM9b5ox8KdquB6IJ2Y31Cs=
X-Received: by 2002:a25:38d6:: with SMTP id
 f205mr34835171yba.208.1638164856576; 
 Sun, 28 Nov 2021 21:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20211129035737.15910-1-zhaogongyi@huawei.com>
In-Reply-To: <20211129035737.15910-1-zhaogongyi@huawei.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Nov 2021 13:47:24 +0800
Message-ID: <CAEemH2eOPjtN0z+-aO-h4LZ12uPveivPDTOvm6321N0qDGWEhw@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] max_map_count: Delete dead code
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
Content-Type: multipart/mixed; boundary="===============1442175091=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1442175091==
Content-Type: multipart/alternative; boundary="0000000000005c38c105d1e6fafd"

--0000000000005c38c105d1e6fafd
Content-Type: text/plain; charset="UTF-8"

Hi Gongyi,

On Mon, Nov 29, 2021 at 11:56 AM Zhao Gongyi via ltp <ltp@lists.linux.it>
wrote:

> When we run the testcase on AARCH64, there are no TST_ARM defined.
>

We thought there is a possible 32bit ARM binary runs on 64bit aarch64
kernel.
https://lists.linux.it/pipermail/ltp/2021-November/026038.html

Or, what's your test scenarios, did you build and test that?


-- 
Regards,
Li Wang

--0000000000005c38c105d1e6fafd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Gongyi,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Nov 29, 2021 at 11:56 AM Zhao Gongyi =
via ltp &lt;<a href=3D"mailto:ltp@lists.linux.it">ltp@lists.linux.it</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">When we=
 run the testcase on AARCH64, there are no TST_ARM defined.<br></blockquote=
><div><br></div><div class=3D"gmail_default" style=3D"font-size:small">We t=
hought there is a possible<span style=3D"color:rgb(0,0,0);white-space:pre-w=
rap"> 32bit ARM binary runs on 64bit aarch64 kernel.</span></div><div class=
=3D"gmail_default" style=3D"font-size:small"><div class=3D"gmail_default"><=
a href=3D"https://lists.linux.it/pipermail/ltp/2021-November/026038.html">h=
ttps://lists.linux.it/pipermail/ltp/2021-November/026038.html<span style=3D=
"color:rgb(0,0,0);white-space:pre-wrap"><br></span></a></div><div class=3D"=
gmail_default"><br></div></div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">Or, what&#=
39;s your test scenarios, did you build and test that?</span></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000005c38c105d1e6fafd--


--===============1442175091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1442175091==--

