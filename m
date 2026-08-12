Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF16C5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:01:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ABA93E8C96
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 17:01:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CE8B3E6CD7
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 17:01:20 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8859D600100
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 17:01:19 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51bfda2cd53so4665751cf.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786546878; x=1787151678; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7sKIaJgGKCGDzKIYsPMSMlARN4G1T8wsU3bjjAXMUQU=;
 b=kioyluDnqo+f66MFTU55GzzPdhZOV4x4oP/AklQVK8WZINmFwEehvDJwH8zVW354/N
 C15VLCt/bJ7WSE/FdjvXrrEU4xolKl1O5xp3WniPQKwAwToJagmf6tayUq2fnU1WOhNn
 dh6vqHprmIbcW2eH4ZRb5RaXmTwAP6Vf12S1nJw3TIW6Wx83vmOgwnAr/C0dPGxY7rcg
 TdcqPt6FF198BI8GgXKVKyeu6Q4MnsxRY5ywuWf77ydiyYtTC+8hcTfJQKAVJX+Xdd0P
 bZZUz1WeQp0dDMSyDQU//UkbHnimEgvRVlgrvzPiGAVRVzQvAuZll9dc7hBlmAOBoLKs
 156w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546878; x=1787151678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7sKIaJgGKCGDzKIYsPMSMlARN4G1T8wsU3bjjAXMUQU=;
 b=m2xOVUmz6ayz5mePCVcxJBwNnREH3Il6E3IzUveVQ0CCsssTo1nqf2Cmzl7tSAMh8H
 xbLDr25lbVSbp5EcRHpYpItu4rvW5H6xuh9mdjJMyvQMsxrx0JZIhIrXmjVUiXz8j8Ju
 rm0/n4t4sJgHxA4dtNiek4aate24DiUplm51ZHX8jZDHlAN3gIIKXmYS2OFYkZiwUVnf
 dK+ZplsDJ8Y0qyCh0FCW2DS2Sm0a/v6yehcZ+6rXRoQzTtL8VOA82z3OaohYIEcHX/1L
 vT8yY5BLAzYa4RB6gPdtVYNgwYQ2dOa/vLxYo2ImDyrihFtuA97pG0+yZYvkrNonV54s
 IJPA==
X-Gm-Message-State: AOJu0Yx41ROZ9J5I7Tmgs70l8PNYqrYGf8s3xdqlqSjmZYTSmiKH/wBO
 IqSb1WFGlqMMxeA4mfIf99U6WBNM0Gn13D7jRCbQuXJ0/chndO/A6D4P
X-Gm-Gg: AR+sD12Q3gRNMCNTVK6Xp/wzqa794mm8wxkbDgHoOkdqAyhLtuVj+HYlTR7AgGX+AW/
 z+DL2Q252XXo9PLOPrbvLkrHKLuscw/vWMH2bU7CyBtk1OVZBqL4idpGV+F1Gwqi1qddGsENcV9
 eaiZYhEmQFwTbBQMT6XfSNLGh+M22EC3oZzU7z78XlSEaa/4/SroMx4UsVhTMza19k7q1hTPRQl
 w8m4xfAd5gvZb6F8ISsqzfIYinQ7uZeTGsMA2kmJqPSFAHpwpH67Y48CGtGYEU5d26HfhtDL8Ex
 HeQQnDb9LrPjaEA8/Oe9O2CZpYicGVUsZrBisAYEGVSlqqYkElNI8BS7m3w0N5xIFJSKnPpdIxt
 4zAYk3SxVHTdXHlLg3fVzQ9SGlF9XDP2bXB21p2Fz+oa8kTf0EOo+ogW/AF8IK3gkb7oMf5ZITT
 rwPZOs80KBcAB32EmufltR8/rgw4Sh+vS4taLDQNyk+Rzqo4tv1pbOU6PqT7KpSC+M5LIrzQCX7
 TUAXQSd9zK1SP82OvvgcMAMS7EoWznk1Njc5L2A8XZRsgzfyyvu3Cfgaipt9f8QW9mRY+283kGh
 2+o=
X-Received: by 2002:a05:622a:409:b0:51c:1006:a024 with SMTP id
 d75a77b69052e-52d6487b030mr47367541cf.43.1786546877982; 
 Wed, 12 Aug 2026 08:01:17 -0700 (PDT)
Received: from
 runnervmvrwv9.lca4z4pwcdgebph4hp2vtpj1rd.bx.internal.cloudapp.net
 ([20.163.133.230]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d61d91199sm19258751cf.14.2026.08.12.08.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:01:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:01:16 +0000
Message-ID: <20260812150116.4069-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812132901.202632-2-japo@linux.ibm.com>
References: <20260812132901.202632-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: group runtime state and skip when /proc/self/mem
 writes are blocked
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

Hi Jan,

On Aug 12, 2026, Jan Polensky wrote:
> thp04: group runtime state and skip when /proc/self/mem writes are blocked

--- [PATCH 1/3] ---

> +	SAFE_MPROTECT((void *)state->write_thp, state->thp_size, PROT_READ);
> [...]
> +	*state->write_ptr = 0;

Could the mapping be made writable again before this direct store, or could
the value be reset through /proc/self/mem? At this point write_ptr points
inside a PROT_READ mapping, so a successful probe is followed by SIGSEGV in
setup() and the test never runs.

--- [PATCH 2/3] ---

> +	if (TST_RET == sizeof(test_val)) {
> +		tst_res(TFAIL,
> +			"Write to /proc/self/mem succeeded under CONFIG_PROC_MEM_FORCE_PTRACE=y");

Could this successful write report TCONF, as described in the commit
message? The proc_mem.force_override=always boot parameter overrides the
Kconfig default, so .needs_kconfigs does not prove that the ptrace policy is
active at runtime. A successful write is therefore valid on that boot and
must not produce TFAIL.

--- [PATCH 3/3] ---

> +	TST_CHECKPOINT_WAKE(1);
> +	SAFE_PTRACE(PTRACE_INTERRUPT, tracee_pid, NULL, NULL);
> +	SAFE_WAITPID(tracee_pid, &status, 0);

Could checkpoint 1 remain blocked until after PTRACE_INTERRUPT has produced
the initial stop? The child can currently check the initial zero value and
raise(SIGSTOP) before the interrupt takes effect. If the wait observes that
stop, every write is checked one iteration late; after the final write the
child reaches pause() without checking or stopping, and the parent hangs in
SAFE_WAITPID().

> +		SAFE_WRITE(SAFE_WRITE_ALL, memfd, &write_val, sizeof(write_val));

Could this write be probed explicitly and EIO handled as TCONF? The released
kernel permits proc_mem.force_override=never to override
CONFIG_PROC_MEM_FORCE_PTRACE. On that valid boot, FOLL_FORCE remains disabled
even for an active tracer and SAFE_WRITE() aborts the test as TBROK.

> +			tracee_pid = 0;

Could the trailing whitespace on the following blank line be removed? It
causes git diff --check to fail.

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
