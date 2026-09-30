Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CDFCA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 08:11:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 018A13E55E0
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 10:11:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B54D23C6BD3
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:11:14 +0200 (CEST)
Received: from mail-qk2-x06.google.com (mail-qk2-x06.google.com
 [IPv6:2607:f8b0:4864:34::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49DBE600BD9
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 10:11:14 +0200 (CEST)
Received: by mail-qk2-x06.google.com with SMTP id
 af79cd13be357-93bfb25817cso313510185a.0
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790755873; x=1791360673; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p92hd9JjbB6kLq7uSI3CxuAa34p8jWQiOQdteCaQ+ro=;
 b=rSRVAjOo23rKoYbEreXCmcpMumshH1jMBGLM5vNshV2/zLOShBOWU8BlZXty0jPriB
 en3Zb7hSaznkVXR4nC1Fid6O4VwMik6KATEuovHCkZ2bkgGPLjrH3qJF5Av31PIkdDBs
 wTxmR2n8aKjROC9AUToy6huxPGuvGC0g2aXeeHg9qcGe/vJAw1PU9jVsCZhWy8KeMFLr
 I/I2EQXKvTvk6RNSw7qJ7MRxjrNnDeLt9UMPCGBkb1TtXoZ+gppPAXnTII1bbeX1BJcr
 myjIeeQ1tsXQM9EqxIvl7/qe0yF6gLzEI2HTyf/TOvGncuTDvq7ZYSSfEUBtEnwiBrx1
 QAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790755873; x=1791360673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p92hd9JjbB6kLq7uSI3CxuAa34p8jWQiOQdteCaQ+ro=;
 b=nawhb/fcODiwQAMR5+JNXK1YQJ/FL4fDJM1NtEnree2Jq9CQQ/TlshUUxlc3lRn8qH
 nB2jN213E3CBehQuUCQNrXZOEJz9jhxU2mftMNEG3pQTNPc5dj9Wy2epHrb2PsCGLPid
 r5YxyLJZ5HQToeRvNXmGSdkb7mQHZMlCBlgI7N2WxGG8FDVyNNCoGmnSi4hs8C60m5an
 L50LPmYqRdN28qlhYzDlQZ07KCUdHcQgsdLBfXdfkXh/bB836MrMKhwbllokXAbucu6z
 mFAqsPfD510OetXYEuc9KUY0vVehjil4ejV3KdIPGdlICKheIQfloyQp8uZCvdedmUSl
 IiVg==
X-Gm-Message-State: AFuF++kegtvjn+xsYCv5j+nJMigBX19TMoQj9IxJN3f3U7u2uaiQB5Mm
 EGBaPuAhI15dKZ+C/PE/We6p9M5/Wl9SQwq0iFVfxlNf1J81MjiHqVTQ
X-Gm-Gg: AYBFou1vIPasSj8sQOXob/zl9FHYsO4We3Mp2XA1wy5v6s+FaNhvZWsoZC/7+Qbeban
 XuGLeA9LCWMUs8//FiDmCSaUmA2Pnnls3E8u2EIpQXG7d95tuGNxK4fZ+KvLdhPNfKDAMb6LGod
 DeDhWgpwy3M1SJgPD6GL8FsV3xHxm1w++SwCQmHuQxaFBYxAAjnHsc0lDsrHutPtEgpOfLLjgrn
 T/p2JvhVysbBvyvGsZjHfAm+ixBdUECBKJLa4wtugvxOZAT9z4rQB6mRcJ7QgvC0yROCXS0ijD6
 VSgtYTHjqzALX0dfW9QxWje3jLd+FBk3AudUuYxCQvdyVaC18tlEMIz/Q66zmctA8g1zjbSAF6j
 eA1RdH5Yw1K8KBLspg1iTpiwddt8X5baKwvC0q3JgKWDp4J5Gauvc34YiaICbIzSJq5yARQ+ePQ
 ATIde+IGDhqL+prvrNROqX2Z3+NcRXCGN7eRLMiFETooZbSAM3Cf4vdXjl/Jvi/PH2tp7VFfvdk
 AcvalXaZNJ4kREsr1RGou/8edsJh695DTAHuOpn9aGZDrqcEoXdxG42KEkXCLf/EaPMjX1TMDTC
 BWSADRvJym8HAa4=
X-Received: by 2002:a05:620a:25ca:b0:939:3885:3131 with SMTP id
 af79cd13be357-93ca95db281mr92364485a.3.1790755872867; 
 Wed, 30 Sep 2026 01:11:12 -0700 (PDT)
Received: from
 runnervmtr4k5.ohoac4jzuqvefkclfujxk1yw4e.bx.internal.cloudapp.net
 ([172.172.157.217]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca82ea561sm61649785a.33.2026.09.30.01.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:11:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 08:11:12 +0000
Message-ID: <20260930081112.9226-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930-fix_fw_load02-v2-1-accf7294475c@suse.com>
References: <20260930-fix_fw_load02-v2-1-accf7294475c@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Handle empty saved configuration values
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

On Wed Sep 30 09:43:08 2026 +0200, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> lib: Handle empty saved configuration values

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
