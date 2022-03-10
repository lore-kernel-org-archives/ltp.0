Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771AC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 01:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352803C6D1E
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 02:27:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12A043C1FE9
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 02:27:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16601601624
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 02:27:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646875637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b/YQ9AUmasqWRO5fpB8aIuV6Mbzta25wTvFONALBK6g=;
 b=TkxyM34oElGUHxZkl4NARxnPC3X9sQUJZjHdJOqrBe2TDBrQbErJj8ckX4wj/0g3dmO+vB
 tpKLeYFsNiWyAwIsZ4abidJtW6FmF+n33ycT5AdYem23T/P8BAXC0e6UCCrtkkEwzoH3bB
 lzOVCWpo++HCmDpnBlFOFNk8kuF0f1M=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-T706WX8tNfmnyP7SKmyyJg-1; Wed, 09 Mar 2022 20:27:15 -0500
X-MC-Unique: T706WX8tNfmnyP7SKmyyJg-1
Received: by mail-yb1-f198.google.com with SMTP id
 a3-20020a5b0ac3000000b006288f395b25so3143310ybr.18
 for <ltp@lists.linux.it>; Wed, 09 Mar 2022 17:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b/YQ9AUmasqWRO5fpB8aIuV6Mbzta25wTvFONALBK6g=;
 b=X/2fblS9pX9vhjQ4hyicCF/3b4Tigz7x/a1Ge9l+ACV696uBPFRn9KdJuGD+Qi21Ye
 Xdm0vcRkjiW1wmZGwbYBNibs9EepN/xy8lT2Hq0QaNcB+v5Tkpf71u5ALQ2K2BPa7ncN
 dmPJ668nTT3Y/HlnNVFsnnS/YUMTx5rhQhWs+io0iVmSJNqCvNVNGYKYjjXUqqwkd/e4
 E2KxhTRVn+lG4RIhom6WMVwO1JqW0xC6Gnu96k73aLRt1lxZrOQeZRJAoYdIVF5bRiao
 +SWUQkPhhsc6Cx4zATvr6lu2hwpaUgU4yYbSb0M5cUwLeGUxOpWtw9YPFV1868wcLgMs
 FgDQ==
X-Gm-Message-State: AOAM531EkLT2M5U2Y2NLJqyCG4Pn8u2KYlEMCsbsS96byoBEbdU0S0y4
 amdfHhvcJjPAypcKXVg8/67xvkE2WLholWWrfASMDCIGHDEsKLG2pAp/912kHWgDrFPI2UID9xU
 ZBvd8CosEy3ifgqkwe3YA0ma8Jfo=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr2245950ywa.208.1646875635317; 
 Wed, 09 Mar 2022 17:27:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLOgrJRVr0+PC/YH33cow7LKaPz1HPtrIqcE0p2BJPoeM9Y0BKkzM9f+zcVlymVDGi1z/WSCu97tC46p1uB5w=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr2245936ywa.208.1646875634982; Wed, 09
 Mar 2022 17:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220309030440.4166954-1-liwang@redhat.com>
 <20220309030440.4166954-2-liwang@redhat.com> <Yih6yY81TPoiSFHm@yuki>
In-Reply-To: <Yih6yY81TPoiSFHm@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Mar 2022 09:26:52 +0800
Message-ID: <CAEemH2cQAdb51RXoLU_fGSNhuXCrSyfP5OOXUJx1QWGy+ymwNQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib: enhance .save_restore to support set
 expected value
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
Cc: Bruno Goncalves <bgoncalv@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============2072122964=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2072122964==
Content-Type: multipart/alternative; boundary="000000000000367b9105d9d31d23"

--000000000000367b9105d9d31d23
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 9, 2022 at 5:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Patchset applied, thanks!

-- 
Regards,
Li Wang

--000000000000367b9105d9d31d23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Mar 9, 2022 at 5:58 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Patchset applied, thanks!</div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small"></div></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--000000000000367b9105d9d31d23--


--===============2072122964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2072122964==--

