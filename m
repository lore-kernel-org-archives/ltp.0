Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2912BC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:34:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F4E53E1CDF
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 18:34:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB6443C5800
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:34:36 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D81CC6009E2
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:34:35 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 d75a77b69052e-51c27a12102so4315901cf.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783614874; x=1784219674; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Smn+fZeYJeV5ZIDeQTf5GIY/VU2iDFflmh1qSVy4SI=;
 b=bonTyWPAYKRjt45k9cMzGEq15JOsliVJ6ele3nNpjo+S2OILD6OCLmK52G/kXrKk5z
 CiAYa1Q9S2wo2D+VmAogkv/GhbO76gK0H3f7LWn9wtOpHdlN077puv4+dmmSVKBi0cXc
 8BCA5NSMw14xTxETqOXZXSMF3v+3BPrPpNRefkEoydO4/BOesSibOyDQMh4i5J8oxC9q
 kcKIxBiORF9MApZuZx+fP4Qc4pcS65F24bfc4Bghhi81o+5dfgHOQbNP2RblQkw7Ca6h
 ivLZFEHgcTvjvU+frJ16g8TsYfpNHc5Bo3dQ1g/6TJ5/wU7VR9T2dAzijObSfE1/zTid
 56KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614874; x=1784219674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Smn+fZeYJeV5ZIDeQTf5GIY/VU2iDFflmh1qSVy4SI=;
 b=GAa7874qlKgZytSGtO4G4ezmJemiUEUVzKe1+KEgy/N8/gAyqZ9my1kuPHOvHE+dkJ
 0UP0LIDFe2BvgFEwR8AkgLDujTShX3aAa8NCo96az1hqJKjZiJGfySirEeTbS11/X/Ue
 nqy1B92LGzli56Oj0njLTLIKqZUUy1646CXCDDu1eE3dg+uJhpo0DZvjRi12s0GNIdWV
 XQVIPE1r0g6gRkR8VzBdc5vHCp6dpPbNZJpFQhP8FTpJGFPs6Hrmq6dPJvwLxT8tXw3f
 78hL2K50Um9OQ1cAd5l6NJqEL5Dw450hsMVlABCV6YgCtKWq0gvyhmCg3WKDSIMHaS11
 bXYw==
X-Gm-Message-State: AOJu0YzqSgRDdnUdjgCNmWgjPUgCrJjqXem9GPwnonVUBFJ6nx4iQ0LS
 owvKgoZhm+zdv1aRxjIuy3/o+cdqwfAhVTQoXtZik+l4xExsmdi7LpNN73UcZi7S
X-Gm-Gg: AfdE7ckHBYVU2NLBJaP9z7TTbi8xiQHYafF6OeGMnzC+A+/0rM16eLHEg7NPqsvVHqp
 uSoXt/ztA3xTlK8pOBI5K8WFMk2q2xhxy8yjoOYlyBVxJW9j8t9LdJHVcep8tjfNum1irF/N1Lp
 FY8yJxsrvvz4j12IDZ8lz6U8XnsrYMaeodjoI46FyGs9wuuUacjzTwfWJ/QSCiCwrcuuTgsGPwS
 r5odCTTD7PcVE1EuDrBYXEn1tMGbdy0rxeN5IBe8jZsoo8W/n9UqTM0SQ7zKIOi8SnbOVxOLKdy
 O7O4jizhcmVUhzMPWODRRH0qeLeoQINb6b3W++uabAAwOcSOFESKrmiE4MAw3/DQuHdd2W1i3IE
 XFw6U9HY7B2/fKd1bMlUXb+I2aLIi2IAKPz7CgZW6vwu8ljP1xSk9tGxgdMcjvfj58aVTxUxcAW
 6OwAublUJFyZfKYzxdE0ddCARZlYrBo1Qynr4DA/0DbV50TJoKuybxgPZhdoHaI9ljdyptB6BRh
 xak7EJOARkx4l7Z3vbXdFiUcP6AJg==
X-Received: by 2002:ac8:57d6:0:b0:51a:8c97:9383 with SMTP id
 d75a77b69052e-51c8b5649edmr86334711cf.58.1783614874503; 
 Thu, 09 Jul 2026 09:34:34 -0700 (PDT)
Received: from
 runnervm5mmn9.sipn1xk4ya1efdqesuaqpug3ua.cx.internal.cloudapp.net
 ([145.132.102.96]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41da510dsm160291421cf.22.2026.07.09.09.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:34:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Tomas Dzik <tdzik@redhat.com>
Date: Thu,  9 Jul 2026 16:34:33 +0000
Message-ID: <20260709163433.4095-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <79d9ea8ebe3e77733d65fba85ef1940e6f263925.1783610933.git.tdzik@redhat.com>
References: <79d9ea8ebe3e77733d65fba85ef1940e6f263925.1783610933.git.tdzik@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP/Lite test float_trigo core dumps due to free():
 invalid pointer
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

Hi Tomas,

On Thu, 09 Jul 2026 17:40:04 +0200, Tomas Dzik wrote:
> LTP/Lite test float_trigo core dumps due to free(): invalid pointer

--- [PATCH 1/3] ---

> If malloc() inside function read_file() fails and return value is
> not checked, the current code runs free() on uninitialized pointer.

The return value of read_file() is checked by thread_code() via
`if (fsize == (size_t) 0)`. Is the description perhaps trying to say
that read_file() does not initialize *data on failure paths, so the
caller ends up calling SAFE_FREE() on an uninitialized pointer?

The fix itself is correct -- initializing din and dex to NULL ensures
SAFE_FREE() is a no-op on the error path.

--- [PATCH 3/3] ---

> -	sprintf(funct, "%s/gensinh", bin_path);
> +	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
> +		"%s/gensinh", bin_path);
>  	child = create_file(funct, 0);
>  	waitpid(child, NULL, 0);
>
>  	sprintf(funct, "%s/gentanh", bin_path);
> +	snprintf(funct, strlen(bin_path) + MAX_FNAME_LEN,
> +		"%s/gentanh", bin_path);

The sprintf() line for "gentanh" in geniperb.c was not removed. Both
calls are present in the result: the old sprintf() writes the path,
then the new snprintf() overwrites it with the same value, and
create_file() runs once. Functionally identical, but the unreplaced
sprintf() is the exact call this patch is meant to eliminate.

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
