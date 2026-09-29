Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF2CA5FA1
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 07:14:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 056C83E201E
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 09:14:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 857BD3C5E52
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:14:37 +0200 (CEST)
Received: from mail-dl2-x08.google.com (mail-dl2-x08.google.com
 [IPv6:2607:f8b0:4864:38::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B63AD60043A
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:14:36 +0200 (CEST)
Received: by mail-dl2-x08.google.com with SMTP id
 a92af1059eb24-1379d236149so1140116c88.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790666075; x=1791270875; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lRLi72xXMgbGdKN1X93qlrivqUyEoiqx+Ky9EyVVbnY=;
 b=O212DUe7RkCwtIN1J/5c3/uEy5rhTrGS+80hCZT7Bt4BEab5MOuEea2r5ZS8lI3Hjk
 9dTqnr/BiykkDK9Jz1LhiLayzCK8SFPlgetzHac0Zl29HOjL8EC+i9o/e4oJpooq8Fk+
 MpTBgP1kM70TpZwU6o0sdWAcbjy/5CpYHgL8yUrEk0Jyc+gIvC9qbcR6BJRdXK6zQbgI
 G5L1NmCjaeVT0gFqf0YxGmy7AbImgj6AKQkh1nXFIrjxnuMEnZz3pXn//HOKVDXNejrs
 i0TZcKkIuAT8NOtmp96ReKJ8qdaO+So2rQ+3kTv4Lkqncf2IXfm+JxRyJ+s1S04Th+Kb
 O5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790666075; x=1791270875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lRLi72xXMgbGdKN1X93qlrivqUyEoiqx+Ky9EyVVbnY=;
 b=RFVHYM3EXKBzjUekkJTOivsF3oL/lxluEtTDICLrS0Bf46ia0Y4iqOkzORurFD8CdR
 bC8wkKy47n5EKVYQBvspuF0+HhbqhEWbmkUF+2Lb6m4lon0yZWcdWVOvYbTMiMZNqUZL
 H00iP7CN/xdPaWJ0vOVtjjFzILPwHrMRNJcPAIUkfQtH3UdcSvi6OHhEI+9Tlh6yj3ni
 4hFfaCidlUmOZEvBGBkH+15kzXzovPJ6wFLlAbgSB7u11RXatPqoV/8Pj0B4nldn6n5b
 xL/+/67WB4scGEXykZsIerQ0VPcqEB6l0m6TW7CCGxm+OmSV+Hs+86JKbC18+ZGHfEqu
 LATg==
X-Gm-Message-State: AFuF++kryITY0UE/QkAP0AI5SkpbDZFX3DRCoos3b4gzB7qMfziwY+qQ
 wj8CSdEdfg4/gy7EvjmKuvsoA/rgCJ6R+ACpeHTiaNKauB+fzkSCeCkgMZny834iH0I=
X-Gm-Gg: AYBFou1HabdE089WkgUKy6hS7zPMZdaHrfjWhasVSijWa04jxM3Xw+oamipJBqIfea3
 xgjI+R4rP5QwYihpHYIHJIABO2t9t30Tj7rL0RHtdLgc81Nys7kZkNiGb2YlhmPnj8VKwUqwUqf
 kMUhHJ+ZeUyi/Cq1Pi9BMRRAsE/v1ALWlLUaX1K/xXEuMENxU7x0NVhXwHwOvtc/gTRuVrsDxyQ
 S0INcvicg+TdG6ufjZVmkn0S9enDkrxssH57gUDWEHlxFrfcYxGeFYB+UEzDHEao1NiAuon3OZC
 qfBl8bYdNDaRJDkyXXP9QcQ2YSd/lFyqal2iX4EXGXvmwnR4Jv0RqLuDARWxlMfIxli/2jWn7Oh
 XhwVkmB+XTRiownie9Ty/UVh7XVzriUmn/A/Kkt185fI2c2Xvjsxo4+amYEPLq55PqcqYkgkPiT
 7lVXIW8YJ9+H/R3z79BpACrQbL0XovPLMERKfJJ5jAC2wJwS3oGl9aHh5JRbomrdCDzf0G/dY83
 Vberv+KXUI9dlegtGu73WzHLrYejkwYpEyYz0NdnKDaRpUNP3j6c6eDGIxunRlFd+wo1UBgip2I
 Ts+sx/u00iaqUw==
X-Received: by 2002:a05:7022:7f1c:b0:14a:a252:26 with SMTP id
 a92af1059eb24-14aa25201femr3873966c88.23.1790666074882; 
 Tue, 29 Sep 2026 00:14:34 -0700 (PDT)
Received: from
 runnervmtr4k5.2d3rfvfmjhjefjhab21txvevkh.dx.internal.cloudapp.net
 ([172.184.173.245]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acd3d8eesm28538304c88.8.2026.09.29.00.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:14:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Tue, 29 Sep 2026 07:14:32 +0000
Message-ID: <20260929071432.9277-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928051740.591819-2-samir@linux.ibm.com>
References: <20260928051740.591819-2-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup: Add cgroup_burst01 test
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

Hi Samir,

On Mon, 28 Sep 2026 07:17:34 +0200, Samir Mulani wrote:
> cgroup: Add cgroup_burst01 test

--- [PATCH 1/2] ---

> cgroup: Add cgroup_burst01 test

The test and binary name is cpu_max_burst01. Update the subject line
to match the test name.

>   TC3 - A worker underruns to build up burst credit, then overloads
>         to consume it; cpu.stat nr_bursts and burst_usec counters
>         must increase. Also checks that burst can be updated while
>         tasks are running.

The test code never updates cpu.max.burst while tasks are running.
Update the commit message or add the missing check to the test.

> diff --git a/runtest/controllers b/runtest/controllers
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -3,6 +3,7 @@ cgroup_core01	cgroup_core01
>  cgroup_core02	cgroup_core02
>  cgroup_core03	cgroup_core03
>  cgroup		cgroup_regression_test.sh
> +cpu_max_burst01  cpu_max_burst01

Use a tab character instead of spaces between the test name and the
binary path.

>  * Test scenarios:
>  *   TC 1 - Default value and write-zero: cpu.max.burst defaults to 0;

Insert a blank line before the list in the documentation comment block.

> 		if (err != EINVAL) {
> 			tst_res(TWARN,
> 				"tc2_burst_exceeds_quota: got errno=%d (%s), expected EINVAL",
> 				err, tst_strerrno(err));
> 		}
> 
> 		if (burst != BURST_US) {
> 			tst_res(TFAIL,
> 				"tc2_burst_exceeds_quota: burst corrupted after rejected write (expected %llu us, got %llu us)",
> 				BURST_US, burst);
> 		} else {
> 			tst_res(TPASS,
> 				"tc2_burst_exceeds_quota: burst=%llu rejected (errno=%d), stored value unchanged (%llu us)",
> 				bad_burst, err, burst);
> 		}

If err != EINVAL, report TFAIL instead of TWARN. As written, receiving an
unexpected errno still reports TPASS when burst remains unchanged.

> 	read_burst_stat(cg_child, &after);

Check the return value of read_burst_stat(). If reading cpu.stat fails,
abort with TBROK rather than proceeding with zeroed stats to TFAIL.

> 	if (cmd_pipe[1] >= 0) {
> 		SAFE_CLOSE(cmd_pipe[1]);
> 		cmd_pipe[1] = -1;
> 	}
> 	if (ack_pipe[0] >= 0) {
> 		SAFE_CLOSE(ack_pipe[0]);
> 		ack_pipe[0] = -1;
> 	}

Use '!= -1' instead of '>= 0' to check file descriptor validity.

--- [PATCH 2/2] ---

> cgroup: Add invalid burst test

Name the test explicitly in the subject line (e.g. cgroup: Add
cpu_max_burst_invalid01 test).

> diff --git a/runtest/controllers b/runtest/controllers
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -4,6 +4,7 @@ cgroup_core02	cgroup_core02
>  cgroup_core03	cgroup_core03
>  cgroup		cgroup_regression_test.sh
>  cpu_max_burst01  cpu_max_burst01
> +cpu_max_burst_invalid01  cpu_max_burst_invalid01

Use a tab character instead of spaces between the test name and the
binary path.

>  * Test scenarios:
>  *   TC 1 - Boundary and sign violations: burst = quota+1 (B) and burst = "-1"

Insert a blank line before the list in the documentation comment block.

> /* MAX_BW_US: kernel max_bw_runtime_us = (1 << BW_SHIFT) * USEC_PER_SEC */
> #define MAX_BW_US	(((uint64_t)1 << 20) * 1000000ULL)

The kernel defines MAX_BW as ((1ULL << (64 - BW_SHIFT)) - 1), which is
(1ULL << 44) - 1. The current calculation is too small and does not exceed
the kernel limit, causing tc2 to always take the TCONF fallback path.

> static int cg_write_str(const struct tst_cg_group *cg,
> 			const char *fname, const char *str)
> {
> 	int fd, saved = 0;
> 	ssize_t n;
> 
> 	fd = SAFE_OPENAT(cg_dirfd(cg), fname, O_WRONLY);
> 	n  = write(fd, str, strlen(str));

Use TST_EXP_FAIL2(write(...), EINVAL) rather than calling bare write()
and propagating errno through helper return values.

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
