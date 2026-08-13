Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67556C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786601664; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ghWlo5JC6NGdxf08Zn6AtIM8+tmOPj2mi9YazzqFTjQ=;
 b=k9lWMszkjHW+BBXd+izANAA8DU26zbsuwEzkZR6MoQgRdmW3T0Uy/MTjNXlUFBoQEg5NE
 JhWvmSLG2q5X22YmoxYO8VrNzseDQG9PoRJLNDvWmk9KI4MNVeXG+KVQfGNoNK/7wOP7jWl
 R9ltkYjzvIJ9YMedoEcqYJ7iH4WWShQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C0F93E6BEC
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:14:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E039D3E2832
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:14:03 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6828E140052C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:14:03 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47fde295992so407440f8f.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786601643; x=1787206443; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bQhufQxbFQhoglfmudA3mGpmVIh97kJQW/jXIsKFiPM=;
 b=BPS0aDVOR2mYtqdnQ5iUBWHpBWSi9e7brt0Wagigau0tU/V9RNhasfps7gX/EGzO/1
 Bz8gDNnUGZcLmNevad0jEiH1FGbAiQcwQ9yOVYcInhkI5psqCFw8mNI1hxLmyamhYEAr
 Q/pdyLOSGCwEa86eWmSpJgCY3Jh3u/On8qGCc/SgIphLc/9A6Wl+gjOtfASjc//HU64Q
 c4fa+wVQ1aS4OkNERICnYyzUj2YAtHA+0bnpy3Buhjgf8edYZsuqvRfXQaEQEUjAlSCc
 C9IQslbg2XciqWfXARh9xNRtULM33kLc5s0yG0cXt46wFOmoRcSpCOgD45H1dAFmuyvA
 Hy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786601643; x=1787206443;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQhufQxbFQhoglfmudA3mGpmVIh97kJQW/jXIsKFiPM=;
 b=kHwlY4LQOvomBEnRavXthf/W/+tYNihwW1Fo9kX+i3dn/t6jHOJmGyOyIBJWFT7kvY
 bzReW8/d8ehqKw6NvfgpSXg9xIzb47CfxBy7CldggyuoClwdi3RZS7T3CvzpygvthaLI
 qmVJZNxpgMtZp9K/t2sqw+eFDctzBMf8mu/Uoiem7uoJfLr0QY2V+RA8kJli3nvRQcMe
 aF0ApZbKp663Fjr5AMywthAgi7Qd2s9gwzhSljuPUx9edmDgULDocO6dArB/WN0uExtA
 PNUTK80OSTOs6balhqdkjLjobTEQD/DXS6Z1qjeFAzrnkTuICrZMA1Yxab6IoBmtqNBe
 tb9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTfFPDfr97AGGCm541qVnCHVYY/j0j43GPrEVewXzCJv8tF+tEPN4/Q5qZbtEzpaHwGG0=@lists.linux.it
X-Gm-Message-State: AOJu0YytC3EtOilfhXR4zhxdzFjp36GV5f2tTHizKl9l+boL7Ey0eZJE
 6rGwQXxAr+cQRCt5VrzBJ6cb7FmaQQhKNOcQ/J9coNOFfotVeVlCcGAmCaZws6aCUDI=
X-Gm-Gg: AR+sD10uM7eX8FRJgSbIEwTJNVfAdvDS4oqQnDAfPUzGY2Xve7UF4SYli+varxJCl6E
 cfZNrwfqWSdDWejFMVvevL1WiehNrkqjFkVcGllJgiynqRj+KURQMxv5XwDUJl6Sph0/Vsa/RkN
 SGcdKVZ2e5jHwPmCohiatiYselTdTutdAMM+lGgpeEUHuq+MWfEjbgTiT2byq+zuCByzjTByf/X
 KrIn9tXm0986iZPOQtXchgIxfal3OkFH49HfMjzAkW4sBd19GhXhJsnG9SVqWK68mCV+EZHdfy6
 /HRVAmW6Kxrkbm+Ks9GXBfBWA4us7cC9fWz28Xbytlw4gtptD90ruPNtgIgB9sTkOD4R2N4fR52
 A+W5yVmHAybwqhOe3p5sIidGRuNQ3zJ/wcRFYH379C0J0tQ4G3t5TFbeoc0ZNcgDkitqIaEFKve
 ZqN5irISuUyNVN9bW3orMp3TgtKMLqCGr78QpXp8+7BTMiU5JcvwlcDAWp0DxYTOPr2I7/nrx5r
 JEGWA==
X-Received: by 2002:a05:6000:2607:b0:47f:8abb:1fd2 with SMTP id
 ffacd0b85a97d-4815a4ddacdmr4010623f8f.3.1786601642723; 
 Wed, 12 Aug 2026 23:14:02 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5612d0sm3527159f8f.2.2026.08.12.23.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 23:14:01 -0700 (PDT)
Message-ID: <95979fc4-682a-4fa5-8833-28f9b9573be8@suse.com>
Date: Thu, 13 Aug 2026 08:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <li.wang@linux.dev>
References: <20260813023216.79848-1-li.wang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260813023216.79848-1-li.wang@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall: set FORK in tst_sig for some old tests
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

Thank you for addressing this.
Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Petr,
I think we should use this solution instead of reverting the patch.


Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
