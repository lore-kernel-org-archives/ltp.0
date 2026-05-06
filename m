Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B87CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1124B3E6AA7
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:18:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F6E93D227C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:17:53 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7F87600199
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:17:52 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so814678c88.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778077071; x=1778681871; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJ/NyIi19fdmpJhi/FNXuaor7J5GM99SA776Jrk3LIY=;
 b=VWeM612rkUjRleRfVBHDEZqOaxfyn85TaA8YC4jQ3XHg2AmGWyu7HMvkHF47RvC059
 sgMFJRqwIgbN+97m5RGAFLuxZOC8PaQZb4dW0udBUPPu5xMGb9tOhMJXOqBrDiv4n0/F
 4wY6P2DLU21B12nG7ZT9AiHaeXmbBcHemhmsDTmgaA7eZgXf5IimYb8teieE1gQih8sW
 Ww7k0mMFLdZ5ERlx8h0VDFONiqYjhsIMAMHW+JVNbtG/5zbhrRIfKKOmiSlL0vlMrQBn
 JN2VUjYQA6clfQe/AA3xFbnCAWRbOd9jqrsSVnn9mOJp5GcDRvZwGKy32uzyO+ZRFjf8
 r6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778077071; x=1778681871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CJ/NyIi19fdmpJhi/FNXuaor7J5GM99SA776Jrk3LIY=;
 b=A/guRQRTl6by2ADXK0fTuzKRB4oRpphEOKY3cmSjZmo2aAc/p/WH21gHSzWiSRrPXo
 tdpn0YfQley71cFPVRWfUnKTsSQTCozv5J7SxZ4/JGAQ44ddZCwApLIGooNWOyy/6T/k
 3yTq7tW13NP5Fsm3Qp5cdmipxTm/pJIZ3nzhvVdX9aOmzcrn70owRb5JcxXMFI/1NW2p
 ZFoz6F0OGpb5QqTmK1dRJdCrsqbabCKH2sEM2k8++QQKqh7LI6Ib1oe1I1Bl66j4e0yN
 wCV2VqnIoSrFts7dALRzXc+Yv+Y0311LaoFrXH/4d37f0jQ1iSr8Pg6mpSUT+xuKmScS
 l5aQ==
X-Gm-Message-State: AOJu0YwLiFpTOa/6LhvXU79PxHYfrglWbgp3wEtz8g9Y+Y7QHrK1uO5K
 06b4UuonaLAWLcyxt9ocJH6KwoD+3Jx0m8F6GUy8L2GbfGSpHsuDHl5c
X-Gm-Gg: AeBDietuA2YJGP/BWSJsDap/qwFcEnNmFWXG3BEn/r0USoL5RQRJnwELEJDxyBsENjg
 vh/BJo3ypyw9H6ap37NdrR9lH1Oj+Kza8u6wog+Gh2376tIfzM9LqbkiN/w69yNS3AQWyt8KOff
 MTkxmpfXXYPFpmBjQLLc95gioY1dKV7tj85HrI9D9mpMDDc+wnWq6X0+TwJd0rwJlq9c+E/wURO
 LiMLOd1/nrcbYFfIlWF2ZoXWy+lJQ+apR780f15C/J6vvKCh4gs4RHyhZfLgo4EXjwPY3GJfyUU
 zRt4CDFeb0s2P1c5FDY2TLDch1Yw/4Zq72Tv4xBGBcw483hLsd1tFYRRDLIGmlgKC56IpibgAZh
 b2Z/24+R5k6t2wqoPbYz/gYxEogMBqu6Il8XU3dm5Uu5iiMuB9cvDZtASXIwIeyp1FFRHsZCvlY
 SG3tRuMQ27Ji+ELatXcy0Ml3WcH7+P0TyDXftxXDmvoYd5EizavPeGZD2szZkP8a/amB/IUtrbZ
 F9IojOCvQjjIQ3jQpK2VM0eqohCRUt6fN0kID4CjVz53hLxwdus
X-Received: by 2002:a05:7022:45a2:b0:12c:9037:5126 with SMTP id
 a92af1059eb24-130a98f8ffemr4040903c88.9.1778077070961; 
 Wed, 06 May 2026 07:17:50 -0700 (PDT)
Received: from
 runnervmeorf1.euvoypmqv01u5lz5obefzjxsjg.phxx.internal.cloudapp.net
 ([20.163.83.246]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202db1914sm3833036c88.11.2026.05.06.07.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:17:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed,  6 May 2026 14:17:49 +0000
Message-ID: <20260506141749.3914-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506130808.76820-2-piotr.kubaj@intel.com>
References: <20260506130808.76820-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

On Wed, 6 May 2026, Piotr Kubaj wrote:
> cpufreq.c: add new test for cpufreq sysfs interface validation
>
> Runs various sanity checks for intel_pstate cpufreq sysfs interface.
> [...]

The commit body describes what the test does but not why it is needed.
The motivation ("LTP has no regression coverage for the intel_pstate
cpufreq sysfs interface...") belongs in the commit body, not only in
the in-source doc comment.

> +	fd = SAFE_OPEN(path, O_RDONLY);
> +	SAFE_READ(0, fd, contents, sizeof(contents));
> +	SAFE_CLOSE(fd);

If SAFE_READ fails it calls tst_brk(), skipping SAFE_CLOSE(). cleanup()
has no fd handling so the descriptor leaks. Use SAFE_FILE_SCANF() instead.
This pattern appears twice (~line 184 and ~line 298).

> +static bool setup_done;
[...]
> +	setup_done = true;

setup_done is never reset in cleanup(). With -i, a partial setup failure
on a later iteration sees stale 'true' and incorrectly enters the restore
path. Reset it at the start of setup() or end of cleanup().

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If you
find issues with the review, please comment this email or ignore the
suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
