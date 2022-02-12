Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6882C433F5
	for <ltp@archiver.kernel.org>; Sat, 12 Feb 2022 02:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0E993C9F45
	for <ltp@archiver.kernel.org>; Sat, 12 Feb 2022 03:19:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 424E23C0F5D
 for <ltp@lists.linux.it>; Sat, 12 Feb 2022 03:19:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EC88602210
 for <ltp@lists.linux.it>; Sat, 12 Feb 2022 03:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644632357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Flxgp4EcreB26Mk6B5kXNTLCDOrLzZbEhAjulyvYQKs=;
 b=G/zpOg363XXNhjslR7ST3onNXAGjNyZXyuDiGL9mYCtg1El8tDsjpo6wN88fBTsz6XB9zD
 2pdOccKbBgDPl6fuqBTUYZZ6pcglCmU8xv6wplN+xn6wR4isOBOnFHhgB33Mi9GnZ10RYl
 wiIv2V32jYtn4wGW7oYGow+mR8WTW0E=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-P3MdJbiqM2eJac6iMIChDg-1; Fri, 11 Feb 2022 21:19:14 -0500
X-MC-Unique: P3MdJbiqM2eJac6iMIChDg-1
Received: by mail-yb1-f200.google.com with SMTP id
 k7-20020a255607000000b00621afc793b8so2076547ybb.1
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 18:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Flxgp4EcreB26Mk6B5kXNTLCDOrLzZbEhAjulyvYQKs=;
 b=D8hDSbnSXZWXLODVhtdxJc8AF5iI+uLewcuRU8AidSWZXFU5HYchm4z+KQ1fmg8XMy
 4ohopiGqDwQJrngNEItb0isyRKOiSqGZmx/fVZtmg6hLoyRpO9Xm/Vi/Mr6uwQFyZasq
 ctEFMZTqonnpiHpoLVrbDyWFQymTEeLmPoWVdPDmlzWJ8hsBWpcwXUMHlH4aG9isWsTC
 d87yDuSoDml4saOHHLPhGuTRnI3R6zFAKcM5kbJXlEKtTbpE6IOdAdii8g9DXeWs2UkG
 hWxpAgf7602uEKYAb0KSmnU+yTewDlzMUT5gSKQf4kS3dPqoM4VFR0B2NyUzhAzHJOY9
 iLhA==
X-Gm-Message-State: AOAM530zfeakU0L/tXo7QGtHgSh9xjHY9E/YLwfeqmW4LwJtKQ+kkVVV
 CHPfLXo92k3P2iQYGnejYzDuZ1toTk4LGFbnCen/SXmbgCg33AKTQs6XNthkaY6wMLAl0p+GbZo
 5W0OQ5DuBwuWRl5H9KtYzOPZo6kk=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr4224492ybt.398.1644632353862; 
 Fri, 11 Feb 2022 18:19:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLctmpd/5lpc3AJNVIIYv7029cn3gMHORZclQtzbEaTyfpiRjlzYQ5HmOAb/pn9rAg+ch5BWOgK3mB7WbyMoU=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr4224487ybt.398.1644632353673; 
 Fri, 11 Feb 2022 18:19:13 -0800 (PST)
MIME-Version: 1.0
References: <20220210133812.13368-1-bogdan.lezhepekov@suse.com>
 <YgU5QvQnzmcCgKq7@yuki>
 <CAEemH2c71jsd5VDZ05pCEGJMHtdxK2_T2MXaK5P73qttBd-gLQ@mail.gmail.com>
 <6205BA38.7070903@fujitsu.com>
 <VI1PR04MB49587421680CE7C6AA8599CD93309@VI1PR04MB4958.eurprd04.prod.outlook.com>
 <62061EC1.2040206@fujitsu.com> <YgYlYoi0AC1flHlT@pevik>
 <YgZhjLc4u+Xb6Y6e@yuki>
 <VI1PR04MB4958065F19BD86A04E7A711893309@VI1PR04MB4958.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4958065F19BD86A04E7A711893309@VI1PR04MB4958.eurprd04.prod.outlook.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Feb 2022 10:19:00 +0800
Message-ID: <CAEemH2erWSta1seG8_T40078SNRtrKNrePvxGs7pzAhwyMhwfQ@mail.gmail.com>
To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem/swapping01: Make sure swap is supported by
 kernel
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
Content-Type: multipart/mixed; boundary="===============1218211001=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1218211001==
Content-Type: multipart/alternative; boundary="0000000000003a272205d7c8cf5a"

--0000000000003a272205d7c8cf5a
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 9:16 PM Bogdan Lezhepekov <
bogdan.lezhepekov@suse.com> wrote:

> Hi,
>
> Ok, I will send out a new patch.
>
> Do I need to update syscalls/swapon/swapon03.c accordingly to make it a
> pattern?
>

Yes, that would be great to have. Thanks~

-- 
Regards,
Li Wang

--0000000000003a272205d7c8cf5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 9:16 PM Bogdan Lezhepekov &=
lt;<a href=3D"mailto:bogdan.lezhepekov@suse.com">bogdan.lezhepekov@suse.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">




<div dir=3D"ltr">
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Hi,</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Ok, I will send out a new patch.</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Arial,Helvetica,sans-serif;font-size:10pt;color:r=
gb(0,0,0)">
Do I need to update syscalls/swapon/swapon03.c accordingly to make it a pat=
tern?</div></div></blockquote><div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Yes, that would be great to have. Thanks~</di=
v></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></d=
iv></div>

--0000000000003a272205d7c8cf5a--


--===============1218211001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1218211001==--

