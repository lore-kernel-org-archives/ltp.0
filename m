Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DB0C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 18:57:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A3AF3E29CF
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 20:57:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F8A73D900A
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 20:57:00 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 245EA600A16
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 20:57:00 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 af79cd13be357-92e84efd807so2776985a.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783623419; x=1784228219; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5PJHk6x9ax2NLYvaws6x04UIpUY0eCXZT+GiVp/JIHk=;
 b=Hy13YW3dCC94CNhrstYOyL3JvmMikgEsXQ/CE/H4gztBIGv39PifDpWYZ1e2yjNkdW
 V9viGjQCejUIg7LLTIJmRpbhwQECehJswJOjqgMxSgScgCjIubDAVzKF9VW/DLzxQ4+z
 Vq0kywjhiFRySpeE1Eksm/AfbKG+Ur3WNH9rAP4lqorj1/+t6V1XznU+i1DNJhIHgdlB
 gTiAvlS6Cvd+BGAivGHVG7PUL9A2u4Z7EsZhsEdQcTQ5slVKpkQnhGyDyVzV8Xx3gGdi
 8Bn7puTM7tcQMTlYHb2BHNaLIxeNZpWJIy2z7k//FyFe9oPdoNcNBNGagHpHlp68cAjp
 GZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623419; x=1784228219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5PJHk6x9ax2NLYvaws6x04UIpUY0eCXZT+GiVp/JIHk=;
 b=MQ/bPfnAqaM/WkNYja5h1sCtS6zrtvX5O5sr1VxmpZVZDPH0hW5bW1Y/hgM3WasAbd
 C6M069FVEUXDrA7HcOPVrIvJO5Vhsuasi8xOKq/AB82IRLPWyK83CVAeMdS2woP7w5d/
 /oPaZXNjpGwwAkNc2+zRNDCXIkJvRYw2ludXnlI6Ok2iMOjxcxzN2g6tlNikwHaEslm6
 E8G59UVRCEeQxthElDoFTDEdA8pU9vcRVdf9R0D84j5CnEYwibvAyaOYH7nWPnK3rP7o
 ndx1ZvPZIEv8wAqrhzIIao8al5B+kz6eGPmt7nOpvVQ3RtY12I04SXOKkAgNGrDSODZ/
 h5EQ==
X-Gm-Message-State: AOJu0Yzgi+AfxHV8mQNFbFgBI8r1ojdPy6TpnD3TKFvU7xtKz03XUEov
 GASUaOW6h6hhV65qef68CTjxcmH5fLHG3lW/HHaRed0t47hhNCfujIJ0
X-Gm-Gg: AfdE7cnT4yqV1LIJJ+xxAmLvPZcdpNUGOS0UoC8Q211BSWof/Ybl3djdAd082Zb8zRi
 jf7s5NyQuKBab3E+yPJ9YP1OGU7wKvDT+hNrZXDehYRJbgHK8gv0Kz7U72yfeg4JgsKsEleL9qb
 1SM5Ij/ntnLB5G2uQXWU+E+Ov5ZNR0J2diDvNTMUbRPCtWNzQj/c3eoG/09A4Iu0n3WWiyas1wD
 xkfXYnAayN8ghlg20rZh0jK+6+Y1syEjngW6IZ0FkjvU+HRCzR1GtZ9jln2RqVkjHStvaaZRSuc
 D4ks1JzDxG2QlMTf8Hayv52GOcBjbqcMG9Bwqunr2UWpSxSlhdE8GC7UR3Lz/ooQPxYAYpzFvDa
 JjTKyytZ2LGnOh/oBRUvxV4NwkQFbxORJ2KYYmB/tSmRiG9J9DQ4aX6N1l5lhaVqRE5KpherEMt
 uiT74xkJisGJskI1fZHyG0LTnQ+7v8qLtVOoueenhAFXvLZAy3ZmQmvcg3nhYGSITEoLxCJJ6GZ
 NtdTRGhAuQEBJUysyfzlGCO0NLs
X-Received: by 2002:a05:620a:8904:b0:92e:6f45:dfdb with SMTP id
 af79cd13be357-92ecf490401mr850613385a.0.1783623418823; 
 Thu, 09 Jul 2026 11:56:58 -0700 (PDT)
Received: from
 runnervm5mmn9.xoxzbnckc3tuvhtfp2zpexthsa.bx.internal.cloudapp.net
 ([20.83.175.232]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b86276sm13796485a.11.2026.07.09.11.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:56:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Thu,  9 Jul 2026 18:56:57 +0000
Message-ID: <20260709185658.3978-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709175927.268677-1-japo@linux.ibm.com>
References: <20260709175927.268677-1-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Add ptrace mode and fix tracee stop synchronization
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

On Thu Jul 9 2026, Jan Polensky wrote:
> thp04: Add ptrace mode and fix tracee stop synchronization

The subject says "fix tracee stop synchronization". The original test
had no tracee or ptrace code at all -- this is entirely new logic.
"fix" suggests something broken was corrected. "add" would be more
accurate here.

> +static void tracee_main(void)
> +{
> ...
> +	/*
> +	 * Run indefinitely - parent controls termination via PTRACE_DETACH.
> +	 */

The actual termination sequence in run_proc_mem_ptrace_serialized() is
PTRACE_DETACH followed by SIGKILL. PTRACE_DETACH alone does not stop
the tracee; the parent then sends SIGKILL explicitly. The comment
should say "via SIGKILL (after PTRACE_DETACH)".

> +		if (*child->read_ptr != 0) {
> +			tst_res(TFAIL, "Huge zero page was polluted");
> +			child_cleanup();
> +			exit(1);
> +		}

> +	if (WEXITSTATUS(status) != 0) {
> +		/* Tracee reported result and exited early - already handled */
> +		tracee_pid = 0;
> +		free_child_state();
> +		return 1;
> +	}

> +		if (WIFEXITED(status)) {
> +			if (WEXITSTATUS(status) == 0)
> +				tst_brk(TBROK, "Tracee exited unexpectedly: %s",
> +						tst_strstatus(status));
> +
> +			/* Tracee reported result and exited, this is expected for TFAIL */
> +			tracee_exited = 1;
> +			break;
> +		}

The exit code is used to convey "tracee reported a failure" (exit 1)
vs "unexpected exit" (exit 0). LTP rule: never encode pass/fail as a
child exit code; use tst_res() only, and let the framework propagate
the result.

A cleaner approach: add a result_reported field (or similar) to
child_state, set it in the tracee before calling exit(0) on the
failure path, and check that flag in the parent after reaping. The
tracee always exits with 0; the parent distinguishes "reported failure"
from "unexpected exit" via the shared flag.

> +	char path[64];
> +	snprintf(path, sizeof(path), "/proc/%d/mem", tracee_pid);

Path buffers must use PATH_MAX, not a fixed-size literal.

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
