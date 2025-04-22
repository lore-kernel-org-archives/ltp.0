Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431E8C369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745324255; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=Wmk3P/PcyAy+eGCt6BGPv708S2nHmG2xrBKAvgNF4xI=;
 b=GhWnf5X2S00n1E6akGfSaEva8ZndKB5aQqe71e9858tZIaBYFG4yE9Y+ivTW5gXJicsj/
 93WGuleEk9gHM4cigCtfXOdrJGID23IjRjUY3R4ty166PkWcWcE2H3dWOPC7evUaQBy3Svc
 wgvEPvJyIK+qQ0IBvn5S3n0q3JOi2O8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1C6C3C229E
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 14:17:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72A453C229E
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:17:14 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FC5514002C2
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:17:13 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so37151585e9.2
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745324232; x=1745929032; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBoOXs/ttj3nO6JrtN62VSoHUt5nBxafArG29QxO9Ac=;
 b=Y54lXLb4DOkFjN5upRrG/f6P/M9renczSP0XGt2KnTwgdH2poFQcaAB7dA7Ah+4omo
 ZJCLZX7QJ9ngQ7FURvOgvU7B++1ZphKalIphlxc/ICSY1CHtVYbEEGp6cwprLq63W2Bf
 Qm9CiQTPJhbnkoE810TrsjXm3T0osvR4zejZwa61RwrCjTLrl0xgUbx+q5KR8LoZggZq
 OUTEUeBPWHoxex0tih0NxJjwr/glHlozFvJBT3xXpSDjlqsVdN1h1eoXhaI3n23S3ruN
 efvPq218CaEv/Ov2Msrw4V7U2EZzwHTvtRIG+AGUgX4hToEeV17mNqWV++LtTE1qFo/t
 CYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745324232; x=1745929032;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QBoOXs/ttj3nO6JrtN62VSoHUt5nBxafArG29QxO9Ac=;
 b=Ywoic1aHz+bJOmHHRKOgVpf9ouQ5GgoLVxZEf6hfr1kzlp/wfGbpzu7y0MEBN0IJhb
 /AursFM46+9MZMdeiB+grXb6ppsGT521yY1c7cLpTtymtrHBq4vxSnka/EYIlm4dOqwj
 EahUqyfGxgJ/4m/jf/S3vxugpbpWS49KNt6AzFrpnOfJyUPtXRlOcVlchWhqadpwFqPr
 520TAQrKYCY4ozXu9E4OUcji/oWS9plg6UV537wjjNpEHvB7H6avQIxNzWr7zV5TSfk4
 PU8xnkKSTLyD8eGpgKmBVu6UJ5NCthV1+I3jql8FbHB/+eyCOoS5w4zfYBbjNWIFQxZU
 Lvjg==
X-Gm-Message-State: AOJu0Yz2oSKABVU997nbTPw8wZx8vWsRlux5guOCBw4DSIGpEebgPOmB
 FX+B4jzUoe6Fdtrnf0A3D4XLEpBU1TzPkbMwVq/64sGN7abbiIAR92tQz85mN99RzCBT2dRlKRK
 i
X-Gm-Gg: ASbGncuBlbqQAX9U0CPyUFYec0arQKSgMjp+KglkcTNk0iQV9IhPkBgsov/C6fZkw4g
 x6tN236RoFCkkROyptSmzzBgiWwwoOQw1fe85Lqz7JLQauCEVfgKcMBecGXUwbSLVqe8I63vM+c
 wgoyrxVBDbTg3Ij/R3+HxyqVHSsx2gp7b0t5yNuZ1cSOp1vJ8HmPEr/NFJrIcVG5y5abbGicFft
 gWKemubTd+i4PyStk8UfozCrWFwZdzadserAmeooMpov7ov0qB/80njmrfnFBXoO2+kDER1QAYo
 tlXh2MRc0v2AtACnsvZ+R+PFS9lFE7AMqBJCN6U0hh7Cx2msHJA=
X-Google-Smtp-Source: AGHT+IGhfVj0Y1vwfe8vtlohHNcx7T/6Zc0SawQ/lUmx0vNiTkGkpKxkEDYEhs83aL8EOTAKlJw5Fw==
X-Received: by 2002:a05:600c:1e0c:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-4406ac0eb5fmr122860815e9.23.1745324232236; 
 Tue, 22 Apr 2025 05:17:12 -0700 (PDT)
Received: from [10.232.133.27] ([88.128.90.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4407c5c7916sm113993305e9.27.2025.04.22.05.17.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 05:17:12 -0700 (PDT)
Message-ID: <63e8ded5-9aff-4e47-9bb7-13c5c1fb80e9@suse.com>
Date: Tue, 22 Apr 2025 14:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Test Project <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting 24th of April
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

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP 
meeting.
As previously discussed.

Next meeting it's supposed to be on the 24th of April 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

But we should start to take into account an another starting hour, so 
Ricardo Marliere can join as well (he lives in Brazil). If it's ok for 
you, we can move it to 10:00 UTC.

Thank you,
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
