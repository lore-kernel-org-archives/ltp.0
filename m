Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A3606A31C
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=feDmw/1h
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D4F63EAF6F
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:51:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97FD73EA605
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:51:12 +0200 (CEST)
Received: from mail-qv2-x06.google.com (mail-qv2-x06.google.com
 [IPv6:2607:f8b0:4864:33::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2ECB11A00166
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 16:51:12 +0200 (CEST)
Received: by mail-qv2-x06.google.com with SMTP id
 6a1803df08f44-91ba7a52cd8so18822786d6.0
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792507871; x=1793112671; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YgYjKQJSO4YN//U3ZLZ2ZupxOzi4CoHF/+saZOxJfUI=;
 b=feDmw/1h42A3JSW9hvb7AVoa6alMj2y8wZ2Y63WUPu0HYKzrJszll2s1xItvckj5AT
 JZ4S2hrjKa6jeqrhX25m4qIeIZzJHgIeBGtcjxzMlNNR4UuhY2xZk65QDySJ//M6tp5X
 CWr9IM11HHlaqsMF1dNaEFewFQYw1lpk2Ruve5p+Ixz6UcqnEgEplQLijEDn0PbtxamF
 4zass9PAC2U1YAomPV4j/LhYazMkmBxdPxUo4Tb4l+nD2y/LpW2+nH0XSalQ/MWdoqP8
 fq9hxm+5VDY0L8nsK6zcJlyvf4l1ddAhJ33YHXh0MyCgHL3j0PymEjnq+2HXHo62ielB
 ZZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507871; x=1793112671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YgYjKQJSO4YN//U3ZLZ2ZupxOzi4CoHF/+saZOxJfUI=;
 b=0ud0d/h48pgxESoWPzndDIWPd12mGi28mRneI+7OPF1/nCQ6rqsn1Qh8bCDUAuGVwV
 rxNBJBH7o8Gi4fyK9uVgSQhDPCEr8Ge/KIbt3oPKBccc/h40slToMC0Yby4OrrwrIWHn
 txjg/fM3gHmUd+LfijkhogulxB/8yB+Cve9fqrVGw5DmTac0sLQjnYVD5J6fw6MZHIob
 FCHkx0cx3v6byeVqHvEQHvRZCF7EeIM1cFupPPpxyNskMN5i1t8dOqiET1WCSrZbbeou
 zWFeZlQM9B530iHK+hlQSfj89qmLWY8g8z2STeuBma6nYrgwLI538GNHCEiloqh5uPxu
 FeFA==
X-Gm-Message-State: AFq9FYIfqAnon3NLnT+dUZxqejk/iXR2S8N7ohuI83rC4gprqHr3uoof
 LQgdwYhVVvfrylxgKGnGw3G0a60OTV6Ze+lPWpKUjetMlGgyAyAo6Cxj
X-Gm-Gg: AYBFou1Uj+Y7fmoQm9FT9RmEoD7G2FuRIeWsmfH4bOncfu8f0O36hGhLI46uZqNqAZS
 fwTzlx95/yxc6FEO9M0WNTRYmY7J97leOezx1FdOb3eVqFC0ilUyTat/6fEnDqcPJOenSAy5rmo
 Wj5MYX0p8fTlGBEwjoelGBaKcDh/bTuPP/9E8q5sMl0gzqe1VCzBreBeQrZCQoy82U6pEdvZSjZ
 PCyaE6W1h3RMNQhpAhASBvmqBJ8qju8FHWqc8fw77KFfj5FeEOBSh24I6YM82LWFQHHviRI/yNq
 Gqe1gokjcXsBWzZLobB86UQ3L1MSFDh9qcEt1qHbW6oIG4m8mSjlGmQz+OAOR4slySfXkGSyQG3
 cX9c8EmBF1Vx6YWW7UQFhnAnRb4EXVaR6Rafr8ecsHc7NkUG1X1eQOElyLxoLx5Za7EoZo9p6DV
 MGbk5sDLAnHGo4Moh98Y8EsNDE5+pmVQ3SBzTCHELeHebNSOjPudeyG0KZ78NLqPwWbSrH3Ppaz
 SOCA0LIp+hxtoz0rTMDWOKqNK0nIOlrxMe6MT4WqntlivN4D/49QOTPU6MRFo/zIicYvtsB2t8u
 oyuoryHWkB1W
X-Received: by 2002:a05:6214:1bcd:b0:91b:8025:2d96 with SMTP id
 6a1803df08f44-91bdec1756cmr177403536d6.1.1792507870717; 
 Tue, 20 Oct 2026 07:51:10 -0700 (PDT)
Received: from
 runnervm8k3b6.nyrd5vg3dtdujdseofgcizl3sa.bx.internal.cloudapp.net
 ([172.190.124.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040baa03sm28167616d6.30.2026.10.20.07.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:51:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 14:51:09 +0000
Message-ID: <20261020145109.9255-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020-pwnescape-v1-1-99e82e00fa36@suse.com>
References: <20261020-pwnescape-v1-1-99e82e00fa36@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: add pwnescape reproducer
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

Hi Andrea,

On 20 Oct 2026, Andrea Cervesato wrote:
> cve: add pwnescape reproducer

> +	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/ip_forward", "1");

Medium severity: CONFIG_TUN and the namespace dependencies allow
CONFIG_SYSCTL=n. On that configuration this path is absent, so setup
reports TBROK instead of TCONF; add CONFIG_SYSCTL=y to .needs_kconfigs.

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
