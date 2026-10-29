Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35708606A31C
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=05kPo39s
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B619D3E999A
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 20:57:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3433C74CC
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:56:56 +0100 (CET)
Received: from mail-qv2-x07.google.com (mail-qv2-x07.google.com
 [IPv6:2607:f8b0:4864:33::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 295566009E8
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:56:56 +0100 (CET)
Received: by mail-qv2-x07.google.com with SMTP id
 6a1803df08f44-91b8216ae32so33866d6.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793303815; x=1793908615; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CtZhjSj4660eCYyToPHFAAm5m8bQYXPvYqYi9JcI8s8=;
 b=05kPo39s807PV0qJ0UQrKCmBz66vgiV4SOE9oUyuvOvJHR/Psw8YUFh3mPTh3qawQy
 ahwEYqxLdXzuKhmFUV7BLi5lu/0YCyyuZtAIr9vPMMvXA6JXw7S9aw94mh+bXppHc6ki
 OpmUZZnjQAbebIZsEQWiLwhEIbNiglBBxNE5XfeaIAg0h/XHwrMfv2VCtnTJtFhvsZVM
 MQ+vdLWgsZtXwsUbZD4Z0EQ/I3lKHtBsnYr4cNAxQYniq/Rwg+S53lSN34KZR2qdxMSy
 K0XjOcScVj7dTLSabHoi4R5tUxG1RtnXrhvkjIZJG8WFY5Qp4RUO+brwrtlVQWzQt8Uy
 8Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303815; x=1793908615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CtZhjSj4660eCYyToPHFAAm5m8bQYXPvYqYi9JcI8s8=;
 b=THveSJd8wqCQZhLyjGDGwb9Lnih9Vjrt7gqGoSJS1D5vU0VgzJj2fU8zqzwnfCu+Cn
 nt3/p4bAikes+kfJQ8yw2Mo2YY0SXHNs1ojNkHdm3M7pMOHOe9zuOQfYqYom3/4PKKGi
 Sp7YZ1KTghMDzLvJC6IzQAcwHoGFtukKftc7PW56OkBLjLu3qAbm3F6p5xzktkPEPfLA
 JUdPmsYbvicWaNmeDyFaBXRC4xPUcPeFaAxWtAg37b3xVGsrF190fYNAPWZ/iOjB96vB
 WfxRUqDB64EmZy59Mc4JFlKv6INLVRZfu/tGJYbQ9696arEFUsa1ql3CWLlGi4WLzKL1
 qS8A==
X-Gm-Message-State: AFq9FYIikiy4QlOfSnXQUmQBmbtBsABTx7cxYyb3VbKXTpT8F/z6ZiTx
 bfshFlyK2k/ktpRu6qNtZS4w/qIui6xo2Sp+k5hVWcqFihJ2J2ANpBkA
X-Gm-Gg: AYBFou1+rnom8splVi1JI9MEqRhBwXuluyd4VO5sfmblCUXuYQMmhk/OklyLFJVTCt/
 D+FMi3wptuWRMXOiocP0hQ/b8umZ2TdGDX0O9PhuDAVguOOmkfb6T1hnW196PVcYqQc8VplGzvX
 42a+rno639vvOBRuQPlrX3RCDMrE2GrSwM0euZh6tvg2JBHaElNKRmqbc0ua6F9PVaQNHMA1UEw
 BnjKK2hYY7wS2QWAPXqzeH3PoCyPaWpMachTKDLDrwwbLzRj6sYtmTekYEdjh6JupnXmPEFN4aY
 4iL2lN2jGsbPOmxxjIbcy6xnBpPfEkOBGrt5/Jb49t+hnOp+Rxa7UyYTzvdySfCXbodHQwKlLaj
 75vC8DP5MvWaOuDWaK+qFBI8pCpYIyBrFZMbEYe5RuDXvrPQibh2QUAi/jWJZNREq6QF3xkIicQ
 x3KoZQe48+BlmXilenicGrU9yBF0DHpmvHR/O6Y80J7j7iRnGnNZnVzqXenGjob0NFpgPv3Wsl3
 XC000OFOHlpVxyp0NLqaPnCl8ZXoHMXBAGmunCUC+tUXxbza2v4Pv45iL0xyOklgGlJnVGWZF4D
 5asOC/sZF3ULk4QYzWfMgOKKUhKdmDYNHEsLlJUrIN54dKAXsx00FsmPrATyH/sbWBBAPKJQsmZ
 epozXZkFD62tIAH9+aM/ItQSBIaz2hlKxBAvFSHa3
X-Received: by 2002:a05:6214:4893:b0:91b:87cc:6d3e with SMTP id
 6a1803df08f44-91ca4a0cf68mr428436d6.1.1793303814784; 
 Thu, 29 Oct 2026 12:56:54 -0700 (PDT)
Received: from
 runnervmnwato.ndmgsow0hvbefolkprppcyhase.bx.internal.cloudapp.net
 ([20.55.87.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca2fb52e4sm4969076d6.6.2026.10.29.12.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:56:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 19:56:52 +0000
Message-ID: <20261029195652.3767-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028051518.22982-1-dennylin0707@gmail.com>
References: <20261028051518.22982-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inotify13: check rename cookie pairing after adjacent
 moves
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

Hi Hungyu,

On Wed Oct 28 05:15:18 2026 +0000, Hungyu Lin <dennylin0707@gmail.com> wrote:
> inotify13: check rename cookie pairing after adjacent moves

> +	len = SAFE_READ(SAFE_READ_ANY, fd_notify, buf.data, sizeof(buf.data));
> +	SAFE_CLOSE(fd_notify);
> +	fd_notify = -1;

SAFE_CLOSE() already sets fd_notify to -1, so the manual reset to -1 should
be removed.

> +static void cleanup(void)
> +{
> +	if (fd_notify >= 0)
> +		SAFE_CLOSE(fd_notify);
> +}

Use fd_notify != -1 instead of fd_notify >= 0 to check whether the file
descriptor is valid.

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
