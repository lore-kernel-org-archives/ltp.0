Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0AC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782996662; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=GV3GIkh2rXduOw+16T2Bkq0GP112tWTU6sOyF1D5mR4=;
 b=dwQgb4zoeHg/Pw2n3GzmHUIfEysu5N1KrzYkRmV0ynC7+DgmP1Lfr6PQm8klQkvuNqiak
 dAzdQ08hP0cHcZKmNdlmfRiCAcH0Gbo+P8LzdeVNkXfRV5NgUY9zokDn1kuTNuGt8hNF+Ez
 CJHohYvtjqMQA2nflUl0ROb3ogYIkCU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 036333E4A19
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:51:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 652913E2F39
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:50:42 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A83C31400044
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:50:41 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so7735535e9.3
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782996641; x=1783601441; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eijj5H+LizwFdJ6o2PBKZg/lVR3uEsYPbnzS7+KX5t8=;
 b=EqjZilF+d7xyDZvOV6aBrC3hDqsKnxKPsRAOFpQYhoQR42mJIQ/F0eLdZruboFuToB
 +YFtGBp8ksgbJ9f5DFpeUQQTt130YhF02nnS/ymJT46rZlBxQD+GOtOUqVa7kfgxlXP5
 rMDd1tSLV8kkoE3lhjraLZ0UMNG2z0H7Wx5EQkF6XX27liK+IMX1oFj9jFrAfkLIETEh
 tSFS91TWhMzp9cqldaPRXOLx11qfPEl0p8yUsfy7P08CQnXSuWW6VreMeYudSUE1HrE5
 zbb2YNtBw/TgacmvmX06skSkMjiEuxuCBDDk6LavyhXSmZZU7qdkWoEs3r+fuGqKzlIB
 53gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996641; x=1783601441;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eijj5H+LizwFdJ6o2PBKZg/lVR3uEsYPbnzS7+KX5t8=;
 b=sYBB+yG0RFTpvw0rk4HPHDd4LdL8qv7IXv5NVNfMHQEFb3Y27aq1kPSkleWaOqpJzU
 DsB+lwac6ht80yUnwZETmaTiFETyhlDO+/fzbLMUh1A7h8Afd42sEn4PSz/ZZdGJK5wW
 PPTcH5w31yyEb1GuFjFdB1AUBfnmBl5X0mre9IQB6C/l7yWKYt+VaVoE4C7Jgnap5FLo
 2UJF5r3+KN5bBX4H3sP/oUU9i2ZpOXF/87XcH9WC5zmTZMDQR4JH0S8RBTKmPJfEEt6m
 fhFlIxngp2W6a/QIKzYt2gdpNm8RTCxkAYYzI66ct/YxITB2ep6X9GYNyOu+B8nqqDzp
 VMXA==
X-Gm-Message-State: AOJu0YwD9GH5f6A+BOGBeFz44231Okyjh7WSPkoK2iFWR9xppKPZHSUE
 etWiqFjH/eb5sqT4OUpxH7j4t5VoN/CnqD5ReYUJ7qvG6UE3LM3X2p0dbx/O7EilAkiES+cuYJT
 g/bGklQLdqA==
X-Gm-Gg: AfdE7cnhdfPCAKorlNPLECNy3zsATBAUYb1pJnTpniIfEh7mQIH2pVo3tblD6S/X+gu
 j5ifAr/yk1YbhilDMGa9kl0FjWGo4CJ55V6foUJpayyikpK7QxwGWxziXgCl0QP09i/UdevJaYW
 3Y5hbxAhnujZozqM/o7Q80eHEi7nSlGUFRdH+2tC2vOa76fN2ugO/nMF1K5BRs8mlaDMJrAlQNt
 gRRFZEF/TGTKJ30KUy2ayQEIoLM9HB4YcIx0jNU0HSVV1BBHC9E9kPbSKO76pdkzoDSQKaUa7jB
 X3ysjaRwYMykT36N2nmnHOB1QQo0U2xXBClcpanNFFHXWEVuGTsE1CkM5GArEMhxCX6MDfbPCXh
 Qhkbjjzsvfg8fcE2Y6myf6568FIbZTdNySXetMQ/rliEBu4ZSI0HtZGZMZd5VcI2ymV131mVFN7
 6pPsCBMnNJ/cFmXkGo/KvFjF8tBDXmsYTWyKN0iMLjn16QsjThr2hPrWxP8a/hwA==
X-Received: by 2002:a05:600c:3e87:b0:493:b3ba:84b4 with SMTP id
 5b1f17b1804b1-493c3cfb0a3mr70053285e9.29.1782996640966; 
 Thu, 02 Jul 2026 05:50:40 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb79sm8480253f8f.2.2026.07.02.05.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:50:40 -0700 (PDT)
Message-ID: <6a465ea0.464694de.1a6a30.8fb9@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260404121120.1611032-1-pavrampu@linux.ibm.com>
Date: Thu, 02 Jul 2026 12:50:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Migrating the libhugetlbfs/testcases/quota.c - v2
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

I run the agent to all hugelibs patches to catch the most
obvious errors. I reviewed them and they seem positive, so feel
free to send a new version following the indications.

Please, don't append the version of the patch in the commit
message subject. All git commits have a specific section for it,
after the SOB and '---'

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
