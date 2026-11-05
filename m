Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582D6606B475
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YecN7+cs
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14A3A3CF037
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 16:54:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6DD23CEC3E
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 16:54:19 +0100 (CET)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 340BE1000A16
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 16:54:19 +0100 (CET)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3ada6c66964so556600a91.0
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 07:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793894057; x=1794498857; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=06UPoRFAVt/yCLTa8BGYsZ7OavAjXVlkkp/p60xHOUc=;
 b=YecN7+cs1WCM3ZWdRWiC388TJSNJ4KQMUCey4w+F1XI/0RcK5MXYIsmjuzVTZCVyKc
 AnjzB8pHVbhMHhrg6kmBrMSDsvCxhHsPDelwLlXnFs3+qWoW7KjkAfl+Eul9KOFCphTP
 sGRp6TaVymDnzN7lE3WagfEN6piyHthLICIhLbj05db0XXh3Te+5fHUZb8dIkOo8A2Uj
 bGmfD851XzBgeOI3AQKwuhXInvh/s/YODHsG+RQxd3etRZjErC66MV4wpgL3v6km6cn4
 FY2DVCWFjESIQFUUzyQmsjEL4nLnp/SwB6zoUYoJaQ/r2Vd3viJIY2L3K4jSi66uctCu
 cxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894057; x=1794498857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=06UPoRFAVt/yCLTa8BGYsZ7OavAjXVlkkp/p60xHOUc=;
 b=2BLruL5oU2OCcm81AAqT2gIZcCejkELP9M48ufLDYnxsge/LJ/dD+zqVzgHaYjdhm9
 LGy7YMp6ZzaETx5kHnYWPbPCB7W/mf12/zr+CI53Cnme6pEHPv9/pFKfVRdpWUqW2fS7
 VJzbo044OJTd+3daP2wEmvRLCeusvXX3d2naomxOScof8q4CKERrrsOnSM8Cy8EXMFfo
 utzbmt3Ekcv0o1Rl7rKBwLPEu6zh5I+4HEmE89XrSYbQcOGXDLJtijbatGt4pZb4sC/u
 60f5oSnWqXEmMCWpy3kP6SdUTkDfANDKhH38z+d2XP5ZvSbbr+csu/an/h8lEIUNin65
 lzfw==
X-Gm-Message-State: APuU4Z/jQIDyxLZJR2YoBjkUF8EVT1q4p8S/xtZtncfHP0LlkI3meHUF
 bMZsa468rUuSAP6cHzJqexLsFL5j4R/akwSj3ptBRq0iIBwtsngU1/1F
X-Gm-Gg: AYBFou1g4U1cw+QoFwAYndjXLVW/Yvd8pXiTymMXc5+k4KSmqcPNhCF7NvpCiYTpG+h
 4skJsJk9Z8t4ga3jCXHEdbbfUuiQwz5HvVhmLaS64WoeaKF4iRSRBP+70ZC6s0bKnAYKDsN1pFX
 SpeXdJSWLxnyOpVD6hW1klDz0vNdq97jvUtw+PnbUP8KucyDHNiv0yaFilWKI67hYI5wgRaVC78
 sV0LwRqALSUit0G8ISm2i8ODTVhm1QUrqTLXE4ANVHj1jt7CTkLIgZlLPlcBUJDnrP7iI/Ck8WQ
 qK1kLSzYXwcHtxxlW1N7blnMKrRWKOOYpObTyvKBDbNqyOalOYIEEad4xb79/B4ex41QPzwreTN
 tRyPl4LfZ0azXKo+ULCkfJnMRh8nC/A+KOkGjJpbgX+LQxAA01VaPH46Sy98ub1yhtbkL4El2sd
 dyhNZt7agVn7H4qnQ2QcODhgeWFWDb4Qd9OIjcTeCFA8ATnRAZCc4JleGI/MEyhnHCHWsske32H
 ccBxiOdZ5eU9hg9spU33ufPVq1LrM8aA6UOjEHJiNhRhO2gGMvrVhiynqgx9d519k7cgU0PLMhf
 r8kCCT14LbX5wJjb4x5U7KJ01v7q/LPTx3/dJ6XR4fEVy3Z42IBz9Lo4V23++oy/zV2GTrb446+
 9SvB5sfdPobru7xO5J8DSGj96x55F2GBkxeOieFOzfw==
X-Received: by 2002:a17:90a:bb83:b0:3b0:bc3c:3e7 with SMTP id
 98e67ed59e1d1-3b0bc4b4857mr1494060a91.10.1793894057023; 
 Thu, 05 Nov 2026 07:54:17 -0800 (PST)
Received: from
 runnervmnwato.2baunt4tlemezmxix0wvdxtwza.xx.internal.cloudapp.net
 ([4.242.29.133]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32b2b57sm4683428a91.15.2026.11.05.07.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 07:54:16 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Attila Fazekas <afazekas@redhat.com>
Date: Thu,  5 Nov 2026 15:54:15 +0000
Message-ID: <20261105155415.3529-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105080245.2067876-1-afazekas@redhat.com>
References: <20261105080245.2067876-1-afazekas@redhat.com>
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
Subject: Re: [LTP] mmap22: Bound child memory allocation to avoid OOM
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

Hi Attila,

On Thu Nov 5 09:02:45 2026 +0100, Attila Fazekas <afazekas@redhat.com> wrote:
> mmap22: Bound child memory allocation to avoid OOM

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
