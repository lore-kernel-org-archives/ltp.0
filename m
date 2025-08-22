Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE75CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 04:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755835530; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=JKKtFOFhODl2R/HfgbRhTdbAYQ5FNqDP90z+cICBLlc=;
 b=n/dCOCzmgjsM2oN1CqCKurncqFtOJGHjwcmUJH5+xX9L/b0G1KNJqhYIdYeHbb5IHGqeR
 zRKAdQBS9jiadpIkkcbKFINcHnP2Bq5qwV3N3GHiVK9zxihTO+PZnCztqxT5roArNEeFTw6
 9aX283lb6XD+2OzLX4Ww9PyWyNrfdkU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7383CC9A9
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 06:05:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3A9E3C0639
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 06:05:09 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 45C80600198
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 06:05:08 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-afcb7af30a5so271927366b.3
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 21:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755835507; x=1756440307; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crb3ukgeGdJF5Q5oJDEJIAZZ5gK1Uu88sxpP9nNpf3M=;
 b=XPkAlEYb5V2Z73u98y6dgXg3k3hKCKLhEYiiY9qWlnoirBd2c9d8+4HlXItrYNv5zA
 5wQXMY7kUe2Fx/FVTaB+hoEFIzxgEq654YOUfC83N+62htjxNAZ5+jUd8DpD0YJvd3qs
 JLD41UuOZRABzaa9XGtgQT6L5O1XpPRAtWS3yNdWJJqUP98dXToE9mY4hvz0phkPIBxf
 9CWMiG7c+b1FwbrUlEhH3rkW+V7lbvy2woMt0BiYBfOBqKfQIOJLbLNiA/ngIWHUQSlK
 cFUNFRPjKjdXY5vzcl0FTR2rZMuMzUxZg1e7DzcgiaKzbwFyy9HJiaYdA6n9Zagp/6MK
 XS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755835507; x=1756440307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crb3ukgeGdJF5Q5oJDEJIAZZ5gK1Uu88sxpP9nNpf3M=;
 b=T/Uy9VzMlG4xMkKiwLHYvjZ54J1zO8BxxZO5/+RrY868mp/pQFymysDrM4jxKamLUy
 WLjRlDPflEr/d3DbL+kRC5s6LolvZES9LjqqQ8Uwb2u+X9rFaWsxZJMZNDn9XEtPwPWV
 4WqU27k6K93dGnQVeSbe8oNmdgOn5ybVXhZNdmBUh5k9Am7cDzmK5A8vPsF3N6+Uenie
 9gVDBkNXaBntfNqIR4zpG1I3Kq9ZaQlIj4Cd2iSnOBPRv+FYyo6MJjiQeRWPxVo4jJ02
 mrYdiUVPSFuC4DKP2JyXEbvxCcty3fQjdG/OaVtO7zIrSBkg1fBOHCkDK7zW/d87KXNw
 3mVg==
X-Gm-Message-State: AOJu0YxTzOlGlnfT0b6hT8llzJM14dOYHlng1euJ61eyWWe+3DS51Kvt
 aK8q4gsvN9W72UMdeGpecUvVafKWj36rNGWAOMEEH3GVbXvTc8JsO8l8GqPPf1yZcOGbcgY4F+k
 ET+c=
X-Gm-Gg: ASbGnct1+ZMtVmBDxFUjU5J+bR5oc07HvXxB8mIG0A6EnYXSMjPj2Jd98ctWcSg1lu0
 opkzyjY3ljYOXGqJUIYu1elHLVGVgf9GM42BaSNF8q5GfajvErv5r6fQ87FVZhGcVkGFjxaG0SX
 8FyZ2o79oeO8qi1ln18PeFEW+jja3ibAF7xYWJeSCNdt6zmL6OKXj8TtsZvppu/XiV2dzUZgcLT
 ol5NVwAfcpkPYMIWCEY09YKtnv45dH3awZdCCYEH/MQMP/UamuQhGf2KzME1woQX6L1lVKHcT+8
 viRnUHNArz/9iM9eOHAu5wDMDhI/vHqf16sJv65gi/sRkVN+e+mv0hyhiZkVqmqGt41AWpkRUjE
 uyiEcQXO/IaA01SNgrCS0wjewJlHGqrB+3+85wCf2nRM=
X-Google-Smtp-Source: AGHT+IEeoYyr1/i7Rkbggsh4uVz0PuDusz8QqTUOE1if0aaUBm/9kizbbWlpZfIW2CrQEs8MRwKQsQ==
X-Received: by 2002:a17:907:846:b0:afd:d20c:8657 with SMTP id
 a640c23a62f3a-afe28fd4617mr100105366b.21.1755835507507; 
 Thu, 21 Aug 2025 21:05:07 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded4c8713sm525324266b.78.2025.08.21.21.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 21:05:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 04:03:57 +0000
Message-ID: <20250822040501.28640-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822034215.28533-1-wegao@suse.com>
References: <20250822034215.28533-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] fspick01.c: Check mount point was really
 remounted read only
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  tst_device.c: Add tst_is_mounted_ro/w check mount option
  fspick01.c: Check mount point was really remounted read only

 include/tst_device.h                        |  2 +
 lib/tst_device.c                            | 42 +++++++++++++++++++++
 testcases/kernel/syscalls/fspick/fspick01.c | 23 ++++++++++-
 3 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
