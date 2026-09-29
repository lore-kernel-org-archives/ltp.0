Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB0ECA5FA7
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 22:04:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0683B3EAA8E
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 00:04:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB89D3E56E7
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 00:04:10 +0200 (CEST)
Received: from mail-qv2-x07.google.com (mail-qv2-x07.google.com
 [IPv6:2607:f8b0:4864:33::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B60A200B3A
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 00:04:10 +0200 (CEST)
Received: by mail-qv2-x07.google.com with SMTP id
 6a1803df08f44-9179b9a4529so331636d6.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790719449; x=1791324249; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LfpP8aaDyTW9DJbGig91IOPuPmDBVRoMTRE2+AzZfwo=;
 b=Z2/SxFtAKxgYHCKGRJG1lJNb/VdY9k0w65BPwc6xpY/MLvBjKwI0y6JLpOOaOgRJ57
 cN13c3LtcfTLRX1Pd5TVmeKXcoYhnvSK/LNeOSSEIAf23PGIzCag5Y2gvudxVpGks/ud
 MEj4w58ImoK1yDxkeJ0OSQkpEXIntdS0B50CKbbN/+OZCR46P8lyRt+sIorWO0uyEdFc
 SMgn+6k5Yl67BlEw7HKOsDcGX2CinoS3p7S/NHUz5YjtsENHQFK0Akvaz55MwVbhcBJM
 wyI/MYSRcoK7EgqmvtcuH1+nbKEYm2r+lrjNLKsgU9B1VaFCnfVKqr9u8EY+gb6LEeFW
 iZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790719449; x=1791324249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LfpP8aaDyTW9DJbGig91IOPuPmDBVRoMTRE2+AzZfwo=;
 b=yDdgU0TCMcaid8eknNIKAgYb7HMosar86MsjM6BGUW5QQzFsv6Klx35gqdRG/v7XGe
 QZuwzr90Qe27w8gBNmtQ37F9/bdfdXMWwVRbCcUwrHsgM/qphOojqQ2DhHv6zMPczPkp
 N63UyYn1Y2rOqpLcDy92xLjXcZ1vPkju5CSOiUhvKVotOKuUdkJ1MHmkjbclFfGcZvVJ
 +uaAO+j6gy3OhcabxOlhuaB5C5cFh/DbUB2srVnTFFYlg4nTytreJozxkLfKwreP+He2
 b6TP7uweQ5t9OU1423Jctc97QCyJrDRnKjcJVTMle6yNd607SeHzV7AGW7EPVYqT+XvA
 63GQ==
X-Gm-Message-State: AFuF++nEXoiX3BlveIdqmXg3TK/JHzGWjb0VtpgkV8bCuiNU5YNdvsby
 HQJdvO1NZ1pyIOJcVJ2X225T+S2Ctxr99776teHMQ1Vd2dKhaDbvAJ/6QomNYrUf
X-Gm-Gg: AYBFou0lcwIXYNO+Qy+QRRgoeh6/gWhUZcR5JkZHyuOTRAyCJ/fiUIGUWkXJElqYU2w
 CCOperh/A7YjUTJ5CzfQV4NdsTRxZBoJsjLtJssPPIWmnVd5kE+xDaLFnMsw8bukgXDZm5HG2VX
 pTt46krYVGSD0coo9MHEEPmqDbVsnCa8LqdQrIZxetr3BE7LISotUzmdgltC3U11T5Rdl9CxU7H
 mljqOQ9eYcFdN8BiqbLbsyEm5MDUJUxac1MtU1PhwLd9yxJ3aqauQ7+ATEc41PJ1qiOFIAoJWnj
 zXxB3tH5EYUaY2Cb2xwqgN7a3TItfyAnU2GOeM6s8HjDcnrBjhhGJ0VmieeqQGZwF6IObUDgddg
 2U8obHq0+eMP81OhzfFInxDzdhCeVJ1MPOh0JCQuI7chD5R+avkphEaMH3mvdM2la/IkGKRsAwF
 W4hY7UTmjkGRjdkoU9k5+wr/YlV+1CWnkVOFGyqEktVzqqbnvBBX4qdOtlRQY6OwQpx0VNClfKE
 /uz/YM7+HVSwqAwf+ffC2lXiQsJiO1cxKfn/xxh7NV1A9egVdbgHEZHEwpZKhjxcPpVd3RKa0Zf
 bnzJ+zeV7A==
X-Received: by 2002:a05:6214:5d93:b0:912:6380:fe12 with SMTP id
 6a1803df08f44-91799a29603mr10861376d6.8.1790719449192; 
 Tue, 29 Sep 2026 15:04:09 -0700 (PDT)
Received: from
 runnervmtr4k5.hdryostwtogu5fpu5w2elnmblb.bx.internal.cloudapp.net
 ([20.119.87.97]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917987a39dfsm5366826d6.8.2026.09.29.15.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:04:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 29 Sep 2026 22:04:07 +0000
Message-ID: <20260929220408.34912-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929193119.912502-1-avinesh.kumar@suse.com>
References: <20260929193119.912502-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: fork() to isolate the
 SIGSEGV on old glibc
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

Hi Avinesh,

On Tue, 29 Sep 2026 21:31:15 +0200, Avinesh Kumar wrote:
> openposix: timer_*/speculative: fork() to isolate the SIGSEGV on old glibc

>  * Test to see if timer_delete() sets errno==EINVAL for an invalid
>  * timerid. Since this is a "may" requirement, succeeding or crashing
>  * are equally valid outcomes.

POSIX "may fail" requirements define that returning -1 with EINVAL or
succeeding are valid outcomes; crashing is undefined behavior due to
pointer dereference on older glibc, not a defined requirement outcome.
Please update the comments across all four tests to clarify that returning
-1 with EINVAL, succeeding, or crashing (on older glibc) are accepted.

> +	if (WIFSIGNALED(status) || (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
> +		printf("Test PASSED\n");
> +		return PTS_PASS;
> +	}

WIFSIGNALED(status) without checking WTERMSIG(status) treats any terminating
signal as success, which masks abnormal process exits (such as SIGABRT or
SIGSYS) as well as test cancellation (e.g. SIGINT or test-runner SIGTERM).
Check for the expected fault explicitly with WIFSIGNALED(status) &&
(WTERMSIG(status) == SIGSEGV || WTERMSIG(status) == SIGBUS), and use PTS_PASS
instead of literal 0 for WEXITSTATUS(status). This applies to all four tests.

> +		if (timer_delete(tid) == -1) {
> +			if (errno == EINVAL)
> +				_exit(PTS_PASS);
> +			_exit(PTS_FAIL);
> +		}
>
> +	printf("Test FAILED\n");
> +	return PTS_FAIL;

Printing only "Test FAILED" removes diagnostic information when the timer
call fails with an unexpected errno, violating Open POSIX result reporting
rules. The child should print the unexpected errno before calling _exit(),
or the parent should report the reason for failure before returning PTS_FAIL.

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
