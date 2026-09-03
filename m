Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25201C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 06:58:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA8C63E9391
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 08:58:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C0923CD3B5
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 08:57:45 +0200 (CEST)
Received: from mail-qk2-x06.google.com (mail-qk2-x06.google.com
 [IPv6:2607:f8b0:4864:34::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BCD61200928
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 08:57:44 +0200 (CEST)
Received: by mail-qk2-x06.google.com with SMTP id
 af79cd13be357-938feece332so102316785a.1
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788418663; x=1789023463; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bo6hFEYUGcUhBcGs8DfIemvi+pc7In5C6cX7BhyNyc8=;
 b=g1ltoL6rlWLQ9wH4/FCM28CAGHr3FTomYmOn+ejAbEab44HfHzttlZWcNZvZQ4/qvx
 0X0HzxMHtoi3dCXK6t5cCg0M1zAVbE2Qi1t2g8bU5i9HAMNm+GO0u3U3Yqd4CSizHztk
 qMhE0JPg7l9bmEO3OL4Kl3unGTr+//FwNEcGkU+KVVJtDTz3/XZh3VNy0NnUqXA8xrBC
 av7nE9w22VtVcpySwt3lY1stfFnSLXkDT3vmL7owG3KBE6noPDsE6ULsYV7DccqOb/4d
 7cVS8amoDHlJdpnObyU0wMixTbjHalHnXxgbvshaaKwhkhj/8/Gff6LJgiKL3f8L5iRs
 MoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788418663; x=1789023463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bo6hFEYUGcUhBcGs8DfIemvi+pc7In5C6cX7BhyNyc8=;
 b=QcdxIbVu6m6HnAxvE4aRJo8VVBzKjyqucaHx5Jqd/QQsCWRHUyKQeSqMEEDYvM/PiQ
 rd5JfE40TYGj5kR8D6/Ua2PTjp6FcPwp94+46Hso+x6QsxVNs2wuZyHHGTNvfGY6KbcD
 S2aS4HsxZD9r4TXSbQwvxYWisw9wWSVa+36qatpuqFq7aXAATxCavvugW7qQfi59vpNl
 rs+VOwMoGA0DHvjKqkRa7z25NYMJeUCO2VPHyfb4lewfJ0CCRXEjFHQTrCScdZoxBCsU
 REHKBKfp8W+I2lsUxv+smGlJA/S+HdGFqtpMHN6ZjfTubL34zWNOb0m0eu37kqH1yGHu
 Z76g==
X-Gm-Message-State: AFuF++lidjJ/B8j8COKkm4YNCONRTNg7H66qUrGRgi+yBtbL5yun8hMN
 EoJ6j1hNsOKYHpzMcNJFyTDoFNMLnKjzDDcTwdL73961TOMaya1eOWpV
X-Gm-Gg: AYBFou1/tHFy69XGR5dKOflSbpucCHtLqN1verZctn9YEV0K5K+N/73uqkz08789DwT
 R5kX0+2EXTEeg+DXT9gOTD8nopAa/lokck8wyamcu+y9lMyftfPGqlf8nef3ti1V8XT8h35RSW0
 tuFJyK35EWuVYhAoRzgNujqrFWHe8c2HD2HGiuEP/nswscxl2R/xtZJaEHQ1Cd1GBrLUBd6sC1z
 hWudiehUVV8SrJX+kqOeALMZbfB7wyweTaV35p8Ho31mkHRFdtCoNQR+EnLu0M0KljIY57hfbVu
 aGd3d3v7tmDT7lVTAlED9MhoE0CqJlL9hSR/Wbx2vkPgWptNr4UDf341M/jXmcxGFMX9VT3Ns7n
 ZQ6eiwpvqadaJzLg51POege4rjn6hRqmSvQ/ily+dbVIT/q2NoZu0hQCVOdvTKxxUAEFfTTxI2+
 dHWcMQYJhSLdBoAazc95ayqMIhnCnDnpsXyq25potm+P5r0T778jjaEn26V1q2iIw8UyLHYc8ah
 YUf4DARzmi+a6dojzyDqFsE4Mazudfas8gK4FCB9aAnZ1+R35YtV0tupvJfbn4AsNcj5ON7SG6P
 NdVjp7E6DojZ
X-Received: by 2002:a05:620a:f0c:b0:939:6dec:55e7 with SMTP id
 af79cd13be357-9396dec71a6mr477351085a.48.1788418663430; 
 Wed, 02 Sep 2026 23:57:43 -0700 (PDT)
Received: from
 runnervmgx7h7.klrlp4dcigdejebputcgrj1dlb.bx.internal.cloudapp.net
 ([172.174.167.18]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f3b3c2dsm424742585a.41.2026.09.02.23.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 23:57:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu,  3 Sep 2026 06:57:42 +0000
Message-ID: <20260903065742.9944-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903033219.4747-2-wegao@suse.com>
References: <20260903033219.4747-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Extend tst_assert_ulong() with enum flags
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

Hi Wei,

On Thu, Sep 3, 2026, Wei Gao wrote:
> lib: Extend tst_assert_ulong() with enum flags

--- [PATCH 1/2] ---

> void tst_assert_ulong(const char *file, const int lineno,
>                       const char *path, unsigned long val,
>                       enum tst_assert_flags flags);

The continuation indentation uses spaces and fails scripts/checkpatch.pl.
Align these lines with tabs, as in the surrounding declarations.

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
