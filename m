Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E33CA0EFF
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756346567; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VO5qy39KwAq/GO+aduRtiQcmvyM9U+qyO6XXoiKegvA=;
 b=hqm6oxM7eTBJ2bry5zf9ktcWFExBHT0jiPU0TWh+w9pDM5NBs4LEofoOvh+DTaGWWgS6d
 h+xazZrFpjBQb/27+uou62Ks18w5PjxjFuhDI0QmbBJVVOhwXMYpGfEhCQoxBHqMPPn9Ps+
 kCo0n6g1IMuCLK/uFiZY80qmyOLRB4c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A4A63CCF60
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 04:02:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3F143CB957
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 04:02:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 55264600292
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 04:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756346542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bgeq7sipc50spSiF/mdVVDh+jvzswv04/Sbg9NW0r3c=;
 b=O28HoUn402Hk6wKMQ80qIDYzOhoRTVq8LIEpxS0g1z6KQC3Um9ci9u++kReZSb0oP8S5sv
 dECqpthiX45WzcDQPUoQkU5BF2Spdv/RhcHFgroq15UaMd/McYd68UDJr8QcrIzGiSJ2P3
 VTjcSSjxC4/4QTG4kJn1hftC/JDRUro=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-kND1CZuBN7aDo4Bngc36MA-1; Wed, 27 Aug 2025 22:02:19 -0400
X-MC-Unique: kND1CZuBN7aDo4Bngc36MA-1
X-Mimecast-MFC-AGG-ID: kND1CZuBN7aDo4Bngc36MA_1756346538
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24458345f5dso4848305ad.3
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 19:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756346538; x=1756951338;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bgeq7sipc50spSiF/mdVVDh+jvzswv04/Sbg9NW0r3c=;
 b=rEHACj/sCgoxVcd6HZALzr7PL3/bNmNqit2qHYoXTH6YBOGq2PCnmc3ou5L3AP7hOd
 KhnQuBf9pyQaESg3kBWgWRJhe24h6+NijmmR8hBxSE32VgDhJkflTFkC7QJCac6nvRaB
 AtMF0GqJJE24hA4xcOuE2MERIwwDe/hBYAzuVT0d7L7Ywxkhot8vwLwxRwtM7jYabPwh
 KlNwPgCamRigbDJ/fu0HLRIme5zEIBARhSXjAvrWN9IPPInpEBi0yShS1KgyTwMTTqFz
 4UbHKEhhuRNCc1IAoYGJtzo5iIM8xFjd5vnHvlfjlImjxENWo6N6e6Kxtm+mgQKufzSw
 8NPw==
X-Gm-Message-State: AOJu0Yyc9HycRiDL0sCGEUsWMcr0Ktwllq7dlpA4kuRwcCWymggGS22e
 xgDWXDT70rU/A8gmVtnnVUM188kaOYuyXqEvrvvj95iyJdFifu4tHQ8fasJpV0RJkm+2lEbmZbz
 UY41LsWjTi7qnsz+4Sc/hk0lSa6FpiVCoxiyyLaNycM8HViV9yqBNtLlFyCmUPjT9yQ72OeiNSp
 kN0YO/jIvankiY5URA6mVPu6Z4j6k=
X-Gm-Gg: ASbGncunJx9toLMTAYjXdJ/AnWHjhtQg9AHFV7a2nhd+AQ5H3ufTuRhQO2Txqx2H1s7
 Yl3nNc9cIfObjB3Z9bYtd2N/NTc1bOhQJONs0gmrNaCw1yN3paTtpzOJDbxE63/bw6qzGq2WJBP
 +pDgKRHmDFZ8AeTEF+/3eKdg==
X-Received: by 2002:a17:902:cec2:b0:245:fe27:fe80 with SMTP id
 d9443c01a7336-2462eeb004cmr300420395ad.26.1756346538200; 
 Wed, 27 Aug 2025 19:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGVNLcskhVy0NrtoYMKXcjFDCxZFlN9a1gegVCAhRnccZEzAcfIFM2r/PEzvfUKzVrPUOzMtB3CVuZXDzI8+c=
X-Received: by 2002:a17:902:cec2:b0:245:fe27:fe80 with SMTP id
 d9443c01a7336-2462eeb004cmr300420165ad.26.1756346537832; Wed, 27 Aug 2025
 19:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250825-conversions-lchown-v3-0-2d261b3de236@suse.com>
 <20250825-conversions-lchown-v3-1-2d261b3de236@suse.com>
In-Reply-To: <20250825-conversions-lchown-v3-1-2d261b3de236@suse.com>
Date: Thu, 28 Aug 2025 10:02:05 +0800
X-Gm-Features: Ac12FXysma76mwkE8ndIug6r39V2xGElB26K9S3EXUignxPkaFCdc6AbWNP1Bpo
Message-ID: <CAEemH2dOrc5xs2aGyh=2oxz-ZmQ7uV8Bah=poZopn01gqOJrjQ@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8HXFdSFyfLyyj3pmzKew1lHocvt_Za8k3VujNBVoRVU_1756346538
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add SAFE_LCHOWN
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
