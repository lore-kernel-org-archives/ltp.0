Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51043CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:15:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE0273E6162
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:15:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC5933CC6A7
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:15:23 +0200 (CEST)
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com
 [IPv6:2607:f8b0:4864:20::a42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 47E0D1A008B1
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:15:23 +0200 (CEST)
Received: by mail-vk1-xa42.google.com with SMTP id
 71dfb90a1353d-57513ac61f0so1291815e0c.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778076922; x=1778681722; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7yDRRnhMjE0yzaDkIdyY4wTIQBbcg6pW/tKtIBnrac=;
 b=mHBTjsVw5lXVKaTbZP5Dmf9572l635HoZEP52NSftcQrr7jR4PqsA1/1FNWB7AIPtX
 P2NOvHauGLqzddgiQfFe/jhLH9znIu++VRpeS8pw02ZF37RrNfQ9Dns7b1gerKwgVC5Z
 Vv/qzwIEiYN93ojOifYBBTVmePD1VazpFAnvkuurZPyQv/NoR66njeBOf8kpGLvHHP4S
 O0TnV6uEc7qDmIA9ZpLsQFARo/StDA5CtlJcd9q6pbRzKVOGZdUkAdmjDvTIo3pdipOw
 EyFCvtaJbw1HETHXe4l56CdJHbA/o0V9k6lL6GAr5QO0Z2GMEwIHcK1yoYESAuq1PdHk
 u1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076922; x=1778681722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o7yDRRnhMjE0yzaDkIdyY4wTIQBbcg6pW/tKtIBnrac=;
 b=CVM1Eg3Q0rtipbGwolqaoojXTbfRM7hRm9Aj/WrWNW4EJO6x2pfM5aVaQoq4IVblNb
 QgyjZuV085MtzVsSdZpQc0hiUkSed4tjrrRA+RVXE9pLsL8iCm4kH1cQ3k1Ko1DzQ5rm
 fdyg3kba4xLvw3T0nouIP8bZ5OuWseIcwk+gScZKwoJ8EnTbO63It7643e+MrN+vZRU1
 eZa14fLIaR6wKCM+EDnqJa8mZ9Wcsrn825Xz83tA9UDL0fpyghoZcXntGdi3W+pVynkd
 CJz4gDcA2tRfNrjmadl/jKNJLdHJVIP3e7PHw9VOZpoRBYZZJ5s9Ow2k2M9KrBcDTzTA
 E/tw==
X-Gm-Message-State: AOJu0YzOOsWAUmuiwbowWjML5CEUMhSY5Qbv2wm8hCGRFFK7hjZTQhEa
 jHMtkndphh4LDwJh9MY2Lx2ClkwQhnA7Ik9FgmIFhGagOJIcnr86G+/w
X-Gm-Gg: AeBDievL4vI/fADY8KA2hkzvohaSe1gNne5Gs9UNVMa5j8L9e8Lk+yvosQW01pDMqtj
 aofo/Oflok4ZUrQ1agujkWUWYhpufGtve9jxnn67BBBL67LLTJGn1RbS7VexvawXyP3qGzpRLJD
 NDGJjFPOMG62hgpkaVfINPD8aUN22Kmn3UD34RNdt95DY+BDmxSs5bND1iGEbuNSOgCZp1uyQAa
 TN6cWMxy6E04qrdXsxX29c++j4YDV6fxU+CAprGxKak0dR8csrZrUOEXJ6eBrin9WLLg7Nqv5IK
 LdBiS3IDYSnKYSXPTBD8k7adI/iGhVjUZ9ra/bqKddKE4WCgcc8rCPm4JvbpqFcX4XKBj7w+0dz
 8X8HdD/RBCxZGaxqoparQdNySdw6c+bdoSjiwlVVrRJuxQuZMtH4MSp/1ZOjmfJ7RBSpJRkHBTr
 L8YEu1LoZhXg8GYeINkpyvY/tGaDmaneAPrOC5ZubJWO1k83QyaFH3l1qPLek/py5oPqFB4OfJ/
 4L+oIlvg/X5qNdi+QQNZDxMa76r+RYJl9BOu223cCWnlsFJABo=
X-Received: by 2002:a05:6122:6583:b0:56f:1c32:bd07 with SMTP id
 71dfb90a1353d-575594ce54bmr1786299e0c.2.1778076921807; 
 Wed, 06 May 2026 07:15:21 -0700 (PDT)
Received: from
 runnervmeorf1.qklmdoxenauenk0l4vssqyhl5c.ex.internal.cloudapp.net
 ([64.236.192.148]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d83114fsm177383706d6.48.2026.05.06.07.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:15:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed,  6 May 2026 14:15:19 +0000
Message-ID: <20260506141519.3975-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506125650.75616-2-piotr.kubaj@intel.com>
References: <20260506125650.75616-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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

Hi Piotr,

On Wed, 6 May 2026 14:56:51 +0200, Piotr Kubaj wrote:
> [PATCH] high_freq_hwp_cap_cppc.c: new test

> +static int *mismatch;
[...]
> +		if (msr_highest_perf != sysfs_highest_perf) {
> +			tst_res(TINFO, "cpu%d: sysfs=%llu MSR=%llu",
> +				i, sysfs_highest_perf, msr_highest_perf);
> +			mismatch[i] = 1;

`mismatch[]` is zeroed by SAFE_CALLOC in setup() but never cleared at the
start of run(). With -i N, stale flags from a prior iteration persist and
the per-CPU summary falsely reports "MISMATCH" for CPUs that are now
matching. Add:

    memset(mismatch, 0, nproc * sizeof(*mismatch));

at the top of run().

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
