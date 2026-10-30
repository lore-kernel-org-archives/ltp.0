Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A6606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ywk7QYY7
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E110A3E5255
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 01:27:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D91A3E1393
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 01:27:38 +0100 (CET)
Received: from mail-yx2-x0a.google.com (mail-yx2-x0a.google.com
 [IPv6:2607:f8b0:4864:41::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 204266008C9
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 01:27:38 +0100 (CET)
Received: by mail-yx2-x0a.google.com with SMTP id
 00721157ae682-8b0cae76396so431607b3.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793320057; x=1793924857; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ApE5zt6UAnldkY2n0Y9UA47LmpW0PHshJ33cEhhbzcg=;
 b=Ywk7QYY7V+EyrxBI8PcZgAcBAO8fOxvaQQvZ3iT2sxq0tpfq8P28YJ0DCPGwzczvYD
 hk1Uy47niCotiKToD//5uF3fNkEjGC1zTn/b3FNrCQTlEc8rpETXT75UBqOzE6Xahv70
 OGJK+5N93j+uE7RYmb6kBbAVt++6wL0QG+3CNT1f1pYTnPSUmYIqemk13k1jt697Koa6
 dkfU7+bY7b6LcvUuquewzYBEWAF7rKAYmOQO9DX7fbyQmQuBuVmp05SrcsEJ0CaRKEji
 C5buMuL3Y2J3DccKTnt0q14PQks6tJeUUTS45REMNywAtqeXvSxJem1Ak005B+4o1vE/
 fZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793320057; x=1793924857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ApE5zt6UAnldkY2n0Y9UA47LmpW0PHshJ33cEhhbzcg=;
 b=I6VZDYDV/97BzSDVpJp2kbfeN87xjbdnGdzPJt8tLWRcf8oOBOFOhPc7vC4U/+EqT8
 yYDeSfIKgiYV/zBRG+XZY/n6uPPaM5tdTjNsyoPySe/FKajqXWh3gjxpAsQsVmSBW1NN
 5Zm1aAZrbcto32aR6YQXva9oW/BUU0iTMydZd/t3Lf7IkTieBhLyXSbh8A3sd5JimCvQ
 eKmhJ+Q7yDRWodMJ71MSI4zO8HQq/QHJZB++AacN+CmoqQ5EOhbfwUEOwNX3QmDf6Zj9
 oK3La067xNvMAzd5W4fxawloZ+AVyJKDAzDK3hxbKbIGzmKPAX0yQ3c05OFI+RHi+6o4
 Yjwg==
X-Gm-Message-State: AFq9FYIjt8PSHcvPaay02rh8p+T6jj+jxxG5UMiKwNjBYm9e/mm9D5RA
 La5+wpfedmgyjxahfaJR01dMjSmjKdEJavDDDbTH8hd6alEzR6DFK5p1
X-Gm-Gg: AYBFou35yGv0v+MxGugzKEYAhRSI23hkR8Lf5GGWLrw5F3lTVyKWT2AiHdXkqHHGiox
 QlMWpUSi6nLdtI8v2+co8akkUet75aGItIP2csQjkcJ397mqWGjbz8Lo9jYXcp3JBVk12+b4Sus
 b29FB4g1jQZjZGAmyLpjVD/rmSm4T3D4/I2YzilCn93n2z1Yb9WIFb9qhWcmAvY763o6HvlpW74
 JpSXfyx8VnxWmwvcU4aNHWxQx6BRgB/BhyDXgU/iLunMyJBJSRkJQgRst4r8Nhnf99CmjnuiF7U
 8efAfkl+CNPfeMlnHcn9wac5Q2JmVq8gLg5b6Iz4w2WeOsBGiJF54EaDnpMWrz+NuwR29VLObVO
 yOCB3n7WNhAh345kmbQKk00dX9qWnotZH6jN6ry3xJqhW0SF7CsQOqqKN2rTEZvXQcvuwZy30Wn
 PO3pZt42wKDZwLlhCzJQuxseoYrZIKVT3arTnJ2Im8Q4b/OrPEXYIa2k0Hfr3b9W5eK10/blOO/
 KoUtjNhPrcdt8nMkuzoIZvU8iF06FJGPc/Z/hp4XGJ9JIZFmNDsa9j+2dD1ATcLoZi0HuDR5gYS
 P5jZ9jVHomqm0cCEKVXZE+Vc/a5QZZbBFo4lRisxAiFlLwYQwmWdjwuCyWQxguDmVtvkAtjrdn7
 oGLuQhV7HGVMYLo87kMx4BwwtEOHTs1VFVgYW/3h2SnTV
X-Received: by 2002:a05:690c:e214:20b0:873:17c9:b054 with SMTP id
 00721157ae682-8b2b66df92dmr2467477b3.21.1793320056507; 
 Thu, 29 Oct 2026 17:27:36 -0700 (PDT)
Received: from
 runnervmnwato.1gdacyd4agme3mbbcxopip3age.ftyx.internal.cloudapp.net
 ([134.138.55.26]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b704d6a4sm1826467b3.4.2026.10.29.17.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 17:27:35 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Edvard Conrad <edvard@tuta.io>
Date: Fri, 30 Oct 2026 00:27:35 +0000
Message-ID: <20261030002735.3814-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P58XUlU--F-9@tuta.io>
References: <P58XUlU--F-9@tuta.io>
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
Subject: Re: [LTP] syscalls/fanotify26: Add test for nested permission events
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

Hi Edvard,

On Thu Oct 29 22:21:24 2026 +0100, Edvard Conrad wrote:
> syscalls/fanotify26: Add test for nested permission events

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
