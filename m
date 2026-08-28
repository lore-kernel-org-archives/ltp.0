Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FC5C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 07:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787901321; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=vKc30fL4rRcr7NgZewUjUxjVSab6re/yosAL0f5ut2I=;
 b=TgIQYgId0Zn+fFs6wlNAuRqaV451iC0Hbd0vWs/uql6Jl6ZSss2ssOC3lnH80m1Urxrql
 JRxIM2jHRNLLAajshhj5brJ3ywdHs38/JgHzDwgShYIdEWUjBhCeH+MJEXJ6DaIgveSCRVO
 x/frQILR1VA8qpHO2amrurC+e8nkTBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 423863DCD6A
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:15:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38A9D3D9F02
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:15:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 66306140026A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:15:00 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso3906815e9.3
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787901300; x=1788506100; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cEiIZ8L3im5T0mdXNRFz8Q2Zl0qLxnfLR5HeTcGl4iU=;
 b=gdyTLuzVC45tdZUr027dsEnEC8zNuFXbCrd43uNBBNkOCm7v5UrSttPk2NpTmQDLz1
 t609Pnwcb8HgTcPDHCI2FP/tjqXNCWpRQtbkSqZD8L0+d8bG2ggnf3CrBbdkkf8Wp4Ql
 fI2VqIy0BfWe9goh3WA0mn4x66Kh8eRdaSlhwcdVItemE4ADa7T4oOBn0omM/wYWlTEl
 iRVpZ8FsG4jAIVrdcnHcoNgIcGUUNKbHjyxaQjmeIwL841oU2jp3oUwkrnvmEJ7hoex3
 pyyVvHHdtD5dyQLPvY+6avVKj9qhKvZU0xpf/Vlq8b9Bfg1503s8Y+q91A9Gz5PMiTzH
 MLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901300; x=1788506100;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cEiIZ8L3im5T0mdXNRFz8Q2Zl0qLxnfLR5HeTcGl4iU=;
 b=fWNr3TmK5fkzJzIcuwkTX0FKWhjnkxs+czKyshpjVcINDruHtjWffggJI9IxKdb5pD
 QCJ10oMYV6OgWnSnY0p5yUOgv72kYqwIcv5vTSsnB0S6fpvd1Lx9p90z9HbEH5R+KWmD
 9MyGNowfGDqpNlXEklpRUp9ZhoHscVccuZo+z+M5oPUsOCDg3b5G5HpnASefPDnejCAL
 5OopFx2kQU6McQN2eoDq8f3pQEbf9f/z4WpbJTtfEki/j6mWNo0KUMne5NtHnQ0W5/eG
 w8NAPXpbZ8ft8CZ0gWO3VUgOBf8vdhK7SQpd96Exoa5gFycVO5tpVV4qFqqvUc6hKfDx
 Mhjw==
X-Gm-Message-State: AFuF++ngAl621XG9VsW0Vi+M0uX/vGeFc2Gc5/OWTzT5yt9+EVHibNR2
 CFk9nqBmc1ZLfzbQ8DeR3NI/hUOhwtkzWf/k/xOsqPjTBYExsI3jnK8uqgGNofaAEhw=
X-Gm-Gg: AR+sD11C8JksJwDa5H2cv9Oaso3HyAracmfWl8+/hYk1rRky5WIz6xXDYuQQTdwK+ef
 G61M7yqU183GDTjw/H37CvTLWPdSv/iNX3OpOofV8L66Ox54cOMvZtnlDUmxTviDJSGZbL+mYG8
 16gU/CyUqxjs0991DAe9K/DpKQc9k4MVEIhA8/NcT+Birqr2Qi94zYzxBR/r8Vph8ldQa/PMHAU
 xaExzM4Ntxxgn2vJrlaOBfs4HZR2leoVyGnpEhRIgPtIUUxjPWNm48d3om3mQyPiGnAAzlZ059k
 A/bLEg0kUPgIwN8U9PouFso8q/GAohPw1B4T2+vXoSV62tJfd6yts7TeEpfxoGyTXHeUltznDmY
 pAPnH/6HswCevAUc+ZaIR4LRCGtQSz4oC87OBWjpJDWd3o5Bk4vIm9K0RP8jIKSloIHMXQ85UMt
 NMmVJszIiD4X78pzTX3D7H3pv0CTGab1xsdu8SbkUPUWK0+ziTYB6WSTkIPqTcUtMmfZ2DQiBZV
 JdIgAvFBf3R1R6A/frfPoXylYDsHVTdkY9pfsHkBM7AggC4cRHkR1U6GsLHloiei2TbomM=
X-Received: by 2002:a05:600c:4e41:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49b91c63a47mr66208025e9.12.1787901299739; 
 Fri, 28 Aug 2026 00:14:59 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb278f7sm2280943f8f.26.2026.08.28.00.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:14:59 -0700 (PDT)
Message-ID: <6a913573.16149c93.337a9a.89de@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <amKjoM7YCXGrzkoD@autotest-wegao.qe.prg2.suse.org>
Date: Fri, 28 Aug 2026 07:14:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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

> AI feedback error is misleading need remove in patch10 , so do you want add new AI
> rule fix it?

sorry, I overlooked. It's correct, thanks for pointing it out :)

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
