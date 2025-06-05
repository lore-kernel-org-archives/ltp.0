Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7A8C5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749090554; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jCj6Vi0T4tmw+aD+QXhdWF15J25SS2MxUYa6ElqdM1Y=;
 b=Hvj3+HVNmtHqZOYAWXVD9iW60FNCiXkBykvAM+Tizehts9uDm6x/DiiqSQKINMzfDWr2O
 eCpcfzTkyitGjj3qhVdqR6cMKVR+gcokpUiw1YD99WfDpRjy4mi41/GjXUDVRMtcUvmu3nN
 q8o46oBYpEZFtoqVtn+l0B1YH+nYoAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C716F3CA200
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 04:29:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB60B3C91D9
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 04:28:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2999820651D
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 04:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749090531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VcU0MrdXOTP8PBRjJcoXgZ03keZ3E/IWGcmqvCCJ/F4=;
 b=J8RPzsJ+Jq8L+P46oKdzsch/TR1K0TaOkl1CApFFfHaZOK5Y3WCimG1rf7ztPV8H0hAji6
 9JzDIjVK4AgtxFd8N953l/Bx0Jy8GSR1lwHTGPYzeCfHLbvWzGOByu1SHSjhIh59tn4oM+
 +nJ5UCYEiQmgoe0JQ49U4IB5Y7OA+oI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-1cl3V9UhPOeGwnTVIsbXqA-1; Wed, 04 Jun 2025 22:28:44 -0400
X-MC-Unique: 1cl3V9UhPOeGwnTVIsbXqA-1
X-Mimecast-MFC-AGG-ID: 1cl3V9UhPOeGwnTVIsbXqA_1749090516
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac3e0c1336dso32009266b.3
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 19:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749090516; x=1749695316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VcU0MrdXOTP8PBRjJcoXgZ03keZ3E/IWGcmqvCCJ/F4=;
 b=GEeQuMwxuCfKtt6eh2wW3uR3sGRRhMO/sjDrf0oH0hXz0c0M6Z8Ih1wgwX41WxotIT
 D1OtacLim27T9FXwZG/1xvRJwvFBKRjqWeQLjY8k6mFZ3oDUMYNsK8vJGB2SBA9DONLJ
 PuoGP5npVCZJKi6OQzd68yB3bdBGP2cT2CakWxaSObsF01vGd6nOhXEPZL5VvGIqTsQ0
 FYw9Avm3RPBfKl9N1SKyZi9XyVtOBQfwf0B+blAMWp10TYuveYhozTSipu4KjyomRxEE
 qSGxF8vSlNdiOaczFLswPmmTlg8kEuSyI/IIP/aGwrb1SK2wC9iSywdlNv6g4+AIoA2d
 UM8g==
X-Gm-Message-State: AOJu0YwiKLqqF47DTSaTXZr7x/etuNiSqWTRWV/nCHcQTdc1/UumRxDm
 aqxF4/QBq3rr0lWMFpYijaQ237xnpAnYHby5OH1nZEbh9Y2QlfMr2w2xa0rjFPXvLXUotzDh7h4
 vF60ToCmCw2Pw+M6kilhv7hZW9v/8vrHvXA56hv8IEbW9iDVVROz6FfRchs90tzj3vlwmO4Ot34
 CfXEfPKB9bEaa0+AWK3FL/ahM/gL4=
X-Gm-Gg: ASbGnctHrfk3UyMq4/P0SPzWYe0bKoJuv4gAGaaVwq6SToraFHad/XXE6w3DF5BsE4j
 +ktb0/FmPl+SpFltrB3SjxqjejFOl84OZFNPmJIWp6hoc3gHAn3LB8lYehFrN/471VgT1tg==
X-Received: by 2002:a17:907:1c16:b0:add:deb1:d84d with SMTP id
 a640c23a62f3a-addf8cac9f9mr480487066b.1.1749090516512; 
 Wed, 04 Jun 2025 19:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt1Jn9409wcuPaoQNfRsZl6OtffzmqjJvch+2E24n817wNcdXPhSBUUm85hfyXuYYsSvP/p16fXpLHk2wAxbg=
X-Received: by 2002:a17:907:1c16:b0:add:deb1:d84d with SMTP id
 a640c23a62f3a-addf8cac9f9mr480485966b.1.1749090516125; Wed, 04 Jun 2025
 19:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-2-liwang@redhat.com>
 <aEAVs1f914nxVD9U@yuki.lan>
In-Reply-To: <aEAVs1f914nxVD9U@yuki.lan>
Date: Thu, 5 Jun 2025 10:28:22 +0800
X-Gm-Features: AX0GCFsYZH7wEJsCWK5iXQcKQ9nJDaCiYWxOWETSs3Eo9BCUU_v4lEQoJzaN9Bo
Message-ID: <CAEemH2dbYCm3M3AqCREhNmRoye6me7d4Ov4EUhxrwMHw_sdVDw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qcPGB7VLgQXgB0zk3yvw11OzSAMRWQ98I_LjuDR1HNw_1749090516
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/2] lib: rename tid to tcid
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Thanks, this patch 1/2 merged first.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
