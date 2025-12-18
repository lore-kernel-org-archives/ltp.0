Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7DED6D229
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766065799; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pzo6tGjz7VBpUqinvLre/g6/Bh3ySWgIaFWaSWlR8L0=;
 b=O7B44fAOwYarEVsAKlKuL6iOkn4a4uEWJ4VoSA9UQcuBPY1xkOpPcpytjMZzskvpKjM5A
 3VepiBC59oY0qwgEx4ESpWevTMk+S0sk7a7IfB9HP8Ax6wCHe9ZtHA3d3idJBJbwFCSHs7z
 eI/FudykQcyRNMNLOcvjxEwaM6tLAs8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 299B93D0481
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 14:49:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74B193CBEC7
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:49:35 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D47E6600A0B
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:49:30 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so551009f8f.1
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766065770; x=1766670570; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEi32Z7sk0URKnwY7rarWcaSH2hzC7klZABd4mOj1Ic=;
 b=eDperBWEovEH8EJ6vu9BvAWQ8wm1DX+limf3T08IQfhEhncztws6aA+qR/zkChpI7S
 bd3KYUjHcDzHNRpQZL3NxeqFGtcR9HqShOgoBmfW9TC1dpUzxS2MOpOorgVXdvS/iRCu
 NsDTdcmAvXZ2kT4TnUhUtJIHrUY3h0JKuCwC6WsZHnCb6Q+mfGT1+v51HnsrY5COqiRx
 hiJ32xEoCMvD3DSNFjl6/CBxMQ639HYY2jmROdPEmqLgYAQYtCJxqH4T32BZU0S/yt2v
 aoqTmD0SwmrB88WSnpKH32oj6mgnQ4l9mwfyWwe8yqHSU5pX6aOfaXG1V+xdIrCSaZQ0
 HwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766065770; x=1766670570;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DEi32Z7sk0URKnwY7rarWcaSH2hzC7klZABd4mOj1Ic=;
 b=Hp9IxNe617icDnhv7mMbpXSr6ku9wp1QFugPTYm8k1aVlGSuSoAOl6WqcGUCBqS0nZ
 IOGeaN/hXpJ8BpZkp8mbWyHnjPw46E14iTCDmoRAqGUvFMPPeXQAMjJrltZE2Xkda7fp
 zKk81zH10nc3kaRYjgScDKfbsUhz6B8FXQH7UvUFyknGhmaTSzgpUBIVtFd19h/en07E
 KLBE245pxRNUxrgWZsNHP3h116gZta0FdcaFalIH5y1DsMorPWJMygIk1hbzoOUOsPuI
 64/vzPQ3oDBmuGF9yzzzt2hBDtYsOGX2X0fy38nDNE2fGvF35mr0af7RGVhJeF7WVOpW
 cNgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQgNxDWxoPixVYc1uevBDKwVdfEKg4nwjsAa2NTPTYFQTHC2q9oAx7LDeI7ewJD5hsU10=@lists.linux.it
X-Gm-Message-State: AOJu0YwbV9NufhL2R3kEgnO9KHpKwJX6OBZGXh/+mLuCg5CUwrz2EW+t
 un5lsBzmnabBDthLqpB9nUHFpJopLK1lgVY5NPzStKCgJKic0ywPgn4sen0T4XcTgivc1JhfIir
 KzoFb+Sc=
X-Gm-Gg: AY/fxX6Yna9a9V4fDVm2upRMqcl04y9pfP5f3PHEkTck3cSaRINov/V4WJgoG8gDipn
 8bq0nHcY+u4hGDpbItDhBqTnZJ7+cd9y5svigWsif9LtEd1vqTcSTFzQ02I+Hnoqx0vJTI90jTW
 Vd/R/WyjJG9AfswRIQm1/sLeBKaxVFrLV6OacwZI1YKXsiDVc4pxsvbmLnBd2UocwQySjq9SDJv
 fxtmwjC1ebieEnuAYy1LqvSfXDsJEN7YbOEPwbZaQ0B/8T53I5d2wwywQJqVq1/Iov1EMW0Z/PR
 2DZHzyZ1rXgivHyI/2hCPPjnQF6md3T4twXL5ip5aQRwvi7vnckZBhdLXZ5bTgkuJdDJ7EDmyi/
 qlLwXiG4tCVDJ2SY9y1+cCRkov0jXaJYwlN3besINFXqzj1EMRdAdnf6bzFYH3O97zY4LsQVCu1
 xp0fme8i2gNH+hL9Y=
X-Google-Smtp-Source: AGHT+IGnsk91X9kla61DwqVk3fJRA1mzw1vLHzqiEP9A/hcGBM3hiLz7jA0Rr0vHUatOz86ReBjb2w==
X-Received: by 2002:a05:6000:2c0c:b0:430:f65d:c0df with SMTP id
 ffacd0b85a97d-430f65dc4f6mr19582445f8f.56.1766065770202; 
 Thu, 18 Dec 2025 05:49:30 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324498f910sm5025254f8f.23.2025.12.18.05.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:49:29 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 14:49:29 +0100
Message-Id: <DF1E2E0JRGSY.3LQ2W7TCBWDLU@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com> <20251113015242.799-4-wegao@suse.com>
In-Reply-To: <20251113015242.799-4-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] ci: Add e2fsprogs package for CI test
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

Hi!

The commit message talks about tune2fs/dumpe2fs, but I couldn't find
tests using them.

Am I missing something?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
