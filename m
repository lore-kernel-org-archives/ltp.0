Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2080CD13D3
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777569046; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Sgrcr5Ie1r+KlwNUMU8zPrT/DXVoDWpPgW3IFYWwyLI7ySc+Xq+QJxyj1q/Iyi2LlSQBD
 VH9iLx9UtTitEz4HWioziOHtjKejSH8KUE8fzcMKNNZpZQ6Z0kL6jlnyDksjCjyTl29gBtO
 QG4RGmGipkPB5132DspbkJ/WT2CPHO0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 501163E2DEB
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 19:10:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9EDE3E1BEC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 19:10:22 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E57371401264
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 19:10:21 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso14350035e9.3
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777569021; x=1778173821; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=XzOAbd+Bng++aPyTTVVvNMPc2IIuQduZpv02fJSVbW1FjnMdn5XwpnoANTTMEpJCNL
 mLgGPHHyvm6bjh0FYSOAyTnRZ+SZ3lCV/qB5aMaXhiOUC2FBMXaAQr6+UaSgjGREFAJg
 bCqc52E0yY2DTtkjWpPdTHHLUMQEc18cCKjgNhWqaZzPTYw1ntvALUiz0Gvz6O/VLpXX
 WVejL2Gycn4MASnbI97WAAGpF8BGsvxS6mdfvu5tI3pP8aUmnBUN3ADOzBJqP70kPHLq
 q2GJCBHiv5YflzLKDOhoxpYjkx+1I88Z2wbrqX6Ig6s8gUvNIo6K/5UeGbDtL1m68Jyz
 mTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569021; x=1778173821;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=RUnjsMRZQjWh495PSGD0qK9yzTX3Wlmx9hJT+VhAK0ZOPVHKA1wGcL4ydjxrjRkBnx
 UT3p0Pyz3hzqrLT0tRLuT1X2bgsgOuuLQh26KIMtXUpd4St87lDFt9UtL9UCWHfSaOws
 quYIoyLwfwTSzWVxN7DbRsxJvWDCF0m5dBtoqAUvgsUZwyqS0AHOqVu8v13Q8VcW+eQ4
 rltScPG+/64W2gdMSTEDllmw3CZ6padOxgySAegjtIse+3YXryKO8DrBlfSGs5OkBmxI
 PlTCOlEqqu2axbxXwQ4/ge4SU1zHaYnRuzK9WDupKL9rZUKCOK5Eb9TvJCmkSx9uMY0B
 uKkQ==
X-Gm-Message-State: AOJu0Yxfwzvh7DfqmaTscQHehGqUp3RJ0Mhi8jLfVUI5J5XrS/5wbkqF
 +LYH1zJMrZF+a3pyJM4Q8DlSqw0dc1Xcqc+zpR68i7Q9HWrLhQ7uk17+p8ZRr72DIU8=
X-Gm-Gg: AeBDieu+XP+4bqd0bf+XUm3gF6v7+u76WpiER1qJkY4f6L1WEomHEE+ii6XUlb840NE
 jQ1Dc6MhjAAG2fqWQPJ7zGIYeWDNZ1LXhNeFWSrtQ1sYmt130KuFZlKOH35iAwuhmgTg4+aKMhV
 rvyewERppjqedU0GAdd+xm0os651/jrVUOOosXyOcVoEUhI4Z5PYuoX5YyF6+IrEPrHBeT+zp0C
 UTEd2LG+8nK64MEbHsMMPv6ueClEwME0k7tVw7n21PS+Y5x8jqYHzq2jbZdoRd/2TzWYFaAoZMw
 kaGIBp5FUWcylgEYntvnkq3XHTTm2qXRydsbqVHvP8bZM5tAl1Of4TqF3hADbK3sXou7syUWpAC
 73rniAOLSE5cAtPMVfiNyq6kOmbtLqX1ktn5y7+HXyQjeUWkVwxFRmmWC5nDoAalyjwK6l8xwcC
 +dZ/6gSQahINuF8qvBRidVyh0T2QMcrCD6vYqal9YDffHCMZliiJIOLSeZPr6Uaq4meU9KBeIKw
 gD7AHa6JQiulaGknBDUe/ZVbSwz+hg1mFmgUDYsTKSWcqEPe9kxADLjhMCTVWIjVnnpfjUoHWtj
 6yzV8DsS3LbI
X-Received: by 2002:a05:600c:4fc5:b0:489:c57:7836 with SMTP id
 5b1f17b1804b1-48a8445dda3mr71221575e9.27.1777569021240; 
 Thu, 30 Apr 2026 10:10:21 -0700 (PDT)
Received: from p200300ef2f4fc9007395fc0cb1d2b23f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed661bsm131788475e9.1.2026.04.30.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:10:20 -0700 (PDT)
Message-ID: <69f38cfc.050a0220.111eb3.c1c7@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
Date: Thu, 30 Apr 2026 17:10:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] cve-2026-31431 reproducer
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
