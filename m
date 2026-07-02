Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59129C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 12:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782994289; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IWek4hrXxcFhmrdCSllLK8vygd+ht3ptvcIx+HYGjm0=;
 b=GtqvNG/c6LzSyykpTwaSGv6BvU3sLZPiiOKTO0mEPFMFJLg7oe/1qVtYgFnH19EM58bBN
 2qhQFxBofQ3DHi5FEp/fqIu5z81I8a3Bl9Lc5aap+IT9mao27tCp+/CblBXPROE/XCg71ZV
 eECb8DcPugDTDNQMHdTGmckm8/eH7Fw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC6373E4A20
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 14:11:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509433E2F39
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:11:11 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E07E12001AF
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 14:11:10 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1615714f8f.0
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782994270; x=1783599070; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U+B1uZC2r4GRjGdw4VPjJ5KcdVoWL04FOb5s8lHAeYQ=;
 b=dtxOfyVVb33Z8dpCTxiGUZaonVOYBNOstDskAfcW+8Uij7CeCtnGDfZ+ySeasH4fHy
 0bckNddKfXt3iBvVbe/IlmuhidMkfQ1jyjV+tJ3ysFfspV9ydaSetoUD3DMjo3FyHpJ6
 fOvxfQ9pWvoxYXSvDnWtsfHibC77iX/R9ZucEMdTXXYRl/bjzMu1+AtqGoNA6C6/IeN5
 JXIPUdh9w6qqgB2+QLophTQ6sTc+5wDWRtqF1rZvcnRWh8P8Y7Hujw/Qdoc5OD3cjcSP
 4CQqMa1ZvHWr7/ApEuRHvxiYYmlUuJB87BcPrnjN1y7lI4kJohlCKUPPZlgtCUX4hBg/
 GBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782994270; x=1783599070;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U+B1uZC2r4GRjGdw4VPjJ5KcdVoWL04FOb5s8lHAeYQ=;
 b=lYrF9fbTp0OTMXdWGCcNFSAkxzHkqlTiDJAcf50ABN5hcS2kgKn5/3/bxVz6rpsdDw
 8QR6NZB6DP6LAxuhgCEyFApe10O9yjhG3paHY9aINk5WPTWGMPvO0Mz6aXtB8quZtSQs
 uMXqIL15DgdArFufw5UdQeTIDQiT2UAOE0ZJ/AeJAckuaOu3H/BAtFZI7KXubCbQ2uR7
 yS2yAalCtr50jasasCp18fss3UBKPQX9gANHrENUha8NhpYhW5nUFu+CsMYvY/PQkoWV
 tayb2660e6EOV4RRfAz1oeBT6SuRzmMsCGLw5QdWw92Su5cqzN+foR1C1Gb6YeyQtBtB
 TJIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoarEkitTrPODBLocK5GzCX+X1y3NTuge6fJMwoYv9XhXV0akFcZ3lMMpzpS8gpm+lqUOk=@lists.linux.it
X-Gm-Message-State: AOJu0YwyLqwxh5cW1JwE5cW5oI0vkIr+q4x8Yl0bMxvHLl8NekNXtZJs
 +gikey4yBeLvYUZIPpRidFchIGouvil3DMeb7s9MZ6f/qYyJ43+GIuGhUV3YCluKJc8=
X-Gm-Gg: AfdE7cnJuyIpNV1SVnDpw4k1npclN7tu8lqrN6xeibP/y+1ZHwqtYQI+ev4p2cKbKbD
 gk6CPv9e7CotaDDYgUOAKJ5bwNC6CTfaYU4l+DZOSVNY5cVeO+qGUUfWz+7wAccjcmCKtSdrCrC
 gheTC+dEzDgDijZXS0xJDsH54O5cOK9lPQIcjREPsDWuQK1oU5XGmaoeOsq3uX6WnVLyYpitmog
 LpnpTQDQM25wfn7yAOvJ+99z8HbK4B+67+ySSsX8aGOMprBCoz/mL+P6j0brw4qgI2qof8fpYeq
 Pb/Jwkh/WEOT9QOHsp4n+BtIggDL2wtFgDbmYu861Hmv4VRH5BZn95DqcBZAK3Cz0y1I16Y1gPK
 FiCx3NB/7l8xNattUng4WHgwx/MDmSryyUW5NKKFACye+ilosarV2nfs0G0y+LSViMDlrfJazui
 jCuFB60rWM0zgVMQ+lvJWdjID5nGlgtLFMKQ6fcduwFcod7d15TLpvCQh2q1lA5Q==
X-Received: by 2002:adf:f30d:0:b0:477:80fa:f447 with SMTP id
 ffacd0b85a97d-477b5677a50mr5070155f8f.43.1782994270251; 
 Thu, 02 Jul 2026 05:11:10 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbc75sm8977543f8f.5.2026.07.02.05.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:11:09 -0700 (PDT)
Message-ID: <6a46555d.b7086f8d.ed78d.7df0@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260702120509.GA535731@pevik>
Date: Thu, 02 Jul 2026 12:11:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/lsm_list_modules02: Log unrecognized LSM
 IDs with TINFO instead of TBROK
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
Cc: Wake Liu <wakel@google.com>, r.kothari@samsung.corp-partner.google.com,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> How about changing this to TCONF? It would be more obvious something was
> skipped. This can be done before merge.

This makes sense, I will add it before merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
