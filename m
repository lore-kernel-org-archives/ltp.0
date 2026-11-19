Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295B606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y2xZUCUQ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CED53EB3F0
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 03:57:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E1823EA083
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 03:56:53 +0100 (CET)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1D97C100045C
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 03:56:53 +0100 (CET)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3b3bbd46625so441419a91.1
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 18:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795057011; x=1795661811; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tl9dNWYtNwZ+T+IGgWHw0A/dUzvoebNXb1Sd3B+dWDI=;
 b=Y2xZUCUQBYfsKVIl8NbZ+KxqQJIUbbkciEp0y1MHgqsitXTmNchPW2LIBbU2REgZlj
 5aUxOXVYw4bb2+YKDBTn+4cjAfkYenyBtPTPP5sINQP/tblmJXkYuMXJBA/vEElAeiWb
 cHlZPuA5B8oib0yLYJBlzhu2JaIqevCV9BXmSJXeOZGp+W1SYZfn3lMnhQheRDJDIp9x
 lEUxaJFTZdtdhY1a2uqOStDGshhgrBZQnAXtPqtzFTEP93gmJhW7k18C9qzFgtIfGi2b
 FDmB6eSh1XxO4BPpUHU7RJPdbbYrqluvpOOB9v90HvhwRlHOi8UKhBQGs3VOGB9dQSnj
 X2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795057011; x=1795661811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tl9dNWYtNwZ+T+IGgWHw0A/dUzvoebNXb1Sd3B+dWDI=;
 b=E0h2j8qDIcw35w+btw9r1Wb9sGE2jVj6WDdQ5n1o7nwcKY06kIj2W2RP1AU4PO+DQk
 dPfYmehaxoMxiKhur2lmFvdWxFLPKPYosWgRPWQ0yudt00pOs9YzHjE9EUhN2pjyR8BV
 wmiou8e5Xai+s/DjTVPgrCbYcjuvDsK42fKHKd2mW5h7PXfEOcP9w53C2CImkR1tGu2N
 Z05X4gPu6RpCQes3e9vaaurg6tZLDgAkRMm98GxcnX3UNwOkc9PYcPzkd6hWkXY+KQQA
 BiROR8dX5TGRu9P8rcTygepm7B0Lptyc4AEpmNvjIBRuV1XL+fAD6POnU8esSduFWwvK
 p4CA==
X-Gm-Message-State: APuU4Z94TA3qd55h8OjgC69YtuAdG6Q/OzNu1j+joVahGwOwcQxhmGxg
 YMfemuTRjIvUwNUxuzbrItWDYgdwDZvDKT8kHUYFBm6rHC2wuaYgEYSE
X-Gm-Gg: AZFdTZfap8obe4n3zldYonoBpV5P7OF4OptuySknBp9soyAnt0qowZqQ86s1Cozogbf
 TVofLiIY/s8D6KF+BXoI0MJJpSS9Q6MkwkTAxn+8oj6bvjmyjHUFaXsy0/RXOzNbe3iPHJrjFKk
 UuQqvlOvqI4SaJD/PJrTGIOo2mY+qJ3IBbdy172CcGCQ/z4T9zJWBsYfB7nO7B+8SnAQu4D8vr6
 vUNiy0U9xWiunD5lN1BUvO1zglTPiB8gBhaR47hlpFDdpYx92/+wbqgnC9gZZ5T9PV0I1FIJUcU
 eIJl0+mxwCyfUmS6d9ARHXYH9MGsLgpnzQHps0Fpg9HPafHOR+SDjuf1RtGnWOtJAnuOZBrohEh
 QRaKVUpgXTg1O37L7GUs88NAP3GJ5/cvf84TF0iTBSURaL9ZUjlrDSI+9HZYEsNAoQ5XweYK4yE
 Uef/FwZt/NClruh4N1LEKmenRZYYebxahUb/ekj9P1AltZZXPtljwHB11Hl4lTdVmVkCgEZic2Y
 pEpEl4uFyuLweDpRbg6DXYG5zu9SgwASShYJdPCCbWFr/8vW8CLRCOzxDepnNmz972yEzJQru+C
 zM8iFyxR9fps5v/ZwWf3iNcJGn6aZm8rnQ8Z3KLxgHPaDs4dxXlfRL8RmgHs23f1tfHxztOAQbb
 Bo75DMvesM68IHT1eo/TdoVSTOaH4RjUqAbpuXCAcwAJO1Ztwp+YxjksWLFto
X-Received: by 2002:a17:90b:2fc5:b0:3b4:52b:4dd with SMTP id
 98e67ed59e1d1-3b4052b0c72mr178450a91.65.1795057011409; 
 Wed, 18 Nov 2026 18:56:51 -0800 (PST)
Received: from ip-10-0-132-150.us-west-2.compute.internal
 (ec2-3-42-157-94.us-west-2.compute.amazonaws.com. [3.42.157.94])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405d96bd3sm136183a91.12.2026.11.18.18.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 18:56:51 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu, 19 Nov 2026 02:56:49 +0000
Message-ID: <20261119025649.3940-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118225144.411166-1-sbertram@redhat.com>
References: <20261118225144.411166-1-sbertram@redhat.com>
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
Subject: Re: [LTP] crypto/af_alg09: Test CVE-2026-52972
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

On Wed Nov 18 17:51:43 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> crypto/af_alg09: Test CVE-2026-52972

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
