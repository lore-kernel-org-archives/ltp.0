Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8243ACD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 17:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4A4B3E6EA5
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 19:04:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 190283E5E99
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 19:03:47 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A7DC14002DA
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 19:03:47 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so6514923a91.0
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781111026; x=1781715826; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckEwsJE9c7CkGoGtDEjZIL+xDsBETmzAFeedBHbKf5Y=;
 b=L/r/jIW2ik7z/pcKe9453iVKl/JY2Tuytv+gQtQL+D/KUC08g63RcUAbIrHPYtxO/B
 2uKtq3Zg4dlXv68LeqonFmLpYhj+m303Dz7zkYEaKevo7S+tFs3Ho9ZbDybzomZe7uQS
 6Hjo1cCG5zEfhadfoDEtCYbj527mussvVPn/3ES6igFRESQCCvMnNwpJ7t6i7qF2orEz
 Hw3UQvKH0CZ63wW6+r7CSisRuRwbnjkLi4Eh8tBJVwrp4NkOBqgQo4oY/qdpA7AcRa+c
 sEqWCikiYX9TSqeO32XZ/+azQJo4ZDPQeQTeCQbT/YwChckBkjPyhPixORKzVq/elah+
 5DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111026; x=1781715826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckEwsJE9c7CkGoGtDEjZIL+xDsBETmzAFeedBHbKf5Y=;
 b=eak15loUSvd5dKsYHLFHg3EVt+23yc6iz+8r6xchM2TEo156/YaeJU2MQOMNvv9J9p
 F5bOmtnwagIkIKOAX4/v0j+KNiJ+4esqMA5wdXOmQEKqt//xRoBsXyCbosNzAQWGere6
 bOQJWoPzwFj3od0Gjh1OPpDTo/GFV8bqkdEEvBBYarO7EIQh5yuDvJ1J7N0KL0S4rnRB
 LL/TcYKNA2aD48t5eTcLTFWyILTHAgmquC8WVVjpHenYHK9hfrVoUQUAjU5pJJWEaTKm
 L1pd9RMYL1pObUhS4wijUc6MxTyCVtcKuLYGUz6WvBvOoCNJTxC2B4kySy6Kc6MwFGh+
 TYvQ==
X-Gm-Message-State: AOJu0YxJ07exBzxx3Ynouy7C4079CRbZ1U+wZXe9ogfpd2dj60Huxddy
 OaOOg1oxuDLd78A0TJY8RCFIi2SiDqj4t/erzt9JDpl7Z4vWDMlOdE2A
X-Gm-Gg: Acq92OFNxvscP+KtSN4VCm7Odmk3QWghQ8i5cFwKtJ8IxtfdaI+Q8zfiHVzG40mMm/3
 tOoTdxWGOQixjiK1+1FkKO8sby1A4OYxhfegWCPrwgYwxyTFOatGF5c4rLikcs06fktVuib487F
 cG/rcZ8vjFA8UnFwQiaXnwHcOzZcOWDMyuo+aTeSAqAzLlBFLra9JOBAWqJMblmZrIvOI7hX6HA
 GmPEFzmEdoIvDE3IOCNEjrNC9I+UzxJjd+3oqiVl8LTnnpLsn0nsZhe5rpFGMpB8xrdR50gkdwA
 XP8Pe1kE5iAmC/u97iOcuUtRg3S5vlCGPtHZGPxL6MM8WH5I0jwBPHV46n9w1ZZa2IIUS4Y95KH
 6vVssN6jofgv0E2M4uDJu6h2LEnalGHX8HfGDR8n3X/NCqn9NgLIuEoeMmLwuODDyXl0yTgmCBv
 CLYmHTJL4EHJQ+JhMVt1T9b1AdO26gLc8cz0o9pgnPa37hv/hUHYgmjpvlaj+oDtNpciMhOIYgT
 uB1Ic88k0jgw01z34M4If5lskEuTDQvOAF9W4IZ8k58SPFE
X-Received: by 2002:a17:90a:d40b:b0:36d:6315:1de4 with SMTP id
 98e67ed59e1d1-3774864eb5bmr86393a91.17.1781111025676; 
 Wed, 10 Jun 2026 10:03:45 -0700 (PDT)
Received: from
 runnervm3jyl0.uhw0sbhxhnzetlooflkaa2yddd.bx.internal.cloudapp.net
 ([52.188.87.55]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c4d7absm215470671cf.11.2026.06.10.10.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:03:44 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 17:03:43 +0000
Message-ID: <20260610170343.4168-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610-fw_load-v2-1-fca6faa237ab@suse.com>
References: <20260610-fw_load-v2-1-fca6faa237ab@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fw_load: Modernize ltp_fw_load kernel module
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

Hi Andrea,

On Wed Jun 10 15:50:44 2026 +0200, Andrea Cervesato wrote:
> fw_load: Modernize ltp_fw_load kernel module

--- [PATCH 2/3] ---

> -MAKE_TARGETS	:= ltp_fw_load.ko
> +MAKE_TARGETS	:= fw_load01 fw_load02 ltp_fw_load.ko

fw_load02.c is not created until PATCH 3/3, so building the tree at
this commit will fail with a missing-source error. Each patch must
compile on its own without intermediate breakage.

Move fw_load02 out of MAKE_TARGETS here and add it in PATCH 3/3
together with the source file.

> +/*\
> + * [Algorithm]
> + *
> + * - Create firmware files in the standard firmware search
> + *   directories:
> ...
> + * - Load the helper module with ``fw_size`` matching the blob size

The algorithm lists "Create firmware files" before "Load the helper
module", but the code in setup() loads the module first (line 111)
and creates the firmware files after (lines 114-125). Since
request_firmware() is only triggered later via sysfs the order does
not matter for correctness, but the algorithm block should match the
actual code order.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
