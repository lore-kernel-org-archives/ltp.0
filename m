Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D5EC44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 13:16:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE20D3E62A5
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:16:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D15403E4E24
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:16:36 +0200 (CEST)
Received: from mail-qv2-x01.google.com (mail-qv2-x01.google.com
 [IPv6:2607:f8b0:4864:33::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5010F6001E1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:16:36 +0200 (CEST)
Received: by mail-qv2-x01.google.com with SMTP id
 6a1803df08f44-8fb613b6726so65052316d6.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784553395; x=1785158195; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Onqv5jdoLUSOueOHyt0App+9w1o6YepM9NskC/jfi00=;
 b=J8BuxgKECWhGsFlyeHMNkvZOFszmGwP0eLRc9Ya6p1syKvFjg7FSnTllmZalplpBfh
 V+1Lkd+hwBHFbM/GffxUU7f7EAXIMNZ1BaCRZcBtKUtiLUkr+wUIgaKQjzCXO/JzKxhf
 EzjeeeLEsSgEgtrM8jZal4zZM+qeBoj0wbrQFyNpM3fjaBSrCAN2GZ7r+VtyljAHGxTJ
 cH4c2JNaG9A+kbGFZ+SNg35+dCkuTNRCKQAt3lutztp7IF6xeJp8I0FYAn5kSKPgnlPD
 qHSmNSAhxZToKFwkg/vzK21XE7j/IRS4OhU16dsXBGPiE2QCOLQyoIocxXLJCOXRPUYF
 96uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553395; x=1785158195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Onqv5jdoLUSOueOHyt0App+9w1o6YepM9NskC/jfi00=;
 b=mTVly2oCI1wFdcvNSDFEgsIPnUS+T3Le5ur9mChOvupVWIjsx6jgvOMDfG/SFjBuQ6
 0MMhgaUedZS1Ho1VD1kMvDrWUiEnARaPuTLr6+URLJ7BdAJKZ91oQE9p7rWShfgmIk4E
 WXvWnYlp0M83qrQMNzMy6TdG0S0mSsslI4EXBHvFV2VAE5o4wSNxnQkSIS0X26CsCY/N
 jZiIfqa5nROl3Su84hpfAs0AfhHWBkLorecwjW0zPeMj8plMbXp5lC4Nw2wq4pqdh+r0
 NPT6bGGna/8UrMQAdixBj1MFKHxJkqup9WX1QtluWVfz9dofvRqxrHtVXP8vAktnfEBN
 xYjA==
X-Gm-Message-State: AOJu0YzJtibV4DLmklm+56OVK5SS7XHwGQ4sxuLTUD8ikqKnl5KTY68w
 r7RbgqzinQ92cbwcnGBtYlvuIdcGYui6GwhdlI9Zm/N5keYzAimzxahtVwD/rE4d
X-Gm-Gg: AR+sD13CysLMyEZr/NXVt/YtB38g0Dvcx98ztytJ9UUA4uKuafCuJcrVMZ2eZSG9T2/
 vKyuUl7ZXZ+DKYaAYNZSXA0AH3WfVUW9zhNTJJasWhjTssThD+yaqyn+Nmx72aUhYqlOGthwVzn
 gJLCL+KEFh7siWt4Z25BY7XfXS+IDVuj4nFmqVu5Hpir4U6bn2QB1mKUVv9ObOrXj16d8iHYQJn
 77s1ody1g6t1oh0KWfn0MM1VjORggUfOMvnbW9MU5LzBmNOI4ie4hltfWTQA5bLhU8lJgp9Klvg
 mkuoM3QsTFRKrpgmHByPXgZossnyBFF4byOi1hTfaSC3dCVFi2Otcx5CuKYA+2zXIf8DeqIR9p6
 bsRGL+9UHL7NCqGab3qEDELL7VaaEU08MrZN+pJSXhQBrvgangknjYP6EyQgF46BO+5buYI79hP
 HTvsnnMI7193ImXJfTq5xA1IhIKb8T3scNUCJ/vcFQqvKv3rXxcHePtXh2ZEilwJjjzB49WFAq0
 Oa+t9p77/dCQi7gggBQ2KylQNvS
X-Received: by 2002:a05:6214:19c5:b0:8f1:7a7:b869 with SMTP id
 6a1803df08f44-907783a736dmr162055926d6.31.1784553394992; 
 Mon, 20 Jul 2026 06:16:34 -0700 (PDT)
Received: from
 runnervm3jd5f.2bjrkiugu45unjuat4bmm5ujeb.ex.internal.cloudapp.net
 ([64.236.160.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907786b21d6sm91389356d6.24.2026.07.20.06.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:16:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 20 Jul 2026 13:16:33 +0000
Message-ID: <20260720131633.4154-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720-convert_fallocate_suite-v1-1-50ae85c56c03@suse.com>
References: <20260720-convert_fallocate_suite-v1-1-50ae85c56c03@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fallocate01: Convert to new API
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

On Mon, 20 Jul 2026 13:48:26 +0200, Andrea Cervesato wrote:
> fallocate01: Convert to new API

--- [PATCH 1/2] ---

> +static void setup(void)
> +{
> +	char fname[NAME_MAX];
> +	struct stat file_stat;
> +
> +	snprintf(fname, sizeof(fname), "tfile_%d", getpid());

The filename buffer is one byte short. Per the LTP coding standard
(c-tests.md, "Path Buffers" section), a buffer holding only a filename
component must be NAME_MAX + 1 bytes to accommodate the null terminator
when the filename is exactly NAME_MAX characters long.

In this specific case the generated name is at most ~29 bytes and there
is no actual overflow, but the declaration should still read:

	char fname[NAME_MAX + 1];

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
