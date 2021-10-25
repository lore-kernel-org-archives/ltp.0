Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A37C433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:36:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57512604AC
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 08:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57512604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B98E73C6444
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 10:36:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1F6D3C63AA
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:36:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A910560007D
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 10:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635151001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74bFE/ocR1s86NmrBIUj6SwThkAdJSzgBsrr1ebfudc=;
 b=ZVxKgUDigtQZkOXUIXqKfGmI3u8W+OrYiTADCWr4y7NhFzv7ziA+5TTD4Wmp+H8ABB99Sq
 VMUBNvZuyUKEEiDvhTUURthR9pP1oSA9buw4l3DZVuZXjr7ZnAdCmteOwyHgasIJ+YIUoo
 FMyUC48C15z01J9fm24RyLQ12+K2J4o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-atnpoWc_NNe8DugLkTTAYw-1; Mon, 25 Oct 2021 04:36:39 -0400
X-MC-Unique: atnpoWc_NNe8DugLkTTAYw-1
Received: by mail-yb1-f200.google.com with SMTP id
 x15-20020a056902102f00b005ba71cd7dbfso16222486ybt.8
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 01:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=74bFE/ocR1s86NmrBIUj6SwThkAdJSzgBsrr1ebfudc=;
 b=birDx0r3awCkqDha6Ol+9OAnp7uCURiw4Zguc1cOH6eR7hQGTcJcAFG+2rq0j2s3eh
 RMaA2Tj5bsTjkMGzBVAODOikMIdPS4ZN3RFHgmhP4JNEwoqwDaFeWzMLfAvCN49GR79y
 4X6ZUQRSApIfQd1daqCzH4NAL5H4KCt+9Tx0T6cjPYImGXVMwDD6gUipMgYeedEQ/gNB
 SunKZVCOu1zFgpx8WxPQzqVPCliep/+Id9VopX5f2iBvGgJ80PCI5k1FDfDDEqpBcDqU
 WhzYfXje+MHWQrV3v8W37wNKSL9s3qgH0SjAT02bDYs7LEt4vQ4Ncqp9/HYeVq05YrcN
 OMwA==
X-Gm-Message-State: AOAM532nfmJp5SSi6htp/0GLOR0UpCPhSnU7bwTeC61yHQlmVLWhyG/D
 ewVKIBwR29AAYmqJsZgpTQEwTmL7OLbrC4c1b/+NxUiX+Cdl5n9r7ov+jJ94NyzUEQxrEsPBXBk
 KI4awp+arEwktVPqV57h0bzQY/mc=
X-Received: by 2002:a5b:912:: with SMTP id a18mr13471135ybq.144.1635150999189; 
 Mon, 25 Oct 2021 01:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc79zDIuNl8yOdQ7y4jKD6PSp6+LDcmsmyeQocrd7re3UbLf8WdTUpwIZm6A/OYPBA1GNTFdJe+8cDxa9ZjmM=
X-Received: by 2002:a5b:912:: with SMTP id a18mr13471126ybq.144.1635150999020; 
 Mon, 25 Oct 2021 01:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211022043806.19171-1-tangmeng@uniontech.com>
 <CAEemH2dOJWGqji+2nYg8X9eKZfFeJPhn0pV2TX6UovS9M_=_Tg@mail.gmail.com>
 <YXZmuCPM1kdBG/eo@yuki> <tencent_019185364707BDF116DD7C74@qq.com>
In-Reply-To: <tencent_019185364707BDF116DD7C74@qq.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Oct 2021 16:36:27 +0800
Message-ID: <CAEemH2cKLqtdMG6ks2GAu-gMsSC7R13n1UDe+NeKsfNO8PSnVw@mail.gmail.com>
To: =?UTF-8?B?5rGk5a2f?= <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============0164757022=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0164757022==
Content-Type: multipart/alternative; boundary="000000000000737d9305cf2942f1"

--000000000000737d9305cf2942f1
Content-Type: text/plain; charset="UTF-8"

> First of all, I want to say that I am extremely sorry.
> Since it was the first time I submitted a patch here, there were many
> unfamiliar and misunderstandings in the process, which led to multiple
> submissions.
>

Never mind, and thanks for sending patch!


> I will take care to avoid this problem in the future
>

And better to reply in plain text mode but not HTML format in email.
Which avoids showing messy code in different email clients.

-- 
Regards,
Li Wang

--000000000000737d9305cf2942f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div></div><div>First of all, I want =
to say that I am extremely sorry.</div><div>Since it was the first time I s=
ubmitted a patch here, there were many unfamiliar and misunderstandings in =
the process, which led to multiple submissions.</div></blockquote><div><br>=
</div><div><div class=3D"gmail_default" style=3D"font-size:small">Never min=
d, and thanks for sending patch!</div></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div><div>I will take care to avoid thi=
s problem in the future</div></div></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">And better to reply in plai=
n text mode but not HTML format in email.</div></div><div><div class=3D"gma=
il_default" style=3D"font-size:small">Which avoids=C2=A0showing messy code =
in different email clients.</div></div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--000000000000737d9305cf2942f1--


--===============0164757022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0164757022==--

