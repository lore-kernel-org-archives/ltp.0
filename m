Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D72D68BE7
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766042925; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DzjtFGhtx54ktjPVRhY3VHRn/BTclrDC97/F8om0LZk=;
 b=dbWB2A0heYyvVcQHcFz+gQpR724Kt1hku1h+EV8UFtjExuG8R7JGC6tpMFQvGClHaH5J8
 EL9jU58nEZpDB4rYxzArmt+FsmP2k5qEDJwpLpAyZcuuuBd0At0vuII8gOfOfJ0CqCplC/I
 6Y6jAjJl3xQGifL4LB2q2zVMb/gV4UU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3A623D0453
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 08:28:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 383F03C27D4
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 08:28:21 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9013D1400BE2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 08:28:19 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so44994166b.1
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 23:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766042899; x=1766647699; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvZPQyOGHh4GMO+XYVhPl0AmoTMtnGS9XWiH0g7tLFI=;
 b=INluY366Pek/k6R8cjZqU6IWdETZU1Ga6F2Beixrwqx7eL1Ae2kmHe/tQDzWbLg48P
 nTZJ7RmXUBmzlpuSXsQDBrfR9Wy7V+/jFGGG2Na+rv73YK1AiAkleinwFkFsvyigavHl
 Qk2E2fvTgKIdHSSqWvP71U578UXDJku3+JGhZDPpXzNsnftzbOLoVEt2JeXmEZKYLYvF
 vpN6zMUpANgaYLvBA7vT7QYYNG+rNjy5uGCdn/kXgqbWPAbWKunBxPmF8F1hEIMd5i1S
 /opyY4P+kVb6Qi+1SXj8KgOZ1+t+O28Ie1alRHoKlXbcq/FOykbcc/v9MkHLixtq0cBC
 CmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766042899; x=1766647699;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvZPQyOGHh4GMO+XYVhPl0AmoTMtnGS9XWiH0g7tLFI=;
 b=Jk0A3+Q/kp9ROLD8ulfO1IBxfSvwxho1E2sS67oOvY7t5fALAoMoEu0Gv58XS+0/pt
 aMgWFRaS8cPOGw6lGwAzVe9nGXvCc0ennPN+s5kxFiMecGG5CyYfNySBf9sozIxf8aPp
 HtFM3BQGogQ47femKqQB23x0+LSHJyQTZw+Uwc7NDdkNkdTPhkmU9Pg1tH+MOFjwQKDI
 Rm3WLdWCyJGzJhUNwxSgpT86IXHzzNGRV2mFeHyTPiSRt4m3VAKfPbHCJsN7Mf8sTaum
 +gEElZDm+LdM9xFi8ryXJK0+apohFkaXlk/JJkqi7oF11YDyY8REwoTg/sitcNGggD4a
 7Ivg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWllAJZY+oe9k97rwS+Z0Or22/WUQmZqI1ADL5JYXaaFnVlzbbTs/p5lA3MxWN4rZUXWb0=@lists.linux.it
X-Gm-Message-State: AOJu0YydWuk14UtIRCxXIuArDa/+z6YarT4jxoam/k8DcN4WElzV8wXb
 fkGurjes/avHFNvGLai9bUUmYXP0+xODy30fEDKmBIQ6DStztmxXtxgD4JJxx8Xw6C80axNFcUK
 iZchob0aKGg==
X-Gm-Gg: AY/fxX5fPK3FPhJW6Sr4vXI8H/pplC54MKVk/Q0Q/R4yJwA5s9D/GdLL95gdjSaIeya
 hUwcHUlQnWwTzacZ0XGWlOk/cTy+pcHmAALpNCxVfv0M11KPOprwzFqeAb+hEs/cgFkAozGALVg
 zlaPgEjbIfYtJ8AFy+Yag8E0uoP/HNX4l+nmsTzVl4xXsUgeWIogkquo8z9YXTRa5Dbie8aYUCn
 GQyMP8PRLRiBPVpO56ondz+73MO8IoPNZODZ3tlGXCH5Q2LsaMR0l1jo5dKz4sDOG1JR7exinLq
 33fviP8JFrLllBtxn8pNqY+cgkYM/5W2iwfvG6lDu9/s/tIlOmtnu6O+tmE3JqLT6j2z5uy19QS
 exlfoDCvaBq0wE550jWSWEtdyQoF5elcxj9lKAubzPK5jRpR0kBg+uZWL4nQq3IAMdvhnI456Uw
 ECBg50Ahj3NbjrYCaokfg=
X-Google-Smtp-Source: AGHT+IHZxVjpT0bwenkAsnTb76fPqKegPjma5bUMh55JR+4id3041HeMkKBbmuelbY3gBYBtW/QJ4Q==
X-Received: by 2002:a17:907:96ac:b0:b7a:2ba7:18be with SMTP id
 a640c23a62f3a-b7d23ab63fdmr2300487466b.62.1766042898888; 
 Wed, 17 Dec 2025 23:28:18 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b58884fadsm1633840a12.25.2025.12.17.23.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:28:18 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 08:28:17 +0100
Message-Id: <DF15YIX1VQHR.2SBBWR8UGI062@suse.com>
To: "Brian Grech" <bgrech@redhat.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251217190637.60929-1-bgrech@redhat.com>
In-Reply-To: <20251217190637.60929-1-bgrech@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] landlock08: Skip IPv6 variant if not supported
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks!

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
