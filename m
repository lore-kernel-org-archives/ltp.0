Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DCCC3DA7A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 16:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED9143EA7B0
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 18:40:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF993E26BA
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 18:40:39 +0200 (CEST)
Received: from mail-qk2-x0b.google.com (mail-qk2-x0b.google.com
 [IPv6:2607:f8b0:4864:34::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 110FA600B2A
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 18:40:39 +0200 (CEST)
Received: by mail-qk2-x0b.google.com with SMTP id
 af79cd13be357-93e490d7b48so15978585a.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996038; x=1792600838; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bg5/TZ13mMJJtkXkSklUi2FuzK6H4iqiaWUhvZ93AoA=;
 b=rpgmTwaVaptY9pf1BjXPRa0tr7MrHSBLQZPIKZxVY0AhPSqF5Cav98YEWdtwv9snGs
 rIg1osIBSe+/7XtXrpJRkXpKmCYmRT+UwdOJhzu6DQuDmLgyIsjBuds2WrMfAE57J2af
 Jtf3f+OlGcWT9LTeN3PabBXw8gSPhgoKe2/py1839dkPX7EGFWVVpmykvpLGzQS753Wl
 4FQBH7ESdz4AOFfKRny24veDtE4I1tzs4iOysIcSGhrW+JTeduOYQSAK2pYaVASN/0nr
 vUfdIkj/TaAeWh8OeHfl2NGfhxoEMXLS3RFk+PtUvDbB+BVQnecdI2aoi10XwfOxzO12
 gTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996038; x=1792600838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bg5/TZ13mMJJtkXkSklUi2FuzK6H4iqiaWUhvZ93AoA=;
 b=qf3BZtL4zryHgmKaWXNYos5qpIeO3SZiZ/bNscea3N/tPopHydZQIvkq0sBe6VsmbS
 veC+590m+pMrEmPsyk0a666UM1OUCejCcZ8eo2sBnfM8ql3lB3ADJpvYM2IbfxgU6ceI
 xDk3+D48Mz1rzh2r70YqkL2nGIAOEjFouhdk9qZJo8abbL5bnnCUvV1yFwthQ+jF1RNE
 BH+f35ryb/RaNA5eQcLkVijOQRY8S+tutJ0++uGH8TvoJ99Qo31kcgxDbm2YpXluUTbL
 6PCW+yp05Esrx0gF1rpCYd51v+LTHiVaJqeBaJqg+xVhaqJQmkEJmrY/cMGRfeeNtHxI
 Yv5g==
X-Gm-Message-State: AFq9FYIRtBTpSdGPPHooGrCGntuUpni/bgAxhNFt3TZSTq/SJqHphWic
 qG56ncljiCQLVmPmiqSkV7t9JFNxyXX8GsWNpXFQSuCxuElKXaaERCvd
X-Gm-Gg: AYBFou2PC3EBXvg7FTZlXQvw02dZWPo9vZFqdPfsQ3QfsWeeFZbg5oryaP/VrnQBnHN
 kx8sb32t1AydSFoB88cIZKZzfD7p3MbYWByV5r2bGKf+rUVsqF5yInIE/r1gSIKzHlOwwdoAkkY
 kLZsrmON2J+3u5iJBO+bDIuVDYTLKDdHJMRYDyTaR6fiGLZzR/dEUB3LEKJ+FeWvyeODqChLED1
 99uRCMwS+yOtuoxET8iD0EYAjikUowceA6m0nFNz4tb2iecD5n5PCQkm5uYVc0oE4pmC+mRcdU1
 x/UjozzqNQfrF3UpoNyrZNgbAnZaK+hkxyvROqA1qLXzvzl523srKqcfhvSyzGkZXF6GMH1LY9g
 SSA505tgH3LQd3+t8ujrf+NbdKbDg8tFBV59xbQqt2vKpYD/E959ML4O8GcK9q5Nu0uXnNpA7ZS
 stDpzye0NLAPXlEHyI8CPCb1ss4pJVDKFFsvul+tyNO5naMMTIudYZPtMK3o4gDPux9SIGRSTg4
 luMLtnArVMzyXq+xcDbHc8/RZeokgbMMs7idRV72wPXDGasBw+w2xo07k8dCVxfMjiUtngW1TfC
 6m8Ip2cw1g==
X-Received: by 2002:a05:620a:17a9:b0:93e:7dfa:262c with SMTP id
 af79cd13be357-93ebd2499d5mr2592930885a.35.1791996037505; 
 Wed, 14 Oct 2026 09:40:37 -0700 (PDT)
Received: from
 runnervmmprz5.mdtce0mt4ome5kzwfyfkzdq1na.bx.internal.cloudapp.net
 ([74.235.90.83]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5051333sm530033485a.28.2026.10.14.09.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:40:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 14 Oct 2026 16:40:36 +0000
Message-ID: <20261014164036.9388-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014-fix_process_vm_writev_permissions-v2-1-17710f74606c@suse.com>
References: <20261014-fix_process_vm_writev_permissions-v2-1-17710f74606c@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/cma: Handle Yama ptrace_scope in tests
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

On Wed, 14 Oct 2026, Andrea Cervesato wrote:
> syscalls/cma: Handle Yama ptrace_scope in tests

> diff --git a/testcases/kernel/syscalls/cma/cma.h b/testcases/kernel/syscalls/cma/cma.h
> +	struct tst_cap cap = TST_CAP(TST_CAP_REQ, CAP_SYS_PTRACE);

[High] All three changed tests fail to compile without libcap development
headers: CAP_SYS_PTRACE is undeclared at cma.h:17.
tst_capability.h gets this constant only through the optional
sys/capability.h, and lapi/capability.h has no fallback for it.
Include <linux/capability.h> in cma.h so the tests build without libcap.

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
