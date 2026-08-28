Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC1FC61DBD
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0855B3D2321
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:46:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 375AE3CB52D
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:46:35 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C691600B34
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:46:35 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3964deae8a7so280203a91.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787910394; x=1788515194; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0o6MwSLLiq8belyoUK37sI8zrG11H4EBs+ZGt99Ymk=;
 b=X2KPY9ofTqupKIBHTlxbqAbKcSXU+bJzZm3lRK4wIiUTx5WozihiL1wnpG8Qw+1rrw
 5cTi0MN4QWtxgdF3luxiSPBNeBCYunlekCXLx/jDLUHuQLhLFsP9Wt3tXbnUYmVj1BsW
 LTHujKOJbnacpVrYnDGYesOonU+wGc2syQt+o39VcgZyj0cX03p7XYBmDN3Nwx/adVBL
 mwUcmRmi0jeIuL7zElEU4oLK1ZooR+Tedgwu/N9qm/jUKrAhZjjP39MdqEbavsgr56v5
 EM2iOQ3+MIy4h1kmz3FFOaKTqm6FywgHRzI4m4RdjZb97LTx0ZnO9yDLJB53fqlhCmdJ
 ZRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787910394; x=1788515194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0o6MwSLLiq8belyoUK37sI8zrG11H4EBs+ZGt99Ymk=;
 b=e0QIbs4H0ikyEMEsZCJHHClVLKkoF6YrYr+j+oRYK+FQVt+nuzjZiX4C+WGctyj1Gc
 kysJKOzR6SPjRm0vao1UC/vRqmexyNKDyVeHcPR4APT7yqT5iHLNcgafq34bD0/94LjD
 uBJPHipRPKHI+HCK+rr2WnJKVu/hAbYKqtJfwTrWXXdobTqii6a9eOFNjSJqlfMe+Bx0
 P/2PIyVkCfWGNOtVfB8WCKE6OYsYS59m5f0CD9/t0NJL9FhpFsWH9ijf6MVN1NL/qSuX
 H2goMUY3ErbOXTzX9TucTN16eU12Dm9BBKOsLSUg3pPTbOyz8uMfW2LCk8I3UkouTk92
 3X2A==
X-Gm-Message-State: AFuF++kQI4h7YnvS+pRqAxENgIXFaDdBPyW+r2oyyb52hf2sawmqtouQ
 K44BeiGrxVbBLm7aDZptl+o5ym70WXw3HvNayx41rMhFRCAfTF1n6/x5YizJS4KG
X-Gm-Gg: AR+sD12QIrYjIOYG8goyYK/l73EgHFbDQQlnkF+Mx0MenDC8/0LsSjzOfwwqbFMlyEL
 1Lo7ERYXwDSNO1nhQzofT2Yp+wjZlavfiAPJXgoQgY5oHA7pkaNBUTAsAujYbgDxyHEN6yFBXym
 dXdB9HEB6whx27Ocs817Bcut+/arhTJpr2x+qrbFet3NuL57hZGZoRx79bhDRYaYOpY861HN7Nt
 OZjUy1uqPTmj4RyWGqwvCNcGyL1tebE3FIu41eaVNFrmFvqhf/EzEbCLbGBNDHxv5fpgL5zcA3b
 tgpm7Bskb6ReXhpqdVrFUBdka/yHvl18+/4e+PBCI48lhGl4XdCgWKy6wrFFUBk01WUJk9VKxZp
 EFIU7fKlafHKsjhS+wh5YZTpDT1Cs+IswWZAEg6vP2YHU1oHdJ9ynzX1PLN50my2bCPZjtsGuL+
 Pv+7L391tDnOuq1xuuEsZQrbDgiNLVw4Xlzf2tbDddJB76QOIx3N5huZlX7yb+K3pwRs6BdimDz
 yCHfwadkyyfL4fzlEOq3FUOgqMsyAJkRyjNRQRBEy5SaEAzwRM24tfv8q6m8BjV05hYGEvw1G3+
 1g==
X-Received: by 2002:a17:90b:4a42:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-396d0e7c071mr10439748a91.4.1787910393882; 
 Fri, 28 Aug 2026 02:46:33 -0700 (PDT)
Received: from
 runnervmgx7h7.hwdy1fi52d2utifharbblzvnqc.phxx.internal.cloudapp.net
 ([20.169.77.228]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f9e907fsm3609676eec.25.2026.08.28.02.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 02:46:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 09:46:32 +0000
Message-ID: <20260828094632.9559-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828-swapon_discard_coverage-v2-1-e55a86dad729@suse.com>
References: <20260828-swapon_discard_coverage-v2-1-e55a86dad729@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: fallback definitions for swapon syscall
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

On Aug 28, 2026, Andrea Cervesato wrote:
> lapi: fallback definitions for swapon syscall

--- [PATCH 1/3] ---

> lapi: fallback definitions for swapon syscall
>
> Introduce fallback definition inside lapi for:

Could the subject and body name include/tse_swap.h rather than lapi? The
fallback definitions are not added under include/lapi/, so the current
component and location do not match the patch.

--- [PATCH 3/3] ---

> +	TST_EXP_FAIL(tst_syscall(__NR_swapon, tc->path, tc->flags), tc->exp_errno,
>  		     "swapon(2) fail with %s", tc->err_desc);
>
>  static void cleanup(void)
>  {
>  	if (do_swapoff && tst_syscall(__NR_swapoff, USED_FILE))
>  		tst_res(TWARN | TERRNO, "swapoff(alreadyused) failed");
>  }

Could an unexpected successful swapon() of SWAP_FILE be tracked and undone?
This is the failure mode these new cases are intended to detect, but
TST_EXP_FAIL() only reports TFAIL. The swap area remains active, the next
case gets EBUSY, and cleanup only disables USED_FILE, so the test filesystem
cannot be unmounted.

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
