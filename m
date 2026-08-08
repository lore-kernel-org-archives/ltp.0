Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922DDC5AD2B
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 01:33:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7974D3E706A
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 03:33:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944803E1A83
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 03:32:50 +0200 (CEST)
Received: from mail-yx2-x03.google.com (mail-yx2-x03.google.com
 [IPv6:2607:f8b0:4864:41::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57B8460070A
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 03:32:49 +0200 (CEST)
Received: by mail-yx2-x03.google.com with SMTP id
 00721157ae682-81e7a64294cso266567b3.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786152768; x=1786757568; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ToMwCu/logacnYvJ9HELT8hcObXkShu4L5+1cUqXPg=;
 b=pas92jztr5m8i48pqBPk7lHUAR2Iws83NykzM33kqvr7TQdzHO4Qb4PVX9GHYwk9Be
 zCw39hvodDPKcowz6KGVRKnF0zwSTlu4O9IiQjKLj8Q3zaTQtMiqYD0QuPEI6mAXwCFp
 bHeHqkacg542rgo/AoQ4eb8NyGuQTFrE/5qMI5I+UwwFn5NOOSHzLJLlD2bxsoQm0khY
 k++aVdbzgtmD1KqgQw41RaNZlw/kzeEkDoaTY4o5M+DUoEzMx+kcTqjiwu81LwAAJO12
 GQgC/jyfrqubt2S4inTWHJlcNJuJ0H9fVoOA7JdUlZFl5rSK3eRGYwRCPqNjHYOk1ClR
 NVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786152768; x=1786757568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ToMwCu/logacnYvJ9HELT8hcObXkShu4L5+1cUqXPg=;
 b=N21PahCr4+pnZXdCB9auDNiOhs5YSLcKoVNU+6G9DYD4R4fgTpWJi58CmGdqdwD1A4
 5VJjviHDKxGvsYNmoXuh/7SL5YXX1IGRx5GyvRynPRMuT/qD/RLLKo+Ho/ud6RfFc3eD
 Q2yhjvsmEfWW9Ov/Go1xksIrCQkS/ImJI9RDP4sLgenElpMhudz8tWCfLo5bAaakqxhI
 rMMftXAmoMipTlAp0p7f5m8pGw0gcPFb427pjYPLZqZnaIzyGxNcogx0z8TbUSjlV4FR
 xzJbGhiMzesyUt0bmMWR7t1hplooWvMsoSy/ucj/Am1jB/60ns3zMI4My3NWD+YeNLZZ
 nzlQ==
X-Gm-Message-State: AOJu0YyPrrFFY0bgXgXR+0kMxIdDgoVX8mlOLR9i5LZTpKKyMmij2Mwd
 wyCEpN0U6Z+10BYd7S+dR8BdMpa44JM7J9RObvmKYmeuKOHch/QSCW9m
X-Gm-Gg: AR+sD128lZOnQ2O/PyTVtAur68JTjyWvHaJSnRS7Wyuxkn6Df7Km1oNF7fOZSMk8WbK
 +3P3mmrcoNaoF2Jaru5+acQFK9dj6PPCnS8e8g/DX4swqJbK2qNz+uKUcMlS/WSOr++Br5x5fYN
 u2zUPuCqm1t42pUPAWfHlloFr2Zqjm3rz+Z3BFVA1di87S+6AJD2bbKlwE7OAUQIjuraCdnyx/w
 iMJzZhm/K9LhQ0sfv4tbhmPliRSjVhw6x9ZtjEQgmfNWcWNmu0aZTXhMOrmKpA07iBSV7trnZX8
 TleCadwoNrHtGSXxjD3GaMGzcVFf7T7UmGSWzBKVgGGdv5xVdwkC58GwoY831JcNxecwZTYM6fB
 6Fij9wF+UzWxWzPJqodBMZkMPD+zbjeHr8Id+ntvaRp+mcP8iQzZgjw0qbbZ7N5XLpTmxIW1eRJ
 yVds8RMe57+z9quAD6qmzF+0OvK3/WupDnXPK//+XtLPBjgMPrwl19JPlnnPVo0IRJgupvebznM
 dlS2XsqjCOscSoKbcU/dgTNupS2GSOVN3SUAt6t2W1iC20FGd2vDJ0j2crtJxBoplxhLy6arRa+
 ewTnRopZEzBbvA==
X-Received: by 2002:a05:690c:368b:b0:81d:bc5:4624 with SMTP id
 00721157ae682-8225d080ed3mr84098917b3.25.1786152768055; 
 Fri, 07 Aug 2026 18:32:48 -0700 (PDT)
Received: from
 runnervmvrwv9.0xavb5yt4blube0y5vrnuhw5xc.ex.internal.cloudapp.net
 ([64.236.177.118]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8268e2c9963sm1948457b3.4.2026.08.07.18.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 18:32:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Sat,  8 Aug 2026 01:32:46 +0000
Message-ID: <20260808013246.12398-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807234935.3248935-1-wakel@google.com>
References: <20260807234935.3248935-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use backoff polling to wait for loop device nodes
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

On Fri, 7 Aug 2026, Wake Liu wrote:
> lib: Use backoff polling to wait for loop device nodes

> +				path_set = TST_RETRY_FN_EXP_BACKOFF(
> +					set_dev_loop_path(rc, path, path_len),
> +					TST_RETVAL_EQ0, 1);

Could the backoff arithmetic be made overflow-safe before these two new
uses?

LTP_TIMEOUT_MUL=3000 is accepted by parse_mul(), which makes
tst_max_delay_ 3,000,000,000. The unsigned int tst_delay_ reaches
2,147,483,648, still compares less than tst_max_delay_, and then doubles
to zero. If the device node does not appear, both new paths then retry
forever instead of honoring the multiplied timeout.

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
