Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070AEC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 05:44:02 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CF86058D
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 05:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20CF86058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A12B3C6758
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 07:43:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76D343C2A3D
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 07:43:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3A9FD1401232
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 07:43:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635227026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+5sLBPTmT9TRALDnHUfzg8tbPisMf/w8OyYg6B9Qug=;
 b=QmnQTVzT7zeps35f1Dvrzhcx+3GfTKej4d36o1bGudr3zbo5YQF9ChngngPpXv4dAIsP2p
 fJv9VxXnG+K19EXdVALlXoIsONPnMhWSnUFLX8X9stCjdQYBXKaPl0n5LFY41PI5IwWWHZ
 /O90OXfFHiRVS39KuWFOL4xytRAxX6s=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-QEkAu9pzOxyOHpMYLo6SWw-1; Tue, 26 Oct 2021 01:43:44 -0400
X-MC-Unique: QEkAu9pzOxyOHpMYLo6SWw-1
Received: by mail-yb1-f200.google.com with SMTP id
 f92-20020a25a465000000b005bea37bc0baso21209865ybi.5
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 22:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t+5sLBPTmT9TRALDnHUfzg8tbPisMf/w8OyYg6B9Qug=;
 b=kxW5rbZAdaC+oQpjZT9Lpkeq0lWjUIBuqzD+54QZo99SELFHenkDX+W9wi9PHq0e4l
 i47n2GSTFNGoPImeP28cjB0ylRYvanFtcW1CrLFzGf6BQnbODUqqYcH3jHhCQ8Wh8U5v
 Oi5RwMhf4yCukzeFRC1KVycXlMArf/j4b+CvTXOP/xUgwP3MIYqASGuJRr1kna8b+41C
 h5EFEGSDSqnL5PljpWGoY6hvjhw2YHbZ/uDy5tepnO2U/SCx3Z2gJEHZZUFtsqg/gJSZ
 Rv41ZDWL8yWXxRsfUi8xHZ7GqSNb7QVguGtubtnV3fSShr/QYux4C4rt/kzZB/pAaSZ/
 wxXw==
X-Gm-Message-State: AOAM530HJXKTl0UbPY8cwXz32cCOddaIFKt8uOfA324DI1vQbGEZV4zU
 gjM2uYnts4ZdbXoSHhBpM1HcXIhgSBNixpKQJNcbreKSoWEfj0gv7r+eUBot211sqLKQM/ZEnkl
 R6sgcIZZ6mouOXrz59OyfAGfZsXo=
X-Received: by 2002:a25:b4c:: with SMTP id 73mr1842421ybl.316.1635227024319;
 Mon, 25 Oct 2021 22:43:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+JrEIDQBBaQ0X5khjxNFma/uhkmEIELghv2RsiTo3RTqPFOoxq8UPvbYYEBW1YnlSEKTY/8do4Oik8c8igm8=
X-Received: by 2002:a25:b4c:: with SMTP id 73mr1842410ybl.316.1635227024114;
 Mon, 25 Oct 2021 22:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211026052849.25944-1-tangmeng@uniontech.com>
In-Reply-To: <20211026052849.25944-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Oct 2021 13:43:32 +0800
Message-ID: <CAEemH2czvJptg3w-4h6nrKasbqtjJQF5BvhQWt5GGXpQ1+KF6w@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1107426866=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1107426866==
Content-Type: multipart/alternative; boundary="000000000000e65c1705cf3af5f8"

--000000000000e65c1705cf3af5f8
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 26, 2021 at 1:29 PM tangmeng <tangmeng@uniontech.com> wrote:

> Signed-off-by: tangmeng <tangmeng@uniontech.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000e65c1705cf3af5f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Oct 26, 2021 at 1:29 PM tangmeng &lt;<a hre=
f=3D"mailto:tangmeng@uniontech.com">tangmeng@uniontech.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: ta=
ngmeng &lt;<a href=3D"mailto:tangmeng@uniontech.com" target=3D"_blank">tang=
meng@uniontech.com</a>&gt;<br></blockquote><div><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"m=
ailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div></div><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e65c1705cf3af5f8--


--===============1107426866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1107426866==--

