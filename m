Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F58C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 08:08:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 344DF3CF33F
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 09:08:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CF433C98E9
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:08:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49E221001260
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 09:08:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702886902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CocnknGzy1OJr2WuguDd+Ryddu5qdvK3Xy3y7/IT6ec=;
 b=AE+UQ24zwoyJbdIhmU2jzocPAVnEla0QySzbnc32lqN4X17j+wLTOYrftJhIS0C592t3mM
 wz/YgyqM5NTunS8NiuC/zn6gcC7pA2B46bkU01j0fsOT+hEue/7oOmewTAFWcY95/HA1LX
 x0ONJGKNiLUKr6w5L1sC+gMXoimrBEc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-kuAVY4FNOM-IW-wJpHGxJg-1; Mon, 18 Dec 2023 03:08:20 -0500
X-MC-Unique: kuAVY4FNOM-IW-wJpHGxJg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e30e33677so744748e87.2
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 00:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702886898; x=1703491698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CocnknGzy1OJr2WuguDd+Ryddu5qdvK3Xy3y7/IT6ec=;
 b=LMVcX8O00gTpKTTnAIx5t1MszvTWwgEkdNKPb4ATND0U7UAsPfoDOF9W/tEu+vP6Wa
 f5ju3QuCroRqywbkxKQxoW06TJusB13+X4IA8dgXwHsdeDxe2yeiB2QQfQUjb7ONj6t7
 ix4g2JUSKnKoT1mtGPbjErsQmcBj908P0f3ihdMm/ZkTsUSQA1Ej7jXNQor0rvuT/Dnp
 1hYS8Q/9WDM6yLgn/6tvgiW8yw9QG0Bt0DAo/slgCSOYFbL+xnRYFAgyQlOVO8BO67+h
 5+cOc20BiU41733aqxANP/fPQJ1pBIiK0UHjW9cPLiE1bB9b9vd4FklSY2QNcrOO0Obc
 meaQ==
X-Gm-Message-State: AOJu0Yz88Zrg58aUOwfkd55QGZLFjApKO/wR6xK/2PR7lCk7RVI4C90Q
 YgtmjoFun9dPWTAGgBv+TTBgEAWmHTfxudnPwmkAd4fw0+4cKY9QjCXcrA1WEgwwgs07um8ItIC
 rl5nGC0fvxu+aCTU25pFFklGtfUdyC20FdLX1XQmF
X-Received: by 2002:a05:6512:3056:b0:50e:16f4:5925 with SMTP id
 b22-20020a056512305600b0050e16f45925mr3578609lfb.112.1702886897893; 
 Mon, 18 Dec 2023 00:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzL4RcHVim6LJKam8wtnEE+Lq0l/PCLfIOsAQsBvK0n7dVwof3B76ZKgSEs9CvWshMZc5q0oXiH8+HQWtb/xs=
X-Received: by 2002:a05:6512:3056:b0:50e:16f4:5925 with SMTP id
 b22-20020a056512305600b0050e16f45925mr3578605lfb.112.1702886897606; Mon, 18
 Dec 2023 00:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20231215130609.14122-1-pvorel@suse.cz>
In-Reply-To: <20231215130609.14122-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Dec 2023 16:08:04 +0800
Message-ID: <CAEemH2c=nsC8rDVmQ2btqFC8P4VY8F-rfaHF6hE_bHntDs0Bpg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] runtest: Merge runtest/connectors to
 kernel_misc
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

Reviewed-by: Li Wang <liwang@redhat.com>



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
