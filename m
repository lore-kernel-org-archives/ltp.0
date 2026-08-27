Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59571C61DBE
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 03:05:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 377D43D0EF4
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 05:05:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58BA13C8484
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 05:05:24 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E9B871A0024C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 05:05:23 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-3952813fb92so654823a91.0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 20:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787799922; x=1788404722; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUmubasayP4dcx6uzrPhwwB20KYIRM7/d6cbsxcsrEE=;
 b=SYOUqyyRM55P8X5n/yewDyA9z/YGNnI5kW4l+LkE3qkQ/RWP8ROKNeLEz3Va6llaZl
 /X5t6fWPwkhK6tpTvIq3Bjx+HL+cWbHS/hk7ZDyOJtCS/m2k/i3WiNVpvg49Bcefpav7
 7QpJEn+CICdUEYJjmBEfXhaTzhHo7FsvRkpE12SBfDtDZdtMakRGM0XqyUl6xIDxVqY5
 pfI7b/onO2ipXbDIQLnr9QJvEGFwlByrjVd9Sre3c0B8iLunDVrhHgvEgIqZpKXaZuQ+
 neG2rgyvwDleTj6m5XGkQBHUYlZUIx0LwgyInVkdICtIAVrcZ7Oh+DAMvB7AAoQiL64+
 Ip8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787799922; x=1788404722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUmubasayP4dcx6uzrPhwwB20KYIRM7/d6cbsxcsrEE=;
 b=Zf2iooqCVe/AF2lwwgybZYW/QIoljXE6GvJ/kZ0sySuWbv9jLxMedzt9/R6Y3XFXM/
 0Sjl/QSbV1T9IT26du6Hh9MG3Tz2IFmEKhvcSIBGlKYDfKg9jNQUVmqS5fqAoicP5dwI
 Da35SmVzynV07Z6Kao5UC8dQ3mrOD09PO8SxTRnhbz6iIgtpK8u4PDnYbiCu9yvCBHos
 47DFyeVservaLfXN8RwVnC3O6vXvO5CtjckYotd4vJqfS16tiu/v0uQRKt0V+xr61/OK
 h/Va1fnK0nLKfC5qcGk4lIt30hBg2hgLCYhCP8SaLZEiHEg+ua3CefeSoH41wp7ZQvMy
 RR+g==
X-Gm-Message-State: AFuF++kYLBtN9sJbe7ItQRKz6zp+g94VsBnZZmKsP+KDSDa/UZWFGKIb
 AImbcsifVSTbpq1GgA0BBxOEAoGzfTKwdNItwkXSrDT5ZckN3lq4/0871fH8FJPl
X-Gm-Gg: AR+sD13uxHKETUYop+O5EU/hBEF5gMAbEL8ZwQO16LIX2qDv7zuxL0TxDu78Mwi6RWi
 zJ/ACY2mlZfEGxLaLxB/q8wUD59oAKiil8joQxiyP84GinAhC3A+GIJ/Ii2xqKVM6dcnf/WTV7Z
 9A/qwG1TIGjl5JEcYRvQ2TUiDC+5PRbHT/BF3XpkDBExMttLqTrO059SDgpowveox5t30iBLDIN
 pBsRr3t8NgqYFKqj7v8zN2z61Sxs781ch+EqrK178Ngqf93/ON6PqbTOIijRjTa8q3LEYD8nIUn
 LqGz1m7n1cghy0a//1ymWJvRiqNsIryTCcrCEZbpe3Lu9LuraXGMsiJAiODIuF+lOHv61viqA0t
 V1nN2s8xdowCOCBXOzQlslYZULIjIcdyizr0EwVkxA+mb/n0RSeFkJ1dYdnJWw6VkjhskZs9PBT
 aGyT8pV3QrD5N6T72WgrQ9t1cHvi0UU7vazH4ga7tPEctiEfrySfu9U+w9vdX3IYUUEmTk1SRhd
 yy+tlaqBn8indBtevmtsccsWyM8F4VMIkv4s4Dxa/beIvpGhTcBdayA17GgCeKteqh5nrQXC3s=
X-Received: by 2002:a05:6a20:d49b:b0:3c3:a3fd:db0a with SMTP id
 adf61e73a8af0-3cf85560c83mr25209379637.16.1787799922140; 
 Wed, 26 Aug 2026 20:05:22 -0700 (PDT)
Received: from
 runnervm76f27.hudgvjupjubuhg2kvvghfquicd.xx.internal.cloudapp.net
 ([20.29.223.64]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1beae6484sm1648633a12.4.2026.08.26.20.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 20:05:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 27 Aug 2026 03:05:18 +0000
Message-ID: <20260827030518.4078-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826222913.802598-1-zohar@linux.ibm.com>
References: <20260826222913.802598-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_tpm.sh: properly detect failure to verify the IMA
 measurement list
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

Hi Mimi,

On Wed, 26 Aug 2026, Mimi Zohar wrote:
> ima_tpm.sh: properly detect failure to verify the IMA measurement list

> -	pcr_aggregate="$(cat tmp.txt)"
> +	ret=$?
> +
> +	pcr_aggregate="$(cat tmp.txt | awk '{print $1}')"

The cat here is redundant, awk can read the file directly:

	pcr_aggregate="$(awk '{print $1}' tmp.txt)"

> +	elif [ $ret -eq 0 ]; then
> +		lineno="$(cat tmp.txt | awk '{print $2}')"

Same here:

	lineno="$(awk '{print $2}' tmp.txt)"

> +		tst_res TPASS "aggregate PCR value matched real PCR value (line: $lineno/$total_measurements)"

This line is about 100 columns wide. LTP shell style asks for lines
under 80 characters; perhaps wrap it or shorten the message.

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
