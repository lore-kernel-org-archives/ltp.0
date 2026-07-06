Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198B6C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 20:09:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3EE3E69A3
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 22:09:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE223CD7B5
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 22:09:24 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1CAC16006DF
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 22:09:24 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso439108a91.0
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783368562; x=1783973362; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbeU6bBWnmJNoR5GSRy2Y35LghE686lXO1fupoa0Sp0=;
 b=hz6dUyL5RekRKxHZBXh0dBhLUTRVB7OOSRkAErKmgmP0YAWysZNAH52p6MHPNWhmKx
 taLDg6XXuV/rZFLZPnLshCnjsLl09ZSLQ9J7j3M1Nz5lCgqI/RkUuX1rcejvpnJ/HfKy
 YVMzivf4zgCPyPwVJW2tWvDJc/REx3yYXTmi6uJlgd/vn5rdlhk7fo8BUAxe8f65WI4R
 Vwg9hTDyC6LMNhDMBHcqU6hrQNPS9GZ5WyN7VsPPkVAGpmRkFc2c+IAcLvUjpeJl9YT6
 zT8MEqiWC4lnmgtVESVWbj/39IQmMOxF6bY+brceWoCNJSntX1Zpp+O4p0dMLiNEZY45
 yKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783368562; x=1783973362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lbeU6bBWnmJNoR5GSRy2Y35LghE686lXO1fupoa0Sp0=;
 b=dOyWHKbzLUrvoJJ/DXO4HaU5f0COhw4247wTRdIc/E7e1ZwNKhcOZfV7TIfgexhFpL
 9E5m9nrivBwFErxz4jKga+kDXuJ1dcykpjTiQGWN8pyqM4lC36XuEykK4drFlTouNNyy
 dSOZEFb0AtYGmEgsbntpW5Nk/8PJL8Sf72gEdWP6/6ZeghEG5ZW+uYPPs9dU2NSfujuI
 bPvnRO286tNRM6O5iehGrCQ8ZP2UEp0mmIREqPxuOhqR4/k++uoQkXO5BoAHVZ4mg+q8
 25gTN34IdG4wu+U4X2Vmu7aZV+pmaRq5JcV/TlfdWbvu3dADJt3hdGQIQeiAxJTSI8gD
 /xZw==
X-Gm-Message-State: AOJu0Yycf09OH4Df7iS0szPPZbhAkUeBLPeg+HqK2gTEle4xG1PfnJeN
 OjC32RHx9OViTb3eAryIFBavR1heihUF8DbpjAHGBhZQWBAzC833FLNo
X-Gm-Gg: AfdE7cm/26sKiQa5T/Mn+isz7ZBquuK1TTnMJN/s+84Zas//WuOecGDbbTiGRAZVjZ3
 fDwCw3EGbyJi7kIYtlnfvcwl2wlIbMBGx0bY+5XUdGUhN+WNI+bpkAaDWFFPhFyHXIbGwNYqx4m
 bQyTF/Y0r8DYolGkC2R2i2qYpHfaUEiSgb35NT5A+UGiXR7RuRPCyRSEcUPEjuWUgnMJ4TFNuee
 GCQPtAxfvyqb37/e3zzIEfr4DkYG0JCDmHTJsD+0Hp4Z3/Z9Mg+Yj0CcUppXpOQ9RNUMCOLrMbW
 FNmbAHD1EsAsOtoN0VXLQrssAT9PC2u01pEe220OWLh5Mo85PD/VJVXR46wagkDxPMlj2hdQ2EJ
 LrD+quR/GMs7zwuBMS3fKt/srMhvzWwP1PU3DYc0gHsl3ad4nO0nsbMrlEw2MinNxjGuKqqyTMX
 r1ipfArzt8oeWUHiBlYHZ3MGBcvdkMIf9RfnEPJow6eQGvOcSSn4o2i9NBTtGxcrCRZLldVieqQ
 f6iTcP7orYThx6gmQwF2YtPjb760g==
X-Received: by 2002:a05:6a21:681:b0:3b4:cd6:88b with SMTP id
 adf61e73a8af0-3c08eef132amr2526204637.46.1783368562321; 
 Mon, 06 Jul 2026 13:09:22 -0700 (PDT)
Received: from
 runnervmkkn4f.d1tc3kjhwwxe1ofz5cvxophb0g.dx.internal.cloudapp.net
 ([172.185.47.212]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c76dsm63561c88.3.2026.07.06.13.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 13:09:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  6 Jul 2026 20:09:20 +0000
Message-ID: <20260706200920.4295-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706-cve-2026-46331-v2-1-d5e47a113a84@suse.com>
References: <20260706-cve-2026-46331-v2-1-d5e47a113a84@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_sched.h and pkt_cls.h fallbacks
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

On Mon, Jul 6 2026 21:12:15 +0200, Andrea Cervesato wrote:
> lapi: Add pkt_sched.h and pkt_cls.h fallbacks

--- [PATCH 2/2] ---

> #include "lapi/sched.h"

lapi/sched.h is not used directly in this file. The CLONE_NEWUSER
and CLONE_NEWNET flags it provides are consumed internally by
tst_setup_netns() in tst_net.c, not here. Neither tst_net.h nor
tst_netdevice.h pulls it in transitively.

The include can be dropped.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
