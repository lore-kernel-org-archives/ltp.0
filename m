Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B1ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 07:35:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2683CA946
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 09:35:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1A6A3CA8E3
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 09:35:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B46971400BDD
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 09:35:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662363320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ighq6d5ySoBXxxIDJwC6ZPBanyRM/5VzkK0dvOdEdD0=;
 b=OcXIbm2WsW0g8pGuvQ6FH5weWMFMZQmKmwnwVGn2wTB4Cm7+5KvQwGxpf+UI5caKaU2nkN
 TKQfHQMoKvUosyk0dqU0IYUhxMdUjKaHt4sE7DyBY79aVIkeoFhclhcMlSmXK8s6fJ663P
 AXjIlvXPI0aIOqCxz/RcD5xUJvxeDys=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-RfBvM7-sOFetnYcrcAtbXw-1; Mon, 05 Sep 2022 03:35:18 -0400
X-MC-Unique: RfBvM7-sOFetnYcrcAtbXw-1
Received: by mail-vk1-f199.google.com with SMTP id
 k193-20020a1f24ca000000b003944ae1ce48so820271vkk.2
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 00:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=ighq6d5ySoBXxxIDJwC6ZPBanyRM/5VzkK0dvOdEdD0=;
 b=jtuDlzcDXpXyhceSY5Wo34J1IJ+VKpt+wmBfK8KG72EbU90dt8Q55w401m7Oqisa3p
 Yn+9HYEJp+VHx65KtN6tr7Xi2GB0nujGAxsaXhlJlvCiq9f2/fX/+4pj1f9xWNYCWGbG
 g1nNeWYyfZOtHb+B2AgQUrwySupkpONUcVMoYUEq6Bs98D395Bixxbf8BJhQ01vhfQEf
 cLaMn9rrQD/6P4PR7ThByJVTH26fNAmUvakToDbzaEY8HeV2LdLoJBadgLR3EkOmH/E/
 xTKiUiH/l1oCJ2zIWYYDVtWZXIIGuyJHwlFiDXO+ZO0w3oucJedLAjiDZDPNiQ38zjom
 wYBg==
X-Gm-Message-State: ACgBeo1Gg3T4ig3BX8ZZcOt8gxkv2TZYxNBF/kyzHJsm7rSKaPZ/xwzL
 VSSkjoFZvT3zCtWBTZNCYhQAjUBelJJwQKDKYTGJjfBCuSFzzb9/8FXsJ8GilSs1fbkYwHLPvhN
 UVtonLbZp9mC4xkA3yMqU4C7l8kY=
X-Received: by 2002:a1f:2109:0:b0:394:5a0f:4402 with SMTP id
 h9-20020a1f2109000000b003945a0f4402mr11653016vkh.32.1662363318069; 
 Mon, 05 Sep 2022 00:35:18 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gUtK13rEC0kvSijQHgQh5t/M43grqYXKxc2DLnUC/oCcWgRAnxhnPUfROa0+PO0Vi7D6sxFx54EYGCjLA6F0=
X-Received: by 2002:a1f:2109:0:b0:394:5a0f:4402 with SMTP id
 h9-20020a1f2109000000b003945a0f4402mr11653008vkh.32.1662363317824; Mon, 05
 Sep 2022 00:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220902133710.1785-1-pvorel@suse.cz>
 <CAEemH2fetx7L+B+=YTsNH=8QR+292s9w+LuRnJBM4nu8UkrR9w@mail.gmail.com>
 <YxWfm7Hi/XA3LjuX@pevik>
In-Reply-To: <YxWfm7Hi/XA3LjuX@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Sep 2022 15:35:06 +0800
Message-ID: <CAEemH2dTbao90ix1bLotXoMwVByM=z5Co9enkn2wADm8WED=AA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] shell: df01.sh: $TST_ALL_FILESYSTEMS
 (.all_filesystems)
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: multipart/mixed; boundary="===============0251699216=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0251699216==
Content-Type: multipart/alternative; boundary="0000000000000c098e05e7e91fa1"

--0000000000000c098e05e7e91fa1
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 5, 2022 at 3:05 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > Hi Petr,
>
> > The whole patch set looks nice!
> Thanks a lot for your time to review!
>
> > Btw, it might be great to wait for the series patch set of
> > "Track minimal size per filesystem" and merge together
> > in case this can't complete test on XFS.
>
> FYI I marked patchset "Track minimal size per filesystem" [1] to changes
> requested,
> I have WIP version which will track set size for .all_filesystems based on
> max of all supported filesystems (as we discussed).
>
> Because these two patchsets
> modify the same files: lib/tst_supported_fs_types.c,
> testcases/lib/tst_supported_fs.c modified in this patchset in commit
> "tst_supported_fs: Support skip list when query single fs" in will likely
> be
> changed in "Track minimal size per filesystem", I can either merge this now
> (probably simpler) or sent big patchset which implements both.
>

Ok understand, feel free to merge first for convinent
or post the latest [1] based on this patch set.

I will help to test them as well.


-- 
Regards,
Li Wang

--0000000000000c098e05e7e91fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 5, 2022 at 3:05 PM Petr Vorel &lt;<a hr=
ef=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
&gt; Hi Petr,<br>
<br>
&gt; The whole patch set looks nice!<br>
Thanks a lot for your time to review!<br>
<br>
&gt; Btw, it might be great to wait for the series patch set of<br>
&gt; &quot;Track minimal size per filesystem&quot; and merge together<br>
&gt; in case this can&#39;t complete test on XFS.<br>
<br>
FYI I marked patchset &quot;Track minimal size per filesystem&quot; [1] to =
changes requested,<br>
I have WIP version which will track set size for .all_filesystems based on<=
br>
max of all supported filesystems (as we discussed).<br>
<br>
Because these two patchsets<br>
modify the same files: lib/tst_supported_fs_types.c,<br>
testcases/lib/tst_supported_fs.c modified in this patchset in commit<br>
&quot;tst_supported_fs: Support skip list when query single fs&quot; in wil=
l likely be<br>
changed in &quot;Track minimal size per filesystem&quot;, I can either merg=
e this now<br>
(probably simpler) or sent big patchset which implements both.<br></blockqu=
ote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Ok understand, feel free to merge first for=C2=A0convinent</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">or post the latest [1] base=
d on this patch set.</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-size:small">I wi=
ll help to test them as well.</div></div><div><br></div></div><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000000c098e05e7e91fa1--


--===============0251699216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0251699216==--

