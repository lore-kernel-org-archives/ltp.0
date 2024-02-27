Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D67C5478C
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 09:13:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91233CEF12
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 10:13:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D532F3CB62A
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 10:13:33 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7AFF9601BCC
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 10:13:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709025211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lG72ubeWdH8+p3sciCmnD52BqR80+m1M8hC5VTN+++w=;
 b=ZAddQSf1Qr28RgGmxA72y2aFIo/bmRoHOclhiN1bX1YNb4IyAhA2VO/FEH9JVClb5vRDBt
 42MwpjpRwapHEU59lkAZJIblAa2Iem357WKc4IdCFHWiPejTQ+JzTO81BdA0Lk5dHWildZ
 et+S+yKIsl9vTZyh/SkUq6/wVAxp9b8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-8aUpqHzINFOhTlbq1aP99g-1; Tue, 27 Feb 2024 04:13:24 -0500
X-MC-Unique: 8aUpqHzINFOhTlbq1aP99g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29a9f042643so1221716a91.0
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 01:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709025203; x=1709630003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lG72ubeWdH8+p3sciCmnD52BqR80+m1M8hC5VTN+++w=;
 b=ATD65Q4EyOfM1QT8gZv49VnL5Ppa2JQf2ibSvxwxyYcB7BT2n2LsgJDYQXmoNgBHmd
 35/h9i3LGlmbo7/TGBtXPaJkww+u4q8P+uP2j56/d+6AorUorEQEMLSprba7oNIW8TUq
 TtKPWAsSAiUDy3gs52TqtnqkAdBrWG7XYARd6vw2i5qgtBzLGRWeW+GhgihvLDUViceO
 Gu//xf2DSXsEDM8Hw5JtVbd2NSPnZJh/dbgoYa7u576pU25Pj0LQM2xMmIMgXXSfksyL
 TFwRLdVnEv2Ti/YKwuIggWcidhvBBJ+6pmqg+25ywFfgNSc/0TmMG9nrIdOXA4HENT4d
 CdIQ==
X-Gm-Message-State: AOJu0YwnNkUwnDGgo/zzO6yoDVnWsDIciyfmHekOQIIwJuRah6ji5Czj
 R8XEaSgUEJzuGmo588OmUDiWkI+ns4xDslczf866BBfwlxTXC0Hd+dzh1v/kFbkT4sXlcms+iDN
 uOlUORXNGzCUa3q8h1y4R7COBilPnW2eWmo5Gxr0N4nICfs7EeQ7pbX6TppOfLVkyyYQgqT8f25
 gji8Wk7Zp6Gog0NUyvkmauZFQ=
X-Received: by 2002:a17:90a:940c:b0:29a:9c12:785 with SMTP id
 r12-20020a17090a940c00b0029a9c120785mr5604455pjo.1.1709025203543; 
 Tue, 27 Feb 2024 01:13:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvfQppb6KcN//UER47RSh8UJ1Sxh4EKtIOmx6cAKmtnItwaQA+FJc4R8yIc/50D0To6GonnkGIg4QWcGy3K1k=
X-Received: by 2002:a17:90a:940c:b0:29a:9c12:785 with SMTP id
 r12-20020a17090a940c00b0029a9c120785mr5604443pjo.1.1709025203219; Tue, 27 Feb
 2024 01:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20240226135336.19733-1-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Feb 2024 17:13:10 +0800
Message-ID: <CAEemH2cpcrPw321Jwe49U=UNGmvVmQ7OKOKzB2LnjPrdT5Qakg@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 1/7] libltpswap: Add tst_max_swapfiles API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu, Petr,

The patch set generally looks good to me.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
