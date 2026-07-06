Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF87C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 14:38:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7456B3E4B25
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 16:38:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85E6E3E2D31
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 16:38:09 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C9E7600724
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 16:38:09 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e51e6879fso43226485a.1
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783348688; x=1783953488; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZ0JKGvj7kI3H7YZLJVCZQB63DyzoeyN7Gw0kFgSFvY=;
 b=XU8Yju3EzyZTAGwy4711qnxeGsZrdca+yCont22XV7Cdhicd98+b+wL61zZAdvRiMW
 y+HHec69brRjKpbJeldp/Wi3S/CAfH5SXo1LRHqbR7gEoEi6HfVR8OpAcFsLGHbXAYyf
 K9EUZCh8SHeuxsHOlDBrIpHPzUAH2Ua4HaRYyaZHG8bf5Xmoe0GZBPpEfon4bB9WQaBP
 i68VeQlpupuYmVhDRHMbr7PWkSFdt1KBBa94aAYoZ2RQFxQPmRp97ma4JXf992SHd5q3
 PKxo4956EyEeUE2pdg1WeuAwWmB2QxHapAV3nKrqV1hu1XKGL4HazdsmvVc0CdF1li9U
 xvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783348688; x=1783953488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mZ0JKGvj7kI3H7YZLJVCZQB63DyzoeyN7Gw0kFgSFvY=;
 b=TBduFS63AkmfOtpA0DtQ8y6I3Jvefk/22v60fT5fb1lJSmPHzPi5xPblvCT3b46X58
 FtKG4vFadgx6wHh0F5kfoRXlfsG9Je3bQKFCKFnT/Io7gsCqqWRwh743ElBJWLwmD86u
 IaH9R/fSdL0+E9/QGByitK39Lb0mcUTY7XGNwwaDBivf/nmU9ne/QXNNJhOjd7kRPKav
 4Zn//Fy7oxLLFvaL9c6nNcVaId+6Va/E7ATRT+3DUmP1lhe3eSh1rif2hPvPf8jkLQs0
 NW/cKJTPGaj7kM1bfOAL6uMqZkIJ243K+CHiXH3pTKgy2KWmbOZyOM4ndJdaKcMH/tka
 fKUg==
X-Gm-Message-State: AOJu0YykVJJZkna6FbF7/o5rla4N1XldJooRZpmVrfYrgPV/q4aSbRZt
 Z+CJnN/+2KtMQyGUGshV69lYkezOwAHWRrapbiBcaZAk7mzaI4dYn/DyTGf37a9n
X-Gm-Gg: AfdE7ck0yj8P4idZpFGm0EIdJLXcu+UXyiASdGL3Atr5XjDjGI/FVyYYxN/OGtR1lOD
 UC/ElBrMDOUDpwvr4P04LoGOUEJf+ni/zosZz/jQSgZiQI/6EI+FTFg4USher3iC6Gw/a+tboP7
 ZrLF54kUwkf97J3hm0fMKlq8SjQwuBGdjSHmYHjJLxlyaXKCGujKwtTFaWzDH3RjWjjeRZTeT0q
 TFQF2xYOZqA3YSe4eiOfmgzqRyOV6fS8xGVWjg0/g67heOOYcFRncKy6RUujPxb49ckE3OPUoCr
 /miCVsK+eDc7M5/eNanKYgcY31CR6ivZQu3JaRSVHXwse7mxawvKWMKpkXwq7/DY4o4WhrqVRhx
 SDZ4/lk7YoS011wUhtu1xiMcU54Ic/UJmLug8HDXD+5HXOAzUFdLbNI9puhYyfnOw6o3QYpreMu
 5DVVaGSxJCCg961gQIPdy78RR1aaPSasYbVph8d9l5h6uEMB8TTtM6OBhSRkWxRxOTqrKmyorK0
 PMi2nqrlTNkLhz1gqP96D/hmA==
X-Received: by 2002:a05:620a:1981:b0:92b:6805:91bf with SMTP id
 af79cd13be357-92ebb5b87c3mr116818585a.71.1783348687666; 
 Mon, 06 Jul 2026 07:38:07 -0700 (PDT)
Received: from
 runnervmkkn4f.wogtp2pjreuubkqbji5x52h0da.bx.internal.cloudapp.net
 ([20.62.207.4]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90ba7e62sm961784785a.13.2026.07.06.07.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:38:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  6 Jul 2026 14:38:06 +0000
Message-ID: <20260706143806.4130-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706-fix_make_check_landlock-v1-1-46f821b20128@suse.com>
References: <20260706-fix_make_check_landlock-v1-1-46f821b20128@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock: fix make check warnings/errors
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

On Mon, 06 Jul 2026, Andrea Cervesato wrote:
> landlock: fix make check warnings/errors

> -			if (strstr(readdir_files[i], de->d_name) != NULL)
> +			if (!strstr(readdir_files[i], de->d_name))
>  				files_counted++;

This inverts the condition. The original incremented files_counted when
de->d_name was found in readdir_files[i]. The patched version increments
it when de->d_name is NOT found.

Removing the redundant != NULL comparison should produce:

    if (strstr(readdir_files[i], de->d_name))
        files_counted++;

With the ! prefix the count tracks non-matches instead of matches, so
TST_EXP_EQ_LI(files_counted, ARRAY_SIZE(readdir_files)) at the end of
_test_readdir() will produce wrong results.

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
