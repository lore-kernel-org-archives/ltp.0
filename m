Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73554CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780652555; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=y105NBT5QaDfv7QJr5KKGzfaPZu6SSEmnxJacoakKZ8=;
 b=aodXfLhuQpaojKKlOAh4iFhxL9Sk2GfgXLsEUH+in8plF3fP4iVrtRmzozbMwCfFFfpwf
 ZdaZqok/FYrxRv+bTeQQFFeZULbuXgJ0LB5PWeVVksJ04WNRCWwPhORNxZu+YKN58JEAnJ8
 6cBTrxl8cA9BHOaxtJzGTFbW1DCJzRg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7D8C3E547A
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:42:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50EB73CCEAA
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:42:16 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E32FC6003FD
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:42:15 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso14618455e9.1
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780652535; x=1781257335; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/1gxRsPTSnYIF6a61/b0ikm6LKszMOL5jlA8AI3ezHM=;
 b=AoZ96BFkSExwZSq84EFqD3DgG11OlUSG6iiZ0yf7B4S/Aqc+fVKLdIQ3twXOzfdnUL
 Ia3Rz7X8OitS6dK/MqxzJZT/W68oop4krh1xSXX74gHQJycCzqUex2fKQFhJUa28Wxc0
 Dc0V+nN7VXSwdKCNAYHplGqQps0JBGeosyzytjb9g9Kazg4koje5IHQ9dbUgAYEKLEXl
 MZoVv/J6RvuqBLxtMHClPkW2BPYG7+ckrxDReoin7zwF1obXTAp/AIDAIDG3Qbq06hdm
 0mNVfkZHFhg6mv0o8sYADImPpfjrU9VJNHU+jNGGessHPU5tpxhWeaXfE+5GqvHUo+nG
 XF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652535; x=1781257335;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1gxRsPTSnYIF6a61/b0ikm6LKszMOL5jlA8AI3ezHM=;
 b=g1vXo8ZN+BKrjknZ/cWAvDuza3Pe+iUk/pIapwkP0uFFodOtu98W0O0VgNCd4cSpRK
 zj9pYVrFmzk3vdjwXDOyPRwRmkE327icQdAGeqBXLwm98qWfAAS0+dmVUP+KpqqF00jr
 taie5UaZvmFdRwvzbrTrXOhXm2bbgu/k7GauHYcgmcMhXsqS10NpT8+8zaI1y5YAsuvb
 mdfqkSqkpCcqbu2gCniv4uNxyFTvpx0YHqyLGtOF49hVVlcSIyisqRvpuGnEmqwcb4cw
 VehxjOOkbqV9sYtet66EfGiN+F35PA6Av/r81D9+PYgz5tmWdXS61gnBtzKwU8l5rwzZ
 M4gQ==
X-Gm-Message-State: AOJu0YyNPb6k8IRP0h6s5/lbQW1eo6Q+XLrVA0TUoq6GigXi8YxVj3p7
 y5Xw7ydBcvfsm4xuMHTNAF+b9M+ELdXLKzhU3cLWaNN9Vl3F9CVHYOJe6C1JXHMW38I=
X-Gm-Gg: Acq92OElheCLrVewTrDPf3dmeshiy39bZYqmIQX8rWU7BgiZwBFb1+pJmi9Q4Dyvfa9
 veRBY5yYlyUtxCUbQqLWuo02JwjeBuFJsBysMChVkycB3KmWCmCp6wabwUgMkVlqc36kX/u+AMg
 C3CEWdOe1LiRRyjTYxAt2yzcZdIktf7Ho6zYnuSAhMARWUW91QqSx6AI7WCC2XFIx++eFJk54UB
 3/D2amsDmCTjgYSb1/WFh4ngAdaYCn8fDkklRzgkswqdRdvdrWK8gFEZUpB9/O7/RJ/Hpi8bVtw
 0A4HrIuv7MZSFLKwR5+4X7ec8K/piE17TEMnWjeiyJ401Ieu5KgwsCTA/FODHvYJT/tDh3DgXRN
 molrR/4EYOoWMQ/oQ0OnBxoMubnRE1em+TZO1GLOcwaeHns0a+LqjRwDL/B/R/8rb/BL+6BVZHh
 S8Ht3l+nJ6Ty04J16GVWajio/ZxvhxchC7iGRG4om7VEtMWRwdjSibbAbma43HG72Zf7O8
X-Received: by 2002:a05:600c:8208:b0:490:bb37:9d49 with SMTP id
 5b1f17b1804b1-490c25b136amr44592005e9.11.1780652535270; 
 Fri, 05 Jun 2026 02:42:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2c9ea37sm60604615e9.0.2026.06.05.02.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:42:15 -0700 (PDT)
Message-ID: <6a2299f7.34ecd23a.11d42a.38e2@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <aiKYR7gagyA0y9zP@autotest-wegao.qe.prg2.suse.org>
Date: Fri, 05 Jun 2026 09:42:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmapstress06: Convert to new API
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Some error happen i have not noticed such as "manpage:`mmap(2)" format
> is also created by ltp-convert skill, you can check AI feedback on v2. I
> have no idea why this kind of simple issue still happen.

You can probably run /ltp-review after converting the test to spot the
errors on the commit. You should have quite a similar CI review.

I updated the agent, make sure to run ./setup <agent> again before
doing it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
