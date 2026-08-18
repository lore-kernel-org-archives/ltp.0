Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54289C5DF7E
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 12:46:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87F7A3CC25D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:46:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 137D63C56FF
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:45:55 +0200 (CEST)
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 878A5200A12
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:45:55 +0200 (CEST)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-4489b7aa0e7so879503fac.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787057154; x=1787661954; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eWZa//Jl9bYWKBIy4Gd+1iznENUowVYGb2CVGk/q6Fk=;
 b=aDLOGj+UBGYFm1eHQZOYViUG7zR/ukmlhBNEsUy/kz7S7RG33oFyWVYIJPnILzXDLS
 DWmQxd9l6SWfcxANaTv6FG5MR3CGytsd4wDgGP98jZ7buiS5yB++ZUcpFciwrnzAYwQK
 GeCyxKNpg+zmliK+N2g/oI55lOWr473S2x2AZVDTt27A+yHP+fgvEdLsGG31ARkA27fP
 WmnrC92j1Bb6DdTBhvaZ1atFQzAULeGoXZNqPoVaFzJqTiIjdTauk0xxlanVSjxOnzS6
 iwrU71pFZ04lPVhUMIUM0xtpJaXpCtox5LIQoEGSV7afBfvjnbgcUbUWLvY/y2VUrjRR
 blwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787057154; x=1787661954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eWZa//Jl9bYWKBIy4Gd+1iznENUowVYGb2CVGk/q6Fk=;
 b=Sw82GXxC+c48M5zYjnNoqEKv8YAPLg00WcTqkN4A1Kl/Krln3VjMZOeaXUtM2od0Yp
 aXc0qs3tzVAHbHGD8CrZTWlU8q0UWUZShs2Gh11n1BwFMI1CRTWyq1HWv2/56unPCX8B
 oABwzd9DuV0wW9yQfv2zJDSwKFgaj39Yf8XamsNpqEAsXuQdULIw65WDBG/bPZ2vHt3V
 iRMIaNqJ+ux8tdKuVZH8RzE6S668urPxfQrWn+35LwcukSBGiw47c1WOvgNqeZ5gHwYx
 yWQ3d6JYjMFzw1W11AzU6JfiSusOeZc9zydmZjL52d41aPx1HaeP8FryKpZqNOwG5BuL
 vmTQ==
X-Gm-Message-State: AOJu0Yx0Tje15F41ApTccoRTdZAhOd7G8781tS7bzrRw/rXfpRgOA50N
 zwh6EScOXd90kJNS3ZDqGT3cXdsnzFSrtpJGddLgm2vvPeroIYhkU0Tg
X-Gm-Gg: AR+sD12rxkkBNqVfQtoOS/AyuvFuGKL2dngDsgFLPlyCwDo2RMGWXDLmsj0LZtZu3yn
 qOxyGOEz5PKrn5R5irivNYUg8VwPplqtj7MrjXFYm6SLoMkXRHw3Ltd6lt2JJNBhJlp4qsLYbZJ
 l3p28clyxXnGTS7aB3W7EzFYd66v80nYrD2ZqPPa1V0qeb5WQGEtSd0ZImCBc4MzHgr/Vjh35sc
 lGV/odmT6vk2e8utfK0SSb+OHQgAYmIf7BSQnvUmE1IKQjkNMJH+8QPmMbXZcV0uuOA7fMXgfcc
 EadEde7lcGjJsZg6kdQwZFLfLhcADsyRb12v8FVlJVzJS/XSHwBMhx7jWxtwq8BOKFyi/4qwerp
 EXgpg2M3k1MXfzkLmJEHZTiTNa4iQ8AIdrviyocNc8fqSVnQZBAJq1V4suQt+iwztgemaV3SDRe
 NvmC93RbAQeoSGQ45yLAre5ui5eITv2OCva+D5qPRvswrwYnKj7H+RhnatUKfBoit1YYL2Dg/+t
 ZACru6NBBPBvRRkxTYymPJNm0byjO1DTATFdpChcN9KZflsf0kfQ41kZ11xwAYbzcH378rJyXk0
 yQ==
X-Received: by 2002:a05:6820:220c:b0:6a3:2368:4cc5 with SMTP id
 006d021491bc7-6b0d696b3d0mr27306267eaf.35.1787057154109; 
 Tue, 18 Aug 2026 05:45:54 -0700 (PDT)
Received: from
 runnervmzvulz.dkjmlu0qx43exgo2czqhiqv2jf.ex.internal.cloudapp.net
 ([64.236.131.220]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1166fd581sm4535583eaf.15.2026.08.18.05.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 05:45:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Disha Goel <disgoel@linux.ibm.com>
Date: Tue, 18 Aug 2026 12:45:52 +0000
Message-ID: <20260818124552.8485-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818121436.1397-1-disgoel@linux.ibm.com>
References: <20260818121436.1397-1-disgoel@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol02: fix fd leak in cleanup path
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

Hi Disha,

On Aug 18, 2026, Disha Goel wrote:
> memcg/memcontrol02: fix fd leak in cleanup path

--- [PATCH 1/3] ---

> Without this, cleanup would call close(-1) causing TBROK
> when the anon test variant (n=0) runs and never opens fd.

Could this describe the actual failure path instead? Before this patch,
cleanup() does not call close() at all. The descriptor is leaked when an
error after SAFE_OPEN() skips the normal SAFE_CLOSE(fd); the -1 guard is
needed only after adding the cleanup close.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
