Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCA3C54FD2
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785401365; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=FdiE7j9K+rozipOwoSTDOGE/DeHWquijyJLaSV4bmQ2DkNwSV5Mnlpax6UYvtUXrSpEP9
 pyNCEs6JKIiJGTEC5QLREYWXpf+mgQkxMO7MledmMh/J1ix+m4k/xxAdsm9QRFfWXy9i1ON
 46H2WksKKRyUy0ReARyY9EA7L36ty38=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5353E5859
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:49:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40E743E49EA
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:49:06 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1EA2600722
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:49:05 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso3009995e9.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 01:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785401345; x=1786006145; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=R9kyksWn0taIpSB3NDdHlSbjTY7EaEtp/RsOBrairLzK4QTK8iYYUvYvEHD56NUqzV
 AOxW5IpChGNKBcGLTyeDJoYjrfCJ3WE4C4N0ohia037f+2Abbr8MfwcliqF5GcFjodv+
 CELYC561x5DRFOwkWXy6HxIr0pF0cIm1u0/8oQmEP/AZgi/1ZncZyrdynQ2aDXhmN8I4
 aYdd6G7lz7ZZnd5HihfNyhLmaPOxxvlTyPyUM+9ca6J1TC8lrw+wMbn5otnKcYVhojqM
 yYmLO2fLEhF0tggIKiCu0yPgK/XlQDr7Pzt2G/ZuVQN8cGoCBqSb1yOPbo/8SovY1HeW
 iDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785401345; x=1786006145;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=jgIFq4EVju9xDL14LKzRT+Rlgy4UZTR+p0fYJkaC7qhngeKXmOePrUZguT9jyShF5T
 kevqVvRKKclMzbqNLu0a4FKWygKLuKr/USLQGZNjwtWBWuKvkpjpmddmC1+00RvAbK19
 yPoMmWYndEyhX+NJd8P0M/oQWCT8O1sDkiqkb7eai//NlCBcO4+K7ZHp/T/BTRUGEJCR
 s4VMQL2+F/rvd7M50+I9MqCsYff1qjnV808iSUocwdw0EWX+XJcLMuwnR04feFdZ/v/m
 BjMLWJ0UkRX4WgGtHFc4awmOioOWmYq/gHrSlDynZVt+Sp5K9lJeFnocqGs10EW/ZkuL
 O2kg==
X-Gm-Message-State: AOJu0YyDhIkLOgMfBLlNhV6wkDuGTZYOy2ZUA1CrqdjmFl4Fnq7V9ooS
 E/LshV9Xp7pBvaPvKp2NZ8FNNzGAGj62O9C9aRkADxC20MIgcVrlP/ARbuWMfwzP+zwM0/xu5nM
 eFxI+0Zm4gw==
X-Gm-Gg: AR+sD11O5IDGR9iYuGhxwzrnyK7lXYMX38jFaj3kDvT4TOhJBtEXlE8kSwu5MdTtvuf
 ZjTYqEtX9blIraMytcEn+K4hT+ELLDbFWRH0lCrYzsHbHsBY1tmWeuhrpWhrnV6rzxurpScFOz/
 2CgfOfhs2dl0/D+BR2z0F4mQuy6uaoJS+b4u5PZoDmuFpGUy48nBmv3DZoIobNYvAaV7uCiIOrx
 FfbGbq7rnydemEt+NNInOjPmuFQuhRKV1tw0R3pGI8cZGla/d3V0MumKm+XoWOa4bsrlUWbkl5o
 CLO4Ksc6RgyJfZh1w60DON81XSPJWmCOLYTWvkUxfvNVawQS7JRO5TBfC3uMz4kgHs6g5ECb9nk
 gljfv2SlyL9GHuPRp5cWxJCJYLIyWBfdKpLIPxKhYvVG+7h8TdBzJlYra9pnWi4xw19oHstEgIv
 vT8BkqYLL7sB6/MvvR9vtyoaqDIUKUIsivOiE5T8t8IF5ENUPAkBT3TWjdQ+xfgfZSEw4ArbQg4
 z4jdBQIUMCIKL6WcVkC9vEiANaqh1dRmedfmYEcWbujpdwXxDT/2t8yfh8BSVUefJo+stU=
X-Received: by 2002:a05:600c:a01:b0:495:4f84:7280 with SMTP id
 5b1f17b1804b1-49801ee1d85mr17882765e9.4.1785401344987; 
 Thu, 30 Jul 2026 01:49:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011e5febsm40363525e9.3.2026.07.30.01.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:49:04 -0700 (PDT)
Message-ID: <6a6b1000.3527643f.2a6277.1af0@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260715123612.1684984-2-chrubis@suse.cz>
Date: Thu, 30 Jul 2026 08:49:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] syscalls: Add epoll_ctl07
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
