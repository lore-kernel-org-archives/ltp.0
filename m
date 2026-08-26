Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A169C5DF97
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787737802; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Eh2eeaADmEdNzdQNuE24er2PUo76vAGeTJmiMj/XV0E=;
 b=YX294KkISa4Xx1trgAAC+WeFZCfSGe5kkbnNyz4X1jvyrMonzF80JSF13C+8SMZjtDWar
 OFbg7bt6HDdFHhwR4ivWkAKQO1KRC7iZevYiMpHrVVwGzteEPxJKbizVBTvswD+G2y0GCRk
 xqzdkA77ukdUa5whMxh/XEwOBqm0tqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEE993CC018
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 11:50:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 669323C6F71
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 11:49:43 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB20C1A00CC0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 11:49:42 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2074710751so103890066b.1
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787737782; x=1788342582; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JHEBnWcTS6+6/xoAB6fH0HTBxf6hQsHtS0OSO3V954g=;
 b=fi/bu5ZtohvsC7nB8u1vG87Z0WUUNZl90K8aAcLo3998bgknVBZvYYq2zN0VGEYYWP
 CX7zVUua/wfKyOsE6zEIK02ip2K+5SGTWepWgb0yQQwcdWfammikR/x1VGcsQ2koPomp
 pcDmMbtKr+GjeUwY6dS5HtenB6R99EVbMfcveEKst/awvZY+CBgUnIcrYeFN6vNs/4mT
 xmG2RrdaOJbk7CZNeqRoe0oD3TLyzWMLyv3U8c7vMjiepEnZ/w3WBPQmnhoEHSJMqFN9
 iveoG5bSzeLqmWuEc2UZqqJ+oseCPiR00iq+buCw9TKNVO4oXCn4cYg+BQ9Cl+E2T+Ja
 sheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787737782; x=1788342582;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JHEBnWcTS6+6/xoAB6fH0HTBxf6hQsHtS0OSO3V954g=;
 b=WIYdi8ADbDdPPfvI7L//4Aio54qTSRdmNtWjMOUdzv/DPq7gyUTOONZ/1eCbpu4M1U
 Lf5nQKW2tAuENGcHT1BflNSUzauvpOsSJ/1/rsPerwfM0VxDAxhsPFt1ZwzIQRbDWYGL
 YIDVIyjZfDtyxZs8Defy63bKeXkYb39taRe2DvN5/bfkdBLzgGJFEYhwWaPu8RiNotFP
 IFyIW+1hItBwTygffJKGBc7s9SwJgaIGQIO1q7hnY4bHl9Oeuw/TycxVM9x1ypAat2GI
 lvRAVXjcR8GAMBopbz0pNbYKz3h/3pWjjReq5oZbKb9TsaP5oIoLLkXI0qAgiRq8g9q5
 FyDw==
X-Gm-Message-State: AFuF++kbMkUSOzY0LtL/IoecHFBbeHq7TzIcNZ28gxgeh2t1EmCXls3T
 eKHTvhDyC3p6JYOGI7ohFoFIqI/13yyIfMcthAA3Utz04e2VXpmc6P3ueokonMba8J7sdHBi1uN
 +vFt7iRg=
X-Gm-Gg: AR+sD12cPs007kye8dQ8OBjnrMkmjYw5IuHXnCclmkG5S0tKg7AecZHOQwKlof/gu8G
 r9PR2Xi6Uf+xv5ZBMVQFO+XemkK24HiKCF51fsCGZ82jaIo0mkx7DFYcIIotOyH5tecG45DrSks
 LeCtVRPKJE1i2usIr7PmHOvJvXqjd+Nrq2yFEX7Zlt+HuoMU0TnyDOB6tVWdhQPBu9ZN4Z93lcJ
 lm6wZ3ci/TPbKwxTpg9CBycHBYkTBpZJy3fdfsrOpN6yAi2oHmoMp46TqEt1YH9Fq6t4c9D0mQ2
 D5mjEqZg4fyRMYwSpogxS0Q79rJBM91RZ7Zhcspo4121JFsRjBBS1PQ8G07GKVRIhlkjKy19LVL
 Ab+5S2DYS68MZ3cgJJQwCnSYWsaPsXpqC98Mhnbqs4syi6hlbGM4J63RqYlJPi8Eo3cEoTcmJ1c
 6IDhmW1ySn/vm8P2cXedzF93Ps20dcKWMEwgghqRthBk36J1x714XCZUfe2Dydho1/eN2+movr5
 kp+nvzVblR/QY1ve92CKfEdN4Hfnmz/zTp5IFxcElzCsXqGWjnUTHwVaGq1XFxjyfbLvrw=
X-Received: by 2002:a17:907:1c17:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c250c596866mr652493566b.11.1787737781944; 
 Wed, 26 Aug 2026 02:49:41 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef382sm336899566b.58.2026.08.26.02.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 02:49:41 -0700 (PDT)
Message-ID: <6a8eb6b5.9c218f23.39bd08.c61c@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <ao6ygGRQfGejamJC@autotest-wegao.qe.prg2.suse.org>
Date: Wed, 26 Aug 2026 09:49:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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

> Thanks for the technical discussion, and we should find better solution
> for avoid oom, but on cgroupv2(does not support disabling the OOM killer)
> scenario, replacing sleep-based pacing with memory.reclaim is simply replacing 
> one guess with another. In user-space, it is impossible to catch the exact 
> second when memory hits memory.max. Furthermore, calling memory.reclaim proactively 
> just guesses when to bypass memory.max altogether, which invalidates the 
> core goal of the test.

Less LLM please :-)

The OOM killer can be disabled in v2, but only for a specific group.

If you don't want to use memory.reclaim in v2 / disable OOM killer in v1,
then we need to do things by hand as explained in the previous comment,
for both v1 and v2.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
