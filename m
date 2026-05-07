Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F77CD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778173063; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5bEHY09mTjNfxqbmDxLkwDBwAIh3gcTofFa7yWdJM5k=;
 b=jMzVhEmPC8EkC7GoVJHsCLLJMKfmIMZ6vgNb7Wl7dpD3dcF9XZXHaOga619tjdtbDMz+i
 pJT3okXS2qLbDzeopPIOvRjn6qxr1JWpsleU5RQd7ey7sJzk8az1jg+tBMdo4w0EKyt/Nyg
 jgaEFxrhxWv/nskEzryWYPZDA7Zlf9o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18193E6173
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 18:57:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF2633E1F33
 for <ltp@lists.linux.it>; Thu,  7 May 2026 18:57:20 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 191A41400971
 for <ltp@lists.linux.it>; Thu,  7 May 2026 18:57:20 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so7087485e9.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778173039; x=1778777839; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gwxlQ+HCKAwTcm7GBhTxeztsEbFN3Knu22gyYl/yVAw=;
 b=ZX8wfIZU/Qw25WWCzqKrE4SdvcnRwA6tfmmD33gZ5izoe0165/SV4L7CiJXnVKKwIT
 gBkaoIOMNTB/wJfXgev+4JE1jIgZnebMk7uXBCRodaJ6psHdGMZaFYSjug8ZKngNI+N2
 FUfIWXXY57oe9jaXbsYcXirIM+ZMYrU/MU/0w87mtHDuYIr5iiEN6TV2grfV8+uzfifi
 nEbx32rhnl3QviiSc8s7ggsxfyhVLALqsUyArWbC+TGyfTbJRpXTJKqx3L2Mj84f4aoA
 F055KZsImrTQ5P9w50DuWG1SvfXKFQRlNNhpT3DIr6k0F1uzFKqm6tOAPU6FjBhCY3pT
 zVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778173039; x=1778777839;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwxlQ+HCKAwTcm7GBhTxeztsEbFN3Knu22gyYl/yVAw=;
 b=JNdgjWHf6rA9DP5hYXVywBqEn96diOq5RFuz4KP8kxA8j4G8meTnddJfuWLUfOKq2c
 G6BVj5iQxiATjudt3Xwr0wPePWWw4lD6nUH1/bRKaCxKjscd0rs7mmamYX2uwscsHzam
 RCBuHf1kRUJDANfrafW9fMoeUNING6BRZOhGN0uAruW6xwZ7uJXDrM0K4/CTEuT6HpTi
 A/KQYmcFFoRHXLpwXT2F1kylQ0rGt+U9givBpI1t0f0NKXYA24xeqbOsprr/sLqNdBgO
 i350rvTQtSDygtpvb2d5Y/5jEq+vG5HFJucgDN82yIhrWX+WNjKCk1gGKi0MLx89YCU3
 nvHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/f0CTy738XdeHNryqn9+zUbqtgNUAOl5ju5fVf/N/kAP1s89sxrI3SSaSUr3/sxUrIL6s=@lists.linux.it
X-Gm-Message-State: AOJu0Yzu6AsxwlvWnhxbKqvpwMXsZSopRu93LstlgO7OgPRshA9QXUUK
 7PjrAkJv/EHcy512FFWrG92ao0/+ZETB2lbmLcs57jm4AsUjnOoYyaqIZjn1zo+JZYM=
X-Gm-Gg: AeBDieu7fJ8veqxEkWpOhgjRCijY1jTiyXjp6SVgrheDevXYf+nsxzYpKaeWzj/Boyd
 XSSgD167Aha1psTjbiog8n65M87Uj+K8mYgRXkSYqSiYjYHcHGnQImSRjcDWDcOUw7Bi3OyAk/M
 WQ/w8lRTB7c+uhx4vqQEBInbngDb7S87lZPVNj1ShLvZV6msGK+cKfU2PS8fz8pAwz6lqMu3e0C
 DoI7UavspPxFxpynDA0cFhBJSMtb/EWFpLBrCQauDey8b/xICTctFa+/fLWw7IWWmKOovfAtcir
 KHZnjGFQ/qwRMzg89lbleeMs2Lz5qGPKvnpc4oSVSOR9By3wKtX0tRR0wTHaWtiFSsuBNfDVxPh
 09gmD+ZNs9nUKUXEarqEzngCFBtWcIBpV25g+fDZm3XjjJlgTrNRD0IsbbsGHvR7SyBHCt3rjFZ
 cTvgV/Sqmjz8PBIZpMtLHm8F+yYzwsxF5vPQxEs5uGCcornv8cJCOyAhjVBvp3MbM43i1IUqyvQ
 EAdDsJ/XtFCF25bJDBZdZrg6ZtxnrZQTY4=
X-Received: by 2002:a05:600c:3f18:b0:48e:5990:9698 with SMTP id
 5b1f17b1804b1-48e5990978bmr99840535e9.24.1778173039376; 
 Thu, 07 May 2026 09:57:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm138079825e9.4.2026.05.07.09.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:57:19 -0700 (PDT)
Message-ID: <69fcc46f.050a0220.abd0.4550@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afylLJCi9a-FELwp@yuki.lan>
Date: Thu, 07 May 2026 16:57:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add helper for checking UFFD feature support
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> The commit is there:
> 
> commit 1840ee23d172b5ab04cca7c2acfa48755b041911
> Author: Li Wang <li.wang@linux.dev>
> Date:   Fri Jan 23 19:54:19 2026 +0800
> 
>     userfaultfd05: require CONFIG_HAVE_ARCH_USERFAULTFD_WP

sigh. Im wondering why it didn't catch it, this is the basics.

I think we need to separate the logical review from everything
that can be done with a linter. I will explore this possibility
in the next weeks when I will have more time.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
