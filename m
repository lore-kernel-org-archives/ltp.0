Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771D7C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:17:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B3F33E59B2
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:17:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267C83E1C23
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:17:28 +0200 (CEST)
Received: from mail-qk2-x04.google.com (mail-qk2-x04.google.com
 [IPv6:2607:f8b0:4864:34::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74C2A1400DA1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:17:28 +0200 (CEST)
Received: by mail-qk2-x04.google.com with SMTP id
 af79cd13be357-92e7825afc5so63279185a.0
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784207847; x=1784812647; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ERDhrZDvpaWXEdNzmJ+JxoKuEJyey2MWXZWjchvrNFA=;
 b=B7e3EX9aqoJcys7Ehs3/Dljab1baQNzHQRSnZHiFhiTWSVCwbJsgIiiaPtLZ4oXSYv
 KLxuhmbonGvkn1Gt81OfiNVAZxZgHl7f8WQa0LDZBHJdrFU/vlEN6bUHeIyyKVsMwXKC
 j5HRNKaYlXXnQdaUEVIu+cqxXXSpZ0PZnk0on8dH+wkAvBK7/aUrSouK9l9gjazp6625
 3I8KmrJfoxx3M8HbotwVJnjjt6Gaj3v/BdllxyHrxfzb4Z0s3BDqVE7IjEDpTi0PfZ48
 6454IkoT5UC0BEft4VtcoQ2LVshNgpsvzJfxGhPxoMS2L6Va/aLmkd2Ul6BvU4nNeqU9
 ESDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784207847; x=1784812647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ERDhrZDvpaWXEdNzmJ+JxoKuEJyey2MWXZWjchvrNFA=;
 b=hUHdnEWRHasc/YRDfQhSRNJtSSjkjelSDvwyd+47aa9/PqmxJKpgutLPtwYFc+OPfF
 6twbB/kgD19JpfVNMrEuKeK/DDy8OP/Ijun2Y8X2vRN7ntRrXO63jGkHQCsGYm/PcySU
 PEtLaee0G53MBysB8+oUlh0jHmL7BkOCfn9eo1YJGzF2j8M45S4KKmb42P+LJ6HDWsES
 aNvQ7SU5siDpLkfb2acTUyvPUbRzU9PMvpspkfpXyShp66rYdb5rjL6KUvrwtiJxo3Bi
 ELOPxajdCB0Fu5r6WW0SjWZtAwtrAj7kjKKVOgZokCsnTpJ99suIN/jyV7UjtWGXnzqu
 9Mkw==
X-Gm-Message-State: AOJu0YyKFf8FnnKzUsvrFNaTaHiDTPd1bhyfsx6FqPjhk6BE0Gg0SLAW
 h3C7kVi53EGGVNdy6EEgG+Rr1WzsIwIMeUq94gFwQOMaRuDTkf9/D1SJ
X-Gm-Gg: AfdE7ckNis54BRQMhKhsAHcieRJL6sCUimMDsWyUAUypM/VdA3TIHgZKOPTxRQVP8K1
 bOvxqXAUiTctCoJulZ79KOG2hZTXgzaMkmj87j38IJKb9X9KpFhpo8g7nUlaEriM12kGNHFu1rB
 /q/n2NxP0OEMJ5DEsZDBmXCwGZgh98fZ5toU0TC+n9dyNxtzmUvG/mL/B4S2SRnLSt/dzCSfgm+
 RrQx56vAbngM+JL+2YMM9zoGPmn8gSSJUflFiEBpys371zmTJAGP5gjP7MLFFnYRzNedS/vcwwP
 iiuCPGREobe3x6qLVWE2E1sr+wOVWf4c0+dxelcG95LseloQXpiC0ZiUZ/V+G8e9jbCGp57P/I6
 P9Jiz7JaRIrKeuHa6ThRHHOuMXeJXIIMWXkhXY4Rt/Dv8EIw/WaGr21r4XwYRIkiJNUKzX+FinL
 X9HMJUxrzKptrB7ZUucONpUJgvdvWVuMhsM9p1XpGbdys3pbTuUq6Nnk4ik7WZ0MBHRrvUuQUe/
 o1Bt6pkQFj/SfesIw==
X-Received: by 2002:a05:620a:a488:b0:930:771e:e8d1 with SMTP id
 af79cd13be357-930771ee916mr1333283685a.0.1784207846783; 
 Thu, 16 Jul 2026 06:17:26 -0700 (PDT)
Received: from
 runnervm3jd5f.ywk1ih4da4xu3m2ljf0f0mebkf.cx.internal.cloudapp.net
 ([20.109.87.115]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930ada3a1c3sm19428485a.20.2026.07.16.06.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:17:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Polensky <japo@linux.ibm.com>
Date: Thu, 16 Jul 2026 13:17:25 +0000
Message-ID: <20260716131725.4209-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716095004.92793-2-japo@linux.ibm.com>
References: <20260716095004.92793-2-japo@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Simplify to focus on CVE-2017-1000405 race test
 only
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

On Thu, 16 Jul 2026, Jan Polensky wrote:
> thp04: Simplify to focus on CVE-2017-1000405 race test only

--- [PATCH 1/3] ---

> +	/* write_ptr points to last int in write_thp page */
> +	state->write_ptr = (int *)(state->write_thp + state->thp_size - sizeof(int));
> +	/* read_ptr points to last int in read_thp page */
> +	state->read_ptr = (int *)(state->read_thp + state->thp_size - sizeof(int));

These two comments restate what the pointer arithmetic already
expresses literally. The LTP coding style prohibits comments that
are plain English translations of the code. Should both be dropped?

--- [PATCH 2/3] ---

> +/*\
> + * ...
> + * Test behavior:
> + * - If write succeeds: TCONF (feature not active)

RST requires a blank line before a bulleted list. Without it the
list items render as continuation of the preceding paragraph. Should
a blank "* " line be inserted between "Test behavior:" and the list?

> +static void setup(void)
> +{
> +	/* Allocate a page, initialize it, then make it read-only */
> +	test_ptr = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	*test_ptr = 0;
> +
> +	/* Make the page read-only to test permission override blocking */
> +	SAFE_MPROTECT((void *)test_ptr, sizeof(int), PROT_READ);
> +
> +	/* Open /proc/self/mem for writing */
> +	memfd = SAFE_OPEN("/proc/self/mem", O_RDWR);

The first comment is immediately superseded by the more specific one
that follows it. The third ("Open /proc/self/mem for writing") and the
inline comments in run() ("Seek to our test memory location",
"Attempt to write to our own memory via /proc/self/mem") all describe
what the API call already says. Are these needed?

--- [PATCH 3/3] ---

> +/*\
> + * ...
> + * This test validates the ptrace-based memory write mechanism that
> + * becomes mandatory when CONFIG_PROC_MEM_FORCE_PTRACE=y is active.
> + *
> + * Test flow:
> + * 1. Parent forks a child process

Same RST issue as in patch 2: no blank line between "Test flow:" and
the ordered list. Should a blank "* " line be inserted there?

> +	for (i = 0; i < TEST_ITERATIONS; i++) {
> +		/* Verify parent's write from previous iteration */
> +		if (*shared->test_ptr != shared->expected_val) {

The comment says "previous iteration" but the parent writes
expected_val and *test_ptr, then resumes the tracee. When the
tracee executes iteration i it is verifying what the parent wrote
in iteration i -- not i-1. Is the comment wrong?

> +struct shared_state {
> +	int *test_ptr;
> +	int expected_val;
> +	int result;

The result field is assigned in tracee_main() (0 on success, 1 on
failure) but is never read by the parent. The parent uses
WEXITSTATUS(status) to detect tracee failure. Is the field intended
to be used somewhere, or is it dead code that can be removed?

> +static void tracee_main(void)
> +{
> +	int i;
> +
> +	/* Allocate test memory in tracee's address space */
> +	shared->test_ptr = SAFE_MMAP(NULL, sizeof(int), ...);
> +	*shared->test_ptr = 0;
> +
> +	/* Make the page read-only - parent will need FOLL_FORCE to write */
> +	SAFE_MPROTECT((void *)shared->test_ptr, sizeof(int), PROT_READ);
> +
> +	/* Signal parent that we're ready */
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	/* Wait for parent to complete PTRACE_SEIZE */
> +	TST_CHECKPOINT_WAIT(1);
> +
> +	/* Initial stop - parent will write first value */
> +	raise(SIGSTOP);

And inside run():

> +	/* Fork tracee */
> +	tracee_pid = SAFE_FORK();
> +	...
> +	/* Wait for tracee to be ready */
> +	TST_CHECKPOINT_WAIT(0);
> +	/* Attach to tracee with PTRACE_SEIZE */
> +	SAFE_PTRACE(PTRACE_SEIZE, tracee_pid, NULL, NULL);
> +	/* Signal tracee that attachment is complete */
> +	TST_CHECKPOINT_WAKE(1);
> +	/* Wait for tracee's first self-stop */
> +	SAFE_WAITPID(tracee_pid, &status, 0);

And in the loop:

> +		/* Update expected value for tracee to verify */
> +		shared->expected_val = write_val;
> +		/* Write to tracee's memory while it's stopped */
> +		SAFE_LSEEK(memfd, (off_t)shared->test_ptr, SEEK_SET);
> +		SAFE_WRITE(SAFE_WRITE_ALL, memfd, &write_val, sizeof(write_val));
> +		/* Continue tracee to verify the write and stop again */
> +		SAFE_PTRACE(PTRACE_CONT, tracee_pid, NULL, NULL);
> +		/* Wait for tracee to stop itself after verification */
> +		SAFE_WAITPID(tracee_pid, &status, 0);

These comments ("Allocate test memory in tracee's address space",
"Signal parent that we're ready", "Wait for parent to complete
PTRACE_SEIZE", "Initial stop - parent will write first value",
"Fork tracee", "Wait for tracee to be ready", "Attach to tracee with
PTRACE_SEIZE", "Signal tracee that attachment is complete", "Wait for
tracee's first self-stop", "Update expected value for tracee to verify",
"Write to tracee's memory while it's stopped", "Continue tracee to
verify the write and stop again", "Wait for tracee to stop itself after
verification") each restate what the API call or macro already
expresses. The coding style rule says to explain why, not how. Should
these be removed, retaining only the comments that explain intent
(such as "parent will need FOLL_FORCE to write")?

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
