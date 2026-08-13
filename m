Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AC3C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786622075; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=McVBT6ECBpUQWgf8eTGc0N01LwJdn90YHfAcIYNX7PJBgf/Rv4oXT/XktM9EzayaQmdvr
 Ojpaw1fHQnlKe0VQNfPYCXlBvSfUlJSDsQwfnGztS5bOu1mmFWCiJxdOg9gi3vntUbP/bCH
 On44Wp/NpQTEMrWA8vZ3lGPGR77iZPw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D8E73E6BEF
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:54:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1DD3D9E8C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:54:16 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82A3760080A
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:54:16 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso7094235e9.0
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786622056; x=1787226856; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=T8mwhw/7DqXCk8NrUwLfcaV2edggkPE6wZm84gEAJrQHrSuG6vnE+BL31qNqW5Khno
 DRkB7UTAwpttH8o3t3wRwEjtlRxgMV9WIZ9Kkg4iQ6XWdAwIMwHNiuDDr+xul49a1z03
 jrL+zKpsvfLlwe4EqSmq5ztH2jjzm2XLgq2eYorYIyWXt/vwbCOSGcT057R/wbMl/dhX
 FHD4EIJW/gsQwjzRdL9ZTNGdU6phZRLoLGqVjKkdUmDYHRrfLRVA8z2qVUo5dcTjXPaP
 /pBX7n98ILGkT+PYhiyYMwtwYwwDu1FxcLAbNhaDcCgAC2apdRsInKakt1fkOgbNljfx
 BPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786622056; x=1787226856;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=UUnDXJyEWbQAnZEGnf3FnFGAJ5Zq4rGMQv4OGt2vnAeypfrP62tSygHMfXewxs0c8H
 X/IzEhEOKPAg6ZUn5/fCTuC669ZkE3oDVQVJ3cTcMbOVMOAIh75n4D17UDgyTvPF4xFE
 t2pj0ie+6iif/DShwSTBArd262YcnhKE7odB0j6MrXsh8r4aM4E8koX7/KjOxNnUvRV+
 x0l6fukjCCbE4emsHk15hECCcn9ABQO5feMIxXDGl8NR4xH179MXQXZpuJP69gw/KIKR
 49jPJF7akEVUW+LVGwDJ6k/HveKma8kA1mfNLH+69IlS5Zo+sVKeQw3U2lTGhjRzswTD
 Gnlg==
X-Gm-Message-State: AOJu0YxlgGgQet+kVwon+FVlID9w4cOe3sezEuyE8SdXfpPIQ207jY1m
 wvPc2skrLPbrLCAEoL/dP7ZIcfafPhosqS2LP0BuR8gJIyRgqMR/X+/yvGy1/Cgyl6U=
X-Gm-Gg: AR+sD13Qcz5/YkKwx7G3KpGc9suZMH4CmnTaq6bdclnY0xkt2FqrwacyJkp0HPYmcg9
 V+KDWmCf1x33w/w2bxX97hstUoajHn8WbYNszQ9xew5TuZaUslMuQFRNnu6DmckWe0P7m+TTKYc
 bW5f5GZbDd5Owugq1ZJBpq2Op90mDkVMlxTbHo+5GCHG5vcfJNqMmSMmeEUdN/PDfnK8835cI0x
 lIe4y+gSygvCLMjQGmFdJsRgNiKSFf9GnUlL6YPzlydQIv0r7uDKQkD5hlF3g8NwVXVLS7KKxpE
 e7COmU8C+XtzA4xm37Czv+4BIfc6oP/kIoT7g+nhrQaV3bbGTBVzKxFScS+xw551W3VFHtksGuW
 WZkesheZAqPxbJAF3mO+geMnTAP2T032k2Tf5ewYbNJDEI+tIu/6ejp7jEcOe/QvY5rQEYRkVF7
 tyRLKA0MvZpa2ExwuViqUrooLP3GN5zgCUPjbj/FR6FgAaIuzeHVkCtK4CmJLGMhwzQpLd6eM=
X-Received: by 2002:a05:600c:35c1:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499821bd037mr67274325e9.3.1786622055871; 
 Thu, 13 Aug 2026 04:54:15 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b03cd0sm64515475e9.1.2026.08.13.04.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:54:15 -0700 (PDT)
Message-ID: <6a7db067.6ab3636b.258558.972a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260813112524.1849695-1-pvorel@suse.cz>
Date: Thu, 13 Aug 2026 11:54:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ima_setup.sh: Use tst_umount()
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
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
