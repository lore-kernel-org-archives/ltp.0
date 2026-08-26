Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA5C61DB9
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 01:15:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274F83CB38F
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 03:15:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BF2F3C06E3
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 03:15:38 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BCEF81000447
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 03:15:37 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-3952813fb92so49783a91.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 18:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787706936; x=1788311736; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1SdXchtzTO70W8YTutku5ZUJkbnwDiPASlLaDdfMlOk=;
 b=VI0YT6z3K2MuquF5XRDPt/k0r7tZgoxC7zT5XBqyI+pk+PMqN/HWuNm5PEIbiB2qQ/
 rmlpvq4wWt16Fuhbi9rz5RgKaDTTLUYqGcl5qkD25M4l4DKM+7H49YSmTOHVw3FTHRMs
 Zlf8zB/vc/7DV3I5duKZZ2sOAF+S6kBx/eMMtz/P3sylUO1WZ2sFV0UNKFsKWsIhCB6r
 BI31pAq+RpmShQim82Wb3B5bdD71Wel9s/SFbQV4gIgMVIm5B81Wh92PjQjYz3ncgLFv
 7ijUkb1XZOg7t+mQwgN6Lqk3NX/4nQw9wsDdVYa9O+cpnH+9Q5HsKHnyVihJeI861r2z
 Xt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787706936; x=1788311736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1SdXchtzTO70W8YTutku5ZUJkbnwDiPASlLaDdfMlOk=;
 b=FG4nxPjK3L6A+zc+xVLY4MuUj/g2Ppiut51Wgi6NwYJGSMlWg4K9HQEcha3yigJfQs
 /o9yaTeMC7HSN554MkWjbkYlOjarkDwuYhju9mnZyYfVQO+Ie0G40Leg+RlxyqenS5mh
 TIruE2JLZehZ9/MymYokKP0zDDjWW2okJ+vls8nvXOqj9mEqamIe0oAKh3L+YBtxgSV5
 pX7jXOFcrGTxkMos+sxFehIHQV/xsyrS952E1NzHl3/BtoRCNmuQBmCkiZc+eDAU3L85
 QdT25QYK436O39wpadPoWDJWpcfrWtXyfsnOHclZUI0dNB/qfwy+yKDgBdsCMgPmxX+c
 0Khw==
X-Gm-Message-State: AFuF++ke0b3O77mh8AKnRnpXh/FgvYLziTcUXdSz77ADBXycBzfQLqfG
 7nzSdaKQJ5VICv96NhzRAJlsBGIa478+lew12hLyNzXiF1cMxv8q418rlnvAWYtt
X-Gm-Gg: AR+sD10stVN8cDXxTDZyF5CkGBYSP/MhtyBzVLfi5Hs0QEbEN5YIvjtYZS+8j+LfssR
 KsoQgrowaRTy6oYt7btiR5LNqkck8m1A88faVa8xfUEXPEPXMQYShiY4+Qf4e3MpUckHTIokgZx
 XOqEuVhoAcWV6Xfv8l2UUmf0PltDndkU+32MfSgSKt6uFetoOzjMz9TcydB7ueKqFuv+3qqfg32
 Z5ejDlTxFrlDXMHbztdRl/cd5sRvjadzaSsT5HpIbz+S3H/6mkPmwxplevURU8FpW8H5wCJei9R
 tW7VJC58GjSihTJ5afYXxYU7s/wac4wxXwegmO8xeTujz2jJrwIrhoL0k0Wcdt8qpwHK+eivNmi
 er31pWFaD4uRKoOtUzy3gVTaJ7IVwi6NNW0uWEl4WaJwbkGM0Hxu9b9DURbFW/PIqZT/h7831/k
 OAj6BRNQpkcq+R7icY4DeiioO0X9811uJEu2VcfmhBLTK/vFoAJKCxb4Xaeb2m6xi0Bx37psenx
 iPFJdT+qLupsNZEI1k1hz0XMECIcoi1rqqy3GSgxkakHJqmXbtIq0S0KfSkUiuA5uw4R9pdYTKz
X-Received: by 2002:a17:90b:2885:b0:380:71eb:4014 with SMTP id
 98e67ed59e1d1-3966d5c1a78mr6493752a91.15.1787706935967; 
 Tue, 25 Aug 2026 18:15:35 -0700 (PDT)
Received: from
 runnervm76f27.4n51afomptxufco1pqravcjt4g.yx.internal.cloudapp.net
 ([172.215.217.66]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a8eedd13sm3047834c88.1.2026.08.25.18.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 18:15:35 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 26 Aug 2026 01:15:34 +0000
Message-ID: <20260826011534.4151-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826003444.424097-1-zohar@linux.ibm.com>
References: <20260826003444.424097-1-zohar@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

On Tue, 25 Aug 2026, Mimi Zohar wrote:
> ima_tpm.sh: properly detect failure to verify the IMA measurement list

> 	if [ -z "$pcr" ]; then
> 		tst_res $res "failed to find aggregate PCR-10 $msg"
> 		tst_res TINFO "hash file:"
> 		cat hash.txt >&2
> -		return
> +		return 1
> 	fi

> +	else
> +		tst_res TFAIL "aggregate PCR value does not match real PCR value"
> +	fi

Could the helper's result classification be preserved here instead of
unconditionally adding TFAIL for every nonzero return?

When evmctl is older than 1.3.1 with a SHA-1 measurement list, setup allows
the test to continue with MISSING_EVMCTL=1. If that evmctl does not produce
a parseable aggregate, the helper reports TCONF through $res, but the new
return path then also records TFAIL. Since tst_res retains both result bits,
this unsupported-tool path becomes a test failure.

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
