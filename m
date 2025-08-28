Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B3CCA0EED
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 02:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756346490; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TSycHMa3fM5Wkz/zfWdenUUi1B7YG5cVv86NE+Jna+I=;
 b=KdwsGnsFc5oHmNYrdrSLmpcpp6j3x4iOeoXaStLeey8vwuY+ai3bK4w/5iz/nGLAz7cZt
 CU0p2FZMRzEk/e42keQUbboE4wzzIH2W5A4GIL9DWoWQl+0YDh1YTEn8BJvoTkfFygwTVCq
 g0fzyNT3pV8CrTMZ8XG17NO6VagaiUE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547AB3CD05D
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 04:01:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E32343CA916
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 04:01:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 306111A00114
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 04:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756346467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0GbZJAO01206DxUmf007W/lSnSEfvpYn6Myi5ALP2XM=;
 b=hBKqaclg+fvR0f/LzYsZunvqrdmY3UQB7DivdIDdGNs9WuWkRrTFa++teEinA+lH2CTZyv
 0Qkka1w/QAsrjVrY4n/LjVBaVQsWZqIKDQuypSZc1BLsoGbLiaJeLZyyIXTMcfNpvGcBFZ
 xe+mYFNSAWnqe6ASBt05KaIISiJWxYs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-6Jx-4G9POhqRWRxSAyXYcQ-1; Wed, 27 Aug 2025 22:01:05 -0400
X-MC-Unique: 6Jx-4G9POhqRWRxSAyXYcQ-1
X-Mimecast-MFC-AGG-ID: 6Jx-4G9POhqRWRxSAyXYcQ_1756346464
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-325b2959306so808846a91.0
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 19:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756346464; x=1756951264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GbZJAO01206DxUmf007W/lSnSEfvpYn6Myi5ALP2XM=;
 b=LwVhEc8oQxToGRaZZ2yWgm/oABM1mI68ywmMCXPCjQ+MXvkAYZcH08ls3T4GMqvPYF
 I0U+zjwY/3XJLM/TmOq9wzWqmJ7GTRvyWAYWVNbzYezoJgS1pB47AECaWJZP4xXJ+5F4
 KRe2gbk4wwT7uoKeXcW0uJPR/LSw+DuhdBC8z3o5dw83w11d3Jo3775a/4irT2n4Djik
 MS45ragG97+pQC6YRlZh78CGIQiXCTzBeP2su+VXXWMHQ2/zcIn6v2wixZ+bgjAcDZGp
 HrQaMWUyNpEjbcnJ6GnMJxDk0SCH06d6FENjQ3Lx8jxciCRwZgXxqGZg7TiZYFxrK2bC
 gkrA==
X-Gm-Message-State: AOJu0Yw6VJnoA/tgffxTt2eNL7cDD4veSzAKVPRWaeKqrMWVHX8SESgg
 rPxo4tHpVLalGHMRO2rTYrF9t4EgkO3Rp+4bx4x/PVMHZrQXcJ59xuKU/hyiZA0nEwyHO6qcI+u
 rn4zl/nrhEG/IKMwd0ZaZ++VDCbegxQFTLnTSXfE4YmcoBebTNVHZ80U6dXdbTBhxTlBWx0cZVs
 gWJvLqxFRk2j794JORXBUpNy6KA/M=
X-Gm-Gg: ASbGnct/1wRLIOlp01kz3u3RP+NdtRtyz49hdH70IWnfryHLpwY+o9olqQHSygtK3Hp
 701GklmfqZSxEZ61AGQL+UBZlAcpysSvHsqCytQsvkl0xlsECi30nZnToERpQ+r4WoPYyHiOt4g
 LBGB1C8XhBUDxnEHDfrEHKmA==
X-Received: by 2002:a17:902:f68f:b0:248:9b68:f516 with SMTP id
 d9443c01a7336-2489b69072dmr59929955ad.37.1756346463888; 
 Wed, 27 Aug 2025 19:01:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGqhr15nTz6+EbdH0x05eEz2L3FQaC2tGf1lFIwurpcG0H9sKVkBpRa2nJ+GY6MdF7PVXLWhZ4S66NX3Orl7U=
X-Received: by 2002:a17:902:f68f:b0:248:9b68:f516 with SMTP id
 d9443c01a7336-2489b69072dmr59929505ad.37.1756346463464; Wed, 27 Aug 2025
 19:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250825-conversions-lchown-v3-0-2d261b3de236@suse.com>
 <20250825-conversions-lchown-v3-4-2d261b3de236@suse.com>
In-Reply-To: <20250825-conversions-lchown-v3-4-2d261b3de236@suse.com>
Date: Thu, 28 Aug 2025 10:00:51 +0800
X-Gm-Features: Ac12FXxhD-mHZ5YCskIAwrQsbl9xb06hF7NkR9B2oUTDU4HxWxiKFeKB2-PySh8
Message-ID: <CAEemH2eAz0kVgxF2dKQ0xzJ1bnD70jkHxijNni8mQvbxGiWrVQ@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: INzbEOt9o89Ek2L8F__kcGAUFmnhl99M99YSC56ANYs_1756346464
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 4/4] syscalls: lchown03: Convert to new API
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

Hi Ricardo,

Since all the tests for lchown02/03 check for expected errors that
lchown(2) fails, is it possible to merge lchown03 into lchown02?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
