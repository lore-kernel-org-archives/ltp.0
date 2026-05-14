Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20270CD4851
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 12:00:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89413E5911
	for <ltp@archiver.kernel.org>; Thu, 14 May 2026 14:00:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E42153DB760
 for <ltp@lists.linux.it>; Thu, 14 May 2026 14:00:09 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 613856005C8
 for <ltp@lists.linux.it>; Thu, 14 May 2026 14:00:09 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-90fc979d84cso127357185a.1
 for <ltp@lists.linux.it>; Thu, 14 May 2026 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778760008; x=1779364808; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8Fvew8JVcm/YdxzZuylzpnHKYmOS7Wkt2w4O6JAhQw=;
 b=QXlgi+2GuI5y7Q157X5frQaYPgp51kiRVCNdjbCJF+SJ/IKBUgsqoXGrSwi55MSe/4
 c74jQ4pzhIdcZExJkRroq2BzIB14ok5C0q3ILbxz7pim8MQzdpjwSLJb9Yt8Xquq3UeB
 fReZssde48MeuaIyuzcAAyZtApthRBi0dhR9eYOO62y3NKW6hq2ASo1I62r6litZLq+u
 8gss4mOmkWcPjmZ3Kkv6S8Pq9/L0gPlZC0Ydfz7u3skraR7j2hTl1cjZbnO0J7e4hMyy
 6yZoaK/KYucKDSdUpEARIVbrlP6kNsxvcV67Ax9Dv8lI6ubscMRpA0ofi0V53XeI35ZB
 Br0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778760008; x=1779364808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8Fvew8JVcm/YdxzZuylzpnHKYmOS7Wkt2w4O6JAhQw=;
 b=IqrCuNVYS0rKG+XS2KPtvJW+UXfHmjLIW/RwsEo/LvYopYgyv7urO/oiXH9ZX5UED/
 WJvYDXw9LKJyfHU+7oO6FuThYIluZdwXvvTGXaUEbF71qOtENh2FL9YhkCwS/zTmlQ0u
 c9RqEH53AqHKSp1IdsBtz/1Vd+BaceE6Da++KtUr3r0rF1GZegb5H9iudS4o2m2XDyht
 uz/fngz/OhrRjYhtDQm0PRpJFdRN2T9/vS9vpLcs2ykg5CdpTMHb9p2WlNiwDJJJVRkP
 GX8xI/OztlDq33T0rPtzA2QhTOEglv8Tz5zXmwLit6NwosXMugXamgntL+Tt1gw4BBIx
 h3QQ==
X-Gm-Message-State: AOJu0Yx0RIz6TMKvSQUIj46iu4RAI/crd9G+1sC5xtGp9M9pvvEVWGZs
 5ISFkvjjNc9sZaSpKTXv3DCdZN0g4LBo0iNQ3QbBUiwvdpmRiaA3l50u6Wb+IJgvZs7nMg==
X-Gm-Gg: Acq92OFVi2a70bucNxuTSa+PYtgtYXybjUkXJsTKmSSJY7uw+HmrHUolQ5reSUcljSf
 ZVUQUU97oPQEYG/CrmN58YV3EROXvTNcENXQW6UpiKapFurCfNTqA1SuIffGetMfneAp2ZZMK6R
 3rnkpzBScwHviaMDERgJinh11F6gVpJ2MMt/eiR4FhvSU+unWcR/K4sHYLNFxMdf/ttd5ZLrEeL
 P0c07G/C1rw5wZ4KjwbfNufqu+fguKuejFWEMnnCq05QVMP1BEHjDokeBYQzmP3Rlh7/dWRg1HP
 mHiiPm+RC4OP7gPuCVwsrFs0Qu4nHA5/uNyGUK58a6y9vVoHq8++2In254cwMVJ2eUMC3aMl89I
 622V/x1ris33+FEspzl6IIor9DNw78t5LkBcIRYgm2jJXzXTx7g/kcQTd9C4/QztyVbL8FdmWdV
 YGYUWUpHd4inmTLPFbosflBygT3eY6BHnfPX456Jqms8C8nadCW0H6I9dzvgXaCZliYKaE+bRPY
 w16wbxVtq71S/cTtqbmX1jN3xVIIl3JuTIgSKW8Fo/akBs1eVs=
X-Received: by 2002:a05:620a:4114:b0:8dd:7422:6934 with SMTP id
 af79cd13be357-90fadb68b6dmr1022289785a.44.1778760006506; 
 Thu, 14 May 2026 05:00:06 -0700 (PDT)
Received: from
 runnervmeorf1.rki5edkztpqeza3bcgf4gdddvh.bx.internal.cloudapp.net
 ([20.163.246.209]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bd620fbcsm231897385a.42.2026.05.14.05.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 05:00:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 14 May 2026 12:00:04 +0000
Message-ID: <20260514120004.4030-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514093649.125287-2-piotr.kubaj@intel.com>
References: <20260514093649.125287-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

On 2026-05-14, Piotr Kubaj wrote:
> thermal: add new test group

> +static void run(void)
> +{
> +	static bool first_zone = true;
> +	...
> +		if (!first_zone) {
> +			tst_res(TINFO, "Cooling down for %d seconds", COOLDOWN);
> +			sleep(COOLDOWN);
> +		}
> +		first_zone = false;

The `static` qualifier means `first_zone` is initialized only once, at
program start. On the second iteration (`-i 2`), it will already be
`false`, causing the first zone to incur an unnecessary 300-second
cooldown. Drop `static` so it resets to `true` on every call.

[...]

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
