Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B9DCD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 10:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D95513E2AA4
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 12:26:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EFF13C55F5
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 12:26:01 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A378E1A003FF
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 12:26:00 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-9158fbaa4bbso865558085a.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781173559; x=1781778359; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2RCKIVttNRXIbRHqVdFuuXxoWgMeO3SaP9wytezhzY=;
 b=jDevQk3bf15aKQacXE8U75oEROjYYnbQVAOyHLaC6LciyJDwfd6Pacsbhwg9M0Bz7t
 Mh8hpR2WJnC8zK+nY58xtJU9gCQkG1PRULl9yAZPlrV26VIOP5qVw+XVjnICopJYBbHY
 1x+3m6t77VzJfdsfn4EWIQpcDhwq6bhI/WGYCo9bjJCb07Ylqkz1XREPWcgsa/CNiF/b
 Yp5YEAcOpKdmU5O1cDVUvHVHWjz2B6HyU91bcXOWGfDXsEa1Uu7obqQetaLg5mNWajpm
 NS12XYt7ES5RObKa4WZCrT9zmQ7Y9r1RAzyv8dnU5bSz+Nk54Ai0QS+9/dDgLCGAk7un
 sB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781173559; x=1781778359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E2RCKIVttNRXIbRHqVdFuuXxoWgMeO3SaP9wytezhzY=;
 b=ovqTkksJeZ+oNauNjAyZaf0Yy0OJ29uH7dhuabRce+SnCp8v6TpMwGiQ0kdj3j2eI8
 rxlysleLV6uWRRhfRLOiIWSYrLMU48Ywf87DYjtQR2Wuf7+76I3rIb6gdyGYYvGZ47o7
 cHEk5MA+xKTRQyKyk16AiLk9OogXov7e8V0IJ/iLtd7JjHjYCwjvja/3dssVpP5YJqkq
 hptrvAGWXwis/iOvxYiH+HFFYu+HDqmPtykuOd7LtZH3YEI/C/lJhfi5rMsh40Aqmi+8
 iiph73Tsb8WBXKdUlat6IQFRThb7EH+64ydHahLs/gN88zmHZn+7VfLKDHH+bGFwK3jm
 Hwdg==
X-Gm-Message-State: AOJu0YwOkEfi6SUGCwPJ/h5gQ1EF4YiVpV9AMp+AsBWtqYcBH4vZI0pH
 79JfF8vqVCGVGM4F7+JlGkTvpinRmP/4iBhiDdyY9nbLn7wHCMKwBX0h
X-Gm-Gg: Acq92OEB4HPqlkKlHAnUVBLff2JO+cqpAcAo9mgcdMHTAXl7Ml0v8VISzqFmhJHTj78
 OIi6G52Rw8ISEuTENYb3nAMNoVyGmI0mEsJ5FjKNzetZcIFICfKnV/aB3gvrQnG2FrklJK16epH
 H4s5WnZRCTTibK8dNlNQ/jqq4APzsb9BHtPfTdideoQCxIaPtQkerBHGaxXeRKjZMhPPEtwJjO2
 U/vEJr7z/bmdCe42YPHQ0MprLuDauESUAfJxDtwDAiAS9RVAux8jztDmy3iWPB5/AaRl9m8pP1F
 gPKVfPFAQ2Y2r7Mj4BC/Axts9h/Sv3YnPz4bbY149osIUHDaGTk+D1nwiDQNBNdKIaYVmBpaaGC
 aFRI+qrvri2kEpc9+6dcbjVVbQF7uhdrEodwKoo50ZUZETc6sBFxxdRgZL+qHxJSAOCZZ33zh57
 dQUkPvoX8rS0bwHoaLXOyMSlyEtLRorQofkbpHeAXucfilf478bIHYAL8CKfaJlFxOUIySBvlio
 OhH2cJl35LArXS6yhnojbGfWVGpQhFq5OQkxe+tGyFJPsft4C2ZE6JycC8=
X-Received: by 2002:a05:620a:6012:b0:915:8865:dc01 with SMTP id
 af79cd13be357-9160ae0351cmr288031885a.46.1781173559379; 
 Thu, 11 Jun 2026 03:25:59 -0700 (PDT)
Received: from
 runnervm1li68.l03qozouujiejn2dhmjp1n313d.cx.internal.cloudapp.net
 ([20.57.47.233]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160adf51d6sm145044785a.28.2026.06.11.03.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:25:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 10:25:58 +0000
Message-ID: <20260611102558.3992-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
References: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] xfrm: Skip on EOPNOTSUPP in compat mode
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

On Thu, 11 Jun 2026 11:37:21 +0200, Andrea Cervesato wrote:
> xfrm: Skip on EOPNOTSUPP in compat mode

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
