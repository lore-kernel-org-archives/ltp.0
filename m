Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13734FD8752
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 12:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773749699; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KOLjrncCxmMAnOd05PRDagJjo8x9794Rj2yBubuRrkw=;
 b=mWlDMLFJgsMghcwHkEeFXiuUlTiParMtKVCiBpGbBikrFQg3wjh2c7ZKrcSxqYvVvNwm4
 Kc5qqUAnZ0EX2cjwaVB6YjMyClndp4Mv6iEWIeUNu9EMGQNtQsdCPzETUd3p7ztLfCxPYDj
 NXgd4RTi3XJ/TsMwU/kevYe53X2qkS4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0EB33E1C8B
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 13:14:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E89B3CC8C5
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 13:14:36 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C8F9200085
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 13:14:36 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso50158205e9.1
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773749676; x=1774354476; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fULIX8/zxvB1/BjKZz9g4yD4YFy3vQBj7a+W3NN4uuY=;
 b=C6civoYM8Wzaq1iVdBToSJLGlxdfpRdzlNK3sPrWrfRlnbYSw7LlwfLFGXelnUHW6K
 6f1q94UcN0Luu7mZJae54VUvewk7izclVTUFntZvnqwf8KKN8d2p+ikmQqj1o+LGvEpF
 iMc5vc6YguqdvJnN+82tZ0JwDqaKAkUOgX/QkdPbbU8rKjSsVncjtakA42jSz1cdmoI4
 scOH3xFeXNSWhxXNc/AZwsCrQo/9/JFbBccHeYxqw9UgLqU73d2ahd5v95wil7OB3Uim
 bAF8NV086yE2bp82AqWnpWDj7F0IFlNqtBzzUHwcXc6//o0kzaAn985pftxRz1n6FK0g
 Li5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773749676; x=1774354476;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fULIX8/zxvB1/BjKZz9g4yD4YFy3vQBj7a+W3NN4uuY=;
 b=knIRaDXYufuRuflqJWcBZuPDjDp4vCNx2yHd+VE2BY+cVdp0FfAgTeDSP9SIW6Fstm
 NKsIG/u4D7wu3fyMxYmcs94ga4sdwF1o8eLXhyAj3yN8fvasFUFP2uAnB+p8oSQ0MMoC
 0OTE/HZvRYajkdIwGQ1LqVFGLl9Tv9wllKRAkfuuzIESkvMqb+JxCQbVYU6QLcDRZAPV
 h4ltO/R1LHzd+Q4GmnJ92qntXVm4plmhLo5J/ZPhInU+4OjHb3cIYD+ZkF0hgT6l8mp8
 XLd3saax7xKC/QX8Pu+HL2ConVhLrZ5Hsgd0vMFC2wxaSKjcyaMmrOZpRWYLdMtNSYKN
 RWbA==
X-Gm-Message-State: AOJu0YyualnEYvaZTU5IvKcEsZn9hZWo21Fqd6W4o43E3k+nNj8Rh7G1
 bC7fPxm5cdgUdh6p4TM4R/c6nxucNsrwNNq1dR+LkPNYUrRUcq5cl+8tvMuSETs4GpU=
X-Gm-Gg: ATEYQzzIq/AdJXMBwBg1YR95YdlQGhmuJ8jCQJu50i8WPPybyITQnsKXxop4AMyHt64
 vVh9Rkub2f6aVcRL039PrVLTmU3uQY67FHdC1D49HlZeIlvgjeMWLNPHBDZoly7uDSJF07S698/
 j0dGPhQJ3gwFtugpQO5OIVreqSBjde4+5sDSVfHNKHjxNvENQGbpadj6ft6m/PeWP5xOGjIK53D
 qiRioARYc58KcKT2qS5EGZtYKsBX0v/Wr+4Fgn3WaamMIM4iu9E7m92kM6T0a97KFsvGp6MwX9Z
 ZwKwkb9qCN6LEm/f+P+RwsTiDdc+m0bznNlOBP4C3O9o/ssnVq0yDhqrT0kv5saYuP4DV2pbHNm
 a9Ql3RrpYz3UggOnU+ileFiLMdmKccqxKrohAoAko4//pz6B4zbgPhgIGeGbZ+e0WFvPvLfPess
 lm2+XIyYtKia/IbGvE9RJ7fA462xM92Qercfbsxf8=
X-Received: by 2002:a05:600c:8b82:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-4855a8d6c53mr261349365e9.22.1773749675929; 
 Tue, 17 Mar 2026 05:14:35 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eabb6edsm57473555e9.15.2026.03.17.05.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 05:14:35 -0700 (PDT)
Message-ID: <69b945ab.050a0220.1eaaec.d93b@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260317115828.GA365182@pevik>
Date: Tue, 17 Mar 2026 12:14:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> I'd vote for limiting patchsets to max tests in a single directory.
> Why? Smaller patchset is easier to review. And if just some of the commits are
> accepted then fewer commits need to be rebased.

Do you mean one patch-set for multiple (unrelated) tests (for instance syscalls
folder) [1], or one patch-set per testing suite [2] ?

[1] would be 20 random tests from testcases/kerne/syscalls
[2] i.e. all tests to refactor in `testcases/kernel/mem/mmapstress`

I would follow the first approach if we want to send a big amount of patches,
or the second if we want to be more specific.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
