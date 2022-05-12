Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413F4C433FE
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:14:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D56F33CA9C2
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 16:14:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AF883CA722
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:05:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B404260115D
 for <ltp@lists.linux.it>; Thu, 12 May 2022 16:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652364301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zN1cZpJufsJv00kzaKVNWT1kK5ZdbwOph9dNysE57V8=;
 b=ZJiiVej9Is7sHuh0HzMo9N84x/5jVW5AMC713DS4NRZmeh6PObPJFlajrVR8nl4V4slfqG
 3WwXZCku2SX8t+705cYzK6vBsPQ1halQpTEB0z7KLmKc8hIQ8otqsRtWM0iqC0VJyv6EOK
 p6nasUhg22Hyjru/n4GGiQWFv6nG+5Y=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-8HCx6zU7OJeiNPbddvnqow-1; Thu, 12 May 2022 10:04:59 -0400
X-MC-Unique: 8HCx6zU7OJeiNPbddvnqow-1
Received: by mail-io1-f69.google.com with SMTP id
 y13-20020a056602164d00b0065a9dec1ef2so3044766iow.23
 for <ltp@lists.linux.it>; Thu, 12 May 2022 07:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zN1cZpJufsJv00kzaKVNWT1kK5ZdbwOph9dNysE57V8=;
 b=C9Ec8NpLKEX7fShd+rqAWhNpSwIlPOGMbj+AFhV3Be2/B6/GlKWThWKSaVRZMk3ROA
 pUbNWsQxv1bUqrVRilwMmwtBssxgnUE7cQkwGcRAHuu/K+yYPXhEnnpjnDtYpv87M+fH
 Zilgw1ZVpY2kn0foyQo7WXFisjw8kiU6VC7TdF4HXnu1fGROJC/sYg9Gx5mo9ddSTXYw
 b7jskSyg1bcoQ/j+pVFo2eZ+M4DlODgC+kJ4UAGI0YFmZv2S6mg7V71NrKPPRFJrAo/x
 A1CME7gJH7pNE4qmvTjZVU9+k1waYqkBhCPuge7ypzydHfaXhRSj2/KMtBshIJZqwgCi
 ZVFg==
X-Gm-Message-State: AOAM533pWynpSmymAetrGLYgYvNRT2GaNiIDmwK4KIJOC7AF/UjJNVAh
 Idb+sWbsxTl7PEwFSapoVw5b1wAuVLaAmNIQAZ8kPX4T48HBqOVUfT6ycVgHXABvjQuzvAaYK0D
 3Vhtl8NUjfZUDmLGrF5KRzzV0UsQ=
X-Received: by 2002:a05:6e02:b46:b0:2cf:24f3:1127 with SMTP id
 f6-20020a056e020b4600b002cf24f31127mr85224ilu.135.1652364298878; 
 Thu, 12 May 2022 07:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQvg5Xkjx173kweDrB8qoLb7eFrPXu7q6KcuYePnqrOEiKxLMW8euSagOWHVce6kqx/3iHtXvo0CYv975fJ+o=
X-Received: by 2002:a05:6e02:b46:b0:2cf:24f3:1127 with SMTP id
 f6-20020a056e020b4600b002cf24f31127mr85211ilu.135.1652364298573; Thu, 12 May
 2022 07:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511021636.2166562-1-liwang@redhat.com>
 <Ynt3c8ks6kkAGs/z@yuki>
 <CAEemH2ftLWEu76r7+7JHmMmHNxeZyrFaZw-BANR62v_0r4LSWg@mail.gmail.com>
In-Reply-To: <CAEemH2ftLWEu76r7+7JHmMmHNxeZyrFaZw-BANR62v_0r4LSWg@mail.gmail.com>
From: Eirik Fuller <efuller@redhat.com>
Date: Thu, 12 May 2022 10:04:47 -0400
Message-ID: <CAF3Th=XPxhF6=g5ZcT1u3D0M9r9ACtYP76JcjGS7CJP_euhqwg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=efuller@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 12 May 2022 16:14:36 +0200
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
Content-Type: multipart/mixed; boundary="===============1665939623=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1665939623==
Content-Type: multipart/alternative; boundary="0000000000000e6be405ded10bba"

--0000000000000e6be405ded10bba
Content-Type: text/plain; charset="UTF-8"

Sorry to chime in late, but do we care about crossing day, month, or year
boundaries? For example, what if we write 23:59:59 and read 00:00:01 ?

--0000000000000e6be405ded10bba
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Sorry to chime in late, but do we care about crossing day, month, or year boundaries? For example, what if we write 23:59:59 and read 00:00:01 ?<div><br></div></div>

--0000000000000e6be405ded10bba--


--===============1665939623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1665939623==--

