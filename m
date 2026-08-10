Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5069DC5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 05:28:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C59943CD382
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 07:28:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 826DD3CC629
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 07:28:04 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 10A01140019E
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 07:28:04 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso14006375ad.0
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786339682; x=1786944482; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J7FRQXUaOzNAV0WiEluN7bGSD38VeElor/e9QciqeN0=;
 b=Mh/U1lOvNHrZv1r5OKMuzs8LX0qJFb3qpxcOIaRsNGPWBe3PJNeX8S9fycaoDrm4Sg
 ovjof0LnGzXp8+NfQZvg3SrHbeblVyZNvKfYLnenAILpbZMpjVYEmMs5b5xYj0RCwEi4
 ktuiNT+YeYKaYejzUzNozrMUL6FLvWiUD+AlO4t2xCBsuQQgqN1I80LotyBEO46UqGcD
 fAOv8xmjPiRGcjKEJsFVjIWxXrWiQl0HnRFVHiUwod/AChUYOuT3e++0YAS/wnJPRUMx
 Zv58l2TkFWomlYYAAgXH5ZPkvDSGySLcOZnUN+lf1xB/b4syQ358bYb0RUTzBBsTLa/x
 KlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786339682; x=1786944482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J7FRQXUaOzNAV0WiEluN7bGSD38VeElor/e9QciqeN0=;
 b=Dd9v8K6grpn4EXHdi9E+e8OgOBxhpJurh+9eQI+9plj2kHx8nWxXYi3FVjlbfCRXPt
 eRBslnfhTQzrhLAnYjseYZNSGH0/k4GjM51ZlTHMk+4a+WqB1lFZPPr2U/fUDBmGoqWL
 k3ZtbN3Cb4TbmrDRKs5xDN6SYmJ+kE5XGLfyrEjoWKPPn0RkMwfoy340KbfpqS5qYfdi
 AU2t3N6h4qEU1PBt1UUTk3KWARJ7wyF06azvCKQ7xVI7vN6ZwqSppD85p/GnNMRiK2WU
 knnfRKHZsZnCobij0uciDlPGIQddoOGFyLtrWmxQnqIUmejGp8tUpqHT2K+olHsFXduA
 gRSQ==
X-Gm-Message-State: AOJu0YysUuQao5325K/t5ICpc2+CWEYZZuk+8nqBg8b9Yc4lVqR3+tcd
 7fzX0u6QkzZNPL3476aIjC4mgjSUo1ubZrufTcZXHjx93DupHhW3qZ9Z
X-Gm-Gg: AR+sD12fOlioytiA2vEArc1aqAHYUe8h83Vsk4lhbLxjTm6CwqnJtydX/VqdqsCXwvB
 w4yJTruRrH5qIYrl0DP94AndNLwE3i2zq1X481p9vQBZBsOhwyte9CMvP4NnihnGpPMa726k3F2
 GoCv+K/flmcLw8hQr97rFGU+BV2ZBJSHDqmqEWkS0StMMp+WYu8J4FDlsu5FQhqFsCuJMWuWCrQ
 So6Qa1CQYMk+f+gtSt8300zcRu0yAC76mJicmFga4fbqGoPa397msrdyJYw8ZzT+hjpv97q3Seg
 ZHB039xV7Jdy8VMm60SkVKbh3tm8ALdGPD/JuAmxix0Ct20aX7L3JBli4xaRqTRBP7dMhapL1Mi
 GKEwYGSEEEkfPbfOdGHZM7gdIehm9rLMt9DFe6D6c6XZvclEs76ijv2QYJ1kiSnLKSUmEZ1FjSL
 K9XDuhNYtZ7HgD1qdJ49npXCVtkC6k/9HebF9IXHMJmwI0M0r4dbPwnksRgPZ2HRBx8/nb/1Dg9
 SYFvDdginYT3ImDOy+aWzSeKoF0JV5E4hvVhLpHKMQvFBFHF0/fS2f7ADFFUNjSq50KuoMre59k
 IDg/ILTHIiU=
X-Received: by 2002:a17:902:db05:b0:2ca:6d87:cda0 with SMTP id
 d9443c01a7336-2d294b4b169mr231166105ad.6.1786339682271; 
 Sun, 09 Aug 2026 22:28:02 -0700 (PDT)
Received: from
 runnervmvrwv9.zp1jdlg1lluuxdof1vfzjm5fwc.dx.internal.cloudapp.net
 ([13.83.160.129]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb87d3bsm40643937eec.14.2026.08.09.22.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 22:28:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 10 Aug 2026 05:28:00 +0000
Message-ID: <20260810052800.4140-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810041738.1714971-1-wakel@google.com>
References: <20260810041738.1714971-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] controllers/cpuacct: Dynamically adjust cpuacct_task
 execution time
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

Hi Wake,

On Mon, 10 Aug 2026, Wake Liu wrote:
> controllers/cpuacct: Dynamically adjust cpuacct_task execution time

> +	local duration=$((100000 / nbprocess))

Could nbprocess be validated as a positive integer at the start of setup()?
It comes directly from the second command-line argument, while TST_POS_ARGS
checks only the argument count. With `cpuacct.sh 1 0` (or nonnumeric input),
dash treats the arithmetic error as fatal, so execution bypasses
_tst_do_cleanup() after setup has created and possibly mounted the cgroup
hierarchy, leaving those resources behind.

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
