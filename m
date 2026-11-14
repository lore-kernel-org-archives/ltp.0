Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1968606A334
	for <ltp@archiver.kernel.org>; Sat, 14 Nov 2026 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzVTFiRC
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 861C73EAACD
	for <ltp@archiver.kernel.org>; Sat, 14 Nov 2026 01:03:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4B93C0960
 for <ltp@lists.linux.it>; Sat, 14 Nov 2026 01:03:28 +0100 (CET)
Received: from mail-dl2-x05.google.com (mail-dl2-x05.google.com
 [IPv6:2607:f8b0:4864:38::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35894601291
 for <ltp@lists.linux.it>; Sat, 14 Nov 2026 01:03:28 +0100 (CET)
Received: by mail-dl2-x05.google.com with SMTP id
 a92af1059eb24-1ac216daf7dso499784c88.1
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 16:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794614606; x=1795219406; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1UkbmkHQfsxUS0JLAjXnc+HSeJpQr16f7nOIEQm9hWY=;
 b=YzVTFiRCqqQ9GrFyTm43o19/6X+tznxZjYSGhqokvS2zEuxOtFvSfOFGI2TflY2Pi8
 QuNKt2tfEUTIoKRz7zhbewymJNbwk828uEAcChxif10j3kB3aZRTAV/Dgb3JjqeaGay+
 N86O6kmF8U6ckhKVpN6kMmVw9lLqyzQDh6fFCs+VPqLUOnZzMDU5H/ehzsri/fy/zvAM
 EDBLDpAcqPxILAg9RWkda5IC3gUS1jkLIHKyyPWfPDT3ZJRm/MhksoPEpzg6IQmnmL7/
 xrU5C8Ki1KXHpjfXaJWJIKnQc6jq5NgH62rWIqr4FfKogw1OVIH/Qz5ktCXumNolO1g5
 Og3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794614606; x=1795219406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1UkbmkHQfsxUS0JLAjXnc+HSeJpQr16f7nOIEQm9hWY=;
 b=NtuqmEf40/+SONQaO2remZgjG6qoTLoUB8Gkj+LT3h2nruZcsiMpjjS8M5EV5rlFuI
 Lf6wS1jDJZt21SOmKhMcT0K+RCWqqWV1uRSoK9rOiWUpSNuFE79S+EQjZU8jezccg1IH
 YC7gS0pJ5YKT1YA83l8QO00wNKUSCKQ+hTJ2Vzun15/ZIjHjPjVIwpzlf5hAxyzuJxXG
 BXHL4SyeLywOzzt1ncsXmnixYHl1NKATAWQIrekUqmEXd7Riwq/CoItnqoDLhNv7yH9C
 Av74kP5kiBWbkMwgN8+wPwxyBQG4Bk2T4R3NFvsKlfOo7WDehJOcgzFgi+SbwlGjn17W
 +KUw==
X-Gm-Message-State: APuU4Z/dJAasmhIFVsm7Ao8vYo2fU/3sBzPN7T/O/FX58qIinLkRO1d0
 Q/GMouhf8aKyKpN78r70yPzEsKotmFAuDDY5sQquPx/GbiKl5nSSayWU
X-Gm-Gg: AYBFou3YHvRRnd6raukRlm9EUjHNCTvrY3UmBCIRgMIzN59inzKC/0BALXlhlVyD4J0
 UwY78ocIuAAb7XUsDPLiIlCGN06OnUPrBeFcmWln6umtSPJy2IzP78/xq9fOkYaqf1AEkuHQXiy
 2+VpGv/FItGgRQyFAN40Z7Y3Ykm57YOu6Ql7yzk4149pgNHFW2M9szyvpGbmfU8JTMHdMM2aH1f
 Pujif+NdZApuzTj8r7addIk5ToFmIKxN9rPetWfWjCv7h3bxHqBnSj9Ew7SUS6PP+D8MWnWgMm6
 ICrTakwsKx9oVmP4UBmLBdo4qB435XrLDgQzLHvIJXSrYXJTM3aWGR6cZrBNa6aKTmlqwyLYotr
 m1+9qBn1O7f+wUfE9NJTdzpPChof5aMhtUjnkoqIsEmJ/+7XVqeFewDDS11ElYUgthuH2iTCtq3
 vxdwAPlqRqRgVwPvH3TQXg73l2pdKoaK8qrPhwODlRfCAmEoOeUvI8Ef9tlBwf0GmhvMP/PuQrL
 1C4LbaqQR97FOexJRDbKzIDoH61kmTporWer/7FLGywkr9a3zv1GiSN2cN4jigCS6p7zoTs8bKQ
 AISJUH0OzVbbj6Ex2vFNJRezAIg3LyboJk2Eb7+iXRxYgPOnyGxW9nPn43ilqCcuCjqbQEmKGJb
 Pf8WrF5Ok9Vq6cWHT6UWJXV21l3nd7XfpQOSOe9vmTnwvQrHQuXqonkAr8qoYAkJdIg==
X-Received: by 2002:a05:7300:fb07:b0:368:d0b6:b231 with SMTP id
 5a478bee46e88-379659c6852mr3606831eec.10.1794614606276; 
 Fri, 13 Nov 2026 16:03:26 -0800 (PST)
Received: from
 runnervmccnms.tm5rrcrii2xevck4shrvo0jfid.phxx.internal.cloudapp.net
 ([20.168.124.183]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332a77sm9856749eec.4.2026.11.13.16.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 16:03:25 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Sat, 14 Nov 2026 00:03:24 +0000
Message-ID: <20261114000324.4189-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113194640.2925318-1-sbertram@redhat.com>
References: <20261113194640.2925318-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] crypto/af_alg09: Test CVE-2026-52972
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

On Fri Nov 13 14:46:30 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> crypto/af_alg09: Test CVE-2026-52972

> diff --git a/runtest/crypto b/runtest/crypto
> index a8330db9f..082b906c1 100644
> --- a/runtest/crypto
> +++ b/runtest/crypto
> @@ -6,6 +6,7 @@ af_alg05 af_alg05
>  af_alg06 af_alg06
>  af_alg07 af_alg07
>  af_alg08 af_alg08
> +af_alg09 af_alg09

Please also add a "cve-2026-52972 af_alg09" entry to runtest/cve, matching
the other CVE regression tests in this directory.

> +/*\
> + * Test for CVE-2026-52972.
> + *
> + * [Description]

Remove the deprecated [Description] header from the documentation comment
block.

> +static void run(void)
> +{
> +	static const uint32_t assoclens[] = {
> +		0x7fffffff,
> +		ASSOCLEN_LIMIT,
> +		0xffffffff,
> +	};
> +	size_t i;
> +	int reqfd;
> +
> +	for (i = 0; i < ARRAY_SIZE(assoclens); i++) {
> +		reqfd = tst_alg_accept(algfd);
> +
> +		TEST(send_assoclen(reqfd, assoclens[i]));
> +
> +		if (assoclens[i] < ASSOCLEN_LIMIT) {
> +			if (TST_RET == SEND_SIZE) {
> +				tst_res(TPASS, "sendmsg() accepted assoclen=%#x",
> +					assoclens[i]);
> +			} else if (TST_RET < 0) {
> +				tst_res(TFAIL | TTERRNO,
> +					"sendmsg() failed for valid assoclen=%#x",
> +					assoclens[i]);
> +			} else {
> +				tst_res(TFAIL,
> +					"sendmsg() returned %ld for valid assoclen=%#x",
> +					TST_RET, assoclens[i]);
> +			}
> +		} else if (TST_RET >= 0) {
> +			tst_res(TFAIL, "sendmsg() accepted assoclen=%#x",
> +				assoclens[i]);
> +		} else if (TST_ERR != EINVAL) {
> +			tst_res(TFAIL | TTERRNO,
> +				"sendmsg() failed for assoclen=%#x with unexpected error",
> +				assoclens[i]);
> +		} else {
> +			tst_res(TPASS, "sendmsg() rejected assoclen=%#x with EINVAL",
> +				assoclens[i]);
> +		}
> +
> +		SAFE_CLOSE(reqfd);
> +	}
> +}

Move assoclens[] to file scope and use .test = run with .tcnt =
ARRAY_SIZE(assoclens) in struct tst_test instead of looping inside
.test_all. Replace the manual TEST() and if/else result checks with
TST_EXP_VAL(send_assoclen(reqfd, assoclens[i]), SEND_SIZE, ...) for the
valid length and TST_EXP_FAIL2(send_assoclen(reqfd, assoclens[i]), EINVAL,
...) for the rejected lengths.

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
