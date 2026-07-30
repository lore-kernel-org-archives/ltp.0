Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F9FC55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:07:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FDAD3E724F
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 16:06:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57CF63E4BE4
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 16:06:44 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC942600940
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 16:06:43 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cac634f921so7703075ad.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785420402; x=1786025202; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PuW4CyGAqAlmkfpKGgw5B/Y1Y3rkShtfds5sSKZHpoE=;
 b=YIeZf9oNoT4m+p7O5LrKCDJa10Z8fONoXHnmkj4EJLc4s3j2TDE7rP0BSj27CrFXYg
 heVLiYsJRSXOWnmpBbcxY0AqCiMTqdI+PYijsh9fBJJn955Eabj+0fxqSZz6qlc4wuH0
 zyxkZ1NfUZPLuA+wdoOymR6N83npFY40ZzB4JdPJcAMrskZuf62gw/t9bhw28mbTidL8
 7/5TTGeoTsMT2dMjEwYdY62EUVadwKC05GCB90dHtJbCnO8bxzHgrDPqUQfSU/J3T2OF
 HIImWiGl6bZlZXrD6Xn4gXUtkVjHHn3pebujbMsWh8LdIWPzzc11DEp8t+KY8bBqb/q3
 ulUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785420402; x=1786025202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PuW4CyGAqAlmkfpKGgw5B/Y1Y3rkShtfds5sSKZHpoE=;
 b=M+ePAEu4XHoXr4CYOEEtoNfXxMlJIxtM8d2h3oUcfL+3j+eWKqiMZZzmuWklo3AAIg
 TR4g4jejdJI4ZdVCWrOOWCd3k+yYTspWq3LrcQ8Uvi1HsLj7YWKBHsFci1ZRx8KHhbGv
 ietbDhAcVM6RTQtGdKndGs59sQ+fR5dWLvKSXGy/apBwRX0d34kX5mzBIuZPq76wLw2L
 lYJVHq+opaZaT6c9w4HnQrUdcAxTAfDeHPQyyfY3svXTrdb39aPxb0xnN4IEcCx++veK
 DWikSkpKTp5n+FH3+v5jOqOBevc0Jv4VtAbuBnusaZxGcRYupbkiiqSuQY91x4ok9ZWg
 NHIg==
X-Gm-Message-State: AOJu0Yz7QcxL0EPEqapzQVMkjiD3TKmo9Y0+4hdZBLpJy/e5CyhZRElp
 uLfC5HOmsJF1LoOI4K9zT/802yFUDZQMFSs9ZMWZ2cXUh0DftxFgI9yO
X-Gm-Gg: AR+sD100BMb6vof1brjSlR7JCtXZocetQKbx/fue8YciRpv3Ol0qM5fQOni0GqCoEPH
 ZU6/TG8HRYJh8+TGrhsDsGu4V/bjGhOSxe5v7xtwRUnhXjuqkvJ/TaLM5Yaf8xw6+9iDbGnHWIp
 FReZ4ZnmqKX+NRAB+HsP8/Bxn1Zk9qGY+98FbS5OFjqtihU2dTVht8rckpHn4zDKs9IoGFjcIwJ
 EBE72aVEzdkBN95roDKki34+Pp9jSLTQs3pFhvn/AhCBvd1O7np3EaTWgCUH92TaJhCy1DQzfXE
 v1UFWOKXYQtyVPKgF4wtS6rII8cIQ+VBFYFZOSYkgrKIbhqex+ynWivlaZbZyO4j9fE/tza6Ecb
 rLkFEkAfqZFeVQSx8HwiNBpYRmPK1W8O6ZIwdyjeke6x336L4zNBBkVvsUVZWyxwYJGezLboLZG
 qVxlqNv0NUt7N0ORa1azffPROOdcjCclLGqcMvOyM2qqTvaIciO7YvNsYM4e+H/jCW1dxT1MXu8
 CisOv0GLhewOyFDcr58xt96ZTOfg+YbOdl0hXFokKM2joZ1Mvi9zU0OHk4MlrHauD9UFvnOPuTt
X-Received: by 2002:a17:903:1252:b0:2cb:ea0b:9164 with SMTP id
 d9443c01a7336-2d035c1c7f9mr27538845ad.6.1785420401704; 
 Thu, 30 Jul 2026 07:06:41 -0700 (PDT)
Received: from
 runnervmvrwv9.uvi0h1rris2uvch3men1rszqyb.xx.internal.cloudapp.net
 ([4.246.63.146]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a45979sm27742735ad.18.2026.07.30.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:06:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Shaojie Sun <sunshaojie@kylinos.cn>
Date: Thu, 30 Jul 2026 14:06:40 +0000
Message-ID: <20260730140640.4098-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730122521.1218460-2-sunshaojie@kylinos.cn>
References: <20260730122521.1218460-2-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_cgroup: add cpu.stat and cpu.weight to cgroup file
 table
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

Hi Shaojie,

On Thu, 30 Jul 2026, Shaojie Sun wrote:
> tst_cgroup: add cpu.stat and cpu.weight to cgroup file table

--- [PATCH 2/3] ---

> +static void cleanup(void)
> +{
> +	if (cg_test) {
> +		cg_test = tst_cg_group_rm(cg_test);
> +	}
> +}

The braces around the single statement here (and the equivalent cleanup()
in cgroup_cpu03.c) trip checkpatch: "braces {} are not necessary for
single statement blocks". This is also inconsistent with cgroup_cpu01/04/05
which omit them. Could the braces be dropped?

> +	long usage_seconds = 2;
> +	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
> +	cg_test = tst_cg_group_mk(tst_cg, "cpucg_test");

checkpatch reports "Missing a blank line after declarations" here (and at
the analogous spot in cgroup_cpu03.c). Should a blank line separate the
declarations from the first statement?

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
