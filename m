Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF97606A329
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=klE0AIbq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 750633CFA3B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 23:23:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95E4D3CE878
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 23:22:51 +0100 (CET)
Received: from mail-dy2-x07.google.com (mail-dy2-x07.google.com
 [IPv6:2607:f8b0:4864:36::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 018B260093F
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 23:22:51 +0100 (CET)
Received: by mail-dy2-x07.google.com with SMTP id
 5a478bee46e88-36f2f262b19so1553eec.1
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 14:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793917368; x=1794522168; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LOdjQIrSgdR89Z54VrN5Qzi/x0WC//M23zNaxoC3nUA=;
 b=klE0AIbqWhKuAfymR4FZntfBH+v7bqoqm5nFV1Kg50fOsSlzRhwp7OObS0kvoICbtL
 1m0lTrHRXvk8li/bM9W49aLeLgr4bPJa8a1q1WqEc+dp4hkyaKF12cEQL/Fair4Dlcrp
 D69h/vgbKlJCufBoIiq1zsb65F7rcPxznbrgWMfsOQJfDbpYvLr0EawXfOWupB9Z+udW
 Pwc99QYLW3WpkUF8O/2sTcNUgjbnrfBarOEVYpGl8E+gzgYU0XB2izDLXeKycXjkfNhZ
 aX6cbI3Uzcc9RvVkeBxSBCWpQisazBN68GLQx2r973VKpOcLK3N/1ooKwMBPd9dMf3m4
 YFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793917368; x=1794522168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LOdjQIrSgdR89Z54VrN5Qzi/x0WC//M23zNaxoC3nUA=;
 b=a3wyt+s4smPvRjPtwiOjfNEcjOHrg9gztY2XDegXwFRNX0TzxKBQq37n3qlCnncGG8
 8wyQkBYifxP/YEZdG6jhdECIThSvFBXxvUp42XxM1Fy0vcprWNnCdbmj6bVDCyE5x7mO
 vLJkZg40IS5aTXepHLUEhqmvBqVJlLooFooDqTZW5cyAoFg2LYHgl8ZpuZ0q5Rqv4/JY
 EIy4FzEz+xLbiZc1qL/471Ri3yAnatLVLX1AVYQHMbHkbCcmHK76i5kSocE2ooapDpda
 V47UCmeToEMUiO3gz9hztzAxPeCHHAT+TxoIF38Efc6aVKvTcY64mz4jc5S6PrN9d4Kk
 ndSg==
X-Gm-Message-State: APuU4Z87QRHFv3l1rDNK1Oa4McZekOQaqxu0Dm7rjUwapBQG5RepTLCw
 aSCHAtxL8PnGE75vjnx62i+IlW28i0ZJmlq9h3MldNH57teQELmuD5qF
X-Gm-Gg: AYBFou1ZJxxqbUkIGBRz0+FA4KzFZ9KZjdz3JpZRzbeI2DAvAOLCoM4A1XauONzUALk
 +M0YcmBY9EQfvTWYtZF+K0q8FBvu/BbYdoiD1m6Fzi/ajd+17C/J0A+coXfzyQFvHDlAFXUsNnO
 GX2LFqH8u9SRJXiZZ5OHZhAShHgNAOMnTa0ERgQQUKPlYEog0j0TPVP72DQLIXcfNjgC/g3aXcH
 ep3LA4xlJKi1wZ/Yp+BGCIPRikHCTItfZVF0g0QMW7u1q+Br7kcRqAqNQtlwG91j2P4wECmQ7m0
 wklUmcBCNVcDW2BrFobI6x0g5rHrk3LKukAg2MF6RY8J4tvxAf+L5QZ9sjX//T5QnjPBi62KZSZ
 3e/yQ3jH708660bqoGxkHlre8/zxk2dFxusLgT1ByS1DL9/2+psov0wF39siG9QeTmHa9ils7vz
 4V/+VEwiLqVQKOLrEZx+1gAPTWCPWD6z6iHwmdBT10XqBoNFVOD9aSIaq07NHJYa5Tk8fE9spht
 A33hMfj8lruX9Wb4JZfRwqeTP5rdUWyuY1vBRAHWdImM6Wt9jU+KzzJt1JJBKEAWORp/xFfawyj
 epcFun3C+AWQ4sA69GpO5s8VDH7DCtX4HjISa3GHAvGJoezyawPHFJKDhaY4NvObFUtXYNMXfw7
 J2hi6ha7Ze+EFqelDfUABtAPPzzlEQr4KwMC7P3MO
X-Received: by 2002:a05:7300:7b27:b0:36f:2e77:93e2 with SMTP id
 5a478bee46e88-36f75d205d8mr641778eec.28.1793917368100; 
 Thu, 05 Nov 2026 14:22:48 -0800 (PST)
Received: from
 runnervmwuk1x.uodw5gs4ktju1f1e1gup1hfsue.phxx.internal.cloudapp.net
 ([4.249.22.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm59312eec.9.2026.11.05.14.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 14:22:47 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu,  5 Nov 2026 22:22:46 +0000
Message-ID: <20261105222246.3698-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105215504.803025-1-sbertram@redhat.com>
References: <20261105215504.803025-1-sbertram@redhat.com>
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
Subject: Re: [LTP] memfd_create01: Reject F_SEAL_EXEC over a writable mapping
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

On Thu Nov 5 16:55:02 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> memfd_create01: Reject F_SEAL_EXEC over a writable mapping

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
