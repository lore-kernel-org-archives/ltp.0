Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160CCF8A178
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:36:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAAB53E4AD6
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:36:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14DD3E4AD5
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:35:59 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0EFC8600B5C
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:35:59 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-12732165d1eso19497411c88.1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346557; x=1776951357; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GN0mI51QXbU+n0scjrVS7RwLGhG39cDT1nAycs3B5MQ=;
 b=RplAUx5UfdLqQibU5Wd+z27D9h+4+CQ4cXFEfJm9kE30ppry1oEyLmVDgIzZday0iG
 ciBIk92k7KHL0XXZPO5awUMQPX8KiJvBjKmQHFXewPx7Hv/v1zeLX+5MRi4kD6y4lg9m
 Y5YrK60aIm04jQnXRpKiB62Bw1lvLh+6XCLTRCnWixSRIkR9bCEuDkSZayyB42HRfGFc
 Qr4tm69cTBV/Z5j9WH3kfZthxGdNaWMQQeMYoCoVimLe2WRMP7VjN8tES4CA3367FCb1
 K4YVwM7OT4V/hYu9QRwi3zRGUbKZUDvYrZ/j8ncfj6psLaZadapO40D4m7NTuR85ar+j
 493g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346557; x=1776951357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GN0mI51QXbU+n0scjrVS7RwLGhG39cDT1nAycs3B5MQ=;
 b=PpldA08r8GQVmDjReyMKAdQ3DIZgrEz4DUws5tjQM5vy5OaWuKv5pjVWTwGoJB43HG
 NiMYjm4may/EOBbAjwF/jk778+k/O1GaTCyvlcgXOwhGk8vR0Fs2pqXhv1HS88brNqBm
 s9s31BAASwJSNMsGFNJtqMpkvEC9DskAjQearVYtmWzyg8j0wtN5s0m5vySmOGRd3qG0
 LqJRDbd/iWs7MZFfZNYIf780GsKYZib+BfzXZHq0oMedwpuCB59K/M2rgGI5FRqlvb6K
 PL6vbiHmWlWk04Lnr9gnCQ239/zJDF72szfR1HjMN928wxYieZHuFrlCk6fgUH2l+aS2
 Rotg==
X-Gm-Message-State: AOJu0Yy2+nuQznIl9gwxUUB53PuIJ/NJlN4Bxx5OX0r7MAnqQsNBz4QH
 U3K9nBxndz6BrcoThKDkX4cWWAyaIeh0N8+3z3igcOnvs6YSZqQRDPDU
X-Gm-Gg: AeBDietuaPUytRcePHwCtV8Ej7iEHuvbhU4N+eseLcm3xe4dxb//6SAhFyX/T2Ba0oi
 scZ0xYuoIK11AvF13XgDo4MhsCJLgq9Qfh9OblgObH7p1KiXoIhvDLbHKsN9rDhW4GgJ3/Dbtp5
 Mvk1s4JDyYSx0thMH82LuWcWU6pPaFJKpKY708y/a+yYtfwAqsJ0im20yWzLfcrCdOppG+sSNEI
 MKzjqc4ZM4dxa+ViNxOHl88AIgO6n7LdNo6UGM9AEPzFQaAGImPsIPxIqbMimLtT4ciqkD05M1Q
 zddF4hMR/yR+VElCbXLYNmLh0ivOLIUiyM+5+j+JPX28pBpa0LWy8BSVPODBtxgx6GWoCrng5MF
 r61a1L9InvQ1PKD0Muir+LYTn+rA4zhj25u++yABLoepr9AYMtXhR2nt+65sdLoLU85x2lVrMyL
 9PtDvupeRpmUDWpfaHTSLWxbpce+A7zpVaUcShPguSo9xn1o/Uyj54sALyYLxj6Lw27VkmR9SSr
 fsxdVXSoLPx2nptOxX55Sq/A936KZH+AeWp
X-Received: by 2002:a05:7022:6b8d:b0:129:fe5:117e with SMTP id
 a92af1059eb24-12c34edd87dmr14168595c88.26.1776346557097; 
 Thu, 16 Apr 2026 06:35:57 -0700 (PDT)
Received: from
 runnervm35a4x.prajoiou5htenajwodrmzf4tne.dx.internal.cloudapp.net
 ([68.220.60.1]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f569f4bsm7125962eec.21.2026.04.16.06.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 06:35:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 13:35:55 +0000
Message-ID: <20260416133555.3952-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416-fix_clock_settime_helper-v1-1-2874202291bf@suse.com>
References: <20260416-fix_clock_settime_helper-v1-1-2874202291bf@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Thu, 16 Apr 2026, Andrea Cervesato wrote:
> clock_settime: use POSIX runtime detection for CLOCK_MONOTONIC

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24513029369

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
