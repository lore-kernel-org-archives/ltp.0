Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3A7C61DD3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 05:34:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEC373E5749
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:34:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 026943E1A3B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 07:34:29 +0200 (CEST)
Received: from mail-pz2-x08.google.com (mail-pz2-x08.google.com
 [IPv6:2607:f8b0:4864:3b::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 793921A01141
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 07:34:29 +0200 (CEST)
Received: by mail-pz2-x08.google.com with SMTP id
 41be03b00d2f7-cc1c4267d50so115785a12.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788500068; x=1789104868; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UKkRUs/vZQK3IHqeg6dMpkYjeB6EclP2TrQavOMElYA=;
 b=Te13QsvBQHbqmKsjKw3qThpOy9ctggJrKKz6P1y6Uy+FUFR47I5tntlhbJOFaMQPk3
 Kteu2t99uotre4yWXJg/4awMQCdjKZcsze3rcLduFFm1Sn1yjNgzQz0Dblq72kjV4n4B
 t4elixVRprUgEO3khzFd3PIJOBhW1DvxdvEwDOVLeqKpKxXSjC8KKMSjaKC61+RSz1mQ
 1POCWg6oCYIUkG1i/uqUkzd8PmMZLPjFszbWNACoTiI8VOfTLKUOE+SLGngzLJrpzSvr
 BNZV/7U/q20WM1GZB3dIPO9BEpB3zrdxMSy/d+ihXfC6vJuDV6ux+q8UtA4hGdfF7omq
 5Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788500068; x=1789104868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UKkRUs/vZQK3IHqeg6dMpkYjeB6EclP2TrQavOMElYA=;
 b=V8FlES0ypQwRMjQp55pIn8LGoBjlGTbSoMaUfkpMFDyvN1aCUAEiYH0bE8QVCyc2S2
 X8OGxOLTz1MfR6XuVZWLUg36kE6SSobDpKk0cYHVzmHvfAn/jjkF52+qmQ+NbeXdHk1c
 umdLleWbU12Q6IMH2RrUNqi5l2laLf6gxzXp0CHFVvIppn/ChZQy6UElV80zLtJRxLda
 htBPpgc0z7GB0Pc6hzJ1M/B4UqaRbp4xvIlC4J+7tBXBonE2f0LtcCJpEWtjF7k20ogX
 YDf57SDSA71/EIQQVo0ArTMS1rZ7STdnJc1kxy07vKvWGMn5YIolo4OudjYYD0zUFVpQ
 pmpw==
X-Gm-Message-State: AFuF++m4AIudLdERP2GYRDiIYi6mItXCw/MG4vhccyt2MNnVVf5/vgLx
 H8WD9R8oIBpqer5djSfCA9llvMQPmuIHOWGj0SL326DFpEM9Qt5QIf+WHMbGnJAH
X-Gm-Gg: AYBFou0frWYdA1VwDhNZun1FBNMN6gzeREnrMySpppG5MdzXqACGF+54I9K+iNJJo8i
 RUGqss4UQC8q58tccoySJuz9MrGH2m6i9aPnnBq6PfVJoJacOpydXd22MBpm1O1UQVuZ44Egibk
 +e1z8lsk2KSUGbP2S+usUqiZv2o+eODlDOx4T0FgvTHAsIDNy1dcFLEIPkScV+wr7C0aTn9HhQl
 G24nM6yhN2+btFrjoERTd0ttfuOEG2WXCHRsnLDghsU+jxPCpNJ75hFZRBXst2B1eNKf7trJtN4
 7A8vrx6exupXpAiGoTIhICgwja4Ugb3Woz9pSPZ+52Gq+fks7+4LLTYd+VpmCVU/Ir9w0ZNaRrj
 mKsa6v2WuineSu+rVxTFGbkfAj/Xg1HRS82CFjO4lVK6GF5qbc/h+T79umbk0k0fbBgZLn2V9uj
 NPGHOSwh+5wvBQc9uWfEizs9XjGWzTUE2Av6qu+g7DuqyD2hvQL/q3W92CPU9KrG6ggVXNImsa5
 xgW4GmHFDfTMilqIDITExkdnhZzn188fo3WVWWQPxy6rIb8jPyZB1r6aNcUMv97laIeeXr39g==
X-Received: by 2002:a05:6a00:3398:b0:848:5f4f:289d with SMTP id
 d2e1a72fcca58-861662d5c7dmr6249373b3a.4.1788500067624; 
 Thu, 03 Sep 2026 22:34:27 -0700 (PDT)
Received: from
 runnervmgx7h7.ltim3s1bkl3uxk3xlqsa4yvwtc.xx.internal.cloudapp.net
 ([20.3.167.80]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614f873cabsm720712b3a.2.2026.09.03.22.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:34:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Fri,  4 Sep 2026 05:34:26 +0000
Message-ID: <20260904053426.4117-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904031352.40237-1-changwei.zou@canonical.com>
References: <20260904031352.40237-1-changwei.zou@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: make result_check() robust to
 page-cache noise
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

Hi Changwei,

On Fri, Sep 4, 2026, Changwei Zou wrote:
> cpuset_memory_spread: make result_check() robust to page-cache noise

> +	# when min_upper / max_lower (floating) is not less than
> +	# upperlimit / lowerlimit, the test passes.
> +	if awk -v mu="$min_upper" -v xl="$max_lower" \
> +	       -v ul="$upperlimit" -v ll="$lowerlimit" \
> +	       'BEGIN {
> +	                if (xl == 0) { exit !(mu > 0) }
> +	                exit !((mu / xl) >= (ul / ll))
> +	        }'; then

This ratio can accept genuine unexpected-node allocations when unrelated
activity inflates an expected node. With 4 KiB pages, 500000/100000 passes;
with 64 KiB pages, even 20000/60000 passes because 10000/32768 is below one.
Retain an absolute cap for max_lower or isolate the test file's cache pages.

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
