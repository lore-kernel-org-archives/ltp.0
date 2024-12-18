Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BC8E77183
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 03:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F5233ED117
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 04:23:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 887C63DFE33
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 04:23:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8BEA615036
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 04:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734492215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fqXfYMIOzpkScA7UAQI7/Zm90VHp+1dIatcBI0kU3as=;
 b=imPg2aS4rdDg9YWwDS4jH7r4X1KCIGilV3tNnIicsgUMP9lG8Xc2KFuJwroVTQq16qvGcy
 EQeCertRHBlHbJCcUc/EFf+x0qCDA7o2xvrCXXNd6OtVSsGzxYp/1HfVeMXr5Lw3inqWWO
 tuk2cbV6Vk+846scxqhxH1MrgzZ6W9w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-UFi4r-XXPiaFaBrgCnuvZg-1; Tue, 17 Dec 2024 22:23:33 -0500
X-MC-Unique: UFi4r-XXPiaFaBrgCnuvZg-1
X-Mimecast-MFC-AGG-ID: UFi4r-XXPiaFaBrgCnuvZg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef7fbd99a6so5348529a91.1
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 19:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734492211; x=1735097011;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqXfYMIOzpkScA7UAQI7/Zm90VHp+1dIatcBI0kU3as=;
 b=VXrkAJHO8yD9ODnu/PxmJFcHPgyPpahiMt1cbKDnIOvddeyxplmumWTG3Q65QCKX6Y
 PDlH/Pr//TGlta6i5NsVQSTTK+97GYQDAKIJJP1yxrbdOZmauhKNL4fZm9pDdINqqW6S
 bHnS+lE62BOTzk7c48LsxtnV8Kwlx+kbRW1AkWlQv3PjtgF3tFsUWAEhyOUfPFM2plNJ
 SAFnyT90L5LArv+kDn5/t0L3Yr9cG/PmhDHGgsAvBOTRXgh8d6zNjdrukyfg1ZRbWEop
 Vw6OTgZVGq6hHl/eqMMb0ClTCoT74gj+j4EhaHWdnSGOoJwZbwizRotgQHca31odefJw
 lf/g==
X-Gm-Message-State: AOJu0Yx5vwaMGzZXtpNtDBbwZDAK50YpRobatH49pL6VCYWbFFdU+/to
 2mRFQiPuO+65R2ztnsqyNtYZ4A7ZSDzW4IC/+NfmfZGDHawDc7r1rg7QVsJcMhzG7aoZ/uYRcdq
 B3cFm33kFJQQFPxRricjYQxN/H83Go62XtLz7WAhbvSnn3AtnzBLQknojpk0E2WNoa+1ASllIzw
 H/l31KWS4Xq4vSaHi4E3CLvMQJaDvsfM0/PA==
X-Gm-Gg: ASbGnctD/W0gAvYSsbowTNmvThI+a7tG3TxLcZWKoM3AOfOVaA3H4Ssge5J1iAd8KcM
 8LXb7MNJobSnED0tn0TGK0b4VrMzxs7q5q+agfZw=
X-Received: by 2002:a17:90b:51c6:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f2e9388a51mr1695854a91.26.1734492211493; 
 Tue, 17 Dec 2024 19:23:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf7cykOeUxj8mPSkzqEY3iWy4KPCno/vDE254Xf6aoulK9LlE0Z1DI9OUTRXO3THbRBLB1AuhM0HRa+z3wuL4=
X-Received: by 2002:a17:90b:51c6:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f2e9388a51mr1695845a91.26.1734492211224; Tue, 17 Dec 2024
 19:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241213224041.GB1577592@pevik> <Z2AkZabEU12gomtZ@yuki.lan>
 <CAEemH2fSDPUS0OtXOWhSq=waVqp4GWgb7EKOoZXxvbLywnqhGA@mail.gmail.com>
In-Reply-To: <CAEemH2fSDPUS0OtXOWhSq=waVqp4GWgb7EKOoZXxvbLywnqhGA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Dec 2024 11:23:19 +0800
Message-ID: <CAEemH2f902Q9rm86kFEHoe=FoEUe6z0=9Di88y2F5ZOz-rJXWA@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 52nGjaLVN1HTlRqmCK1nVP1eDyGjg_hCGNCHfxOtRAw_1734492213
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I only pushed the patch + Petr's suggestion. Let's see how it goes in the
coming test.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
