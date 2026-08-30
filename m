Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0006C61DE1
	for <ltp@archiver.kernel.org>; Sun, 30 Aug 2026 17:59:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 399E83E9704
	for <ltp@archiver.kernel.org>; Sun, 30 Aug 2026 19:59:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 693A33C2C93
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:59:35 +0200 (CEST)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 008B6600830
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 19:59:35 +0200 (CEST)
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2caced6038eso26846845ad.0
 for <ltp@lists.linux.it>; Sun, 30 Aug 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788112773; x=1788717573; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RAMJoBdMNZ3hjF0/k0wL9DN5EhduvaVl4GaDRGeTroY=;
 b=VwrgnbhgAFJNmVsnLxitYVYgi+vSoZL8nP/LwizTu3LNGVsLH0EurWdy1wH3s25YLl
 N/mebvuxKiNNZLrfSJvG6XIyY7xzY/kZxs1rIthiwCCkCcentLZ40PFLhgT/2SlH+pe+
 0fMqjIAxuTZFIwMZ3DI/CEcquGqONIrvaNpe3q9luiVP7X/Pkr+aojx9S7OAeF3i1QjY
 bfUcr0SsNTZYSMPjbPqHH8n+JO96Gwa037d2vyOyGrXI16jVRshRA5Kkn6nexYn7/T9u
 X9sJTJItSrpZPeOcnGY/6Gt3xmczHsXXWGcu9TxzPnmWrgKVejuTIHk1nKfIbeHwRZwS
 qUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788112773; x=1788717573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RAMJoBdMNZ3hjF0/k0wL9DN5EhduvaVl4GaDRGeTroY=;
 b=NZ7Ykv3zP5E3XsZvWkE5wa7tkBHY9zN0ftRhDua3vfJTRb3QLjlf+pg93kZs1Oxl6X
 avdNTp8RdaZUVSwLoL5wEUJbepj0xuCQLf1ab5hxiLq9a9cIIqUUM/En717aFrg0um3V
 pVOECDcv0yt4CfjDa3H/d5adNs6UCoEutGYv/yi/lq5PiloMpqqBEpALBuun0QHWZohh
 mWcoDQXFBwQXQVGHtVhg8wGb2cpKPXUKeDINGH+dT1ILA3ZJnhfNBMRqHLW2uf8dGD2E
 gL5Lfpvo0v39utthTXO1WrbWsDStaAB9bt3lkDmWCyUHDCapk0vpePIMjU74QpzZY7zf
 Sjbw==
X-Gm-Message-State: AFuF++kncYtSaxLfRPE+MW7jRqXhKOlYuZj7BuRIR01Y9LmholyF2DSC
 gToiZvK50J/fGlPYNcagjPgkU7lRyovED35icvv9nJMnqeL6gem9BZQn
X-Gm-Gg: AYBFou33lRTnlqjlnXeNzY/ClXIlvp0N39yiBJO7FriMfm2mqjuYQeXjt49p4L2tew7
 XoR8lfhwVLtG3+ZxrBjCtx0RU7mUf1n8KTZz90m/rnApkaFIk1ITk98oyUUaSBwjxRG8E6uYKx3
 1K2h0QMU4jhXIQt/vwzhubCtCqEt+8HeXduJulCHC/Qbq9YRZ7MZBPzThC/5y3MkjlgQPq7faAv
 MQvHoi3xAp7y8orES5uU+057L/PVWFhp6MtsIz1vV6j/E8KIn4ioI6l4exrcCIotm/fnQ78xnqz
 NXn2+1HkGRMB0HvgNirycAqCgEu4kJKZr6ZXtNnYYkyrFQTPrXhUkTFDlpKud9q0cvjva5XIyxG
 P5SmcfA0sF9M448mLM1zfJBMcB0TaHiX5u/tGCzlO9B5DPG4nJc6lS/qzQ3faMNnkWK62AyZMm/
 V1DdOktdsc0BFmt8Q8/L6zqRtfEZ8hTg3OSFlo6YvSU01sWTvJ4mcmI4nmxAxpjdMwiKmzRTUT5
 lnFUCM7lFT+hfBXJDWiBhdoW1tW46ftd24HigjcJ/gL0CmAjOCYvMi6y3hFfjPW+y02UbqrogT+
X-Received: by 2002:a17:903:22c2:b0:2d6:f80c:6ff1 with SMTP id
 d9443c01a7336-2d91af96e65mr31370695ad.9.1788112773186; 
 Sun, 30 Aug 2026 10:59:33 -0700 (PDT)
Received: from
 runnervmgx7h7.k0cl530ymbcudaj23gkb3vcfxe.dx.internal.cloudapp.net
 ([172.184.247.5]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b26fd7edbsm12152998eec.5.2026.08.30.10.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 10:59:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Sun, 30 Aug 2026 17:59:31 +0000
Message-ID: <20260830175931.9014-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830173408.261946-1-pavrampu@linux.ibm.com>
References: <20260830173408.261946-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol05: add cgroup v2 task migration charge
 accounting test
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

Hi Pavithra,

On Sun, 30 Aug 2026, Pavithra wrote:
> memcg/memcontrol05: add cgroup v2 task migration charge accounting test

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
