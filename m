Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F36C4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707136598; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=jY4a0KOdyvxbhGGAmCFlKD7515jZfkKPEbdVUo7H6WY=;
 b=rGnfj/sMs46ozLVQNg4sXcTtiZxurVEyEipvHfOOjKhQ2t8sFqEQe//AQUElYgSovsJux
 0Iq/yiC64XcJKKCrs0k1OS10IyhuQvrYZfsa4+8EvQzxncnxiwTrjbVqkZfI3r1TF499uMg
 ha2MMAuTU4Zykap+0FHNcAVUEaACZMA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D9463CC6D2
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 13:36:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D51073C12A7
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 13:36:16 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0678D1400075
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 13:36:15 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33b1d7f7366so2072159f8f.0
 for <ltp@lists.linux.it>; Mon, 05 Feb 2024 04:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707136575; x=1707741375; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTQ7d59RVVgz0Zu6+xQAwy4mcuPsxusWXssRUlh9F8E=;
 b=LtWTIJW8PY9GBOZLt84JEvjbsPxmiXtKb6WNPQTBcPSyReWpRy49QotQt0XtrI30PJ
 8/Rt4r2Ihdlu2o76w2fR41wyWwJtKOwQO5JPSriQ5U7pPndjkyPcW4bRxNJhxJAxbnlD
 U5lMcyoLd+sJYbdFPDgzJdi/kjAInyhlmvRNJPczJXTwIL8XdI6omZt//LvJn+/WSnVx
 OPBGx585XD40xRjav7X6JGGHdId/AQHqmF8hO1xhTyhjRz86Kch98EQenOrIUi1wnmmx
 zQ+S+qudoLfX7nFMMpVCjfr2XX7mjVTB4qjHCvSUZv9bMwDLatHDNdAWWhFLcNuF2jRo
 gkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707136575; x=1707741375;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NTQ7d59RVVgz0Zu6+xQAwy4mcuPsxusWXssRUlh9F8E=;
 b=mJYxvsWm0SwRku94qyNEX7MsImdlKzUgCU3uWI6ANJeOwp65oQ/fIxGeGsJu0L1gJh
 RmOvr+vBABWoK3RfRFgw29FqG+Ec/vWMSmcZDC3t65OjYHgfp04YlRur4uZUzbpDyeGz
 DJlytkSsyCfmwK4jDzmHquyRObve984VldGEvHEVHxLHE+Ryfnx/5SNqn8MS7gMz4R/O
 5uNnccG2c8C1mDMIIG+LhUjc3RJ2U8YAPaeFi2lH85ON7gujDn6rxEytf4063spDymTD
 mXhh6o/YFsc5DiUwV0PQOqzlwfelcuosFOTxWz3mqCJu4n6KY27N9G76DtEO1CW7DtvC
 jmLw==
X-Gm-Message-State: AOJu0YzpfA58sXGN4jNPebRoH7WuCLxva5o1dgKxL0nO6V5sBTfP+LQ6
 OhSv9zJquWt8G0eNhV8fWAU4yhtrM6mejMlt7r0wdq24h+DPqrTDon1Zht9KOdWp+u7p8EWWJTY
 /vx0=
X-Google-Smtp-Source: AGHT+IHqy6tChDGsUm6Llq0cx+GtnG2MEv5HhCQXZfAX8VOuX7HzbbYhxa5ZZtlpsnVIqVvDXTmWwg==
X-Received: by 2002:a5d:65c5:0:b0:33a:e8fd:f43 with SMTP id
 e5-20020a5d65c5000000b0033ae8fd0f43mr5800325wrw.6.1707136574642; 
 Mon, 05 Feb 2024 04:36:14 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.40])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a5d6a48000000b0033b07f428b6sm8055030wrw.0.2024.02.05.04.36.13
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 04:36:13 -0800 (PST)
Message-ID: <534e6d05-fc91-43e4-b384-b7a43125961d@suse.com>
Date: Mon, 5 Feb 2024 13:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] msgstress SysV IPC testing suite
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

Hi all,

I was taking a look msgstress testing suite that is supposed to stress 
the kernel SysV IPC.
It's a well known testing suite that used to randomly stuck or fail, due 
to the poorly written code.

I'm about to refactor its code, but I noticed that all 4 tests inside it 
(msgstress01-04) are basically implementing the same concept, if not the 
same code that looks copy-pasted.

We basically have 2 or more processes reading/writing messages into the 
SysV IPC at the same time.
If all messages are correctly sent and received, the test passes. The 
only difference is if these processes are spawned inside children or not.

So I have a quite obvious observation: our main goal is to stress the 
SysV IPC, so we can trigger a bug and it doesn't matter if this is done 
inside children or not.

I'm planning to remove all those tests and to write a new one following 
the main concept, but without the actual redundancy. What do you think?

Regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
