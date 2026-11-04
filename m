Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05114606A32D
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VV3VIJ1C
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B65AE3CD350
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 20:01:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF3EF3CAB26
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 20:01:31 +0100 (CET)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57E626008F2
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 20:01:31 +0100 (CET)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-36e06480786so6264eec.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 11:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793818890; x=1794423690; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rEH7td7LWkgeUu1RoHHAOLkmOQrxeUuMDr6yNd6t+O0=;
 b=VV3VIJ1CO49TIxE0hQPhaTKazuNIGb5oPNn6aYUDXuij5pXMzuqhczWLuVl53jeO+R
 VO0yB0/0+/6fxaYogiw3LpCe2EnaASwLQDaFxpcp0SlJkipmogTQRJ85c6jKZVex1C3h
 Wvb6Tr2GwrSlPDYuYjgOSiWlyth3bo44MVBoc15qoe3VKwrf0VyG5pY5krHYcqQzNx38
 AWaexQonsnxvBhLuXOt1ZoDZWysZ1mYF6NaTfnOHmqYO+HlYXMJTJN6RyazKNzzC5DTp
 AbMaeND4EDjJL7UnKCN6c7DothjZZxiqSKbDFX7lNY8WEfFypPmMso81j/p0f50tSWJV
 S9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793818890; x=1794423690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rEH7td7LWkgeUu1RoHHAOLkmOQrxeUuMDr6yNd6t+O0=;
 b=pCl/wVyETFsG4SbwqXcxcbGnoDg6+/fWyOX0mupstPTqqfWTM7h9Rg2fanIWpBwqda
 v+y+tdeCMNCQjFbziuI+mBXyk+EJ0x+bbg9GPXTFFgl9gAFRiB5ARZ2j33RgxilvARR5
 lnOo7lzlIqF1pX5OmEWk/ljx2LzU46Wocl+NR1SIIGAJ9j1JcL7XW33hVoLr5CCmEMaC
 LmjTwZVefNg6jGICTHWfb0Yz2JzNOSD33GH+CkuHmZs0NkAlYhMQJUPS3A2Y85luZVXs
 wK0R8d6PLXgYxGnCWvaiPrhYu9odpVqr5ojBcNSkTzx6CcIpKszORkYS53M+MSepW1LT
 A4AQ==
X-Gm-Message-State: APuU4Z8RkZE87jtXUQ92kw/Bf/sRUkl0shde5Ky0HF1ikBbIMlkdZDTd
 fzaEYQ/zs67sVXhUjIC5WoJG8R7aEPcT561jqH8PIE+QCiOQ6AHPyRRYSWPV+NZL
X-Gm-Gg: AYBFou3AXmf6+9ccpaQKlyMJLbkjfpB1MQ414bEOX8sHWsiYunsJgbGG432CDXtbzNs
 Vnhq81attsnoF5+mesCbMfeXBTGGiQpIUpcQaVWFNu2dqEb0baFtgYlzhIslO+waHK+0EXVqFY9
 cLl4Kb/ZbnmBmQsMfF9wTXYy5EoaBijxhph6rN1R+AwzFK84oOfeg6HnEoJQR3gRivrSm3talbZ
 5rBbrHgkOK5IE0D1Pc5CahpfD2c7WsaEhA2L2kGSXTXalKK2vlJlVjjOD7cJliMzKG6SqFGz0Fd
 O81Xn8PBM5kmxuHmCQ7hgUnKtDEVaCeTt5R6Nx+d29EhvJJtLBsal/7PMEpfxXPwCIjKze2TtI8
 n4cLZYLfTso13vGsYmjzX0gNuJVFJYS4Nn7MpWsy/c384fDOmdZggS+x339soodfoCAEnux/lrJ
 +hacvm7E6LNc5jm90CV8L2AvxXCqC+pwFnqSUavdsn/TcQNkLewI+meViTbyxAqMakv/Vweq+Yd
 NGcVqVpT6+3wxqGi5g3SfIekz8okD8S3bjR2/drPCpddm0ZKzUoeEi/AsjdM0GvjZt9QXpNnxSD
 vF0ds0s5xPZhHgtaIyitgu2qCJbLzeYAgeCpZ9KTkHAhMokZF7IFuwDGoV6z2UxWANiVhQvHkEA
 6HJupgFoEGS0hU2UB8azYuScV7SkzTWsx52IcImKp
X-Received: by 2002:a05:701b:4349:b0:1a9:d04f:1b55 with SMTP id
 a92af1059eb24-1ac5d0da4acmr23399228c88.26.1793818889257; 
 Wed, 04 Nov 2026 11:01:29 -0800 (PST)
Received: from
 runnervmnwato.ua2h0otvkkhuvjncfmrya3lohb.yx.internal.cloudapp.net
 ([52.161.82.84]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245b8822fsm11516681c88.2.2026.11.04.11.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:01:28 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed,  4 Nov 2026 19:01:27 +0000
Message-ID: <20261104190127.3959-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182800.421758-1-pvorel@suse.cz>
References: <20261104182800.421758-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sparse: LTP-006: Detect files created in the current
 directory
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

Hi Petr,

On Wed Nov 4 19:28:00 2026 +0100, Petr Vorel <pvorel@suse.cz> wrote:
> sparse: LTP-006: Detect files created in the current directory

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
