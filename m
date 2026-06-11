Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46133CD8CB9
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781163664; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=OPYpuoBKA/qEOE3TYmuG6whNpHmZ3qBOzvP63zcC/UOLIk9lPfuActWAizReIVxQMBqL8
 iKhTvzxFNnTH4vrxUXJ46wUlU1/AJ6uz/XDYNQwoWM7ZxFfPL/iQzi3+SH1f2dGxdhlJAD2
 5NCft/r7RD6mBb8h79HQWQ3UfCmfjgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CBA73E2AA2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:41:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2648F3C2B4B
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:40:44 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A27210007C3
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:40:43 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so5745075f8f.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781163643; x=1781768443; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Z1fueUwpc076qVYlx/Zj9+3JnVxb11lFlfIUOjXp+6OJU3kB1dx70besRUW6lLgPJ7
 0kdjeUI563hiJxqG8qPlDBw3sWcWq1kcSySCHsa54aDsMPCXtswopTEmDde1df0gsPX3
 dLFfATcDpHTnFkSsHdaD5rbpybSwWThQtvpBfBacLlU5Gz+Ku3ouHh6smrAQeMhBo++4
 FK+81QWkRCNerE15pN0HpUglZc7iABEVp09ydSvaEd8S+ZIrXvxZ9SiQcNxRE4+aERw2
 IjIahDjrsxOXe+Q98ukoSXMEn083C6bfPiwkekG7Zi6VjxsaNjy569adJOy2APppP/VP
 qgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781163643; x=1781768443;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=VqhY0t2b6YH4JVDvVjTTNrD0sjs0LVlGo7Qjq+pwsC0WWLWP7KGqEAz99qOUnDMYB0
 XrYVgPf05nl31/eGEFvQFhBM4vFrUle+AYOUBV83gZjiO4AUzZNWD83itHEiuChVqbyb
 yPXUruPgr9LN9POnNfEHIFH7DzojMNBSwlXr+18hdp2vROqulVzrOOkqeGV+jAlv7XH5
 kEjxAph6HxFT1WoGTz0avO01nglsTBD165eWGJPXJwsdLp/5Sz0S8nWeKCtg+GX8ow/S
 qHGwNx0SDR69uvleeFWE6mMZ+EwKFe3dOsv2lchIMIDxi073lUj9xbHZ6NGAVVbWerpY
 e6lg==
X-Gm-Message-State: AOJu0YzW+iEf1Yjzl3DG0FLoYv5Uj/KUQwKKFBgPaZcwJO+1INXzcZEC
 Rc9rvHgc8W0pRKe9G25JPQsZcBsfhO4J756JpqxhEcjzY/GBde/kBhhTf+q3I8KRVok=
X-Gm-Gg: Acq92OHNa5HmyWDlus/zHQKBEHo87OUbzx53ODiftX7Of87tQTIYTDfFnkliKd3djDU
 GsTEg7CFrvIw/rg3f5rJeFpPSXJeo7qGdN+gBFECMLbKhjQ2YrZv/b1YDP7l8/wc01McejqtP1d
 OxQRNntpng7QIJL4jPjgfpT8UAytqMZnB2Gu0g0r9M2GCMRF9OYayLmpSCqRF95bKFsLm+ZpN2/
 q2wFjOI8ktDCReFMG+dOnirbrx/lc7yodbrVQyt0HCmP2WUHD/UmxdubtPVwksiAb4U94TXjDd6
 2do4EEp5R3RBy7no4np6SKlK4kZ28ZbO9Fm7CvdMphvQrBbqoEbSvIWq8IDMV3ME2Gb+J/Ek0fw
 Hferh6MUdZZik7rocCWPxvw7lWEdllPksVqXchNnKhnPjMndd9JGTxfKSUpBn2g/0E+cOekMfqQ
 ofLvrHBWmansriDpSRGc005jhXAMFgA8JKY9AS278VBLI856WJLDEpfxDchDtOS96cHl0unR1BG
 KZpdpjKZQwvA3yrZ9FgPLHXqC3TWz5yuwj3w0tqsws//g==
X-Received: by 2002:a05:6000:29d1:b0:460:c9f:8747 with SMTP id
 ffacd0b85a97d-460677dbaedmr1511430f8f.33.1781163642899; 
 Thu, 11 Jun 2026 00:40:42 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcb13sm79661299f8f.2.2026.06.11.00.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:40:42 -0700 (PDT)
Message-ID: <6a2a667a.379593d1.176819.f149@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260507181045.19489-1-rbranco@suse.de>
Date: Thu, 11 Jun 2026 07:40:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] memfd_create: move sys_memfd_create() to
 lapi/memfd.h
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
