Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B67C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786437621; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=j9enTR2dJcRGIllnEgOXY9idyq343DXEQ02VV8y82Ueyw88e4t7DK0vAgwEc5o5/Hbp1o
 nhHk3f3+HIh3LbR0V96PkPnVs/+fnnk2zxh8hRPWi31bhvfeJZi0ViZ4H3+ue8hfl8mkiQ5
 N4vzfvSoA+5RzIFfvJysRedmZwS7fz4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB95E3D0844
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:40:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EE983D0D4B
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:39:51 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 38A8A1400762
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:39:51 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso30189855e9.0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786437591; x=1787042391; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=QGb3LWEDA7qfemsFYLafFLyvtbb+gzbAWzSunKtAf+njD8luD7aQfBPlMz+Esrrt8C
 +upJRs1tGNso3j2YBYhIGkJ3WPeqN2tVw+zqsXAqAh50oKfDBkH3NCjIPQTP/IPpOvXs
 OnE8Ed5B+t3qwRI6oUm2slA9UKMJ9uoE9cK2tSmaEYY1H2bJhc1fC6ae2R/yCbeM8jCN
 RbkQ7EhLSj6OBtZVaEvcb/9YFMODJuNVteDVCdUadtkZBhoLuaYcQhx1r0hVV0lbhoUB
 T6gEWQL3rQbGfA0AORnQZ2OqBJqruJM/tRQ2icw+1d4eHm7FKVCrlgx8tUniJSWft9EX
 MOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437591; x=1787042391;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=oHdYCLfFzISnaabJ1e04aIs+7unAscw35J0IjOXwElwABc43jvNLtx7x4OmeXthb3o
 7wE6+SRJVEbv76J6tAiiWJWO13LhH+KckNJ+mzQ/NrlxAo0ckd8usHn0iRaNHVXlXhxQ
 k134EMJa26pcV/EKoBTXLu9Zw1qDfxTRxOmlRWA685Q6rPNlLBAhRvzaNxf48tekN9Kb
 MbpnFpqTzWwwBH+0mzMHE6pCHaHbjhAO5owooXrv1Ppt6j6Ejd2gOrIV+smlzfMQnHy0
 AsqXQFIYNwwdmSIhKTRjurBrbWkZyUCrKQ+KQOPKxc5hk4ePVCPgAJMqpA16daNKWChV
 x1pw==
X-Gm-Message-State: AOJu0YywZMB6KQoWF035UOVgPI69EF1rLCpDdpH/3+dgXYVzvGRjdnAe
 oR99RdJ6wxcaLmyHA+JvVzNEm/DheXJ4YS2dhJYdqpCwdi5s8+uGlDqGzxdoAR016Fydgd8NJ07
 O/eATCv0=
X-Gm-Gg: AR+sD10qX8r4/NvLfuGfwyLRnZcNZnOMSZioFLQbUOe/0lTYXfgNIVdmw2auogVJsjo
 il+N3byIsZc4LJvY9VYTg2JYRMuyrCB7pAc590xiqzm+OH0z9HXI3jTYr1ElgJIVSkhdm3fN1MJ
 jdihHVggijLekRyPk8DePCKvRFUwdE0rmwGi2SyvuaPcrT0NTD/n9tVnmF7tRMJnYbnUaF/DvY6
 RM3ctjQQzacATC5cOZqgsfESo79XwWjCi7huXaiUQny+8Ra5nSQ1UDpQHK/C0cjsm5ssj5yaUdj
 jsK0KqlkXkWSFCMgNJfW5SP1DdK7DaK+h8R0JxHA3R1b6w7Gc6rI07ad3Yl5YpB1v76Xv5Z8rUP
 XORZUJTUpEAj6HdJRTQeDaGoeFf0Q85ZGu3DVMkkDW4bqjIxHWltYCsnyPDs6nn27jXJG7e4wFQ
 iaU+8ia2ddvoSmyD7yeCdVgBBcwb2EiW3AF1++72vg6mWCQxlgYPd5felGlfiwIW831pmvkA==
X-Received: by 2002:a05:600c:4695:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-499784604f0mr21773935e9.11.1786437590513; 
 Tue, 11 Aug 2026 01:39:50 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788a5be9sm38695055e9.4.2026.08.11.01.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:39:50 -0700 (PDT)
Message-ID: <6a7adfd6.c5b9c171.1a61d3.d198@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260806231423.17724-1-wegao@suse.com>
Date: Tue, 11 Aug 2026 08:39:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] min_free_kbytes: Handle transient memory drops
 in check_monitor
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

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
