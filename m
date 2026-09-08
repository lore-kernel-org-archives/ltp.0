Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5906FC79F9E
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 15:01:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4693E94A0
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 17:01:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FA963C71DE
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 17:01:15 +0200 (CEST)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9FB001A009B7
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 17:01:14 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-cc4902427c1so706713a12.1
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788879673; x=1789484473; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wNgX1+2bvoIkPg5P10WmT5GZfMecepAehbB5EkQLbpE=;
 b=UshXkphGlppdnzsz5AKZgjccEz8qhXhpRR/Tgd/mF9BcQYRwaFaMoH7khARPNuVEw1
 3mebXIn7JsN1s7GDJdPfeiklKYthn8e/4PgS2+k2D38AXjgCclKTGIQmusB8cApGpJJI
 ToW4Sdx1vcouEtrjN7TDtjuXCyh2w+FrPF+LxyB7D69YSwjGnKREHe0upAtTo/+za5L/
 TtmbE8BkDq2nezkKltAA3FYkMTz9gRVIoFjL5sy9RIHvzmLUUY6UZHiOyCxap+jvXAxj
 dVzhXpfRftN9kR8TlTrHtd0afvp4//n96LRpvnpUZIQohT8beM9e3kjS1lvm0t6ppgv3
 6b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879673; x=1789484473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wNgX1+2bvoIkPg5P10WmT5GZfMecepAehbB5EkQLbpE=;
 b=WhVrWBna5MiMKCITVWpLNvyAGL5o2/Y419m12DVet33WV0YY/HCDK49/0VKNgP31yW
 7JkChfd4rBMBr7tpG7hCJn5hAuxm2yMNXtQfNxVU50h/2S4Is8nRwfn7+ZJ4KmjlUyWT
 j5Rsn5t+bR7S/RB1GqiewCggBl+bO2quvN7IE+4mvrwAulSNMlPy0naUHS5+xXC06TX1
 IL3vDmQXriSP8ydjpfftgrXwj5RLIck+XWTktaCohzXoZJ/JpWmvoQ9hThLUb5ttCt7X
 bvkvFJ+H/2ahV875kpJlAZ6SzQx4wSdeBBcwQlPbqfd5T+MiOu2BLa17EO8SvysSZBB3
 C2kA==
X-Gm-Message-State: AFuF++nggg83f4fLWtFb9ly1Kz9ah/sFNxFW2rjWFPgQm2amxxbEYp4T
 f37jaIIPS4zwEhSklnqVEJIaDb6xaGBpIE3oqAPkMYAJU/p0Uaipd7E8PxdnJbHt
X-Gm-Gg: AYBFou1q6dMg2atqs5+6AU9sqWd/hUymi1n7yAavfSIU7GkCPUFpYkud6WihEf1FA3k
 48eQCYHNNgXIFmS62kYbrjIL0VDQgj4+H1wULEKk2Un11gBtbQndDkCkFxErrvD+DUtKcBYBY1q
 5nime3OqyUunWMUXmZgS2m7ebVC4aY+xi3lNyNlv+3VdEckQkNyArg55iGd+1/6OKNCTQTpryPe
 dCGhOE9hoHZbjXhE2wUjfNe2ZRQgCVYlk6vmnLH0pkEZJsZorDRpUo8lQMg99/sUjNX5BfaVPYO
 fipLSBqz7wu7VuNHqaOPN74yQj+xbwdowVNepwM2Xd7Cv99mufLDmjD5huyOPJIA9v1rLsSRsRB
 OCR500B1BRNqpfEoOSGEvzBNRsSh5dC3+ug1fJwal8bJ1x7BBLDftly/QedfTfD1unNknlU9laH
 JG2ZHnZOxLbhYygk7wTDclg6MkvsOFkGn+w2zUEVclnMilweNiL1XSRaFPIhafzTYvAIBnZAArm
 GHLwNjHO/bogtFtpE/wbFqMfpRXod0Wn8ZpeCUuuGSdZGr7Kuqhnemi6ap9ssARkEktJ74soYY=
X-Received: by 2002:a17:90b:5745:b0:396:669c:b5f6 with SMTP id
 98e67ed59e1d1-39b0803accdmr38489475a91.12.1788879672407; 
 Tue, 08 Sep 2026 08:01:12 -0700 (PDT)
