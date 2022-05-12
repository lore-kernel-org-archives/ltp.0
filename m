Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A57C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:24:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5895F3CA9DA
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:24:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF37B3CA722
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:24:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EABFB1A01101
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652365466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fJw+9jFRx9rSe5zwofjBt/axQZVvIbgIEPnIYuALgUM=;
 b=I7ZJKfXcDcscpZCg9SKnEgxnWs+TxSZpJo8+v/Rj9FyIt/GowD8L/DB5VKEDbdfeKAhqXT
 WBrEzR0VaCsRCmekjSTGAT3PEyK8Szi0iuqpEXhpaLTadmuL2gxfynFivzYIjDAkBKuR59
 REAuSBbycb5CVy4rfsDJEUuBXmcg0hk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-TmkMt-Z5Oz2X-Lr7CsJNTw-1; Thu, 12 May 2022 10:24:25 -0400
X-MC-Unique: TmkMt-Z5Oz2X-Lr7CsJNTw-1
Received: by mail-il1-f198.google.com with SMTP id
 i15-20020a056e0212cf00b002cf3463ed24so3387069ilm.0
 for <ltp@lists.linux.it>; Thu, 12 May 2022 07:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fJw+9jFRx9rSe5zwofjBt/axQZVvIbgIEPnIYuALgUM=;
 b=ZY2UBfDQFianio/Y2HlfGG0Juh5Em7KQoOyo1NYJOm/NF7cvH7kDW6NQ9hVnoeT+VI
 CBQa3yKsiUyXQ9Y4ir2b6qFv7UawYee4Yi+u4rg1oPVvax6VrV1ST506fut5RJXP/AnC
 q6jgT6mpJsa0UBhgX7N+p6Ay3oCuE49hVhtQXeHkRS7ihIum/O0RIOY9XvjxcSsoup5R
 hW+hn3CGnz99niS3RB4FYkX3eKyxYBLw0VZtwcPPKd2V/6QvOm3rMxk1GfdUB4C3P/WX
 cijTVev8dSNlpPrbmJVsL+3N0u/qDkaV8NBOhryqN6L0uO5/IQ/wb3ux5TodjWDCEwGj
 qidg==
X-Gm-Message-State: AOAM532rQ0pHS3rHGQTeWI+3FEOpcXez/p+YC8ZXIzEjEfI8g+fV3yhS
 d+pKwqILoMBiLgs46hPeBOUlFfrUAz6C7efU8xC4ArG8UdBYlq2gXo/pm96RGMdduhEc1VjPCsQ
 tKCkl/E+xM36fMz880rXTK0tm9hU=
X-Received: by 2002:a02:9f1a:0:b0:32b:4f9:79fc with SMTP id
 z26-20020a029f1a000000b0032b04f979fcmr89940jal.287.1652365464585; 
 Thu, 12 May 2022 07:24:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXT+nAdaBXWZQY35xC0++7iWefa39IwTZPuctwtIb3ahOdwuNoeUMZSITTaFi7eOWbp9eXkkplEAUK1kECVnM=
X-Received: by 2002:a02:9f1a:0:b0:32b:4f9:79fc with SMTP id
 z26-20020a029f1a000000b0032b04f979fcmr89928jal.287.1652365464270; Thu, 12 May
 2022 07:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220511021636.2166562-1-liwang@redhat.com>
 <Ynt3c8ks6kkAGs/z@yuki>
 <CAEemH2ftLWEu76r7+7JHmMmHNxeZyrFaZw-BANR62v_0r4LSWg@mail.gmail.com>
 <CAF3Th=XPxhF6=g5ZcT1u3D0M9r9ACtYP76JcjGS7CJP_euhqwg@mail.gmail.com>
 <CAEemH2carO+D5d5hZJcHWwp0hgy9sgEv3YMOjFi12TCXeh5o+w@mail.gmail.com>
In-Reply-To: <CAEemH2carO+D5d5hZJcHWwp0hgy9sgEv3YMOjFi12TCXeh5o+w@mail.gmail.com>
From: Eirik Fuller <efuller@redhat.com>
Date: Thu, 12 May 2022 10:24:13 -0400
Message-ID: <CAF3Th=V4V4WXXkaS-J41fkN3m3ct1CT5Px_1xtkr13uVg3v9Kg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=efuller@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1302712283=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1302712283==
Content-Type: multipart/alternative; boundary="000000000000898a6005ded150dc"

--000000000000898a6005ded150dc
Content-Type: text/plain; charset="UTF-8"

> It's impossible to get time crossing day/month/year (or 00:00:xx)
> in the clock unless a new bug is happening.

Yes, sorry, I should have read the code before replying :)

Thanks!

--000000000000898a6005ded150dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div class=3D"gmail_default">&g=
t; It&#39;s impossible to get time crossing day/month/year (or 00:00:xx)</d=
iv><div class=3D"gmail_default">&gt; in the clock unless a new bug is happe=
ning.</div></div><div><div class=3D"gmail_default"><br></div></div><div cla=
ss=3D"gmail_default">Yes, sorry, I should have read the code before replyin=
g :)</div><div class=3D"gmail_default"><br></div><div class=3D"gmail_defaul=
t">Thanks!</div><div class=3D"gmail_default"><br></div></div>

--000000000000898a6005ded150dc--


--===============1302712283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1302712283==--

