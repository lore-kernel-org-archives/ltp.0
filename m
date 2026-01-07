Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C0FCEFD1E
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767788612; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3PH0t6sww/Emy85puNfpjbyPPopo8pwbWMKYPWzo7lE=;
 b=arn1iY6pJPc0bJX9Pq17ANT+22bWfOO0LzX4W1+T4LmknfbTgAJHTRDJxdKuVK1sefCAr
 B896OrBoQ0Lo3PfZy6OWiMBd4SnB2MVtK025lB5EO+SCB3Zgy0NEQqCwlE6nAwkeZ6FUTDN
 WjLcBZKroeTd+lhWDWGaftX0TmB+lQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CC073C2F29
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 13:23:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C06C3C298C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 13:23:09 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B27111400762
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 13:23:08 +0100 (CET)
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so16971145e9.3
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 04:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767788588; x=1768393388; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAwYQWe9XbCTtFXg+WEC67bz7k8pcD/ZP9QqM4eAnrA=;
 b=ba/qmgF0RvewLDXH3d6BfKbfA64IKr7HjpbQcXFyWUNM5Ne+pTNiz1lU2QcWFgGRbf
 Dqu6ISEYd07QUFnUMpjJ6yFUAQmEikm/vDl+Undq405a2fuuvt6ZajgHqWgJN5gRMl5/
 PUeA+Ps/aVz+2Zz09qLqGhIxoyU1uxSLie0S4to66xy3M3yUFbIg/kk09IU2mso2Go9G
 P8k2fv8QFvuC+OMzE3Nh86Gnj37+B18ptYD7SoArEalkFT/5BaSYCnx9paPxbih2XTa8
 OK6MpBlbwCUh1clxb8ZsN66/caM8wguXf4726g9fuRXX6VO30hsHws867TQn1oMXhjMi
 zWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767788588; x=1768393388;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DAwYQWe9XbCTtFXg+WEC67bz7k8pcD/ZP9QqM4eAnrA=;
 b=M7iTPHWLye7GH8dzEpgQvFf4IdbdLVT9kOAf8H+VQ1u37Ph/aiLMiG0Swb2dxwn7UR
 /XEdBRajI4xoUlDgOeAH6L0coky61Gl5/7NkGxVibEA6X79auhh4ZLffCUsihPODXIlF
 yTyPxDoPzwNsr5+Qh/oucKb/abIUrDhlqeeNmkAM1UZxWQUtH1umthqemIJdws3QwiKt
 dBnCpvpybL5nfvYvfK5fsFNrmHGTiqvyEHskyFq04Q8hEaq1l3SCZATHnrYensZgdDu+
 ogrVbKAckcwvT8e3Sx2aIeLNGNGVd+kpCkc9bKnZNJuCoY4l18r649KCa07ycYrp73y9
 Z/2w==
X-Gm-Message-State: AOJu0Yxgh2LKWsQd5Ps/xroERvnmoSvLbXwgCCGh2LPcQOPNUOs0MtLi
 bmfKFoT1Nj8BKRJQaq59OB6xEJFUhv526ECAqEbbdzCy0Z99WxbQ5+qYLYdiD8Wp2rHu9FdVe4d
 FS7x5x2OfmA==
X-Gm-Gg: AY/fxX56gODg5a7TfFsv1/yIHhbCh+KKZ0ZBFsahDNhWNd4SZzQP2HjsLO7MbhuzrUD
 AxaIYjhT6oL5oNL644FvZvl6HLU4jRzyx4Fw8AWhoQgY4EuL6jt+QbRIHnyHPWl1xSmdBM3IdqA
 B0CwipNTSoyknq3H4TwfqvO0zoKKBY8qJt5Wf6rtfD8PGfkr2AbprFZjuSaw9CvZvI2b4yCeSPU
 IET5kl9BgKGa8PakArEBE1+pHEHgZIl6LzwiURqzgNB4rv1V/uS5wOjpnBfqnaFam74MiGCSaT/
 WAjnc4QSxuKkyWvpwnYtqdeauKev+GDgHzV1GCBIr9KNQthNVDxn40CR5IUPsYBQCRp2QPGDV9B
 Liwu/67i47fY9TlfXssVi9vsdj2RSeu0V+fDnaCBo3wz2pzvWFrCJvoYzBN+vTo4xvhwIL+BMzr
 3SCe1+mBxw30yN
X-Google-Smtp-Source: AGHT+IESBKAKizBqV0rpvGQuyvHUgOBxa4k2vm7K2fLUSSLmTj0CHVbOd9QIoW/vaXKFAzLiV1NNhw==
X-Received: by 2002:a05:600c:1992:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47d84b1a08amr31461395e9.15.1767788587955; 
 Wed, 07 Jan 2026 04:23:07 -0800 (PST)
Received: from localhost ([88.128.90.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8719d057sm10569755e9.16.2026.01.07.04.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 04:23:07 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 07 Jan 2026 13:23:06 +0100
Message-Id: <DFICR5JD80LT.3B77J5KV4VLAY@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260107111133.27041-1-chrubis@suse.cz>
 <20260107111133.27041-2-chrubis@suse.cz> <20260107113155.GB753482@pevik>
In-Reply-To: <20260107113155.GB753482@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] doc: Document process_state
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> @Andrea: I wish sphinx doc would warn about "undescribed" and I thought it did
> in the past, but I don't see it.

That's not sphinx, but the 'linuxdoc.rstKernelDoc' plugin we are using.
It's developed for the kernel documentation (perhaps, we might upgrade
it to the newest version) and it doesn't provide this.

>
> Also we have too many (~ 220x) warnings:
> "WARNING: duplicate label description, other instance in ..." it's not usable.
> Any hint you could have look on it? If we solve this warning would get useful.
>

The warnings you see are generated by:

	pip install linuxdoc
	linuxdoc.lintdoc include/

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
