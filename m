Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF6EE01F3
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 06:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3F773C1C3C
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 08:14:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DB3E3C1BB0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:14:25 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BDC4C602122
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726035263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTvsb6orPdYnUNkI1jr7OOceuXyJHJFnYsYPllSk0P4=;
 b=B2W6pdWy47BIObufmSTC2AYY4FcE6cFjr2XNi0m+MZu7qXPfjfcWSlLjrtUTapt3ZNHcAv
 WpKWUyOM4EIyLhoyAuZQcXRFiRvPnGAWS/YqBIBo8G+gJeLVySe9ZqucW2uBqaHj8+zWZt
 TwLQm7IjjvWYmno6F9WoWRHZ2lTSBDA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-ftFOrOw9NmSYon95tnoS7w-1; Wed, 11 Sep 2024 02:14:21 -0400
X-MC-Unique: ftFOrOw9NmSYon95tnoS7w-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-71790b5626cso1531378b3a.2
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 23:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035259; x=1726640059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PTvsb6orPdYnUNkI1jr7OOceuXyJHJFnYsYPllSk0P4=;
 b=qNkWRgZLisbTIeclO1LxfvCXbvouKOnBzVT7cBfr3HvyRpearxUuGW2fs6P0ILn935
 0t0ztQZ3V9cwYfTNDEpWTLlA6pEys3wWRkfc4kZqZQ++lISF4T5nFlw9a1ZuBROzj1qR
 92siOqoimRHDwWB/Bl8iea0cwm6eppTb9w0U4scQ/s8ud27OgcK+NeF0qF3gbydZR62B
 beKU/le08kGDOILIUzugeAO5Y8Fcs2/ZEocM4CeZR7FHyt8D+h9sa86llzTBTaVrHmG1
 HnjE1Nx0jBx3Wuxf+H91y4T59zvdvZrW0FG8IxdOtVDSDohQz+wCeL5WuEmZCf7lKoQC
 GBPw==
X-Gm-Message-State: AOJu0YxCDJUj7rmeloChlHNN0EC5xoNxX4mF5UIR5HF2p0uhI6Tw2MnW
 AEOhMvLZcaOmLkdB9jaETrlWChM0kUgiE/eFpMFt0UTxNj1yisJFxGV4IHC4Y93MJwIQ1WD8nI+
 3V03xQ5tLVdzWSbPvGyc/C/kdH7Tqcg3IyOINj5l5Pm1WuDW1JbMDtcUGsjepQvjingWWhFMirJ
 C/ujh7Tu8P+gtn+fECS8iaUwHcLV2QrjMZ0w==
X-Received: by 2002:a05:6a00:1a87:b0:70d:2cf6:5e6 with SMTP id
 d2e1a72fcca58-71916e7a914mr2628376b3a.15.1726035259555; 
 Tue, 10 Sep 2024 23:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0esLo/qSqzGU70o5NRoYwlucvXhwFpJiakVgBsilYqLmMPHvIKo0sZ/sncvLG97CQxFaZF2IxGcujQm7VqYU=
X-Received: by 2002:a05:6a00:1a87:b0:70d:2cf6:5e6 with SMTP id
 d2e1a72fcca58-71916e7a914mr2628356b3a.15.1726035259153; Tue, 10 Sep 2024
 23:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101023.58695-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20240910101023.58695-1-maxj.fnst@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Sep 2024 14:14:07 +0800
Message-ID: <CAEemH2fC3-AnSgmeBYea-hwgr1e9+TauZb4ANvfhF0Hucd-rCg@mail.gmail.com>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] fchmod01: Convert docs to docparse
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

Both doc patch merged, thanks.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
