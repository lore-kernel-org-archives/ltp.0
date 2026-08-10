Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC9CC5AD4E
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786355259; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=aBV6O8Xp55Bz/Ken7DDImcl1oOssOVAIBvLIqqHkrY8zu7vD6GrM8pZ+PmVckCfUAu65K
 LfnCqe6jEMG+gbw7gpUONcv84bk84PpTVZGXNseNLjuRdmQzvIyeMKXzfbmFO7eabmegx1b
 kDRdTR3oe4YEYDdh6zuhDfVkOE9EEWo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A246D3CE6E7
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:47:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 811253CE141
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:47:19 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9305D1400745
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:47:18 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso18230465e9.0
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786355238; x=1786960038; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ZrsWzLKgeYdnxSrV0IWRinmcDsKeCe1MogeGaePM9gCQQIHGMmkFom6WZPwlgkZY+3
 jOl0NEr1LT304TRPGeiqZ54EgAnIucc9sjiCvZGJ45ZmA83sIpnYZEE+GQteFyeRW+2R
 MJtQnRmVEKs96ZxG4VbDTNa/r2JGuyB1qKiq28pXoPsa4unCzMXOH2zBVVikys5EqSx9
 K9J9BvbII3eSq0KInxezrA6O21hh/fOnYEQB2plRHaXdDw8GC65Bwu09F53ty7IEmTeA
 BAaM3fREfPQXzRb2ZiDi1F+iVrACD7l47Hu+XrgWeFmby2R1DFDjaIhwV6Hy6Yye+i81
 Fp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786355238; x=1786960038;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=D9Ynssp7yOsZC5Au7raclvN7/kEzzAxNcOEMhpuO4FsmKfv4wQ+GZZlIu5ZhzTezo9
 fZ+FrY1sAxcQgz8uMwuclp282+x+ksf9ef+NkAzVyw2yVqjYyFtLlFDWixb0Biuahd1E
 Zqbu6k7dtr6LRUg0MzH9NpXd4SD7gVnkWBuFCoiV28Bay34xT7msMQ2vG1mD23RX65mc
 Q4XbAhpUGpVdNdKnhT7Sxqy3ePpCFHCv4O1n3ZBPj7S4dn6DdJxVfeuVaFF/ZmiUQ7Bo
 IaF+8LTvQ+TwLamqPlUXDZR8sNUGX2u2cc2/kBzd9u7VMLUU6wPW7F03kgC/wXPJ+Rwm
 icmA==
X-Gm-Message-State: AOJu0YwLORjzqTE/n3kl3sksyJ0Ija+sl46+lKUYVYnmdiP/qgs/wQGI
 cnzPiAHC2YOrf5e9DbolUKiK00ocBtifHpVcwZutx9eoGcy/tHjjzSW6viCfc1caIFWlmfJ8sdT
 OuVvi
X-Gm-Gg: AR+sD12w9XSAE5npBrRV8MajqxMat9WJyNW9k4tEYZpBnKhnBiKbpEOB52yVU4z2Soh
 j+CcklXnOWbJOj85HaPdMYD5ZZ926yB+Thycv1s+/1JSQYv/bv4CYj0eBddKw+35kvTJCxmDWpE
 WhaNafpJznDA4JfHn9/truY2ZkfkYaGSbv1SzabNGWkae4QmXUoSSmbghQAvnllnopXSU4VGSLQ
 k0vXdo+W3m6Vpp+j2IWiTd4OKAXJs2qUFkIEQ5pxlxmR2Ysi/xtArz1glrKX6RXvwIOgmSeWx/C
 gpDMF8HChGTRdOHld3IWHbz7YtB/fKh+jomAyNBCY+oHW4jAJI1Lgiem59MGWB6FxC60+YmJe/P
 Ht9+3nRSNChEUAH/uam/iiDm/bSedGdtvjScRMm8GQsW+wGD7aTRoXSdGXG0aePZrrLvqeG1Oy4
 6KHLFxe6HOPCpS8YSS6qbiTRznh2vCgtgQKszyM5dwxYP60om2P40f2n1I3RHPGL+ECPOZlA==
X-Received: by 2002:a05:600c:4715:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-4996195884bmr209451615e9.5.1786355237620; 
 Mon, 10 Aug 2026 02:47:17 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c8bcca6sm218179895e9.4.2026.08.10.02.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:47:17 -0700 (PDT)
Message-ID: <6a799e25.e9cff95d.1ecde9.1250@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260807231752.3218267-1-wakel@google.com>
Date: Mon, 10 Aug 2026 09:47:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] inode01: Use uint64_t to prevent inode
 truncation on 32-bit
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
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