Received: from
 runnervmejwal.wxrpj2k41buetg11k0dzziqzpc.dx.internal.cloudapp.net
 ([52.159.226.1]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1434c745a09sm5447740c88.7.2026.09.08.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 08:01:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Tue,  8 Sep 2026 15:01:10 +0000
Message-ID: <20260908150110.9037-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908111332.150323-2-japo@linux.ibm.com>
References: <20260908111332.150323-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

On Tue Sep 8 13:13:28 2026 +0200, Jan Polensky wrote:
> thp04: group runtime state and skip when /proc/self/mem writes are blocked

--- [PATCH 1/3] ---

> Move thp04 runtime state from static globals into a heap-allocated
> struct thp_state. Group write_thp, read_thp, write_ptr, read_ptr,
> thp_size, writefd, readfd and fzsync_pair in one object instead of
> spreading them across file-scope variables.
> 
> Also add a real /proc/self/mem write probe in setup(). If the write

This mixes two unrelated changes: refactoring file-scope state into a
struct and adding a runtime probe to skip when /proc/self/mem writes fail.
Please split these into separate patches or keep the static variables.

> +	SAFE_MPROTECT((void *)state->write_thp, state->thp_size,
> +		PROT_READ | PROT_WRITE);
> +	*state->write_ptr = 0x12345678;
> +	SAFE_MPROTECT((void *)state->write_thp, state->thp_size, PROT_READ);

Modifying state->write_thp here triggers COW and breaks the clean huge zero
page mapping before the test runs. Use a separate test buffer/mapping to
probe /proc/self/mem writes.

> +	if (TST_RET == -1 && TST_ERR == EIO) {
> +		tst_brk(TCONF,
> +			"Direct writes to /proc/self/mem disabled "
> +			"(CONFIG_PROC_MEM_FORCE_PTRACE=y)");
> +	}

Do not split quoted string literals across lines.

--- [PATCH 2/3] ---

> @@ -1183,6 +1183,7 @@ ptrace09 ptrace09
>  ptrace10 ptrace10
>  ptrace11 ptrace11
>  
> +ptrace12 ptrace12
>  pwrite01 pwrite01

Move ptrace12 before the blank line so it stays grouped with the other
ptrace tests.

> +	if (TST_RET == (ssize_t)sizeof(test_val)) {
> +		tst_res(TCONF,
> +			"Write to /proc/self/mem succeeded - "
> +			"CONFIG_PROC_MEM_FORCE_PTRACE not enforcing ptrace checks");
> +		return;
> +	}

Do not split quoted string literals across lines.

--- [PATCH 3/3] ---

> @@ -1184,6 +1184,7 @@ ptrace10 ptrace10
>  ptrace11 ptrace11
>  
>  ptrace12 ptrace12
> +ptrace13 ptrace13
>  pwrite01 pwrite01

Place ptrace13 in the ptrace section before the blank line separating it
from pwrite.

> +	for (i = 0; i < TEST_ITERATIONS; i++) {
> +		if (*shared->test_ptr != shared->expected_val) {
> +			tst_res(TFAIL,
> +				"Iteration %d: expected 0x%x, got 0x%x",
> +				i, shared->expected_val, *shared->test_ptr);
> +			exit(1);
> +		}
> +
> +		raise(SIGSTOP);
> +	}
> +
> +	exit(0);

Calling raise(SIGSTOP) on the last iteration leaves exit(0) unreachable and
forces the parent to kill the tracee with SIGTERM. Skip raise(SIGSTOP) on the
final iteration so the child exits cleanly on PTRACE_CONT.

> +		if (TST_RET == -1 && TST_ERR == EIO) {
> +			SAFE_CLOSE(memfd);
> +			SAFE_PTRACE(PTRACE_DETACH, tracee_pid, NULL, NULL);
> +			SAFE_KILL(tracee_pid, SIGTERM);
> +			tst_reap_children();
> +			tracee_pid = 0;
> +			tst_brk(TCONF,
> +				"Write to /proc/pid/mem failed with EIO - "
> +				"proc_mem.force_override=never disables FOLL_FORCE");
> +		}

Do not split quoted string literals across lines.

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
