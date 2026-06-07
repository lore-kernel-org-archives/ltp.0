Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6F5CD8C8C
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 08:02:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69D9D3E1617
	for <ltp@archiver.kernel.org>; Sun,  7 Jun 2026 10:02:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 261013E2FCD
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 10:02:15 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 630DB2009CE
 for <ltp@lists.linux.it>; Sun,  7 Jun 2026 10:02:15 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-135e7f4a295so1855412c88.0
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780819334; x=1781424134; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhhP0svh8ItNPfQjjPUVIxh7N6x7KaU5lgQL9dVHM78=;
 b=A3QBkVerg25EfeNqmN4BbvOb1Y2IJNu7geMCEFKcwE4YF7iHO0N7Lmw31wQ52ew9gc
 CtaPLclQpP8Rz1FdggpAlDFpOjI53qhp6MhqoolwMYROZmYU6/UXOi2RZ8oTQgKV71Ug
 tvJWBBcUIMMWHusvQsYy29hm8VSww7jnr+XiNloQElbrBJUx+U35FBJwBy4K20ZT7Oj+
 T2FHAUSThgx3b5pfSSpwxCIq87HI+g6VfZ0ILLRXoa87KgI1S2tM0zjf/ZjXPtlWpQJs
 4RCCzW46RcXTIGBI8C3FndV1nDHwf6j44+H20S3GmKjTrxcC2eO4vpctDjo0ckUi8d//
 yGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780819334; x=1781424134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhhP0svh8ItNPfQjjPUVIxh7N6x7KaU5lgQL9dVHM78=;
 b=s1nzo62KxTSzZXa8M9Wd8RWUHwou7B7ov2X2aUelzp+kBQNewm5j0rATf4DQ5zotq2
 KokBxPx6PxUEYQn3PzX6sQOFXvZWel0SHFAvhfo9W7QTq3P1DEsvWKhikk5zqp0ZgKSS
 GPnPchipP7x+M2719czCaIKJmktuDPIwNpe/dXjnB99SH6lhh8uD8rMS5fa/gzqf4A35
 TX0uBtaJDe7hc8TKqpWLF6HYLBZnaIhqITUiVp7CRxOBKqR0lCYI1geIvxmeb+RbSg+U
 1UAnM/1rkmis+Q+1gb0uqrQxQJlJJo2K7O4HNcVu5WgEaHlhe9Z4pD+0bsjLbU7l2uxi
 ARoQ==
X-Gm-Message-State: AOJu0YyhpwD8STZefXWl2OKgymG2pfF/ZA8+Gjs4x1oUMiXz72V7c7Im
 DWxCy0B69hycHSn1JEIUiA91cFMaXkVUgectR57a1vrnVA7GZWQV4PuYecJMfdSk
X-Gm-Gg: Acq92OE7hrIigmWxBG5r89hSo6Br4uq65orJ/Rqn/70KwqSlA3/Ld0l3+4GbQqtmVmM
 4C89ijiCoTirg8UKmpfHIIME6Wck0KOOg3sUuRo4KynEnBpiedtBEPQGOMRULXzPnjbdz/Jcvzj
 1sM1n5TV+YQNSKKX2sJV2v0nWPCbf0LFi6i7hfpInelBpAlpFUkRtTznS/AGlIhJE8Fmq1rS9bh
 YUF7MpVLIjD73LPEbxMRs4FKjD8A20Wa0weftTJEB2KlYB/Qi0IItFQxBnNmnPseW3PblQZ5qfT
 GzEo6Mxn6ugFC82KYlMKPbBpHSClHzz9yicMp2/p6MsDRaxbJI1m4DrNxlm85ohxSndSFjIrVsK
 BfF6UMgSKjhlirYdmwBHe0JlcC7nzjcM5wVcQ/XIi/w/jybQTWCQgtfF4/fLEmV9F3aIzFCv8pi
 UpcAYB15+DdKRiKb+Mh/eVZbW27B25+rj5KY/Rl87mXRiTAmjG2FTwXnwHTte6uqGhGSEmdEpc4
 emkvnfEmK177TyFOr26T3ZZkrcrOOfqhrOBadHL0iQFgKqJ2g==
X-Received: by 2002:a05:7022:160c:b0:12c:1288:ce63 with SMTP id
 a92af1059eb24-13807d7b5camr4256786c88.13.1780819333545; 
 Sun, 07 Jun 2026 01:02:13 -0700 (PDT)
Received: from
 runnervm3jyl0.2b4dycjmhivupb0lganmtm1jpc.dx.internal.cloudapp.net
 ([20.57.198.164]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm11765811eec.25.2026.06.07.01.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 01:02:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Sun,  7 Jun 2026 08:02:12 +0000
Message-ID: <20260607080212.3930-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607045219.32729-1-wegao@suse.com>
References: <20260607045219.32729-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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

Hi Wei,

On Sun, 07 Jun 2026 04:52:06 +0000, Wei Gao wrote:
> mmapstress06: Convert to new API

> +static void cleanup(void)
> +{
> +	if (child_pid > 0) {
> +		SAFE_KILL(child_pid, SIGKILL);
> +		SAFE_WAITPID(child_pid, NULL, 0);
> +	}
> +
> +	if (cg_child) {
> +		SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
> +		cg_child = tst_cg_group_rm(cg_child);
> +	}
> +}

The drain step moves the parent process into tst_cg_drain, but the
parent was never placed into cg_child -- only the forked child was
(via SAFE_CG_PRINTF(cg_child, "cgroup.procs", ...) inside the child
block). After SAFE_KILL + SAFE_WAITPID, the child has exited and the
kernel has already removed it from cg_child, so the cgroup is empty
and tst_cg_group_rm() can be called directly.

Draining the parent out of its current cgroup (tst_cg, managed by the
framework) into tst_cg_drain leaves the test process in the wrong
cgroup after cleanup. Compare with ksm02.c, where the drain is correct
because the parent explicitly moves itself into a child cgroup first.

The fix is to drop the SAFE_CG_PRINTF(tst_cg_drain, ...) line:

	if (cg_child)
		cg_child = tst_cg_group_rm(cg_child);

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
