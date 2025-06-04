Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A038C5B552
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749019354; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sjIEXI0dvcW2HtYzo/KVnQiWxNo3hXUpsDWSmiYSUXs=;
 b=qT5A0Wxj2ArMq33DrVeMDyvg3Eggu7xfVvgB9IP8uVrgqe4O3gXA/GDgjewWvxjDW6Lnh
 nPKpJP8IfM14034l4DGVZ/1n/7/wF4lzaoNuQAxqLKCpMtIRmQbYGQwBzTjj6hItw6Lyt8f
 232F/4unkX0+e7xHW50ZS7WWBF4rNKU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0E543C79AE
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 08:42:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 226083C79AE
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 08:42:12 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7C651A00240
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 08:42:11 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so5406563f8f.0
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749019331; x=1749624131; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=YauJnv9eZmxVhe8ycfIzBN7L2Xj7F1wUIGdA2jsfV8lixAs8t4UY8D9lZkAS3RJwbx
 UzdTzoxkIhWsO7wg+kLb5+/T4+7uYPw2LJMjJeUp80LO+dNOBVg9nXFPfAnU2HoA2vHT
 WCEMHQ043rfoRz1upPG4LI2CSfIgJeHziV6sIAuowU2spQBsZyGI0j3LYo2qzXskVVBZ
 uxCPHikTW9TtgpbinXFvnKXpUfcRCg8uQDGBXHuHfnUErCaoNX25wGZeMm+udwTmCHM5
 nFlEYq9lDBLbA5evsopj6ccDf/X2vZJR4YRJLXxqoA8aKK4V1sOxkioHMwd8Xvu7jemP
 6v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749019331; x=1749624131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=mdhMJisZKbU8snQ2xtcHSf1XyQIuBTZiRUXLsssyGInA+SWIhVaVsskikBQzNkrr7W
 UBn7ZOcMpIISnzrx9d3Jp8snBPaCZBDoIqXZtFAHjmliO8hmOCmNEIU7epR9CtHgVgfu
 jxyf8GQCSHgR8BTyxs+qkH+lpQfrbHP0sXYF5I+lo3jseWLF9jnts+GJdTNuDln8kbEc
 fL+IV6sj9g6/8Gv7lfAb9LHT0HfyqH/FvE1xXVWLNO7fjoiyu4kicm4b98Mwnips+OTy
 tpr1PK3m9nxLR0JdoGA0qDv02I75eOcAo5oXFLZCphNjuGyG/VDsaLz1J4STCBMZ/mYh
 FVsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPiDY9GebM4anYOuy6jyjabc0uuvh0vSKCtV9R5Ahtuwmdvo8mPgKqNEXkYtlb+RtGyw0=@lists.linux.it
X-Gm-Message-State: AOJu0Yx5/4jOflN3gYJY1y5d++kDVvyALYRJ95zshTJBFI6MDHlHPuG3
 5YJnC2cMjh2hY7MZDzNNEswV0gLDAXtz2iqhP6uoQLT58C52Rf6mdaK8V7Y74WBE2+U=
X-Gm-Gg: ASbGnctqi85YLJ8ucu/Rf2aHS+ufYI3lsUi5mPwg4Z/J/lLEod7AO914KpehAhWYpOx
 YhE1G3IdHaYcoZMn7R7iWhC8qHgur/mqAap3ML7m7zLKK8YaSeZuicByArW53ix405fOGOS8AN8
 VWHGcyXMnbKswPJYiDVoeszm5o3TWhiqjQPwIgiqJij9xWJduGzTWXeUFWAf5PVkHiBKE6naSsz
 3APx0e6eDOssgaUTkZK72oQVgiK9UHF9JZ1dy9wrAtjmLqO248Kypz1hMZDqMbFK6TIiBGklgFc
 whZC8wFrWFVhmrLhH9a9hUyY5dMd6KusvrRGzcLuo+qpOw3VDxAkl/PIZ2C34HbeLrp2Njafs8b
 3I9EnsPeSHGexOoB8BI1V4j9KojE3lSgLcKs8ecK+MMUeSqEuEsD5+X4r18+rM6VN6v1fVY4W0H
 ToDweR/BzsAQzwvQ==
X-Google-Smtp-Source: AGHT+IFz6vPfnLsWTTOZiXGaC1OT0RmBkCnBkn3Ji0hPZMzhUg4hPDBCGSbmmyeMbb18Lgm2nzDsgQ==
X-Received: by 2002:a05:6000:1787:b0:3a4:e10f:4a54 with SMTP id
 ffacd0b85a97d-3a51d930093mr1169909f8f.22.1749019331145; 
 Tue, 03 Jun 2025 23:42:11 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bdb402sm96778775ad.84.2025.06.03.23.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 23:42:10 -0700 (PDT)
Message-ID: <bc7d1cc6-b5b5-4b2c-9175-78007ca8a304@suse.com>
Date: Wed, 4 Jun 2025 08:42:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250603161327.217374-1-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20250603161327.217374-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] open12: Convert to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
