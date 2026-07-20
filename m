Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B11EC44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784549199; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=q3h2WHPFW1hGSSqiGxAyxgJBOQkoaGMlrl+XV5yUnJs=;
 b=JVtx9Ef2wPNZW29A9bVoe0yCeVRTi5/pIpYPDdDW8skwDp04+vbjWcauOlP2VymR2s0vw
 DvQp7IzX3Qx8S1wew76wTVPutwZmvxJ5bVN/xRgEiRm64AIJ/+TCGs+xAWZzuEc7+dRQNc6
 8kjc1RXqb8hryvlXPqibuXyAPQ1Q4QI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 208743E629F
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 14:06:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8178C3E2162
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:06:17 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89435200042
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 14:06:16 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so8805390f8f.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784549176; x=1785153976; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X84ARa/SaV6RvxFjMt7i91fNrafj5OYoRq4v49FyAj0=;
 b=CSSTcsa0jyjAkU9PiI5E/fFUnJuxQrNBet1RhadNIPsGxkXbBongdmUAGcW4EF3Gy3
 WSev1if50Kmv/ndv01UqyTJl8bGq5n03w1NHkknFSfs/WfCTRsrIbgQYh5RmixC2f/zu
 DgRZuHxm29i+0Pcm90uYwMhtTNLNhquqUuRN+sTQTr5LYuDuqyAMPDDHxuh/oh+G0e7b
 w4fVbI5dxFQsOvfSOo+VXPIUH8Y3XWiDA825n/e87CFvDLvPF/eHxq5Ca798NuG09oTa
 vlPBDrl5esZWVc/tbX1djzrmsXC+7PDEjxwHQTT4j15XIkppTkbJYGGC5Dz1u7raxwZ5
 LIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549176; x=1785153976;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X84ARa/SaV6RvxFjMt7i91fNrafj5OYoRq4v49FyAj0=;
 b=b9ZXd8hxnlSyv6RMmX3tvKWm3g37SnkKlMBPn7LXDRB4QLhvR4mdzV2hSLbBMitDSv
 i/8mD+dQtLTAg36OygAuf8uD4IrE5oDnHGa7xP5YwztxVXDWtoqHECFh9r7fOe/Gg8mp
 llKdmVNjeBWNUtY5s49dFda9Kcszvbna+cdM/i10WK32C4HkUf1O1lqjRhQsfjuGXvmW
 N30HNvtMEm5/aT07aq8xDvwQ/djYAYzEsOuVbejNlexWZ5UrwCuPL8oAvF5waMKKHq1s
 yyyPlQsKjOH+fijIQlbyoSvpnY8UGA6an2459C8OPAzKZ82PUqHtBIRejEqpj1xRk3/N
 T/XQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhGbHo/nWWb+YZDOf/Y6tuB9VyafB2f1fbO5n+4VLzg05VC0GPa/RV7OJZgcVo2xkHkbk=@lists.linux.it
X-Gm-Message-State: AOJu0YyIAOVNNCB7dB1k4jfoGxVpKc9Vva7Xz2Gxmvhx0fLn25FnBVws
 jYuCDibHtsc//YMHPhKljNWhcn3LI6MhvknUP2RgxPsguLx8rvhy3MgTxW/sjrniIAM=
X-Gm-Gg: AR+sD12dvr6zJoIJ6CYHMRvDF5Hi1sF6XKprn8rTxtao/cgVOG1WOkpKfwQ4F6PS49h
 urkUB8WB+9gNhzBAcXwMDeLuD2uBs5x60C/DzL8PipE8iwuI2RIKnc7LG4ESFXk1h7GiPnejCRp
 u1xFXANHdsqyONTFy2dybzax6AlhkP/Md6xIqt8p1/wLMS4JqOI/5o0q7wIBGDbovQhdgJJ6N0H
 /4/toHmUFKTIdd6i5tZATqnpJSjZ3U1cim4vtQnKItsCg+gqyhT6nPeX76y2zF3gcnO9fkO/4iG
 PZrJvz9wwp+V9MKPgStneyBCHlaEdgmNpuoZIWwBU8tyChvCDCe9mRJkOvbLtWX5OVd3U1+JZmc
 9r5PJk/+KWAxaCF7suF4jhN7TWhzDV73VWj0rFtrHJol4RSk0SmtdyxgMTkedMEbXU8dE/ggEi3
 TXaERT7c922Em7C6zZWyg3nQ==
X-Received: by 2002:a05:6000:1785:b0:47f:7b75:61a with SMTP id
 ffacd0b85a97d-47f7b75083amr1930046f8f.15.1784549175793; 
 Mon, 20 Jul 2026 05:06:15 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm28382854f8f.6.2026.07.20.05.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:06:15 -0700 (PDT)
Message-ID: <6a5e0f37.cc089686.1aafba.fc23@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <al4ASHAmTGEYfIVD@yuki.lan>
Date: Mon, 20 Jul 2026 12:06:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2026-46331: fix intermittent ENOENT failure
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> We do have tst_module_load().

I guess you mean tst_modprobe(). If tst_module_load() uses insmod.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
