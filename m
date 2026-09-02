Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD03C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 17:44:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4723B3E93B8
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 19:44:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD63A3E93B1
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 19:44:04 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3DB972005C3
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 19:44:04 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-398a0a87595so1161425a91.1
 for <ltp@lists.linux.it>; Wed, 02 Sep 2026 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788371042; x=1788975842; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Xr7xb9cvT0fQLmksESf/aN688yeL2tMpmjTsx2Mabk=;
 b=FyIobriFXrX0IPXTtAnQE7Le40XQQFjy8Ccx9GY0ZNVW1rSvbHXPpEHLMIWMzm36a/
 TiuDS5NIS39cRKPdrA99gUS2BNl2cpktTCyrM/KLenwtS9FGccOvl+4JKVx+T6tPyoDK
 Y8Yf/2KoJkovCbh7hUUTLuZ7DVsLZ/0FgSxqvA5NQFXqBn3GZE7sytzzDEMnYPT/gkv6
 KXFiceCfPgd4SEx67P1E90zY9EeLtZ+0/X1i2aO5nDJRSiCoiFCj+JLEjXpQZtJYg2L7
 H+VDoLldbu+1IfNMKM6wqCWNpgdXtlHeYdXUWboAxFA2YcbCH9awZENg+8QBFZk4xvE/
 /0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788371042; x=1788975842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Xr7xb9cvT0fQLmksESf/aN688yeL2tMpmjTsx2Mabk=;
 b=eB5aQ7r8fRsOkYqFNmElFNc+WqVrhJEL0j3ujPBTgNn2NyNuq6qWNk32Czj6iBxAOq
 z/bMBoFPeqpYrS8UE27ChgThDnto2Y0tVLW1Qfh6FgOOJ6C9ScZGYUGyCPUmtG2jWcX9
 1ZJMl7ohcWCnxEi/DIrJoS7A4kLxPPFLGnlYmGl816+43rZL2buQ7U+AqVVE42UXmzJy
 iTUjvocTqyU4rMxs4I/rk3OcOD7WTum5Y6P7ylTA2O/s1CPxD7GC/c4OHTyHTJBAqamy
 PXP/gvYaseMMG2XG60SBwkfNB/xcPVeIgLtfmdgH9t8twU8s06nSBHfulpq/dlKc2DUl
 QoLg==
X-Gm-Message-State: AFuF++m9NqhPZpVJTamgREbEvx0drf19ZZLy8j0LaIhRU7pxauWV2z6j
 jYQ9WDOzba2gSMFonVcgv1OWWRxTflmuIdgFGAMB/wK7ZjOI067oEp+9
X-Gm-Gg: AYBFou3jrXkg19D3NIrzaTnQKuVNyv+3vXN2Y/UcexDgeBo8g+U7WPXr/nM3OB54Ypu
 L9qt2WA8vNbV6c1J4B5aHJ46YR/UEH4WoVsoZcAszdhPCuc/SHCeCJdH5Kzc86/IxK7rebRqamI
 mgrvClrsRlVYfSg/Dsj4W2sJNH6K2flPTrwhNOVa1nzkAPXHgy2Ks2YHLSZS0iInfXiNTgn7dpW
 Cag2CCt+k+6eSdDQsqxEj1mgqXBaIixW+W1dbodOrPtrZHgI2ykFDgIrS6Pvs4kI8S1x7KzH0gT
 jzr7RPi5EYtGuBdXu5HjZ+swrV6R8hzMGUJEH/fzZOvNbKFMXNVNmLGnDuaJRrbxeeeV+MqIV5u
 sMJpTyTEyL/VEOBzexUvruDQQqXypnvldKMIKlgTGkGDDP2uGwAhB06RXSuHpl3KwDWZtcvlbAB
 sn6nEu4vdwZJUdmOBxZ9zTV5eWeLk/5MK2nA8ce3dn5J8JoiaRDJRf+8l2/r/SYyiU+PxXsInsK
 tg28zHXg4IdV6VosuITys39XIWCalhDQuWnIae6bj0HsbBxBb2sKQ+97UUo78KNY7hc6LpijHM=
X-Received: by 2002:a17:90a:597:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-39aee9b4d44mr7048350a91.0.1788371042442; 
 Wed, 02 Sep 2026 10:44:02 -0700 (PDT)
Received: from
 runnervmgx7h7.fptswulnz20udhhtfj3wfpx4th.xx.internal.cloudapp.net
 ([20.3.231.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae8ccc72fsm1862065a91.2.2026.09.02.10.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:44:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  2 Sep 2026 17:44:00 +0000
Message-ID: <20260902174400.9226-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902-coredump-v4-1-3f511ea1c96a@suse.com>
References: <20260902-coredump-v4-1-3f511ea1c96a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

On September 2, 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

> 	if (tst_get_path(HELPER, helper_path, sizeof(helper_path)))
> 		tst_brk(TCONF, "'%s' not found in $PATH", HELPER);

`tst_get_path()` can return a relative path such as
`./coredump01_helper`, but a piped core_pattern helper is resolved from
the root directory. Canonicalize `helper_path` to an absolute path before
writing it to core_pattern, otherwise the helper may not start and the
test reports a false failure.

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
