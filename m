Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA42C00140
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 10:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE7FB3C9442
	for <ltp@archiver.kernel.org>; Fri,  5 Aug 2022 12:05:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5F713C021D
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 12:04:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 273222009DA
 for <ltp@lists.linux.it>; Fri,  5 Aug 2022 12:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659693889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRISR1ny+hs7XZrga6g8Pfg7pNkVCoT7rRcyTqGgldk=;
 b=ZL97LTrRcu8P5LKWC+oJCsse9gTp+Owr26H9QaQBTeid3i2mg3Eq3VQxp0EiILlVh7Rg1D
 ULXWD558vIYFj1v5eD+vNR+nqRzIGoGXAYwWNaU5fgapIQ4x0fovDJMToSo46Kvb04B2ue
 bN6nCJAgiJuLlHb4P1B3zEYXdgYYuJw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-ACOn7m10McKS6nGLmWHotg-1; Fri, 05 Aug 2022 06:04:48 -0400
X-MC-Unique: ACOn7m10McKS6nGLmWHotg-1
Received: by mail-yb1-f199.google.com with SMTP id
 s186-20020a255ec3000000b0067162ed1bd3so1707735ybb.8
 for <ltp@lists.linux.it>; Fri, 05 Aug 2022 03:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DRISR1ny+hs7XZrga6g8Pfg7pNkVCoT7rRcyTqGgldk=;
 b=zXxqPEn5l1R/RGcsrcT3WhVdBuvXbeJ5a6YiDEPAqlTNU3NcwD5bjeFgFzsk2b4Rfm
 CEfA5d7SfHSXM2wQokhzuQ5diA+noN1DLacN0lpT5pvzDzAuxRXCzk/rTsr4ScrQYKvX
 qlOzOyeb83QQzTFeagREZOGCw+BE8wpXJWI0vT1iEQKGMcp5Zemr/nngFWg7l834O+cS
 87Tg7fdjiNnTEFfntuUIkeSc58i9V/zIhFecIcG/btuGuMt1MOmP9JF1kuyzX1w2NJRJ
 FYIdpx/CwB4SlGWNQeXyYvflr8NOpOBcwaCzjVz9UJKXOqD/oCz7VmE8hBJmFQRKucq3
 dskA==
X-Gm-Message-State: ACgBeo2NlufEIwRMwjoC0kZ/4HMiQWU3tNCdu1v12gkLWucKPAE+EPml
 eec4DI4bVV34+2TYsLH5W8ytM++SCOXNhGLfuHHr6b10OmPNAq5518yVApy4ZvjHJtxEMbgewWZ
 qz5lfOPUZMt/O91ZIIqfjYR4zcsQ=
X-Received: by 2002:a05:6902:724:b0:67a:3d6c:213d with SMTP id
 l4-20020a056902072400b0067a3d6c213dmr4781145ybt.461.1659693887667; 
 Fri, 05 Aug 2022 03:04:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cks6OFXN63B4vXAGC10KE3CZVmj5OpcMRA/gEFAPDYtK9D13kKJjAEbqt+jnja4xyX9fJQhxZmWKY8D6qvP4=
X-Received: by 2002:a05:6902:724:b0:67a:3d6c:213d with SMTP id
 l4-20020a056902072400b0067a3d6c213dmr4781130ybt.461.1659693887373; Fri, 05
 Aug 2022 03:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220805063401.1647479-1-liwang@redhat.com>
 <20220805063401.1647479-2-liwang@redhat.com>
 <YuzDY8Lg36lCXlEe@pevik>
In-Reply-To: <YuzDY8Lg36lCXlEe@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 5 Aug 2022 18:04:36 +0800
Message-ID: <CAEemH2dKyjLw4wH+yeMXyv6QLHyTLWbxxSeHpyuUBjDiFUhFOQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/pidfd: adding pidfd header file
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
Content-Type: multipart/mixed; boundary="===============0393043894=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0393043894==
Content-Type: multipart/alternative; boundary="00000000000097dcd705e57b98d7"

--00000000000097dcd705e57b98d7
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Fri, Aug 5, 2022 at 3:14 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> obviously correct, thanks!
>

Patchset merged.


> BTW if you wish to use rawhide in CI, we can give it a try
> (could be reverted to fedora:latest - i.e. the latest release if got
> problematic).
>

Thanks, but I'm not very passionate about enabling it, as we now have
ltp quick test on fedora-rawhide internally(RedHat), but obviously that
consumed people's energy on debugging *temporally* failure[1]. I'm still
thinking if that's worth it.

[1] some of them disappear after code-rebase or package upgrading

-- 
Regards,
Li Wang

--00000000000097dcd705e57b98d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Aug 5, 2022 at 3:14 PM Petr Vorel &lt=
;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
obviously correct, thanks!<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Patchset merged.</div></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
BTW if you wish to use rawhide in CI, we can give it a try<br>
(could be reverted to fedora:latest - i.e. the latest release if got<br>
problematic).<br></blockquote><div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Thanks, but I&#39;m not very passionate about=
 enabling it, as we now have</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">ltp quick test on fedora-rawhide internally(RedHat), but obvi=
ously that</div><div class=3D"gmail_default" style=3D"font-size:small">cons=
umed people&#39;s energy on debugging *temporally* failure[1]. I&#39;m stil=
l</div><div class=3D"gmail_default" style=3D"font-size:small">thinking if t=
hat&#39;s worth it.</div></div><div class=3D"gmail_default" style=3D"font-s=
ize:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small"=
>[1] some of them disappear after code-rebase or package upgrading</div></d=
iv><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div di=
r=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000097dcd705e57b98d7--


--===============0393043894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0393043894==--

