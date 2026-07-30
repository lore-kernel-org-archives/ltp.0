Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD5C55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785419270; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=hRQoTDwKA/7Y4yxFNor1vOW4xqO/NA2d8paADbqUkTwv+2uIAOyc2Y4pknA3syf7Lz6YJ
 QYoTBOgAoVQrrZMdur97zK42GarEEbWMAGkM8n30jsNX3Lud6XBy8dyNKcbEeaC4wJPK50G
 cOETUvdpplEDzLHBu2RggpgLsCP8XRw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A4F23E1C9D
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:47:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE35D3E1C9D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:47:28 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 107791400769
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:47:28 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so4337685e9.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785419247; x=1786024047; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=hBzTgmyIc1GLMu3cSt0k6FGjiJimmPX7Ih3LLdSpuGd0VWbxioH3ZsK3JkZfJ+447V
 eu7olncY5N07YW60bU5xJ4wEeamV0OiZq3LGaNjJXIZeNfwkbk1FkR0lA5nR/M8mE2F8
 i5VKgl6sdRaIw1j1CPH8Ck3FQ277GyX/zi4Edz+4CtGFITJxie3t205OrTgkMLE7onMs
 sMRDIYdSYwymzegoKZ98a5h1YDi/btNY+pZxJFRfhGgOgJUsu93B+jazKQdnAG+Q+xFh
 fxsTFEy5AMHrq86J7PynACN8np259CLeYmA1tkO+PEFvJwzLB5T3UoQh72Ssl4ciJ31s
 0rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419247; x=1786024047;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JIJDzfmDCpYNHGl2wxfIkU3UH4RrepbcMbsZVk0fOgAf4qOP1dfqXDqtvJc4rI/SVt
 iD/hqxpYulyoww/sy+3zppig/+dLHQj+O2sRFAT0fAitRjcrrloUZFFzGFV/CX89oJ1x
 0/zDdv8h16gkxLPS1uYf4G5sK8TqfgPxLK9LkYOmaMIhWv9i+tmxU6QZO0Hh6WeqafiP
 RCqN+ZgIbNluok7GDBd6H2NYPGuwavoqXqCZ8y7LM3iA0atPRXxnvoe4HWoX+i7I+nzY
 waeNr9og2wrgAc/wxcNxzUnpBkO3YWVHvf+QEs4x7UfspSZ0V9hqB4Gun6f5WeRbpGND
 ArFg==
X-Gm-Message-State: AOJu0Ywg2YwGaKtYa+aZ5mR/nX/vIn2Hq2yHcouG8iBNt4Dd/94Bb9K8
 uNpf2m5rZ6jyuPCwlsw1R+NOBgRQHcTP8sOtrncLQSOLd4ceOEDZueuvLeHCQGtgGCLspNx07Oz
 lLpIAxig=
X-Gm-Gg: AR+sD10p3Okq+LQAVug2LujdkJH9cqu9eQ3J8hq6FVD2Oughokf7lHHP7mVZ6LQm2i2
 RIDUm8dvEvLWh/CePrToxztEn6kIb+glqmRYzwNM1Ls3zlZGonLWP1lnHa6ELvg9AmcfTpiLRpm
 PiRU5wZhcPkynifB+uG8oFSQGo3VXxvj0nGpiivmb8ruwdDdwcq8qbnXbMqwwWRNu5VdzRsZu/D
 nT5MWzEhbs/PaslFOdHyl/MMB0W0vX7NVu6GLgXizE9yRNSRodRu8SWD56MBRItgQQlgrdlcLBC
 NyD4sf8RRBevLpGSNpT4ZmQIu3Z959TBIZmauakhyMFTRGNrVjSGnw26gDoR185QFqBCTFj+knX
 swmeNtRBLImAXopyMRvZGF+QrurVt8e3SUZ68/G/qTuaWSCRjC8wfssgx9H83RPhxF8izEzpBdB
 Zj4NtuP0+8uJPgPHc4EdSDjll1ENmvfgbJXrG7uAlTnNY/FkAycvJYndQd293jgsQhCjUfBh43L
 iM2u3uleTLggKXdL0LNI9UkRidG4NMRpePLHg==
X-Received: by 2002:a05:600c:1d8c:b0:495:4487:61af with SMTP id
 5b1f17b1804b1-49800ece1e1mr35272585e9.36.1785419247372; 
 Thu, 30 Jul 2026 06:47:27 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011fd5fesm57183935e9.7.2026.07.30.06.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:47:27 -0700 (PDT)
Message-ID: <6a6b55ef.cfe55ba5.193c31.0029@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260730134102.132477-1-avinesh.kumar@suse.com>
Date: Thu, 30 Jul 2026 13:47:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] inode01: increase dev_min_size to fit the peak
 usage in parallel scenario
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
