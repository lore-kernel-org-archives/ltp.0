Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0FCCA6017
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:35:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD2F63E2E20
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:35:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0B123E2D20
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:34:51 +0200 (CEST)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BCC260071B
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:34:51 +0200 (CEST)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-33baa8eb238so273853eec.0
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791624890; x=1792229690; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wXW8+1FQNVxHCpT1c9GvrpCHR6a1tW2sXwxNqGMqjy0=;
 b=sWRgBj7aGPGQrOJRpqBesKKQyXQR+smHgXxvsL0gGa6asIUWDrBK9DhHHXw8nOpm2d
 Qo9yItd9TOwEOADY6BtW3XiUcCYQSFAVPeq1RSwD16c4W4ZavnmYh8c7shasQr7HkDJf
 cxbehAR4sRxeuClOWW2kQsEm2RUZwiiHJcol7YwQ3GznZggsgplI6lA+8leS+T1lBJ02
 nIS1vH/00BhEMyqDCsZE+1F606R8xtQBNc+zGtOtppma8mi7xcsLMlMZWMIRDDpGMdqZ
 Si7V91fwTTw2ssQdLrwwP6020z7ly+o9PSHB4dnQEwyZo/eR7j2eEHcyh0z/E8Ve1Lay
 t/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791624890; x=1792229690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wXW8+1FQNVxHCpT1c9GvrpCHR6a1tW2sXwxNqGMqjy0=;
 b=1hArINqGGSzJx/wcbUXRizqjGsmM/eJLIRfuMVB3zxoa75T0/LjvRFMfFtc0C0hnOD
 8z5JFzsD8vT7PD91isCDi9HqSse0sOrAdHgYjHCpdTz5MtKD6km95PFuqYMPksCYAnGM
 FP29ayxC3qAZyCMiQiXa42YeprMNqQMNpGyx8E3EO9eFWQ50j+ntugbu29kApSh9zNSm
 PYT+6tZWogPjyeHojYvoRM4LJgzib9wlCLP/NKioHDrkt7jYPClo0CncsA9tXGyBinXb
 Ob6OCkQXRH06fv9MwNiPFtTvTwIRzHa4CpTzDna/G7ZR+99znInq5xYo1EBwlu9fOJc6
 Hxgg==
X-Gm-Message-State: AFq9FYJZ9DC8CBF/RYHG4dLjEaD29vVtEt0P/kAxQXJZphi8sHBC4715
 Vze0Msb1qIJi0i+l6gvNyN0MDgjiAwgFwA7l2/BxlzwojcLh+VxpZRR+
X-Gm-Gg: AYBFou0ViC8CT0jU1/IV8ip+Q6d9+CrFkZr1cYjFv4betHW4yFNq6R5geIBnOg/8KEo
 H+oiHmhElVuzNRd6pTUWuXUqx62xyaxqSenn/QSIqYFP/kC1mf8NB6vLBw2AYrcwmeEbPC/dk4Q
 PbSR5Wq+MW2+gupK9yN4odD91AmN4BoZC5gCNXYfLlToF9UKNTOVGdoBh6vjE4bfFPSgU7fgT7h
 uGU9PX+1ep3g+Ty3bBL/yz57hTijc0MU2CJQ+a3cBWBw/MT415mTv8y4UQK2JsaQzAT3VaWsG6e
 aZgVqeseKCFE3Fhfu45i70Ek/NWSbtB/aIPWa4aLaxjtEbGkUSZryswbgntMKk+8wwL2j0jaIIj
 UCr70aopQJMlF2zoa9Oq/RdcBfpG+4zIjtAeeWvK5xBCi/DPVidcMeyHT+xWuilW7AeyJIbiQr2
 fh4eyzsQTOOFiAfTM/smnQ+ZYXOy6mJrTAylZqPQngUlwfB6vb8SjVRc5FMgFFQfs93X55Cxbx4
 +upllxErjIHrbp6VyAJ82bqGNcrGvvNuau3CiHKFtziVj1t+4X+K0ZGQkBFLiqVb6V2cQlA2lNn
 aAkdLvVz9Tsy
X-Received: by 2002:a05:7300:ce94:b0:345:84eb:7153 with SMTP id
 5a478bee46e88-3537e033341mr5955306eec.11.1791624889490; 
 Sat, 10 Oct 2026 02:34:49 -0700 (PDT)
Received: from
 runnervmmprz5.kwurqgh3ggeupncspab0njquae.phxx.internal.cloudapp.net
 ([20.168.127.89]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c61eaa0sm16349489eec.0.2026.10.10.02.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 02:34:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wenyuan Li <2063309626@qq.com>
Date: Sat, 10 Oct 2026 09:34:48 +0000
Message-ID: <20261010093448.8958-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
References: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/munmap03: Fix addresses passed to munmap
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

Hi Wenyuan,

On 10 Oct 2026, Wenyuan Li wrote:
> syscalls/munmap03: Fix addresses passed to munmap

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
