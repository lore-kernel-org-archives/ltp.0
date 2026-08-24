Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF2C5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 09:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745573D02EF
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 11:50:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 943943C8484
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 11:49:53 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 72D6A140054B
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 11:49:53 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cc80544c74so9060055ad.0
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 02:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787564992; x=1788169792; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ncLHZalwefoEoJwjBbbQaXtMPWrse+I3AlzTSk/633g=;
 b=nXMHJwrxe1zxlB+4F2+blCxBpmCpQXimX4TpHWevaT6TxM6BUssSVC+k0Zrff2Cu8I
 vRGNCtbtS6oU5AbNMdK3YQE+wBKuMObhoiGSPPxzHHpozJqWvXiec3sfcP64hm6rUO27
 rFGK2+stZK1zaK2N2TbqIK/FTBhHtsxfBi7m3ks5yTboXYa35lZh5EGgtOgcVktv2bAz
 OcR36Ss+QVD7DFhP0mjhgVCSpPAymXq938ro7v6lgMA364/Jul/46SPnVwzn0HIbKtVV
 vCBms88tC5NoDIohp8uS063P5haVrDWWBTDt3c3b4nCELaVt4a/ZszYbPfR0Uppc6MeD
 zHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787564992; x=1788169792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ncLHZalwefoEoJwjBbbQaXtMPWrse+I3AlzTSk/633g=;
 b=IgysoCpOboZpfp2UnAWT5Jn7cPoSgQZ1PW29cX/4V/2m4Nai+6qhGq4fAT5pYtwTk2
 U7TXdpQpn1WHmIEgKrHTqEDgw28j6BJiM9N7wW00+43qDkTndobygCNCPpe1AqOr0811
 kiDO4Ofc5DmgsHj67oz2kzjgpxUbX8KF4ZKK2aJCFZajke+qrjAkysEdQZC+2KH50Idx
 JuLBzs0AYvprHAG9si9aQj4f8CQhFhwOdGy9AX5JJ+epYJMergGWB3APZM871eo2KnxN
 uKJ51AwL3gjG3XOH9/N3pdvlcGh3RwQDU49tPmKBnc6WV9XGOUmsH9GJjbDOVo6lPJAb
 B8VA==
X-Gm-Message-State: AFuF++l1a0fZudXLUok0l212NP0wdeh6uakFJdkwgCVMbh86WGWjiUzU
 87Q7su9gDgXvbrGeHlft2MoVdy7ndcvLozlrFSN9v6fQUtlv+yw4snfj
X-Gm-Gg: AR+sD13T+2Hb8BLn8aGl0lTX27nn3ZHnLo8io5COT8K2uDzxsdUM2/MnjknclqUiwxk
 VtgqCNaFWDz78dfeJen1Qwc+A6MxSNJrAUNQZ55LcLs+NFyLiP13wkp36s2oAp4juEG+5NxPMUj
 x9eZ0YYW0ZiT7Nnp8HbnuUDhTyb3LWTNmAA8bVbTyVrahxekgBXg0J5KRH3QpYh7cm6la8Id+oK
 mLXpZC4sMY0urx4NXwp/vk8l5sAvUCgabYY1fck1ji8C3VdutCa3tWFH24kklkvJM2F8g0Atlj8
 9kGIemTiJOmbEIP5zCERMypL14m+DW12fYFesY+n0dbP+q8V63bcRMg5vVc8EWYyFG0H87g4irk
 evmAYWiyeeWSSEtDos7cy6dmBoo27YHVXYQJLC6aAzIAMel+on1gsk5ZviPNSkJIS6dibW0326h
 lGoTA1qUx9sfSrpfN78gHuKN1d8pDOlL1OIEDEmfaBtz1WgO/C7tmGcEBe5rHXMAuLGgeY7rFdS
 Wo3EX+OdjRlKow4eYfD2Cc9OUoPPoDszA4APmS8GUWcK+FBsnZlRCpMv9jt33y5qj40s/AH8Qan
X-Received: by 2002:a17:903:b4b:b0:2c9:e846:a57e with SMTP id
 d9443c01a7336-2d64a9a1b03mr507113835ad.0.1787564991547; 
 Mon, 24 Aug 2026 02:49:51 -0700 (PDT)
Received: from
 runnervm76f27.jlritpxf4sdutfcgm12ssn1vih.xx.internal.cloudapp.net
 ([20.112.122.54]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676791d44sm16130935ad.24.2026.08.24.02.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 02:49:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 24 Aug 2026 09:49:50 +0000
Message-ID: <20260824094950.8983-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-coredump-v3-1-6429da674718@suse.com>
References: <20260824-coredump-v3-1-6429da674718@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Mon, 24 Aug 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
