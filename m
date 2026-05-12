Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1892DCD4F25
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 17:16:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B55523D7C3A
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 19:16:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F9783D227E
 for <ltp@lists.linux.it>; Tue, 12 May 2026 19:16:06 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D2F61A0069D
 for <ltp@lists.linux.it>; Tue, 12 May 2026 19:16:05 +0200 (CEST)
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50d75bfb259so38988121cf.1
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778606164; x=1779210964; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIao9h0iko3Dw5mvMTJLnfdvYVXA9vKQT4YGTx0zutY=;
 b=Fq3ziMuX4sRc81Fka+NIqclzBGf8P1UC0JjaB4lzVVlSZ6KhlzkAibt20f34yKvCVC
 nFRkQK3TxCJvUn3fxP2pFl66Mq6yFmBWWtKm19CBJQxFPz9p/Ymk/2LFxIZVbROEQhl8
 PLJzlt/UCLc7vxPlGUDHgl1oNPwBLBVmCjMKxs/N4fO/Umir9JVX8TLQmgptVPFoK42e
 q2nkMTJMOqNjIepzr8BusBMjOZD+iu/KDLgwEee1Gq4dbahsTYA1G71SLIjXeVNNu5Xu
 XQZG+gvE/J1LMMeuwG9W0dVtqgDyu8N2n61GcJ0T7hwsjFJgr6duftxw7+iS2Zd8TL/N
 jrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778606164; x=1779210964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mIao9h0iko3Dw5mvMTJLnfdvYVXA9vKQT4YGTx0zutY=;
 b=PCqU9jRVqgu6/zaIDX+/WGJDKIcfPJZEnjr50BjbDRI9k/P7MxXpEFaRUKD6X3Y3N+
 Q0106fHBwlsp1zsNeCXC06o/Sjp11yZCIDqvoHUb30AkNd16t8DORtYsz15OWOQTitn0
 nXHdP3WFsjQ7+jyQCnIQ/pxg5taaJhh9PQsAME6UBze1jIywRXNp1xzLDXMsXwImKI9U
 lVJUuCh/SLI1tD5jenaZ69UbR55tTYsbnI1IQqtFlJ9JGhYbxmwcpAPh6Pl/z0mvwDUy
 voBrMmRfFbZVDPjtM4QcB2po7HdhvyTj6LLgnba/EkxhFMYxPNGnvnlM9QAMKsJJrjoi
 fn0Q==
X-Gm-Message-State: AOJu0YwWRnOEAj3AQsqs1l0q6TZodU1VQyCfWSZFLAEH2jh3U4fLop0F
 9zZAB7+b1Torp1pT+5UJFm7VKOnSuB6ecAcu5jB/UGO0I7M75xaQ2fe8RfpWFHNI0yQ=
X-Gm-Gg: Acq92OG+w7r23F5NrcDtp6JpeTk7nR4hedUtLSs9rK8k2svCUmm9Ezz9KIQmCvEdC5c
 rWVbC/NO6b+2kdRkK/3XGhlQLpiO5l/HVn1GojcvYH+mzyicumIjLmtQMIVpQRugX8nsQyBzWix
 tGehR7vKLT9TE5ap3Hc5OthY87AGthCTe2AwaM1xkcPoNJCFvkvsm5yIJuuWasB7oXTfPPeu5Cr
 iz+1VPaXSJdseG6VZJZnf2Qrrbvv9DKmvcnlfhB3k4D2tl5f6QobdPvvnOMb/EH6Sj8XQKq23Ho
 SMN+H3HFkdGzgsvo40LXgfvj4JKhoMGsuq7xRpAVbd5uQkz478u1VOmq1t7xphf9OYwW89Jp2Vt
 p99fDSQLuEnpgQkaQiglKaw1DaOjl7Vy3aq3ll4GKXW56u/gPpbgKgHF/UndVdYuaQhzfIu9R/u
 Vx93luKf/Sac1D1oGqgEHhIQIkQe5JXHC+lHhy/EAb0xE+K0KgbRPyrD+H1GzYVCrCow6+2Rr+R
 aKC91l5hmvaByxpgYJCrblQZIYa1pW+oHNgOUo=
X-Received: by 2002:ac8:7d56:0:b0:50d:7406:8f05 with SMTP id
 d75a77b69052e-51461bea4fdmr422160131cf.9.1778606163322; 
 Tue, 12 May 2026 10:16:03 -0700 (PDT)
Received: from
 runnervmeorf1.l4lech3zw5cujgxo2oqdq1jysc.bx.internal.cloudapp.net
 ([40.76.117.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e6754b2sm123006681cf.10.2026.05.12.10.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:16:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 12 May 2026 17:16:02 +0000
Message-ID: <20260512171602.4049-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512162735.80055-1-mdoucha@suse.cz>
References: <20260512162735.80055-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Add TST_EXP_FAIL_ARR_SILENT() helper macros
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

--- [PATCH 1/2] ---

On Tue, 12 May 2026 18:27:16 +0200, Martin Doucha wrote:
> [PATCH 1/2] Add TST_EXP_FAIL_ARR_SILENT() helper macros

> + * @EXP_ERRS_CNT: Lenght of EXP_ERRS.

Typo: s/Lenght/Length/. Appears twice, in both new macro doc blocks.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=503985

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
