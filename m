Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F8606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdzn7YdI
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEA1F3E96BD
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 13:16:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29B5F3C9C7E
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:16:25 +0100 (CET)
Received: from mail-yx2-x06.google.com (mail-yx2-x06.google.com
 [IPv6:2607:f8b0:4864:41::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE40E200922
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 13:16:24 +0100 (CET)
Received: by mail-yx2-x06.google.com with SMTP id
 00721157ae682-8b4d009162bso4843147b3.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831383; x=1795436183; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/VqzmTr2lEo1q3+y66qXxzzEM23iMJ7E2IQdQV4m6Ro=;
 b=Zdzn7YdIr/tUZZ6wdw68vazEV2AT0VT7C7CQAFlTlHGg3n4c2kJs9pJ3xcgbSfZikZ
 fOBSUASGiOQ1O9AcaJoQ2aB8fds6Z8ca5A+ONC5pGlcGg/gCUrsv30NBtdx6+tYLnw+w
 ulHvU1GXG2YentIQ9cqJ0oFY+6zkL79tj0XmwYlNHjq4W6fzDrqAPttp0HGvg2xroQbq
 JRgxIHejY2GCbO+ouzvgI11CNOTtDJbpJrBVOneUNLPEcU1Khy+ZEQRYtaatQ50CG8xH
 /y7IVEejChG36SzP7IjTKIZEO5H+qdNUGI7g/+MqrDDTCb02I3nS8hhNnlTZJAeLV1xV
 XPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831383; x=1795436183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/VqzmTr2lEo1q3+y66qXxzzEM23iMJ7E2IQdQV4m6Ro=;
 b=B8TRmAZLipwsQLOzvNf0t5Kt99j5PcGTLlqFGtfvDv9oqOQAEHR/HOj2jPDn0z/aFH
 MVYQOOHnvQYWpb+yLJmZAoGFLZrg/YD8kuxPgf3xIkf+hhgdqjdFJABSNJGs97Vf1DuG
 EBrBVFwO/7PKM/K8rDQuumxKLbGh+SBtvHE4HooTNsaHPKlqZoYNS4T454rIJ7Oq3RRC
 G4AdluHBVhWB/V4/6e9yN1TDv2G3HbWiY4mPHA+CJ4GWbhPoqsUGVb5BrxyuMyBL+pLm
 KO1KQUxaH9CRLjFdp3K51e2IXypyG5BWorKUtKE4F0wnTvNn0SI7o+EYr7AZCdYe/TLf
 mfxw==
X-Gm-Message-State: APuU4Z/XKmcxicQi1Tvg085nFltvYAD6uFbI8XtNyXTIsXtwF70jArxU
 fk6j8XsujnAr4Sq6K9LY/6o7TX9DruOEPrnN/yAWdmDIWCImhWDLEmbG
X-Gm-Gg: AZFdTZeUPmFmhtAgWbPb/qjgWpjT7BSY/p+mJ++5/8mgjOBe5Xoow9PX/86QXyZFVh5
 HyximXkR8GvwXq7jrAeHC0dmswhThxF8ywVoJJxbMCJzMgMGjGaQEFW8Adt78hcxMEsrLLW4Cj1
 BONMslR7Hyc6X90izbxnkUubyTNCryJ/WlG8HnoT4acEHUqReIMFzzXlzSNsUDAepE8GPznEgZ2
 YNJaJDIRWj7wsQfvWo2PJS2zAXiGlx59xmCfdyphoj2cPFvQBjXNGd4ts3UuOrL/r7ntZo0RoaS
 cecJ8WI6IOn8lm3u7LaV5RuhCsVXENq0O826301Npw19lR+5QF2iW06OGxz/WuOBFspy4udCjg7
 EOVj2xDhO6Z1rcGTlIPwebs9kbvTH4cKHumv8fCI7ejIfY9mGaECKYBVyzjK4zrHfC3xsF6bRJv
 2AKXu+P87DJtZPgqHWZU6sEO/AGuhyIt2LVxfMCV2zAdJ1O5Il1Tgsg4oPugNkaxmBBHs3nmkY3
 tejkXIqrR0V8fjqTGyps9ZAVjCHUuxLHKlGpMUyziYNXGukoJsPI3fEJZbL9+4YNgv8L7j/2KFC
 NI3mew3TnLhYhaZIaRz4t6v83mEmg1Cmw/zixVPEL6lrr4dQJDDgyPITgoEdjZYE+4R28HG6vzQ
 LgvRUknF/ldcEnH0pv5UL2jY7RyWtevLlqxNKhyPFo0M=
X-Received: by 2002:a05:690c:d82:b0:8b4:c71b:e4d8 with SMTP id
 00721157ae682-8b4c71be972mr26229417b3.55.1794831383381; 
 Mon, 16 Nov 2026 04:16:23 -0800 (PST)
Received: from
 runnervmccnms.ikcmrumbkutejmfa4rtzb3r0wa.ftyx.internal.cloudapp.net
 ([51.57.154.86]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa9870f7sm83909097b3.24.2026.11.16.04.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:16:23 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 16 Nov 2026 12:16:22 +0000
Message-ID: <20261116121622.4337-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116085612.20171-2-wegao@suse.com>
References: <20261116085612.20171-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_attach_loopdev()
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

Hi Wei,

On Mon Nov 16 08:56:04 2026 +0000, Wei Gao wrote:
> lib: Add tst_attach_loopdev()

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
