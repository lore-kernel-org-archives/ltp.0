Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17795C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713364383; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=31wCjPnVfwd7bDQ0GIyuaVN5Azp2rzkWtAd0QCG4DYQ=;
 b=mcm3CXGRWVp5OgC1mQcPaltcqM5CTRoUeJv+N7Ay/dNaZaUiHuSn87a8dV0iLdOoqKYwW
 qRJ0GJQSE1FIQhy0rfZkBFhzKeY70o/53JsoovS2AD1JC8ds1AWlbWT89TnCV5+sCv9EItk
 8WB2tszfTnI7z3rHCy/NrSkv6Dd2m/I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 079803CFB9E
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 16:33:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0989B3CF6F0
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 16:32:40 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1F58A20A6C5
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 16:32:40 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-418a02562b3so10958495e9.3
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713364359; x=1713969159; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2HYAz4y/Tr5Apq7r7zHngZ+cZL852tSH4Rp0lJC5rY=;
 b=YLjrjxyPoGspAhL/D45A0awLH0a60efpttsS11STr5rCLqXzuT4ByQ/jl8iXTYtYj8
 wkHR0rESs1fa9DBPI7FRdVwQuuI79dq7AzeCnmqLno7XxNC0s7sp27UYPgbOKX9InvLs
 lfNw4udks1QCFrTYMFO9B2q/JmOblT/0J9Sy2ayMzcQIuFBLtW+wyRRR4umVEh83vM9O
 2WCP1RvmPpBOh57Z9OwI30TsRxLVEbm90rMJ48sJUdw/sNYMgFdrAHduPRs7bS7iZ9e6
 3/A+wevC7tcRexxr2rGeTmw5ez/NeUf6+XBXnFpaiC1FnvAuWLMg9XLwEm/jt94Gr31G
 PPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713364359; x=1713969159;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E2HYAz4y/Tr5Apq7r7zHngZ+cZL852tSH4Rp0lJC5rY=;
 b=Ho+ldp9tqemSNKj1H+k+qt8mBL8/WBmot7wDq7NqPqZVgP7gF+CcbdrNwXti82MBo7
 OrrNURWDSQVwBcwvbZMTNeazbcL6NMDvhXNX/tEZGO5D4BldfS9H1XdeaqIWbaWbZE2N
 mVPLzb9fN0P6fQazN8S13NaBqet4eT00xAdmueL+pkbX5m35TLXLkMNJZlteDog5xKXt
 lGoy9Q2DJSJJ6thAsc0svRWgHcVW4yqitNEJH5sor4Ohn4esLSWQ2u1g4ovLIJdxuofy
 ss7AzRM+6cb71VABq/2fB0jGMmXsooeOOEU2UClZx2q9H1JdnkcOjyBtSd1KZUDYSOyz
 FrMA==
X-Gm-Message-State: AOJu0YxyjCcsbW2k8Ed4QI3A4jgpx6iwLwGoHdapHFaCdFqowf3q8HXP
 bncSIM8I0M5RNK2+lO2VZHl1lQ/H1Yw7CMyYvPfc0wayEduJQffTOWXtble/VEfYf5gLmawXZPr
 R1urODol3
X-Google-Smtp-Source: AGHT+IF62m0im7YI/CfnV+O486zwaCs5RIXQ9ELozW3sVZTq4hPR7b0oudY2oWUKx+Gs5ZaZsUIG0g==
X-Received: by 2002:a05:600c:a42:b0:416:9ba1:622d with SMTP id
 c2-20020a05600c0a4200b004169ba1622dmr12801270wmq.38.1713364359277; 
 Wed, 17 Apr 2024 07:32:39 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.72])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d44cb000000b00345920fcb45sm17667635wrr.13.2024.04.17.07.32.38
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 07:32:39 -0700 (PDT)
Message-ID: <b5872e1e-723f-4444-ae9c-39fd8b9d39fd@suse.com>
Date: Wed, 17 Apr 2024 16:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open monthly meeting 8th of May 09:00 UTC
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about monthly meeting.
As previously discussed.

Next meeting will be on the 8th of May 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

Thank you,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
