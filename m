Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C3606A890
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G81VDuvn
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49A473EA08D
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 11:06:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E609B3E2187
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 11:06:09 +0100 (CET)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B594B60062F
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 11:06:08 +0100 (CET)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-53394bffe0fso27378811cf.1
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 02:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794564367; x=1795169167; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sQZFhXFKLcVkMPUHa6Atd4150OI19LDFWyajHgJKlEk=;
 b=G81VDuvnfEZJaeX1woKQzoELMV68RcER7Xu40TrzrxPtSQbl6zxATrJTrndGo4T1ek
 0UVZxprA0Ec+5b23sGygxF6In6gCeAn/X5QtVZSvCGj1WI8octb5+dtfqtVa1MhrqWLA
 bZHuNBqJlUwjJgPM6oqJnslkjeqZQklfIFoaOkzA8llPhqNeLJ4t64n5Sf+3zcMyArEM
 oJE97MHE7XjG6LV5WAvMaQeaebqL8sd6B5G+KO8uyl7SMW2QYNPaiOfp3gfJqdTkkTn8
 QVGIOrWkvJGOtV5N4z4v3FkXBjhlTrIkcm0nrPJQh41h+pi6kjE1/p8sJN6P9eaLoTYd
 Yfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794564367; x=1795169167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sQZFhXFKLcVkMPUHa6Atd4150OI19LDFWyajHgJKlEk=;
 b=SR8rvZfNrr/FCMFdqJG8QNOUkBoLrZCR7L90bpZyFzIlKKK0dJwm24EpiMBJ3N5z2C
 46nivTBD1bbrZ5MdUUhXofzRohW7CRyJN5FC3Bz9IV8fz8xtRFsN0R/LswaWoTMn6a82
 KjtB5GkGBX9mKfE0BQ7DrStKSJ01Eqpkr2EA8a6Eh1IEbo7ltzu2NyuNoU8wAxeR/+EO
 8HhleXwD3FHHGfRF0GmSSFKoeFbCn5VfxIxp8GGH//be7WrWmvwjf5f2sLPcJHOkUze2
 zE0YEWZTOIRctE9y1M9Fq4c4JH2eDQ6gowmC0/q4df22cor6jSODrrTNZIbsRP0dSIQ1
 c8fw==
X-Gm-Message-State: APuU4Z8xI2c+9pvlY75Px74O9j2omXUeofGSUr+GhPdZxaJ9ntY0GOaC
 ik4BcbmE1taGpFcVvXqa4C9uqKXsAn4AJYt2WNij7iOs3lM0JchswmdF
X-Gm-Gg: AYBFou3EDC2+JzMTgwM79Ur4JTi0t0RvJAiiVSU+TsMZShgD5Cs3ko4idnrs2LwrJ6H
 cTrc6TUN9o+iwlMyuM/rZDk+8Umu+f8mOhGGOpWDErayPGm8nzrxZtNopZtkay/SeKDj1aE63+k
 yKeGKKiP7cmOOLSKTU1LShQd1i79hymfA215LdqPML3hRmGCIJ1Z1+IzbgBq/IV9wUCasAp3Ia4
 KdhfikLso9K9hC8mr23hsnrGgrSYDkkwC6eCH7K+ohBkeGnApTJkv89dpFobWd1zD4xDVViqAoU
 ZZFZd9OOxinVC4S+LC7QyLKd5zBa64Yhb9GHgMqFw0lzX1Oncp7cEaYg/GUcVuZs0OuUteU/Qxh
 7/nyKYrRzM0LmUIr0nxeuF4FXiKSTvhC1pI4K3mmAxQMDCzSr7DXB00oIOHZfq+pUHtkNKAJwu4
 8jhIaz0q9jKScsqqUtztPWnz0b+o69IkXYsyW8ki8ggUgXqUjIOYUtQAV7uqgwb0uHZGJcwGNyN
 gZAq69GuS8uMY40CcA+bks3QdHuBkZtT+1FsIypnsLFUYCN+JXw5k3bBa94T6GUZNHekoJC7JX1
 c8uWE5PFlrpAV62Y756r71bzIWUODBkywSRubyWO+u0YQWI47KKooRdSbMy6EGj0FLp1lG+s847
 W8yTU7xP685W1D77g0ZlKzifaMH52wkZdEocb6esrnw==
X-Received: by 2002:a05:622a:5ca:b0:536:6013:be95 with SMTP id
 d75a77b69052e-5595644e72amr86478571cf.16.1794564367290; 
 Fri, 13 Nov 2026 02:06:07 -0800 (PST)
Received: from
 runnervmccnms.gjdbbupuwjlu1o3x5tnkqk5h4e.cx.internal.cloudapp.net
 ([9.234.149.182]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d6193esm16767776d6.19.2026.11.13.02.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 02:06:06 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 13 Nov 2026 10:06:05 +0000
Message-ID: <20261113100606.4056-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113041136.17102-2-wegao@suse.com>
References: <20261113041136.17102-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_bind_to_current_cpu() helper
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

Hi Wei,

On Fri Nov 13, 2026, Wei Gao wrote:
> lib: Add tst_bind_to_current_cpu() helper

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
