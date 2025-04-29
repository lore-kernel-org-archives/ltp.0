Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C2FC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745940605; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ha3jKfrwE417+oo8f6Xr+eVXvJ4IXkznn0oZv78niio=;
 b=FOASN7870COeB1ZVLMZYy3wKlO5rCiZgnnbTCKxcmurZAesgG/3D4B9pLVxHa/Ad2Jlgf
 WapfNRX/m3NIVJslrcGczwmgiywwbDmgmkKtPfd6VQl+O212kKxza38KXl/81KDgYOMBUXH
 QRU+HNMZ2OWIBmYENwqXkpnrI05Vv3c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38F043CBC1B
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 17:30:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED1B83C82FB
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:29:43 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A8F91A0043B
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 17:29:43 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso31097405e9.3
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745940583; x=1746545383; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=shX4iuzt3efkEp25V9LIyPlYw1agA00q4AFaJHYLaRs=;
 b=SAs00OO1rSFcZvSlIAZcbsLngM8ncOv3GlzaRrflFRjWVFCNE747X0HD0HPJ9xVJq7
 BXumPUkw7hIcRCGxsGzVSmajb4fEeOig4k3IHEeAG3CI9ZBOg1ntJtKURz3zzYNv1rA+
 6gD4DNpwFCJaSQNQpTWqMFhJyizU6jmkhCb4bxCZMgZ3RBGCyz2YD2cHuf9rthnhMHB0
 PSSDT6TLVd9HnZzVx8ORaoEnyZbrjgDUiAxIoRbDOkEBElS/BESjsy6vFFn94WeV+IJy
 MLwUlwdMGw9zYn7+Xy7d8y2LqFrtgk2WexvjUHMBu33mJCgFn+BECLT7GdbQMBRVbVSk
 CYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745940583; x=1746545383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=shX4iuzt3efkEp25V9LIyPlYw1agA00q4AFaJHYLaRs=;
 b=TMO+wyII1Xpr6sXpIqiZUke2kF54da6olPMm4BYoD7dixgqz4sKnCRAECFpygR1QEJ
 yEDWeRE5mYxJnCWZjbdi7PQ2bKhF8R/hJiZAsnkA9RcVmdpIBRVK0JWwAv9kz/5d/X6H
 or572LT40AOs/p5lXqN0/WPRIHEKWUabiBOiQEeeCoKbEqLHWEi0AMF0E0zn2GQYIyR7
 II8GWWLyCBK2vanaPJDUwbIR58TG52nI9uArN7MCULSKGVariG9LqecVCc4CJ4gGyPwY
 GblPvBEOtkkzZiPaAzYO8kCfYYNpOn73cTF5WGJLos2uOPnC90FJyWij3drgBTrz8JS9
 JjtA==
X-Gm-Message-State: AOJu0Yw2mW+Dew20Vhvj6OIgeZR7QVrxbk7Eu/1xnEhxug6Tz7DGgJRR
 whJOQUbSZepJRHOcpKI/R7aPNMdUXb8U7X/Ss91FzyyNuUIy5zwx7DIzEj1Zw/k=
X-Gm-Gg: ASbGncviN3A7YUqTy9EiO9eYHzyPDniAWgdWBTYw+CGhNqzBjDwMTMksHpWH6KDo/gf
 bL56KHDeIzgeRj9BaJjmb6ydxeBiZ25OPBk+0EF6PhX1E758ChjlI/eL0BAa1tRM8uSQR1Bqp62
 lof++Ky0iqEmrXt6/9NsbYAYTzd0WcU3xMOFwoHIxH3j71aJoIvu1owkndnQZGelsJY+XWCrSMY
 CoTW25A5e1gu6B2rIbJfv+sq4KpRnUJgL5JHYC+9XGHniZU1f6eUzJmiWWn30oX36D86KSo5g3H
 djIh94vEwFqQqAubjD54QmAvNDes/lIGgC/Rh6cwnnwoCJoXS90mEn5yrQ2z96VFoCIrmQI8PA9
 rrWXsGmpmWap1mi8T2oHpGZkRGsVpNxz2w6LAjpdiQbvi4abIDbyEgvNLdi43VSV2kmtYRIEzke
 kHxTA=
X-Google-Smtp-Source: AGHT+IE5e17/GNUq/wJ09Zzqfxl3MSjZYNTh3fIqidZp9CYrdecAZu4srTCtHiY3uYKa8WKHFep66w==
X-Received: by 2002:a05:600c:4e8f:b0:43d:300f:fa51 with SMTP id
 5b1f17b1804b1-441ad3b5759mr27935385e9.9.1745940582744; 
 Tue, 29 Apr 2025 08:29:42 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ae3f5949sm16278275e9.1.2025.04.29.08.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 08:29:42 -0700 (PDT)
Message-ID: <e467e438-5102-452f-833b-d841f8032688@suse.com>
Date: Tue, 29 Apr 2025 17:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250429135542.19680-1-chrubis@suse.cz>
 <6d9e6e5c-2453-4f81-add3-01c193776e7e@suse.com> <aBDq6PobtIDF2_nV@yuki.lan>
 <f2a81424-b035-433e-b299-07634039ef3c@suse.com> <aBDuQdahWAlcm38G@yuki.lan>
Content-Language: en-US
In-Reply-To: <aBDuQdahWAlcm38G@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: do_setup(): Check for supported arch first
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 4/29/25 17:20, Cyril Hrubis wrote:
> That will not get into the metadata, because the tst_test structure from
> the TST_TEST_TCONF() is not parsed by the metadata extractor and that is
> on purpose because the real data is in the other one.
It seems like there's no alternative solution then. Feel free to merge 
the patch.
Thanks!

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
