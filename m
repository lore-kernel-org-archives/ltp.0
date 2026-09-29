Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A02ACA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 07:06:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 591633CE13E
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 09:06:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B98253C57AC
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:06:07 +0200 (CEST)
Received: from mail-qk2-x08.google.com (mail-qk2-x08.google.com
 [IPv6:2607:f8b0:4864:34::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 972AC2009F5
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:06:07 +0200 (CEST)
Received: by mail-qk2-x08.google.com with SMTP id
 d75a77b69052e-53337382d74so7088771cf.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790665566; x=1791270366; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vDZbrFb01AZcyp6ysYRJqAw0XdLcH4NdgidftLlhCPE=;
 b=n/uuHTHUbIOndnmIOZZZXCv3+qgsXsaf969s6IgpHDnmnUc+q7K9F9FnhtVh9ou6/L
 c0hJWTOvEmv4C/uougN7KAVROUlkpKGeGX8NgOggbpiv8jXA8LXMlyHa5QbM4mkyyrQx
 585F8pJEXNB0HTWIQtoZvilL517JGebo2c73X9yN/69cs67OcutRVsoCnV5uH4NaiOkQ
 QeO1gMPZCG8l+cEYEN+1QCIXFeFeedvjcFeTyZ9MPu8iesthpafDuDyMw9uLwGj+p0iH
 qb0eEexgvwNN4Hm2AVxOZYUBWlICqXR/7kxe9ozdpKh2UmqskeWXjN+rj2arFmth1oes
 loxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665566; x=1791270366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vDZbrFb01AZcyp6ysYRJqAw0XdLcH4NdgidftLlhCPE=;
 b=ctuGXqONnAlkCrR88z28ZzVdXSOXbji8n315QsxhcWUQkhMvXYBYVyZY/e1PNdnAJ9
 eazotksmrs7IyrFqj8H540jQO1K9kOcxD++JudfMnUczcZb9dyIHvZfrGHI+kCXgHMWu
 jnHoh8Z0+OQiahSKDi2RtaTzls5gMrj96OqHFKZWyjd/7ZG7y/WuzEicYV5rkXRap566
 hivlM54cn5SB1foaB5LI859bH+OWCh9V5vH/GFbrHRwTeivrjUeKh7SXUjL008qAjWO9
 GEDL0V072NZCWqtSOk8V+SXZ7RyAG85SF+SJtKFsH9mCf4wR9/g5DVDSW6ANBJ/aupjF
 ITHA==
X-Gm-Message-State: AFuF++miAedawbZeMJciS10uNKi0zct6VjD6SpiQOvgJNi+624bcleYe
 kMQb/+1xvIeDMEqtGQkUpXbg0QW5eccFvBEyHERa6PHM1JHhj1cmdpca
X-Gm-Gg: AYBFou39EUf5bD4S8CXH+N29kcTlz86xsApoc1UDV5gh4yiBbkIEcUG0Nl3ShFIFg48
 MG4yKHLM/h4Mlu28eQUGGdIVW/8DASwMyKfraGmZsHphFMS5dQW6HlnvwnYFxwd1M7R65UjUT6d
 SUiDVKkezWrJlpNwnmF3O+tE+rgg1Jf8+CymzZKXA/76FzvRzK7DVrfgdO9AZGSGgHA/Qu50o3S
 hZannrkvkqO3qWe1ZhGnQ2/yexrl2aGHqU8FMpHA3uSJs38zDb6zZSOfykMs74uE7KKSb6cwP8v
 jF4j5oshPzw97Kk8+CiODSSls+zVuI0ifYlJqDX+a9PffSS8Tb2pZh3xnG0sNc7k0ePgLGAv+QM
 ffyjRjBeOhqgDwC8mzAc96pyZOer3eZN2idSam/mFlshntOy/knlzkX7ZcIHR4gCDxGyp8CvcPU
 Jy5V8V5sYDr0Kk4C3hvHdyxN3ZHTK4NSH/ZkZsAoMu3BHyxY57ZpxWPYK1lBp+zv3c4SZzp2U+a
 j2m1iN/sXb0FC6jyjeSKvbLhm9XiaxQk+wrA5mpiOQX7eye70Ks8KA7HcjPrqlqDiHNnt2gf47l
 XsgwDfQ/I3w=
X-Received: by 2002:a05:620a:4450:b0:93a:1fa7:1afb with SMTP id
 af79cd13be357-93c43cb6a76mr2501000485a.42.1790665566018; 
 Tue, 29 Sep 2026 00:06:06 -0700 (PDT)
Received: from
 runnervmtr4k5.f21uuyqt0vlu5czq0hxzcz2hua.bx.internal.cloudapp.net
 ([57.151.83.102]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c81447bedsm333125085a.33.2026.09.29.00.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:06:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: "yang . zhang" <gaoshanliukou@163.com>
Date: Tue, 29 Sep 2026 07:06:05 +0000
Message-ID: <20260929070605.34590-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928083603.682527-1-gaoshanliukou@163.com>
References: <20260928083603.682527-1-gaoshanliukou@163.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open_posix_testsuite/sched_yield: Fix
 sched_setscheduler() check
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

Hi Yang,

On Mon Sep 28 16:36:03 2026 +0800, yang.zhang wrote:
> open_posix_testsuite/sched_yield: Fix sched_setscheduler() check

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
