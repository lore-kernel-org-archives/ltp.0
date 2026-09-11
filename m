Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547B9C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789109869; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=AB+9Dri1soVTnGV6Xt56t7XkR3l12lkaamc+VR/aArE=;
 b=EFi9Sq5LUsCS1aUVXKQaZc51uMGFopOmdbyrwYRM0b2u+ilJn3I5zpQjG40zmYH4Kv7x/
 7TThu+0KB63dJXr85pShuc1OR0BX+ob6dGdCqOLXbJlJCmjqoPYM+7UfUGx1X3W1LJOQfZe
 Ytj4coAg98beB1RGiTOHq899rKDXyQ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 685273C5717
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:57:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EF103C5717
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:57:29 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D0B271000937
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 08:57:28 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso4950395e9.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789109848; x=1789714648; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OzfU+/VlIp9UAgLGw24xjMeBIutaMozrcqkGkbjcG/A=;
 b=QcnRRctwLgY7eNLtphhM4NGlu2MU67i7tpguhN/Y4yfQAmOzxv29nDJx6UXcM5NfZj
 r1ImQWBhpJWNFA/ivhB0tjlgXCfPVZmoeOoS1mojOUslwdIzyGvABJ+S1h+WARdjYNDz
 v51dNF8+6dG+6SpwgkZKTI9l9wWqwKGldmQB2zHnJhhhvHpQ1LUtTwc25GrAPb0xNV7D
 ohzIDSW9o/qDhqh2xsKcmiWJgPfvqj+yt0jR23iCOxYar170mByVWxrPjvhxLPrDYqQq
 AKTInFKyOLfVJK3/q1vLySa4ESXhxCYqLc9HXf5ADuwdw9JMsaRUCCYhLDbJQAZLL/Cc
 7dPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789109848; x=1789714648;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OzfU+/VlIp9UAgLGw24xjMeBIutaMozrcqkGkbjcG/A=;
 b=P5YOYhxa1hTms1h4L63zZtavTjhYTWMRf/X/QCAUeDIybaOQ9Uh7nf17N+HsLM7+pB
 GXDZjQKdMHy7T3QcgvGWhtg+Zzzx1ViMFDhgjP0bnBR6WxGpSkwrCWNNC3WOE1ITXed2
 G2Ibq83xF+38gzIFPlEK3iw5/jttGTmO3dGUPQYrbT66Y/E9AYAHHSDx4CuCxOJPTSO/
 qoTgx5XdAteha+fWEN3t9B263Mqmr+1UvLfJTHxMKE/6xj/GxwvHLjweyGcJM4+imC2i
 sEZjU1HH8pPVzdRQZgolIElSRHePEgUmdRpUHcstEYS/oJFntqqY2d0Y5lSfCwZ+cyf2
 MAEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxoTPF8pnaK0A1lDpAslNZmz/ELjf6m3aJJd4zNR7QgZhHFoXdtq7hslGbu34WNxJshAtA=@lists.linux.it
X-Gm-Message-State: AFuF++l8/81tSjsWJCJkSw2J+S6F0lLs2yYNnEG1fbssdotqJRMuS5cJ
 dCb1c3poQogE3ZunmpzwfYJJR7Geqbn3MQyMtY7oBPIj03WHcq79kmSId5Rn3I27dms=
X-Gm-Gg: AYBFou35M7Wcyvz+2wusa+FhD6hlhRGzv4xMz0KIDDrd4LjdJeilSvpuk31BHmUy2F7
 IpraQ50YynH5AULUdSp5UhdV52KPBN+C61KhCWd+UwjG4vwPfm6yQuk49JXVZ7esbfSnA5D7xp+
 VaHHk8y71pjqVXmm/4F9IvFij6UOvEBBYpXkHPwCTUDuqHV8od5Xf7fQrn/nSyneQokdIWQxkS7
 7I8CXht2jr3Hkdd7mOOI2ZG/C46MhpbQjsTYa5gJZPmuF/ORMcMgzogW+9El4CilE4c2KQUpRR4
 NSyVKLOZlwNiJQwcmZmdt3sROcFeJi6UE+hvysKostCsHv0l/Y/hg/SEDIfIJk/9G2AgA/lZcLs
 X28gAa7fLgf40IxVLeLtg/0j4m5y2XgZwAhmlA/iowizK+EDeIEDgJsJgwCmj6pFyDdQLb9S/jZ
 O5ncEZCOLHQ92kAiBoxTg88ceXvRx07B2qzuRzqofMzguU6itNoHJA86fSX6JNTV1QULtyqJI1C
 zvoDNXZcTVEbD6MJnzBrfYZOJAnlOxbGg/FMD1k/6BymJWWcFnvr8h6tTRJEfEXwlvikIhAkrpb
 oYI/P3/zEMxRgt+F
X-Received: by 2002:a05:600c:4293:b0:49d:e79:612f with SMTP id
 5b1f17b1804b1-49e619cc5ebmr16803255e9.26.1789109848162; 
 Thu, 10 Sep 2026 23:57:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60abab54sm52868725e9.5.2026.09.10.23.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 23:57:27 -0700 (PDT)
Message-ID: <6aa3a657.f20365e3.1ac8a5.6340@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260910195257.GB270563@pevik>
Date: Fri, 11 Sep 2026 06:57:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/9] doc: Clarify API coverage and navigation
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Network tests are documented in :master:`testcases/network/README.md`.
> and delete the rest of the docs below ...

this is ok, but we need to translate that README into the documentation
at certain point. I don't think it's a good idea to keep README around
the project instead of using the main documentation folder.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
