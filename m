Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCC606A31C
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eaV6eCz4
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 372953EC36A
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 05:51:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C85E3EC2A2
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 05:51:23 +0100 (CET)
Received: from mail-dy2-x01.google.com (mail-dy2-x01.google.com
 [IPv6:2607:f8b0:4864:36::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3E646006D7
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 05:51:22 +0100 (CET)
Received: by mail-dy2-x01.google.com with SMTP id
 5a478bee46e88-36f758312e0so112657eec.0
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 20:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794977481; x=1795582281; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZS4XI6+12llJHLkHDShuNSIUStP6SDNZStHE+mmqcoA=;
 b=eaV6eCz4GJ0b5QKFftKveQhG6StF3VmerAoZgQDXzMUgNV8XTeJiTzLCKdbkMnQQiW
 MZapirFZjixxkxBXMJHiauH///Be5hxk78BCeT1t6QHdJiFHU8EVLQ5uhrofARu8IVtO
 9gKJoZJS/2a+4uSbFJ+ELO7/1nXQqBki0x1DQj1seoDFjtqSyKXcgWJRQs4OB8awqjs2
 cco/Kjuq9hbEEsBv6PDoWkrewSr2vGh/54DoDQmtxzhDw4BdfM/OouUBZMFEnmjL54of
 NejdXAGVwgdzVTaGjBJsrGCdpPFYM9wYwQJDq5RGeslFcqZYU+cz7X3OwDGzgcx02JEl
 VQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794977481; x=1795582281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZS4XI6+12llJHLkHDShuNSIUStP6SDNZStHE+mmqcoA=;
 b=ujHLcDHft5Ied3rVII8cB2zveP+5/ly42UwMVNuYhYUHufZkENX9R9tVcMxo5yn+uA
 VE/x4DMEmDd8nFaPZRqjUhlYKvjAQ6BquTk4o2MIWfkZeQ7NZ7rJmyvgsxABuf5Pnxxe
 2ZSEpvVaiq93LribCutbAkzR79Z74yYm3XWY1v+Tm/ivwSYWVDih7u3j4TpUjD+AeeiG
 4RyK06Fv8F2Wdmwn8KowLVqhps1VAcY4ZmHJ+WjJb3d3A3cDh+X+mfMGmTclRmswKi6l
 ev9lGdU1SePuaGJ3rdXV3zfZkOCVxt8xp06Nrr4xKhqsnODlDBhFWq3NuWDYqlsKSdfy
 HTLg==
X-Gm-Message-State: APuU4Z8AzTxvCW2lGflFxceXTnKOPpHpQlw3kFVeSLhFjAYMQXeAsBlc
 fWNArgdf5Jvd3USIB+22Myl51KM7FuVlJf2pXETzkAsEUv1YtQt6CJKd
X-Gm-Gg: AZFdTZcF25broLjBtTJugf0266/i0Om4Z4nr6bmCuhrBIEEI8FybAdV4UyM0jQiQflr
 vZ/PuACQFY77/HtrAnS5gKha2R2hdOZiODvJGar+fXN3wh1R8jWjqHCUL5195K+eYk/NiJzAd7N
 sYCeG3on2LcnYm/fDfsNIeppVt6oTwBTgfSMIXfAfdFmWa0ndKv911unsVn2o04nr4mklcEJ97m
 3/sQWh93upIhXRGKGQ+yOjJ0Usw7yatq2TtzHRHYd3XVecjZkEi7J4jxs9y1rIGRML97ilK3n+5
 eHREPZhHCzi5ZW05EyZRH1ToqoxVHC0pUBrBqJqRIThMQ/oDGCjNg0fipwueORRYuyZFT6IGtWx
 pGCzSTzNXWsp+Pvto00MqALTIXg0BqLFDqDnNRXw0vCe0Tlvo5fab0jbl0Y+mzrmzkOx/thD7OG
 juU1TIuZ5LJc6FxscYrIf7Knfxrhn+mGjxcHlY49FkW5k93lQz4Ik2CN22e6HwKv9wVSn7FV2xs
 47QoHUi8TETS9l2XYTfiHg911KT6Cw8STtjp8UE1MrXGxSyvFDO2Pl2L7C90OE25DDAMUmlga2+
 ureacJHPqZnIAp+OXytLUuZw5X3xJd3Sktjes2m3AjAU+VuwQOEazG9WyLwt31r4NbMwjyrnmkL
 i2KjXSdIzxfCK8QihVOptjebe7qG6sx1uPiauixYgmA==
X-Received: by 2002:a05:7300:fc14:b0:36f:5746:3364 with SMTP id
 5a478bee46e88-38281215bb8mr1461007eec.28.1794977481007; 
 Tue, 17 Nov 2026 20:51:21 -0800 (PST)
Received: from
 runnervmccnms.ra0ajkgn5sserj5qestw0c00tb.dx.internal.cloudapp.net
 ([52.250.243.99]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a75d401fsm2882368eec.20.2026.11.17.20.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 20:51:20 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed, 18 Nov 2026 04:51:19 +0000
Message-ID: <20261118045119.4764-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117232036.1228445-1-sbertram@redhat.com>
References: <20261117232036.1228445-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] network/sockets: Add handshake01
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

Hi Stephen,

On Tue, Nov 17, 2026, Stephen Bertram <sbertram@redhat.com> wrote:
> network/sockets: Add handshake01

> +static int unprivileged_done(void)
> +{
> +	int fds[2], err = 0;
> +	pid_t pid;
> +
> +	SAFE_PIPE(fds);
> +	pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		int ret;
> +
> +		SAFE_CLOSE(fds[0]);
> +
> +		SAFE_SETGROUPS(0, NULL);
> +		SAFE_SETGID(nobody_gid);
> +		SAFE_SETUID(nobody_uid);
> +
> +		ret = send_done();
> +
> +		SAFE_WRITE(SAFE_WRITE_ALL, fds[1], &ret, sizeof(ret));
> +		_exit(0);
> +	}
> +
> +	SAFE_CLOSE(fds[1]);
> +	SAFE_READ(SAFE_READ_ALL, fds[0], &err, sizeof(err));
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	return err;
> +}

Call tst_res() directly in the child process and terminate with exit(0)
instead of _exit(0) rather than sending the result over a pipe to the
parent. Drop SAFE_PIPE() and SAFE_WAITPID(), as the LTP library propagates
child results via shared memory and reaps children automatically.

> +static void run(void)
> +{
> +	int root_err, child_err;
> +
> +	nl_family_id = resolve_family(HANDSHAKE_FAMILY_NAME);

Move nl_family_id = resolve_family(HANDSHAKE_FAMILY_NAME) to setup() so the
static family ID resolution and TCONF check run once instead of on every -i
iteration.

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
