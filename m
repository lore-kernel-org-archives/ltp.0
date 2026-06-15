Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD30FCD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36633E5B6D
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:40:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D4C13E202A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:40:39 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C85442000E7
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:40:38 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-137335bc3caso3949471c88.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781534437; x=1782139237; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cjG60j4ss+PKQjOqQacnKpP237kYdD/9fWTVptIlyQ=;
 b=fkRsh0zC2eMaXLY5m3IUis3M2tm2qUheWLB/Gv6rmJyd5qr1a2YsEC4P46eEYZT5lz
 eHybn339xv7kOLtSBxCShz6RAGbnf8KXVq3RhjQslE3AbJzk3VoanLl6D1EMEfP8KE0l
 A/nFVzCHarF321COJfFwJg0uolKbGC0anmphcIeYlHe0usncrDILqqXVYPMvLPstt0O/
 kQV6sHBLgyRuQEUOE6obyG/4ztIWd7FpK/vTsNLIzIcmn23spQGZQwGXwAli022qQ6lh
 iteY/qHkmwvtmW9MABWC53OmDpI6doV7ScTDtepIa1f0zrjqBQFvYyblpZWylCA9hZn7
 en0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781534437; x=1782139237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4cjG60j4ss+PKQjOqQacnKpP237kYdD/9fWTVptIlyQ=;
 b=oOYunjrSA7hFsusmT2AUUdnysPxBoKBj2yWgZNSBHLgY9cDiCOHSNdtxn5vfJmO0jE
 IEOkPi9kW2LJzZyvU8E+OzUsJggF1kDO+D3rBMqGz7vNJduHfaiGICwdb84s7wLnqevh
 vfwbFJD3Ks9vjeypH1Ww91MTzK9370LynhCKZobuZlqivDUM6awDeTLYqmCV5j3UkCv0
 XbdyC9QFKzjPTE79kVSwPm1Gi8PLwtzj4cwQThjQXXh8DNDWkS5Z70TiNV0yxQlKmjoi
 IYKrtP/HSJmzw1+SGIk+lgdPCSju8xmd3a0YvcL8eEqkINaKetWB5q6Oe59Xlp64TGjg
 vhAg==
X-Gm-Message-State: AOJu0YzWyIQ9AU0BcjvpbSIW7GkLFrmT3UU0zx+7MTsmxSg0maDAds4j
 v54JgzC0Tf+bDCSfX2x4RSjk3dpfJCFk7U8GRLyBCmupAaiPeAL6ekxJJSI/4RL7
X-Gm-Gg: Acq92OEUos3L4ka1F0bA2Ev5uijoZFnHICVEcTMGsD73dLYMbItHIbNTG4IWKskUKui
 nSU6A+6hlpEQT3NHqur+8jjVQIpp7lEde/NjyRKiAafGhI88TPFtILpupjMTRwiaaUTKOOx28IG
 MG6ah5nXoylUwcPCJvOieMdVEbm1mncWTRvkLfukIxlg5yC4zNYusP/pfjcPUt0LE/N+tlYk3/v
 +Bw1sQNN11Gtz348RsOKlYOxPg1RDuB/VaBxyrS/BVXwiHZYmQLLsJaFC5bSR1v57kD16nkclJJ
 3faXVA2SzQl8zt1u/aSGi41bZkLV/24HhgpK3Y8iJ0879WM1tV5EwuZhhop/iVqA8prbTRucyCO
 +gqSalGOAAgmaLSlPIBsGdSzCw8Vj64siPC+rQdJwrNg7Mlp6zSWiw13Nkn76CDB1XMRywVwbPd
 4Vmmin8qO9yOpo/6Srh50zXIUei9wYDTQJj/mlE5oFpq7LjYPZXtDiLwN+c4dW7jWZJ/RTMpZ2J
 oBhlvJ90STc5WB50uP7xFu4t3czEE/jABXh/g==
X-Received: by 2002:a05:7022:692:b0:138:43f1:e48b with SMTP id
 a92af1059eb24-1384bbb6ba0mr6426314c88.17.1781534437023; 
 Mon, 15 Jun 2026 07:40:37 -0700 (PDT)
Received: from
 runnervm1li68.wymfr5ei2g4unblxoe4fek5heg.dx.internal.cloudapp.net
 ([13.83.217.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b964862sm10690303c88.10.2026.06.15.07.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:40:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jun 2026 14:40:35 +0000
Message-ID: <20260615144035.4083-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615-fix_pids_errors-v1-1-99a54a205180@suse.com>
References: <20260615-fix_pids_errors-v1-1-99a54a205180@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pids: fix cleanup of orphaned pids_task1 children
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

Hi Andrea,

On Mon, 15 Jun 2026, Andrea Cervesato wrote:
> pids: fix cleanup of orphaned pids_task1 children

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
