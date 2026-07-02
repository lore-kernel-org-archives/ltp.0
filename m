Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B8FC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782997774; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3+LtQ1vtkRD/YduCjd+wSzenKAel5JFCjwzKEcai/Nc=;
 b=CVApz/hAgXGoXv5Juf8Lbl3agdRT2evOqCAcsVc2eBEnbvCQqRZG8ibZ6HF5USJv1lNhb
 dmle1JJAPX6zCD0hYnZrR/ujUHOanL3ubK+YPVZuimFN9ErXm5ZMF91tqmvPEywPbVnPrPx
 7zSmKyOUO66Bn3ntoqOFCKY8LCtQiFo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3180A3E4A16
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 15:09:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BF063E1CD0
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 15:09:13 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ADCBE6001AF
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 15:09:12 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so1683730f8f.0
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782997752; x=1783602552; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=94Orv5KnZRUfv/hnjbWgAxzJ4v4j4miphWgQ63jqmOo=;
 b=WMr0cnZSsPHgbHII4JmiP9FLGxXjHFR9FEuRHGvI9sSwkt048juR5HPYZrAVTvWndT
 8ejc28mSXXRJwF7ujT9bfuPIvLQaKQmaoE9sIasB4vlZC/cnYEV6Mzxo18F8ThX1jXOa
 DuGLljytFzl/KTm2NTDm21QxZSVgQT2OsPZoGRHQO+WoMRjddR4L/u8sn8BTLLF+aWyh
 o3OILK0RT1140salyrQCN2UvaNX80sQhNHAljbsoSv7sE3H2qVY0ALWGD2BdaZEvV+jw
 uatDK9d75wVC0pJNu4gCR7zhZ4TFmct/SkokPOUwh8N6o4pijHKr9tIDpNzc+8SEfJQh
 Avtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997752; x=1783602552;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94Orv5KnZRUfv/hnjbWgAxzJ4v4j4miphWgQ63jqmOo=;
 b=QShfk/jfF1fsLD1sBMk+k8jdpYD0yrwpuBoNW+DkyCK+lCmKEOb67ZMuAmAAl6AY3/
 WUosXcnavs+h12VVIq4aEaYmUNb5huUsTsmpFc2yQuPAOLDoKbZ8SWjMLBd/84lLejrx
 fsz4SNNKOwdQruhLGAEm36P0za7CFPzkE4B+fHQeTCCZzEaAlmf0qJFUfzJFz7WS/Qjg
 BkeJZjvLPRfAtlvFHXBCOYR1CkwaID6WHzGzDGSTzdYHvP5shlpwVlstNnroBir+Rbd+
 rF3qq4/yRf09JPEeTkBXgLM7O+NZ3Ia+EdvYZ+vW42SNPAXaAWJ7JxMYKeFKgd9Yk13/
 A71Q==
X-Gm-Message-State: AOJu0Yw3YxusPmr8SB3rzjxfB1AHCMjRpJlbXvCzpFzszgnmu9kFIM5i
 9gsVhYACUiyfQZFLbTKoeeR8+i8ps+7/5CdBeY/Cu3ELtxZfjUAN9yfSrE7BNE1H+Z8=
X-Gm-Gg: AfdE7ckeq3yVXEmNq6UVB0t/ifVoCgELX2mKYDSB/97JxXZALjSG5D68H/6uR63KXNz
 svfMxxiReVwIERClNNkKvG2+ZdKIXu6j5ahSXtvK3eBDX5hTYBTZXxyVLN1oQlsDKEXrtgoJuF3
 T7+i7C5jjdJwp7yySjvH1l7rW1vukexPXvohikvsxITIZXyM0NEzz0Cor9IgzrP/iUDJIy1vQlN
 EiltxKd0EkOKnnaUbkkpSiJ3AqsFNy5YLyrCd46RrK06g0ECxMXPytSKFEmZerPPiCqdWj6xbuy
 /eECP29uYrwVuFF4OBjjPmiZQuB0luXcSGDVtNAqPsBVtmkitHOUflWKbi9iDXeeW6IeL/gWI8m
 H2hN39pCMVijDRN8jDRoFZaJvLbLxuN5lSAuvfPHB4IOeq+DCdPP6DVfWxucBwn9sl3RrVErvEZ
 T8w3Gy3PvWAM78vNe21GSackr7rKqzYUMKKRFruj7OTlVbkBLmKm6+9VYRNgCgJw==
X-Received: by 2002:a5d:518d:0:b0:46f:7d90:8128 with SMTP id
 ffacd0b85a97d-4775a2efbb4mr7569978f8f.14.1782997751939; 
 Thu, 02 Jul 2026 06:09:11 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a450bsm9409012f8f.10.2026.07.02.06.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:09:11 -0700 (PDT)
Message-ID: <6a4662f7.ebbd881c.20d8e7.cb94@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <akZhAFNlgvHvYbbU@autotest-wegao.qe.prg2.suse.org>
Date: Thu, 02 Jul 2026 13:09:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] statx/statx04: Skip testing casefolded
 filesystems
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Wei Gao via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> So i suggest we just give fix like following, do you agree?
> if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
>      tst_brk(TCONF, "vfat and exfat filesystems do not support standard attributes");

yes you are right, let's just skip this test for those two FS
in this case.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
