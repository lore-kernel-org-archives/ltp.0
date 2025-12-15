Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860FAD5B84D
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765815315; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IWSo5SyJdRu4dy05AV6v7zBCww3Wt1VqWxaur2FyeyA=;
 b=dfhWMuEyG3+yiGETytnIgH8t/1INZCQW+oDZGPInp1gIRwCiKiJb+zXI1E8rBCmC8nDXY
 WcRf/XNH4BDJKeRudN71vSLZx3622fj2aw3OeY3TapDh9PTz/gOgDubDmoZ8nNOLmdfURI7
 HdMn9YcC6XuQZzBN4ytq0xe3p/sr/30=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26BAF3C1817
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:15:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F1333C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:14:51 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A3FAD1A006E9
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:14:49 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso29531885e9.3
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765815289; x=1766420089; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Egr+OREyYJ16gOVXmLLzHGd9bxlGhAvqrdQ+jIqPCa4=;
 b=Zwdyv52RKsOWwDT47JCxVh9QsMwRABe6ym11CWKkujZXAwtGL+5GaqY1ULpKLtLbzl
 JgD1t5+KasDVRgz6eu3ZFf5QM0Xk3vKur8Doq6b0IMQmEdFNBa/FCggnL/XqluemIjBL
 pROmACuFO9wodh010ueZgA3X8OzMDEifZL0QsvN0vRR8DBEShFXJp6v9TKFqkRyK8S63
 8EC2SQbnmaD3XxNHpV+aVifErhPHL2vM4dMAp0YPn1rWcGLJPnWAtnSQ5ceh/ubqXI2d
 RzsBUnOucs384JBJuuiBzpE/uezvvpRuDcNDt2H8GA+cSeRA5kwkFmtFITTfN9IbORc9
 I/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765815289; x=1766420089;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Egr+OREyYJ16gOVXmLLzHGd9bxlGhAvqrdQ+jIqPCa4=;
 b=aqk96E9o2rfCn6AE379+BQi4Snc4wCzY4njCsS4w0y7rnmfKYarae4n+/Ctwi7rqCP
 vZxuArEgYVF8ZWKg05kicwB9+e7AhbEFfu/pCe9nu5B1edQP+2ITE94BoaI+5Pf83x6a
 6+MLe70KPMDHueDf0cg7lZP/D3LipIjiCU7KRU+kuOJoBuk1E1TsH9BDwbELoZvjAbX5
 3dwc370K6Gt9iEk8UbCBXJzCVqccfj/iygKHZT1fUuyCjs2bithTjAOmPlpice/7EHUZ
 OTBG4aw1jvz5YhEF80iytE2PGPpZiVPUMP0QHUt9FUdGHoj8M9fSRP/AN9RwafiREfAb
 j1jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGMFZA9oTkUJkgwtcs1g8tdvrV/fLH2YtDPZ8hznwB3WdcTVrXemZKl+Jv9lyNEowyNa8=@lists.linux.it
X-Gm-Message-State: AOJu0YwOzyOipGOnG6gg19JP/pUU4aaha2vR0Buo8tHFC7SgTj/1GKoh
 tiXE+WkfwYZe8roNL9IQo01/xNCPm5KdktT9ciMcCEX01KESyRGWhwKeku7uZ8qVF9o=
X-Gm-Gg: AY/fxX7M+FPckk3I/LStK3wN0G0US2qVIcgdJJkTFdK2+/sT5Krw5LTqhUIA8enS2c1
 sJ8cdVeYY+HEe85g7zr5fXr9nEsCJIFOMkDj1g+6c8rgzpshbpZjwhBGZyiZFapdViWn/9YAnBv
 fzgZ9B3VEyjMBXgxZtvz4Y6h5ItDe04ERmrU0Ognra2VoZSL65ZygmxxZ7iS9uUYg9qr4kS3vaR
 mdqoJdLmTHLtcJ6blI+xr/fqmNtsxhr9/CnOM8BEzIJB0N/sNJvFwMNXOJOxlyXnxd/+PS+7N82
 UgfYjD0Kui4qNZ3rPZIV+89eM2U6xP/ZEycZ+Pd1GewyyZVtqG/SwrqxmelTThCXOJ/AAXKJiyV
 3yKhP5zAu5ZF/yFsJ4v3pYuBl4Wc9dLqc3m7+YB3AknYR39EOEngKPqeRCjft0S8jbK5c8opRij
 5XLG/li8RLJddcRlZM51M=
X-Google-Smtp-Source: AGHT+IGoMkuKKc5g61NoSqsdg50CIXXFU5eW3MmA5qyr3kO8F4nOMP0PhOWou6k8rrV7QZdEhu3d4Q==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-47bd3d41de0mr10354995e9.11.1765815288933; 
 Mon, 15 Dec 2025 08:14:48 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f32f7easm75608535e9.0.2025.12.15.08.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 08:14:48 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 15 Dec 2025 17:14:47 +0100
Message-Id: <DEYXA0DF0ONX.31DRZCCXNKRPB@suse.com>
To: "Ben Copeland" <ben.copeland@linaro.org>, "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251215-fix_ci-v1-1-792d418fc240@suse.com>
 <20251215155532.GD272695@pevik>
 <CAL0q8a6bP0TJn4xCBoL0sRKeLatXYMw3qUGJQszZ5+1tHv83Qw@mail.gmail.com>
In-Reply-To: <CAL0q8a6bP0TJn4xCBoL0sRKeLatXYMw3qUGJQszZ5+1tHv83Qw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: fix patch download when using curl
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

>
> I suggest adding --retry to the CURL call. --retry 3. At least then
> when curl fails, it won't fail on the first?
>
> Ben
>

+1

I will send a v2


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
