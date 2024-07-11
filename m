Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B6BC3271E
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 06:57:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A734C3CF367
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 08:57:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FC713CBB49
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 08:56:48 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B0DD206515
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 08:56:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720681006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fkPrshtt76j5zD7aJ3R4ebo2DC3hjSR38W+6LABLA5A=;
 b=K2s1NrHQTdeUkDygTgw7BzMnvln7nBSuakmxKEpxz708R4tdSDuT1e5mzQeTHn1RmFL7vK
 BbB7KWCekVwdiRP0imzGisTs7AJSl0MYB9cwU0T1ktLKzHDonjgEmN0rA46hHQq7hDXELl
 yU8tklTuXvcCqubtkMyVMUDmsi7u72M=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-jNX4SP3iP9KEW1qAqIymVg-1; Thu, 11 Jul 2024 02:56:41 -0400
X-MC-Unique: jNX4SP3iP9KEW1qAqIymVg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c96e73c886so535362a91.3
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 23:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720681000; x=1721285800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkPrshtt76j5zD7aJ3R4ebo2DC3hjSR38W+6LABLA5A=;
 b=S1d1ULlOzb1+dCj1rt9aLa4k016c2edvr83865hIvTUWVyx9m5MaaljA+bMQ0Vxw+H
 Tg0p2oGyzl+3N1HeAnHBn+aPcv159KQjxOWJ28edh+RIWhWiGHcLNl5ckTSM2YKtIX1O
 0K03BkK6fmPSWIt01k8LHD1Sj2cOVUomIKQfO2umSxFoswSynvE6zP8oJLMIENm3FpGU
 VXhVBZj6mI7Qsdtt4UWpjYn+QzMN6wHVw50oYZS/2jQE30+wNofdsMnVAXoLWSSsg76Y
 x8pwDlV05Y+4LBA9uJ8+WDu1DbbDOpwPT+wBcj7m1ulhCNTqhittJz2VTSbk2eIA2ReT
 TY+Q==
X-Gm-Message-State: AOJu0YzyTsT036h/2mrMDP1SyHoWxoyxYFflMqg+k5B2XYksH8f1lEnS
 cHuCKscqdkpzQ4QFArGFJNISG/hN8AAdxK2Nd86/POD7iYai7hT6gpFeNYkCStzubbxPCz80GAQ
 tcZYmAMOfh7KX+DpIS/E4FBThKM7Cc0UkwheGoALRstkjS+jzBi4YwEdVM6p1PWX1IVuMlwMD70
 Yf+mFAdpWeOqJiIKd06zcDrf55UcAOfgTyTA==
X-Received: by 2002:a17:90a:a384:b0:2c4:ab32:b71c with SMTP id
 98e67ed59e1d1-2ca35bf0752mr6891144a91.8.1720680999825; 
 Wed, 10 Jul 2024 23:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUV+Pryqh2IHMPnEGftrBivxCOEEntFnn/Z4opvRBVG8RGdiesWAsrTon0hBuOAdBhXRXpa12GGpru83waFE8=
X-Received: by 2002:a17:90a:a384:b0:2c4:ab32:b71c with SMTP id
 98e67ed59e1d1-2ca35bf0752mr6891139a91.8.1720680999524; Wed, 10 Jul 2024
 23:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2f=PzW68A2NzdfM0BDNKRHX4sfytCkzN4oG-USPHuJk9g@mail.gmail.com>
 <20240710131241.193232-1-shichen@redhat.com>
In-Reply-To: <20240710131241.193232-1-shichen@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 14:56:26 +0800
Message-ID: <CAEemH2cQwLEo7jUuhSi2on5DNZr2jjbqnJ8KfOoo0KvV4oN8Jg@mail.gmail.com>
To: Shizhao Chen <shichen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] realtime/prio-preempt: take cpu isolation into
 consideration
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
Cc: Eder Zulian <ezulian@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Shizhao,

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
