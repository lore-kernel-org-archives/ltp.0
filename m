Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968D606A31A
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iVPumm0W
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23AEA3E9A07
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 13:19:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A59B73E99CC
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 13:19:43 +0100 (CET)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4ABBE10007C4
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 13:19:43 +0100 (CET)
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2e96be2196bso13309095ad.1
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 05:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793103582; x=1793708382; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4btpLJ+jEIqoDS4DiChF6KccHxXgyBAQlNU2Zfsfvc=;
 b=iVPumm0WuqFPw7R5jGHxXS9/KHPqCN/kPG+1QYsYXdTX7iMUcaBvw5MiDRnDk57HkH
 IOJMxxn5OKNZMLVk3FP/WTRveGl6fq2wcVtAYsvCdlFKuGVyS8ii2JOkWLHX2LrCXoy7
 lqDbYRhs+wy6B/OSVmJPBV7nPsF6zuxlPQl60KdArlxZrx99SVycAXwzBra+NK4mGAZf
 4zZScAXJOBqhVOKJ1UXoutYC5mpc80npAmu06q9W//4wZ8Q6bnuetHtXF5x2S1dy7zhV
 csgkdcEqok4uDCZFnS1RSl9TRnAj4rCLLOplsoX+IsiLjzy4OVrwljdNZ3fi2xIXHREw
 LW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793103582; x=1793708382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4btpLJ+jEIqoDS4DiChF6KccHxXgyBAQlNU2Zfsfvc=;
 b=vKxXFdSXGOAoUcGHnM9ldPhjQp9Y1r3EVXk/FEid6wudc5vTjW5Tlg5NEnG3sVCL1A
 XdQVlQoMTJEzOCQlGNKyzLrp1myZXSUXTwKElka7foX2qw0rnclveQPUPVhwERt62um9
 LgfcJP/9UgXpR56isG+eDlLvIR8Q0/09GeZ8ke7t8FgTteUqE8kUnyqTqN7AlBssgYZz
 +u9ti4E8luuAjpUg3+VOZW5rMxnoH6tiqPhLKzYXzZ0sVtinlODbU33UeW2te3UMX2uw
 yNux1c8yNybCaDmToRkSYHuWz0V08IkrIZToDwXE8ZlhYFlPkNZqJed5JGXuc74ReLTS
 I+Kg==
X-Gm-Message-State: AFq9FYJFHAzjgwgwFSVsvq2ac6c2RE5OWPzRBbdb1+2qoJmL3Z/riv7O
 sbHYTfRI5HNDqwLQq4uejcSLPDC0bnb7HuU8+uqM+tLOHNBE1K8k9V0S
X-Gm-Gg: AYBFou1c/V+pZEvs4UeKfp82eqokEsDgWS/xvZavmiNor751GEYnKEKFLrnPhCAdwis
 w6siUZPfiFZlE/XUxHnxvv6c6tVBM8tNHDQHteswtX1l8CXwnJ//zd2ecMYelhDVdsvITrD7xft
 cU4ciOFEqwnc/NXDqtwggzMZ3UJJxiOXRjqruS1RyfH5TC9zzkRPjBH47EmetsL5IBvavvPrPKJ
 2duVTi1lTOucVivIzCXO/+2ylbvvYp0ia/KmWhcolfDC3ZZOTVASW+GbtbXhuvX8uPIHMXi5Xow
 a3Nwnp1pV2Btp3Ep0KIXyaxP2UYDqQMFxRcn67HU3LjSFz0y/fIOcDRSL4MhefdSM0l4NEze0hJ
 z3GEUv8ehZtwuoK+JMfOYaBihtg+vx68uoJrV7JvZdETthNIZdDGJU0tQv3/zZ9DDkqPFCYTjEh
 9Kepa7OJARUwtOzhRP/3NPsHr5VlxIBmUaMsXZSQpar8r+YHwZGFi8k3TZ+2VfewOVev2pxhIww
 PpSwkzKvDlU5cedJCKb1t6dmZ5gYRL3P345oQ9zpdd3gJU7j/Pt0OjFz+dSLToq597ySVhnSuW9
 VpRq7hShwuG4wGEObwvRo/E8KIirJisvAutu5fOkDLnje+dDvwVNUeV+a9VzPGTPLVM=
X-Received: by 2002:a17:90b:5105:b0:3ab:752f:5f9c with SMTP id
 98e67ed59e1d1-3adeafad11emr7262199a91.31.1793103581375; 
 Tue, 27 Oct 2026 05:19:41 -0700 (PDT)
Received: from
 runnervm48cm3.qm23kbzblwcejfc3nks1hnkmec.dx.internal.cloudapp.net
 ([52.157.32.56]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm7914566a91.4.2026.10.27.05.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:19:41 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gaurav Pathak <gpathak@suse.de>
Date: Tue, 27 Oct 2026 12:19:39 +0000
Message-ID: <20261027121939.4218-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027-statx-atomic-write-v11-1-e9aeb50e56ce@suse.com>
References: <20261027-statx-atomic-write-v11-1-e9aeb50e56ce@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/statx13: Add test for STATX_WRITE_ATOMIC on
 regular file
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

Hi Gaurav,

On Tue Oct 27 13:40:05 2026 +0530, Gaurav Pathak wrote:
> syscalls/statx13: Add test for STATX_WRITE_ATOMIC on regular file

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
