Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A20C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785484782; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Be8aSLL67oZA9u/OfMQWkD2iv+7g1Xe0ym+9n1UkxpDhC6iuDuF4CcfnuYKMGKhjPQvXC
 apfAuD6O0TVjsb0T5YfYpkfih+v6pLmqV/7rgpxX3HyeyXvgi888RMiLqluBL0KgCRheo6G
 wRLxMkhpZ2TD2sWC5eiHQjEL4XH1iRQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A07AC3E286A
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 09:59:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4F803E286A
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:59:20 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3184B200A0F
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 09:59:20 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so616632f8f.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785484759; x=1786089559; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RETgU5YBwxTsDZdRJYa+X16k1QZBWDGf8UZ05J56M2gSyenWZS9xNEU6lOp4dmxrX8
 Bgp6X6dMTwXvQybdyfcQhvAHsZHbTmIyMpxEAJJbGzu6b9Nn88h5ZL3mX2a5zeMNJsS4
 wA/M40vv2bdu1xXwnW2Mj4NHD/vQNHcBR7qhghAKufIqSi8zvnsf91xxQ7wZsLW4kxYB
 xqi8QqRX3e7v3jkibgl8lqfd5bEXNKNyolcsIrjuXq1G1I0wkZzgnjQ3ervoBezQA38M
 6GLEjxATKnhdKUpUGfKEflJCMORccF/mTxiJYt96gK435Jhn/SmxG1uC9E11bKWNoK+u
 UhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785484759; x=1786089559;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Md7xlzxJkmAFMhdnQvnh76smFLJOa+dsoase+MO5vBGgJAEywhOcxa70eg14JzvhO+
 hy6+Yb6TINadQqbAU4J1EtrWPdfVIpoLiDeav6TFlh7oyzeIB1R5SadSILFq/2X+1Fjb
 nsaE31N8TU79BpEVWXFdqELUhJcZyOFtnW0areB8tDjxzZJW1KAulqHNCCmfWqf9RBDW
 vA9OrjF1gSCPLJZSKybJlsiNxGGaaM0ep3e/tY5f2ToJkftlCgMxlu2Rhbzq7yKwYnia
 Cps9LkM+Qlx7MZRul2lbPvGlrxX3tQE+GKdPiJWPNNzA/Hzl1coUKCFuoc3LaCWprLpY
 ZdOA==
X-Gm-Message-State: AOJu0Yys30x9vKjtp5CDqBINdNj2IZsgN7OYZ2bxZA3WNuEMKW89djuP
 GSoyiwoo9NbftlpjsvTSkQvckFnQ+IeM/Nj5nJNBrhbXRDUv6iNdEDXbvfx3FpMmnOEX7zLNDlk
 82+eLUW5NDA==
X-Gm-Gg: AR+sD11yzxkkeWaoMDcVFLNwrTQO8x7kZf9m0WQEHBa0d9kh1LpYMDUu4vECqin05Pm
 ANsBZoMs+G5eNgCfJYdcTdiOH80oG7I0rjdivlc0WwvU6dlCUIJTltcMOLD7YXcQFfGum0zfChU
 kSTVKeLqGPKF42euE5DRq78WzMckr6n44AGIQ/3ODGb+apPO/wIgPx5pDqHlFGLoOgSCF7bZjHU
 qxg6x6OXtC5NLnx6+40qZG7xD/tNS/2OQlhFZ6S8X1vP4HUnjqTBPXv+bc90XGpDmKu3wp0arhD
 ZR/EEPY+LVt+LRL+yqda9lDNe3r/eRZQPRm8bnm8M8R4bK6WS7raTHD2Tp1NfM6+Yuwt8e++RVM
 JA/LfYxOatkamZNCRIN2onOXWRniIG0YjB356pUr6gaRrmiX5N958A/AysENnyEg3E4c4iqFPrm
 FTZYB4VI09wyI5YWiNCpoHfIRPd6DCxcpfovcsqmqegr9/9gWGm3oob+6h+4NYGQtcC2z4F9h+P
 fmHDbAm0+4t6zXRQRCTcAOZv1z/hlO3DfEQdK04XaY3Yrm5P0rFE6lPR9VuVxxaFlBrQyA=
X-Received: by 2002:a05:6000:4209:b0:47f:881f:74a8 with SMTP id
 ffacd0b85a97d-47fd2b40da3mr2476639f8f.28.1785484759516; 
 Fri, 31 Jul 2026 00:59:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm1940813f8f.11.2026.07.31.00.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 00:59:19 -0700 (PDT)
Message-ID: <6a6c55d7.9b582779.1de776.5996@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260731071545.1334046-1-wakel@google.com>
Date: Fri, 31 Jul 2026 07:59:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime03: Extend tolerance on slow kernel
 configs
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
