Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DBFC55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 14:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785938934; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=KnmBPamBRGTXoW+ZK8rfl4qCrJk2hQ4cP9iCDw9bOVkb7VQ7LXfk6GWFAoJEtq70t+n2P
 7ooTYG3RuFfbyDaYXUerqW1yiUM6nR573rN6TNLEJExths165on3Qf+BnDa67/oPaV3n/Sz
 +EPn2xsx8R7VDCAu6zu9py23pcOBMKE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D0C53E715A
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 16:08:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38F2C3E707D
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:42 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8A760140026A
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:41 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso5604515e9.3
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785938861; x=1786543661; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JLYg1zS2UctlujAwwCU0SpsNAsxH8zIvIb4CYDq+mlfTecsIs76AVHavUjEQdDA86S
 lUcHrFad8Ea0KcGjM+lwIA8kq74xudjOd1r1DHHcE0nN6oZKA5TyHok5nRSimAXDcmpC
 StDeVSKOihkvJv8kBFHW2MDj3Jf033b4hrtV6x8pFRUOA6RxRC/Kk6LNxY+ffHG1CfcC
 UoI5ZVTbRyIKVU2dkYSNzC56kLFJYXdkxoxdpofkGCiFtZUvqg+qg2ppiwIQy7L33D8a
 /+/Co0kC+pEzgjBDk+z/edAxZ9g1ODB2QF7AMq5B8HtGPLyscbTwUVGAGtpRDe0QURgV
 /wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938861; x=1786543661;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=o2HVAszrSLDdQVhnrhKL5Q6f5U6GtQ6mI2PuaN9Pvx4tOyex49NIKL4BvSdtXh14Xd
 hvd0xOH0hXLv3JdkQXtLZvOW252katWvFeMBru0Mo5vOayIg5MFiicP/XSvkhwi05Irx
 tO8NLGOdNP+csbMeO8OOPbAsjbh2w3sStpyO67IEf3CK7NpRbvMjKvU7bqcwz9Sk213q
 +Lw5+Pbfk15qtwMiDKT4kC9kdSf2YOEXghpqFjAmncNLjqg/6UbSX0DrE5ZNlbAMkRkn
 aVhsUS1yrVjRgqHVuHSxM8CZ5crHq39w+zlBM4p5yH8uytJ6SzqwYn4V9IX+8yioU2eQ
 STQw==
X-Gm-Message-State: AOJu0YxmKCI9ELUUt6CvpozaI9Acj9UcS/HClfoUBSsui3Mvl+hth+b+
 u9d6vpvHV4Qj199gHzuChNFodfN+3miV7K/tURNKgP2YatgSIz7W12sZhh6Fx5RGizMX4LhB1zA
 55B3R11c=
X-Gm-Gg: AR+sD12wo8at1FU0hoy+wdYpRcaZ+6RP+F3LaKRtUW3Bo83lz8NgbF5OLNwzLXYq0yc
 4lnYC7BjCNoZ2agrh8j7ZNwxHS7vnSPGsBs2qD7t4zmi9oP41QHy2NfUnyI5IayD6EL3Z8L64K6
 +kn9fyNzpfENz5llrz1T1I/1i+xV7vZ1IZRdYcwqQBfr8d8sbMSCQra3YATjuBHMJWTYjcMXHB7
 bdwvAObUC7DUDCOF4hRSHISEyNE+abd7s0/mjpgbpJTZp+VFMK76ew2IdCULUjnBHwmT85HA1eT
 59GdwQEHcjkclH2Q1uIPDhMFK0j1m0io0MldzSBJlA8YHVy3STh5fhRAMFXkZt/sdhY3qxBfwyD
 kY4v4+ZquOyJheahTGRSws4NkmtpOLdMWrTV4wv451cX2kSg9Rt347JCjoK/fX7CIZdzortFZhX
 L9LyeRzZDaDCqV4+GOrN6bDrYaiMLZ58SDtS4LCVky7ATauB2+IJ4IKQSfzvL4KN/ZPTrXLO1xT
 vdshphetKKTs9ClYLz7gGp6+qsbQTImLlzJUtVu39F1Esb0lyvuJVZSxDggdzl6KBXNb4sjIfSV
 xOtimNG67IHVx8N3RBOomCjAMUjaLPzaBwwSkp1KCMQcoq/PHw==
X-Received: by 2002:a05:600c:4f86:b0:495:4d00:2fda with SMTP id
 5b1f17b1804b1-4994e72f7c1mr86948675e9.2.1785938860871; 
 Wed, 05 Aug 2026 07:07:40 -0700 (PDT)
Received: from p200300ef2f1109007d27a2191b5ea63b.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e988687sm53567045e9.3.2026.08.05.07.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:07:40 -0700 (PDT)
Message-ID: <6a7343ac.1583746b.1c869c.d34c@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260805094935.448896-3-pvorel@suse.cz>
Date: Wed, 05 Aug 2026 14:07:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] doc: Reduce default sphinx verbosity with -q
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
