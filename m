Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BA7D358D1
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 07:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769673515; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QSjJrJzB2xLNnJwOHnl19TT/+kkTNZXVZRlIJ2B+WF4=;
 b=EsFfjo3CedowP9lZL7y59e9QGCiw0JMPsDhhDsYqMiLPLAWtqldlE3zTTh7JB4gQ1VB6L
 3wSQqmPzRRaq3GYQWfVHY0Sji58sp7KTGWuKQ7Bs4KRMm9299OFzmx6DXVXuyZ6/w+AiUa+
 xwHfCSSe1BbwOeHUuo+Mgkzv77/cUuo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4FBB3CB234
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 08:58:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0223C29B6
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 08:58:12 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3A9351A0070E
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 08:58:11 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so627022f8f.3
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 23:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769673490; x=1770278290; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEsXcmwktaYzA3tuhogFUgZTG7q28ddAiewi0abVy4Y=;
 b=d4xnGQpu/n8j4VIRU5HWmtC+UEv5l+NdmZLbokPHg1Uct1kZRp9Z/mFiq4hbNq9Yxo
 nFTV3j/khr/1jG+uuED+d3qHTHLCEuj4za8zRERrtKt6EY/pAJTT5VojI4p4FABY6KFw
 hXaTOgv4fCJn6SA+6n+KSA56sapwDRaAMh7Wc2g9vo1rXU5MnC/Q3h4gykpbqpI039/7
 SACtUU8wDLkB7bPsh3ItXmnu3ZIe3v1wvLur29Vjjei0uRvo3bpnFCKCx29PsWPROMmY
 5Zk1QUkRufA7DnLTz+KzQ+YBtjLVBif9/jTT+bYpI4x8HL90xuWkxCsSr0yRLMFggnix
 lvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769673490; x=1770278290;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gEsXcmwktaYzA3tuhogFUgZTG7q28ddAiewi0abVy4Y=;
 b=qgBiktYcKxGvTU0szRm+muSEcj5/DPug4KPYx+T21Gel8rhuJQjqBUOmGK8S2hBehn
 CdJ7hK5Vt9N6fCn1Lk/DOzOqYo6De6vUKGD101+a0KCHGPygCxJxA1VE+vuNlxw5J6lF
 e5RYMUeH/r0jlgPqGMDJRRCKXJeW+SHZxjl86fuvJpBbrMGVIpZtABfN7sffSTRCu4yn
 qayIufgO8XD3kW+BRj3/4671+noTMrOCH2lY5K5mbnqpm0Rts+XQkv8n5KRtUZzd7OhB
 Q0z4qO2AuAOHMG8ENdAbAbrUNaiARfWvl2HWPtsUz8mg+7Id1/kqpmMQxwTeY6vWxCrB
 c8ww==
X-Gm-Message-State: AOJu0YzrGFQJe+887OPJigv4LpX+W0cJat/vrk5/kHXdbk/qpDxYCIyX
 ltn8IpjNAstQr5dKY6PKW2oRe0KgLlg0JFKhp/7kBkXA4lRlFbaw5SKlQPEA7mGqmo4=
X-Gm-Gg: AZuq6aJM9KO4zfVD+FBWkKearyny5NWdbInCZ+fPLGbd0opZVZw+4ZAvwWPEyP101FQ
 nU2bKWVqigJHlqxMKLQa6SJVA1ANMq9AKQHF8aaCijpJ4g13BEDOf3hvimACBwZSeGZA1DEuXny
 G5uluIhBxZzwgA4sMauwCpvjH2jyqAEmzhws24GDDhn9wp1655QZI6H+jzOxdmccQHjxclNIIp/
 Ki2evblk/SFUo2+neS2rErWFEnXfJA9TKu5g/2OH+5qArE+Yjd8tMhdjfcfXuiNwWAd1b+HFUKd
 8QSnPPkl85jy5O48BruuYo/W+3cUkvsscxap+cCCQcn1cb0nwcZXk/HEnfsyVpPBdSO7DM0l9Wl
 VmqdOXw2BClwL+DZcjHNVLgu4hnUHmvfzbpsRCuaQQUM/nos7elnrVVQapPVGmsROZr7CCgZU2Z
 PYMfYEdT6+HDR1IBzFANQ7FKusNs+Nfrg0ZUgAsAKtCU7f3+tskhXsqmGGK1x8971y6QecJGZAL
 ViaNts=
X-Received: by 2002:a05:6000:40da:b0:430:f7ae:af3e with SMTP id
 ffacd0b85a97d-435dd1c1339mr10701936f8f.32.1769673490443; 
 Wed, 28 Jan 2026 23:58:10 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm12064515f8f.3.2026.01.28.23.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 23:58:10 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 29 Jan 2026 08:58:09 +0100
Message-Id: <DG0WW9TPR7HL.4XN47J4S4E4F@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20260128-kirk_v3-2-1-v1-1-9364f4bf919c@suse.com>
 <20260128204237.GA56387@pevik>
In-Reply-To: <20260128204237.GA56387@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: Update to v3.2.1
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Feel free to merge.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
