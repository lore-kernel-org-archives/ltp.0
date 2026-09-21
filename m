Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBB4C982E6
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 13:47:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61B5D3E6E6C
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 15:47:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 780D03E6E5C
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 15:46:46 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ECED560067F
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 15:46:45 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso11810095ad.1
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789998404; x=1790603204; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z90sTP6o9JfHrzJFllr9oeqXWArSD2KkMMSh1yvcp7k=;
 b=d1NXrfY49qXMCyrhnvvCr++jQ8CZdfuOG5Ahg0Q3X/0ZxIPczPXRozAbES8uzSWCq1
 Rx6iMKbxMN8jb6RZtK4Mg648Dkp5Q9/h5yxWEi5Ag5Lk8El1Ur+8f6H2txSasYgQm+O7
 MhMoWVCzfLRKX00HJO698TIp1OIVpUmhkjDAYliuO5YcYGx4rDM8HV2aLtPNtPbXCCAu
 t1ijCpSEm6rKhfyNYPnAONdzFVaKdmRviyJcjd7g4VZxNevtckhoB3NG5LMEJjiDBFCT
 7kFE7/nD5ClOhXpPJudpTGlYbBlkTX3g61rRiimflLZONXLkOlsg9+3pNJ0zbStVesZG
 NtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998404; x=1790603204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z90sTP6o9JfHrzJFllr9oeqXWArSD2KkMMSh1yvcp7k=;
 b=zLpULONNOfC58IDqaCRG6rtctXIznK07h+Wp3DgCEOtUJ3LXywGUaOQpHqm+MCYZKT
 6foNIkHXjq7JiZlhR24kaFxTmgvuaNyJtxXEFYrv04RCT0KYJvyTETapV/VD4EqR2MPA
 KiPnZloi+EbMM8CMEaner4OqzIXcwHqAGGU9TJnidxGYcJ7C3fUNa7fkMC4de559LRcf
 aNrXx/sPwewS84W9C89W/AxSmOvU8NFLqRTvJh4nIIpAlVGO7L1wY9kobjl4NX8vbisw
 fG8pXqjhe53eG2TzQnFTXm+x2jwHFQ8W9DOdIzstu70hBZ8r4tP2U2Dvp+tYC2BxuQYI
 Nr6g==
X-Gm-Message-State: AFuF++nuWN2YYn4cPGulpEA1qzbbdWEi5LvfXsFtAnwy0RVU2dDF7BT9
 9X83PHyRXLSpecajGtZNmIAWfA1GZpAAbaxUlVVPlBHqSris88lMgIMn
X-Gm-Gg: AYBFou19mjcEFGsL/5i+Px8018c6mWrNsJN5+Gvy5BlEeFmLIiMUmopWmafsJAvy6me
 45AQlJAk9zm9P7CQKMTKP77vNemZFZUEeD+dC61ot1728PiVO+e2Pe9bVvcW5RtAHMvuRBFRjIC
 53SzYAUwrKsXZgjJ5YFtOxHxI7P0OV2KlFKsMFr7T/HzLlt97D85VxIScTWiMQtH59m6mHz5zA8
 xcCXGjaJ4ppnIKCvTnXnc6zRwFNoVvPejmBXw7HZliFqc3iPYpXfCz0qKWjVDjvLwmw9YWQgL31
 BS8UNqwamnSDS4h1vcBby2WEikWCp5FrQwPYmOXSTNHh0fxUXpXGNvSe9FHP6QrD9X+NKsdvmRG
 R97wdXXFM9myIJEZe5xEBF7VkyVQIYmq6ZkHtf2BX0cbTrR866DQYhTNZVB3EDKmDPMpenmWbzd
 kpkZYuxY759qA7K5tKjFzVPEXCEWdwr61xHnpmHr8E1nigYc0gBfXRXrzjENCIZ/ps6yUW5exPI
 WAr6btNYJVB6W9/vv0qKpWJr8ZEtxCx1vaX3y5XWif994eBMwEVu18KiHBmboEdjsCZaGLLWE1M
 rsCfFaYrJmEo
X-Received: by 2002:a17:902:cec8:b0:2dd:ad74:ac27 with SMTP id
 d9443c01a7336-2ddb1ba5957mr152686115ad.25.1789998403928; 
 Mon, 21 Sep 2026 06:46:43 -0700 (PDT)
Received: from
 runnervmlun5p.hoohsil4ppjutajargwo53mdib.xx.internal.cloudapp.net
 ([20.120.156.213]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc16b471fsm34887685ad.3.2026.09.21.06.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:46:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Sep 2026 13:46:42 +0000
Message-ID: <20260921134642.4312-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921111407.2137467-1-pvorel@suse.cz>
References: <20260921111407.2137467-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/keyctl.h: Fix compilation on old kernel
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

Hi Petr,

On Mon, 21 Sep 2026 13:14:07 +0200, Petr Vorel <pvorel@suse.cz> wrote:
> lapi/keyctl.h: Fix compilation on old kernel

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
