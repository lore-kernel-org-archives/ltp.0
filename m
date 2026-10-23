Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A6606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AO8UlPJ6
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3535D3EA538
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 19:51:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D641D3C52F3
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 19:50:48 +0200 (CEST)
Received: from mail-pj2-x06.google.com (mail-pj2-x06.google.com
 [IPv6:2607:f8b0:4864:39::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76D55200141
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 19:50:48 +0200 (CEST)
Received: by mail-pj2-x06.google.com with SMTP id
 98e67ed59e1d1-3ad41dad3faso724915a91.1
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792777847; x=1793382647; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJa0jYIIDW6aZg1tpBf9xAOSEegviMs3TbdEtUxhYWI=;
 b=AO8UlPJ6//noJ9+maYy/K5KzZvIXIcaz41SG7JRwJmO0xG/i4JUP8NPt4doqiNW9RZ
 sa/14LnIg5EGdYDZs4OGP1lYr0lPC1gUIc26koJhESgW7bx5xeNKOTKgLGSNj2e+5Gvl
 wQJXHZDDp+6Q0/gLnDhjcRImYAPPIT8bFf1bq8DDVM5GeC78pj5ktOSucN6FWrNkyQTs
 5rXMo1XAfRs6fjpAHQkpdV1dfjvep46LlVJrDKvbgSaOQH2zKFXKAT0E7SGHVURcsE7l
 T3M2SNMeeuNGGfUFdtoyKZhdtTyWKuD+HhqHQM69/oV4D/gDPFMBVm/SRqe0p+85recA
 ksVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777847; x=1793382647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJa0jYIIDW6aZg1tpBf9xAOSEegviMs3TbdEtUxhYWI=;
 b=XJChg24ndvfrYZPNs79fLDv21jP+GfIqKHs5Fr9HDLqG3I81LVd6fA8PasEpfgd11L
 +Cr6r/h3e6OGkNsxFJYWZG4X4oV6nR5IA8qXcDlY5h641gbimJllUF/HvMQwYjj5ea3s
 0Cbc9hu0l/KjNEPBqirgf0M/55Yh3Y8l3C5CvT4hcdhz9xpOZVW0Ve/pzx8J8lj/HF8b
 cqMiDC+dHu1zx4JBLm2InD/rTMjuXhUdKh+5RtsvjKDXfq6t+F/1443GjBChTrj/fcX0
 QYXKi8PJ1Z517oP6ZCbVXFc7xTWiM6BhIRbLMZCACwOZW2Ydbm1L9VPSFo30qOaX8eEs
 O2mw==
X-Gm-Message-State: AFq9FYLWtD5OSdFRmHVE1ojmyPJJNPrT94BEepd3kfjkIZ7mBLxpxAlb
 MW6YTm9LccKRZnXEKWzNVPHLYsedLFB2Y30g6TKTKvJ4ocJOETDc6NcV
X-Gm-Gg: AYBFou2l7E1QfQUXgJeOyRUYKbHqIwq5FSTwVIMrLH3/u06ZtjVlfu35mlqaBUO4wCi
 7BOvG48nrrZdBFsF7plSgfhqCiCmUNGq6rUazEca9h6eOI9+fKJcJ+mnCBu3Y4kpBzcwqMWIG/z
 IkRwetmdGtH+82CNGO/mapbc3TkB6s8uBUZ36vWR4SVEOXgwmZmiZo4xcL2Dy511ke8oLaxxJxt
 7CqCPbIGqR1jd0ze6+s+pT0SPUS7+cwTjpClUDo26RJ3929+0ceQnfGQGqbHHqaxl8gntMLt6FH
 LR5QMEBXEbx4/18AIoGrZGmmsIduQDcDyJo/bxdbR53s8VSQq+DrN79wOp/UYzouUSnBfDbKr7B
 CVxCuPZRHN8Zwbu+7mn5UqJ3ZrVwIbYIBSXTnujgjOBlwPEEp8MpIjTno3exNaTMz4y5+w4DTn0
 ionpCQKIpLxJ8MeoHPWLFYZHoIkf+ZrJvBUXU9LdljFt28Gqyqz5i34VdxFBFCQ/qfHSd20DSDh
 pzPtID+vH9K6s+YekccFRB//tVUhnwSlYZyY/8aaguUTkXnkHdIVO7nEQh3xylXPMQ/UIt3ecQr
 PhfrOynHoNxcE5LsKRf1Iirzspg6cpgy2Xg6bPGCRcmP7hJWDQgerFO9T5Vqoa5mLPk6xTE=
X-Received: by 2002:a17:90b:3842:b0:3ac:8527:3fcd with SMTP id
 98e67ed59e1d1-3adeae8b8f4mr46491a91.39.1792777846774; 
 Fri, 23 Oct 2026 10:50:46 -0700 (PDT)
Received: from
 runnervm8k3b6.hoohsil4ppjutajargwo53mdib.xx.internal.cloudapp.net
 ([20.120.156.212]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adde914acfsm950039a91.10.2026.10.23.10.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:50:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 23 Oct 2026 17:50:45 +0000
Message-ID: <20261023175045.40320-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023123436.1274448-2-anders.roxell@linaro.org>
References: <20261023123436.1274448-2-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Install the .args files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Anders,

On 23 Oct 2026, Anders Roxell wrote:
> openposix: Install the .args files

--- [PATCH 2/2] ---

> +++ b/testcases/open_posix_testsuite/scripts/generate-runtest.sh
> +find "$suite" -name speculative -prune -o -type f \
> +	\( -name '*.run-test' -o -name '*.sh' ! -name run.sh \) -print | sort | \

Medium: On an in-place upgrade, this scan re-enables obsolete binaries such
as pthread_detach_1-2, which was removed for testing undefined behavior and
is absent from the current run.sh. Generate entries from the current build's
install manifests rather than scanning all files left in the destination.

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
