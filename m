Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4C8C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 11:12:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8C4C3CA798
	for <ltp@archiver.kernel.org>; Fri, 29 Apr 2022 13:12:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203C93CA710
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 13:12:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A9BF600835
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 13:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651230743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9devpSmXmelJ7uzkspgc9F0NgqeTiyW7+AwqE1HwnBQ=;
 b=ADZGSGSPn330HVKexBcx10AW3QqNo19h+cg4vYJm4r1yUSdzRzBo2JAWAT4mO7Teh3IytN
 irIPVbTc2rZ/jQiJyoWNJsAzRRwOtBn/N4r9T4yUpqw8wTVI4r8V9D9fXfo8U+hHV/PQQU
 KcuzWG2r8AuVKJHKnKTaojzgsRaiO7M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-eNNI4IG6N1uvoygA-ZK5YQ-1; Fri, 29 Apr 2022 07:12:22 -0400
X-MC-Unique: eNNI4IG6N1uvoygA-ZK5YQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-2f7c5767f0fso71756807b3.4
 for <ltp@lists.linux.it>; Fri, 29 Apr 2022 04:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9devpSmXmelJ7uzkspgc9F0NgqeTiyW7+AwqE1HwnBQ=;
 b=zT/yvATc9gLq3MUbt0ZX56jjLMyQcSJqyGkv3AlYCDREw663i67nC/2jM/rUzXUEr2
 OZ5GfGJIDZAGJc1+PcW2gl+0lNRCwnSwtcnZnDuMA9qtPNE3LjYewpCtYx/x+84Cqv6K
 JwAAYzbVCF+mToQPP+2jWKHCWh0j8fKFAtUdnewbLD/+BOKYWH+AIXCj8El8ixKStx3S
 1y4lLrQDjSMEwyEK08qS2LXx+mUXKlpuTWJPgAry4iJDN+oEzUv/Jzg8UdquGpGFTXvg
 96lyRIGM3n4f04JZHj8lYUs2EwvhzWbrHT99UGjBkkNLnKk7cWDvaUqN4dDn/12NvP5j
 3m+A==
X-Gm-Message-State: AOAM533CFgBNt8QCJoT6Y89pLb7f/sJNNKmYDDZ28LIf8gsi7kZGwJ4M
 L1mTt0r8l3xUYnEpeNPS2QFWa5pwPyIPBlcDNGXr9NjR+vNBuX6yIsNgHgYJxlxvWtDiWOcv3qn
 xaXuRJaEFeEL4MIsaZRavgU0Mjls=
X-Received: by 2002:a25:107:0:b0:645:d3ed:3cb7 with SMTP id
 7-20020a250107000000b00645d3ed3cb7mr32513301ybb.26.1651230741743; 
 Fri, 29 Apr 2022 04:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeLORNMsuiRnWiDSZWtw0wWURrMgSyU3HRvKLQi4hO643E9mtnXTBrTt5wHneUD/7gZAS/w+RZgbeosVyD00A=
X-Received: by 2002:a25:107:0:b0:645:d3ed:3cb7 with SMTP id
 7-20020a250107000000b00645d3ed3cb7mr32513272ybb.26.1651230741444; Fri, 29 Apr
 2022 04:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220428132656.11075-1-liwang@redhat.com>
 <20220428132656.11075-2-liwang@redhat.com> <YmvHDc8esDqfAJj/@yuki>
In-Reply-To: <YmvHDc8esDqfAJj/@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 29 Apr 2022 19:12:04 +0800
Message-ID: <CAEemH2fq4OCqOpHehuSpgbT9FEUUzWYyOdaWfjDgKK9edUAY9w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Hiroyuki Yasuhara <hyasuhar@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] rtc02: skip test with unsupport set RTC
 platform
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
Content-Type: multipart/mixed; boundary="===============0740655010=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0740655010==
Content-Type: multipart/alternative; boundary="000000000000c94f5f05ddc91d65"

--000000000000c94f5f05ddc91d65
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 29, 2022 at 7:05 PM Cyril Hrubis <chrubis@suse.cz> wrote:


>
> I wonder if there is a different way how to figure out setting RTC is
> not supported, this may potentionaly mask away a breakage in a driver
> that is supposed to be able to set time like this.
>

Yes, that is what I really hope to know as well.

Not sure if Hiroyuki Yasuhara (already on CC list) can provide more info
here.


-- 
Regards,
Li Wang

--000000000000c94f5f05ddc91d65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Apr 29, 2022 at 7:05 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I wonder if there is a different way how to figure out setting RTC is<br>
not supported, this may potentionaly mask away a breakage in a driver<br>
that is supposed to be able to set time like this.<br></blockquote><div><br=
></div><div><div class=3D"gmail_default" style=3D"font-size:small">Yes, tha=
t is what I really hope to know as well.</div><div class=3D"gmail_default" =
style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"f=
ont-size:small">Not sure if Hiroyuki Yasuhara (already on CC list) can prov=
ide more info here.</div></div></div><br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,=
<br></div><div>Li Wang<br></div></div></div></div>

--000000000000c94f5f05ddc91d65--


--===============0740655010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0740655010==--

