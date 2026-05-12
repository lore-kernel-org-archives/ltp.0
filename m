Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198F8CD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778578338; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=pFZztGmtOmp4HBIoO13agQF/AZZ7r3VGM9JIKlyd9Qy4qQM9TvW7mdiQwqMSvr9KrYb1F
 gTqCM1EUl7jKhrA8eyL4t8xN9PS/soTxmLQ1rT54MaC74aSuqfHX73qt8s/UqA6SPHe84B+
 LLtun457HOq2m6UOYvWcd9dK52S7YAQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0E853D03E3
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 11:32:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F50F3CEB8F
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:31:55 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C1E41A003C0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:31:55 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso48503195e9.2
 for <ltp@lists.linux.it>; Tue, 12 May 2026 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778578314; x=1779183114; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=cX5UJ65MtuTG93Y2uN8V+DRFK28cFCU1nhs7Ihg2svUG8IuUTQj1gGrTaGGKYBYQbQ
 luN+nxMaYJNjyvtziIJ1FL3VWGh3wv2hqT37bw1i00z0LU8YDnGRIwVfB4r6gFQR3RrV
 vzh2DPragux9HHP9y8K+ODEWCo9ihFQT9ELnr3rUvFEWEv7EittQOaWRrIfmNytPuIrN
 3IiRs3YpQj40vMVHU4SFtAQOityJ2XoHZ4yp7BUrmG+xikMYTsV6ehPzXzS7U0NDJsAM
 7+qotO5h98Cg2pKim/pukYKT9SJre/gH3FihLBbrM6L0m15QYcaJQVTVLyQP58jxtJhp
 UfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578314; x=1779183114;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=DOZMrvth8M4F0a5ZmmaatPskLyMWPelnCESLTJrhrSkrMIMngkwNKZME9f5ni3PC34
 uswHVQG8JJobfnVAscpgBD0Fs06kLBhQHRJ/POCVaEZubZ/ctsZ7VwFRDtcoseesnn8W
 8YDWhtgWFT0qhf5nUbKvG6hRyUCpok/Yf4lm7DJb0ocpD4HXs3DjzgUqJkoDXBVZqWFX
 LvNz2XDpNN14NASn568u+UoTDPLynb4f8ksmpLmID6xP7vQREAUNjiTtI20gJHZvP/ii
 uuf8B8tl8yfa6/5KRFjE/J1ZIviizH0EicDIiweD159pUyzR3U4/4MaQKDTRyKm8/5lV
 O9bQ==
X-Gm-Message-State: AOJu0Yy9tMNwyXsELpht1CEuwrSWEhoIPWBtkg4UCIkrfbDew9HeK0DD
 fC+igyYX0iEdoMGd7g3478LmM965FaXBpURFV2omLwvNTMFsgoUyj341R5YFH8Br2eLA3uopHIJ
 g/WXrx74=
X-Gm-Gg: Acq92OFihVwuBvCBOOX57No9TQJvVdiAAaVXiq9zgjBruttB+D/MDUmtcHc8e8ZzdP4
 EqpCyC6s0y5C0wtyhM+6UUZYeRX64AxCZHQuBzsHhlDLi9S0OFjm25eD1Qkyo6YtkrebG4cG1hl
 A9BnBGgZGE4+Aiw3W1zJQ7InMoQqQ6oGun6OPRDHGyd5rAM3Jjtj3Fw8kFTVYlD5V8jrsP7YCHS
 0vgkUAQpG9TEDkAQPmLDhdhZf1fJqElYzd7kO+rOub8g6/WuULCRzivwp3wtxwfCYYtni1W3tdO
 b371SjlbKx/bJjrqsvbiTr8x6E2jUO5nd+HoVFpEElX5lhvs09o3tw7fHPCxJJfa4XsI01eV4dr
 TwbrOhhK86ZWU5o+zxX+nVc1IvKKE4dAarGSiqyY6pGGjzHFSSuL55sYgcli39Kvmo/jzSdfnp/
 kCCd77stm97T9LvaXwmXvEKyEEFsJg/Wi7lFB+i6+GupF72sdd8dPCaSUB8VAAihrtFrHVeHCzH
 HN7HzMEqw0XtNo3F0ui5k8zuE3dtITWy3aJq8iOb+6MA3jUd80gp4PgMAmYPgsbhuSY6a0Vk7hz
 jN1VmIpyyE/Y
X-Received: by 2002:a05:600c:4fc4:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48e706bd7bdmr209003995e9.19.1778578314149; 
 Tue, 12 May 2026 02:31:54 -0700 (PDT)
Received: from p200300ef2f4fc90038232d0ed1260eab.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e906b04a9sm54002945e9.7.2026.05.12.02.31.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:31:53 -0700 (PDT)
Message-ID: <6a02f389.050a0220.b6ffd.0f6d@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260509082649.8533-1-wegao@suse.com>
Date: Tue, 12 May 2026 09:31:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] OpenPOSIX: Allow 0 return value when detaching
 or joining joined thread
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
