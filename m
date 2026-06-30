Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD23C43327
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782808532; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=iz4s3Gye8XIvkb1FrEWbpM91q3bYVbUBah2jnxOSytk=;
 b=RHdL4rfiSIQfFbPFBjtKdDOqf76ievJxq62NYCRgwof3PYaSweTAsGFpy4z8q7ccg297o
 VrikEgCF6kxHOucUuDnajPuxPbllaD6djV7gVdMA4FPg23s+8nqgpovrHTi8hg0/RflN/ly
 0xd3SETacQlomkRXZCx+ig2v+FlCHso=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5453E4B45
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:35:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBBE83E229D
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:35:11 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AFC4600158
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:35:11 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso281954f8f.0
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782808511; x=1783413311; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bySewzYSmxlgOeqXqSWF+EW6PYt2f0/gC3Z5kcOmICI=;
 b=gl0k0kReXmzGcArc94T1fBXP51MauzfamGxrUZM/FaBelpo+xTaaGeJJpPWosvka2A
 ZwcAvYmy54EUBpZoJXV4z4aMkRaYHyNtrxOGI07Q1dh8N/hw1QQja7/Z37eLX+eat8tu
 tXVGsIAFFVjmrryzRdWH8VZ9Vlx46Cj6oQSxhAiS21UFw1R1kdOMR0KX/AlYiSZz27Sn
 KcFAw7fBILLiXdieFOJMbDxfqFcgPQviUAAV3X65dtuBWMyZSeE/AzUBHZtln5HAqRAT
 7I0L06SXtEe8a9UGj2BMfKmM+lH8vAyp4ILGdWRAgvlXNbxyw2bcYRNYy02nrUxpbClR
 Rdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782808511; x=1783413311;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bySewzYSmxlgOeqXqSWF+EW6PYt2f0/gC3Z5kcOmICI=;
 b=JbeGm8pwCXl6GMElssYPZ3S81CicS7AsJrkSNZd0jaz1jFJSh5kzhV9q4BhCS3X2DC
 nn44bAF7zS1womCFgsabRNFmSGXXUv5uf/+8zWUHfRE0w3CZ/NCYQBKck4WsCWhLios/
 4nQWhtqMS5BKfdUouy/leMTQES1aI2hWHFEXNdydS+kcrI2kN4CMYh5tHhDJ1HYWjeQ3
 SiJqhstvxCVoU5SpPcGF6O52ywycMXPNGA2ZC8Hv+RyxnyxVtLrTpF4+H+EoMy52HQsd
 LaTa+V/hwpikwKypCeY20jZEBnhcUKjPwzsfAfdqbmOUn1Jt9ck6RscHdaoOpZ8zHPre
 2Kfw==
X-Gm-Message-State: AOJu0YyYyceEa66JTjG9Y+kN3vcZyWuovDZpGF5RVbvOv85Jg9EP7e/M
 Q8QGpB6KT04kLfYHA689eZ6SQ7OxPaoa92oAnWvsv0D/tCHdo0UaOL9pZwfzjjT/EweF5J9pToK
 PlkCdNXA2eA==
X-Gm-Gg: AfdE7ckVZXKUHZWw7YulNmpJhBmcrLNpf7uGmVf8192hI1HUa3iQvFJewW7H3wYYlFN
 YnYTnFbRFv6xsPbzBqAAP/4zVugRwr1aKr6QeLawj/xbAoVR+F9oCSHQHn6QEbiJ9bKIlP9PP3X
 NosFOeI7ycSgA7YMNw5YtO2J09KS4LRY1jQrPwA9f6ldDdqxR/CZBm6P3vMoQbzmmNF8ES5QLmQ
 1kxLxDnWh44ixx0k0gepgy5Up38n6LEEMFHTBNaFbOMXpJUOsKmLL4o4DQ4YQ+8Vm7h6Dkc8Blm
 Pt2cv3tRT5C7U6VKm2EpVF61boAzWz4IsdeeLBocvUnq1CREEw1mwDeX/kJlr+tFX3+XgLwVPQx
 cqTUYoAIfycjo9LqdEBw6XrNWrDypOqyurqLdImnicoaS/saqZHCFzevI0QQAUV8WiZVjlaPD/I
 0R0hBOtC3JKKCx4uqUcb3YUaQ3SzSDSzjSfFUEj/ciPj549M0OkwvCJT6Tqm9vApF1caD2eZClM
 PyIL6HSkrJ46fHwBUABbMlKSIiUuSEuNg2CsGSOFFvhYnU0oEabUqRWf/MFMNJmBQQ=
X-Received: by 2002:a05:6000:41d2:b0:475:a05c:c642 with SMTP id
 ffacd0b85a97d-475a05cc8d4mr2192988f8f.19.1782808510678; 
 Tue, 30 Jun 2026 01:35:10 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756778fac3sm5244709f8f.32.2026.06.30.01.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:35:10 -0700 (PDT)
Message-ID: <6a437fbe.f31388b9.243dab.4184@mx.google.com>
To: "Hongtao Zhang via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260417022949.2881047-1-zhanghongtao35@huawei.com>
Date: Tue, 30 Jun 2026 08:35:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tpci: Unbind/rebind driver in
 test_assign_resources()
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
Cc: bhelgaas@google.com, liuyongqiang13@huawei.com, ltp@lists.linux.it,
 krzysztof.kozlowski@canonical.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged after reducing the verbosity of the commit message.
Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
