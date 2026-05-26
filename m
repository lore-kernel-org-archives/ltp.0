Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABC2CD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 15:29:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D33B3E62BE
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 17:29:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C21243E62B3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:29:17 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5CF881000223
 for <ltp@lists.linux.it>; Tue, 26 May 2026 17:29:17 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso2149326eec.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779809356; x=1780414156; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWVqD3wi61mrqswQKBHIJZnaqrymwWXImLah2hqCH74=;
 b=UV5B0LvsL+DkkRSOrQEQ8cdp5mgSXXObNzmIhH6ed4aaGcCWEHoR4lUAtplNWvseZX
 sg2vp8rmd6H33d0wGI0r8hZeiHsyk7IPtFUQDVu8ql8tSDIeKLMe4fMWgzBPh73yNMcg
 yL61q91TdWnMsps9acqwa9QPOfWRCm0n5TQw/pgiPPlT2Z2ZfRXVGfsrsghoQXFEvyuw
 CQcODWqjKQ4yGj4DQzdZA2ts/gNnfR89O2Z2vKinRX76yNiWBTxMatGXx+nnzD00+7le
 w6lOgeZy6lwZX+WEybzGDoswLu2CyjFzCKKP6pOtTC9GU8VpirLKXLDnFRn5MgGgtZbQ
 Z16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779809356; x=1780414156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KWVqD3wi61mrqswQKBHIJZnaqrymwWXImLah2hqCH74=;
 b=BAS8oTBuvrVDzILMJXtNPFP5FCXYAFf1YdRpM9EQ4bGtEqtJe3MTWPrN7cDbIh4iP1
 XyaaqZwQH6q3aUJF4jtR4AxXcoUAOgvbJwmu5W9r9+4FiM1EgVtoomnFJVIE0TsTIAAp
 iLM3DQOP8pbmnObC53KiAyBlV3eIVQ1AUX15g3MZ6NGy60/r69UdZxG0aMe0AfRzBqiT
 8gzEL1fTqgRR2r4GXWbFd6drCTGUc+vZhEDDgJkEEAQKMst0FVRL43IhO49x5xvrWQTy
 wz5Ee5lc5o9tzcPoysBST5TIGY+qP44AfTjA1nI96EcRfWsCTpZuOVqv5WkfKP5Q9uCH
 daMQ==
X-Gm-Message-State: AOJu0YypBx4edfJFmeQbHuN0K/iKYeGIPn4VnIJAFhf9Q5YcREry1d8W
 QgC2q22dGnbwxXUqmWprzaHvO9qAsY8ADT2uu28QBm8Ok9rFfTuD3fkt
X-Gm-Gg: Acq92OF1tZVHj9Y9d7x/WpWImDX5jnG+EI/rUrxQA6WdpOMZU3eaH7IHkR8o4Uoy7cx
 wacXGvrOH+53HV5y5vgmjAUxREZzdTneuBU8vwZ3evLuL7RGv28axlF2Qy8EhIoeM5pXLO4pUun
 LVtiPXSRue9hzUrdZul7wFvNkVdbE0cpOyuN2gVRvyzz5GdImhxjXeeT2fWVTMPkF58E9FBvGyK
 RMeme/HgYB9/oL7iLGByD9vDnWqR/M09EcnwPkRlxFb5L6HLUyTuZr5ReIw6l3rSt0wrfPu+qKg
 l+ytuJxOEF8nbVv3GwfJ0iBlSUWGh03hTDjRBVR9LlkvKRUKtvDVTQ5wJwxUzKN8WSpVMEHEKSh
 xVQAJh3D+9pIQbwuFAA14Lg+WrkZ0HPnVZxs2pEMFv35j4UV7JvHvTiSgApk7qaxZgZh2H7Gpc7
 BP7PNg5cclftZLkEMcmtHFmjwLW6P/WJvx3cUplNTzLZBa5ZdjB3fbrT3ECE1wnYmcfLVeL6T4k
 /Z140Mb7dGrVfb3KBOM9hdnEJ8Tb8l880xAfq4=
X-Received: by 2002:a05:7300:ad2d:b0:2c7:ea98:d94 with SMTP id
 5a478bee46e88-30448ffda4emr8297293eec.2.1779809355609; 
 Tue, 26 May 2026 08:29:15 -0700 (PDT)
Received: from
 runnervmg397c.g4nerqiq52bu3pqkxddim1hjba.dx.internal.cloudapp.net
 ([20.189.181.74]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3045245f4e5sm10959422eec.28.2026.05.26.08.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:29:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 26 May 2026 15:29:13 +0000
Message-ID: <20260526152913.3671-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526083650.14036-1-wegao@suse.com>
References: <20260526083650.14036-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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

On Tue May 26 08:36:47 2026 +0000, Wei Gao wrote:
> min_free_kbytes: Handle transient memory drops in check_monitor

>  	struct sigaction sa;
>  
> +	end = 0;
> +

Good catch for multi-iteration support.

> -		sleep(2);
> +		usleep(100000);

Changing from 2s to 100ms makes the monitor much more responsive.

> +		for (i = 1; i < 1024; i *= 2) {
> +			usleep(i * 1000);
> +			memfree = SAFE_READ_MEMINFO("MemFree:");
> +			if (memfree >= tune)
> +				break;
> +		}

The exponential backoff is a good approach. Total wait time is ~1023ms
(1+2+4+8+16+32+64+128+256+512), matching the commit message.

All good. Approved.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
