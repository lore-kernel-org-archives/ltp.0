Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F15606A31E
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CX5tA84t
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01FAC3EAFB1
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 21:36:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9121B3E98DB
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:36:42 +0100 (CET)
Received: from mail-dy2-x07.google.com (mail-dy2-x07.google.com
 [IPv6:2607:f8b0:4864:36::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3456E10004A6
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 21:36:42 +0100 (CET)
Received: by mail-dy2-x07.google.com with SMTP id
 5a478bee46e88-3831d564bcfso1489024eec.1
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795466200; x=1796071000; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Chv0gUv6ToC0q79yTfpvdjh6g3lKKICr2OJI7qWRNI=;
 b=CX5tA84t/nA0NkCLq01gZ/5l6nv4CZZYgN9XaH4Z8bkFqpvOxNBCevf3EUgfpL+gsH
 kxndhd2mAsyoxoy/NtI4ULNkMicDZAuk/7m88/kNDtrJZUVc55oChVsXOA9aqFuGho3f
 1nQ9OYTHfQOHZesIG8fq/wSrJc00ZFjkN7xpZT2JVnUhd88DtO2eB5bEZI/86V3MaxCs
 6Q+I3vOOkhqx/NSK4a+c+DY7Sk1eBWpEzFJqIELt4Wh4VdvO1rRPlkYvATA7ZggT1u5j
 m5ZqSEWLzry2UWkXqhsNJth2ewa0K+t7Yi+wOENfxO2RQg84OSXzhDK60By22fo+xTxh
 gx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795466200; x=1796071000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Chv0gUv6ToC0q79yTfpvdjh6g3lKKICr2OJI7qWRNI=;
 b=QC3QUEm7eoFE5/p0o44FFFExWVY1QkBNRfJwZZmDKkYrwAUfiOMHud57SLLL3XwIeY
 CTnNYfNncrY1Jk1Vr9lsFbLmtce1pqC+9p3TFYVLEkKKXg+PsGHSuP7Rom8FtsgPUt0N
 1QCVN4wkkWq08vcYIk0GM7BpVdciFZ5ll+GRq5Wt/wRMQMeKMzksTi2mg+ttQOi5ZBqb
 +AChmgGtJW4+PKY8e9yw5bpU+7RgJhwyTzHSTM4vqD9/f/NLvpohmCl5CVk9jDBbasjT
 w7O2MJWcx5LVVHYF655VQRPiziyc8PUrqxmNjhW1WW0O24K0IVaQ/bFXrdfxZ5xIJspj
 TzVw==
X-Gm-Message-State: APuU4Z+DH2Ob7KpBi+CpWlYQs0WheAcN6No+T49yo/OarbJoI431nekb
 Y/XFSy4Nmj1DQ6q3a6MIytpZbbRfXF2OCTRG4j/PDnnmjBovooA5tg4j
X-Gm-Gg: AZFdTZe/LoXtifdjnEnii0781pLKYWqozflufF7NH2r8mu98+LRl78X4e5IacPnC6FV
 +B8IIpaupiNp+bFAx4zdKb0Gijc+0dNAoviQJSVbQblTeTYQXUsGhte1x0oGexyh+M0Rx1xUzBb
 y/EKS13Uc4daAqzx1ZqflrYYpPkPlZOB48Xso2L6FabZieMvYBxHb55WMlB+UkmscvdYxZAKucZ
 5KeZsw1E1W3ZYY/chKZNaXbp7wr+8p45C5fDVvTVPpGRlEZ0dgLLVrh/the3RkqvVht4om6lxQO
 9MssdB8ntfQBVHC3XhW+Qaq0KQdczLFcwh3xT35clnfLYGAjVCN417/DMTbNSaxv8aONbXE9K8Q
 NQCkradrwPIEJDgLoN2pz1xZGLJKVUK5YEYER7RODgOTK/nIuogSOXPO704a5NDCq/6hsJ7AfRq
 WK0V9rjruFoqNATvNWTaMxW4+EWl6lfBOjo6yYDzsKzCvb0ePQXiYlsg+T4wUHR5Vatkb4jrsOH
 cyaEyX48f3Cuez923KqGQDceGIZ9BXU04GmZVPfZQrCNJ62ghwQMKVwozzS3AEIO/Zr/qtAhvSB
 rqRftq1VM9nrcRI3J2RIJ057umshs+rQBjOPsVYzFGjCIF8bag4r4WMITcNb3RZbojrezTTPX62
 bsvXE6ioktC+fTw/PXa1a1lt3brJ5cMAb488G+73me5A=
X-Received: by 2002:a05:7022:b886:b0:19c:c396:37aa with SMTP id
 a92af1059eb24-1b5568e1d36mr11806870c88.22.1795466200258; 
 Mon, 23 Nov 2026 12:36:40 -0800 (PST)
Received: from
 runnervm0hi8g.omvjkrb451xutavd5bjv4x3pgh.phxx.internal.cloudapp.net
 ([20.171.21.215]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b56ef9fd16sm17378338c88.4.2026.11.23.12.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 12:36:39 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Date: Mon, 23 Nov 2026 20:36:38 +0000
Message-ID: <20261123203639.3675-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123115636.34935-1-zhaogongyi@bytedance.com>
References: <20261123115636.34935-1-zhaogongyi@bytedance.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify13: clean overlay workdir when restoring lower
 objects
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

Hi Zhao,

On Mon Nov 23 19:56:36 2026 +0800, Zhao Gongyi <zhaogongyi@bytedance.com> wrote:
> fanotify13: clean overlay workdir when restoring lower objects

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
