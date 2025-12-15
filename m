Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEB9D5B175
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765810891; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BBJ5exiMro0U5mD1ZIhMHxSzsI7V5TVwH6Y54zmHG+Y=;
 b=o4ZXRAOaWmqAa8FYKCVJOH3gbHk6mnYlYDPGetu5kzgMVDceaHQYScaALYsQeblIYhPqp
 WV2BsRoVLk+EgNPwPEtLOvz9z7ghI7baUfshfGeJkm7i1kkaRTZ5q8LckpD0Z/CnVYAbhe7
 R/UsjapH4B2LE6SJOuN9wGYlcYAQJQU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22533D00F9
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:01:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D86693C02B4
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:01:07 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E04A140045D
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:01:03 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so29202135e9.0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765810863; x=1766415663; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9i4vm28QqnfKB/h2bL8hZlt5D8K0d/uFHOLRuajd8c=;
 b=FVezlfsU0oZWiVUWiZ0OOFtbhnmxPlfp9TLP8qgPENVkJPBsoiVmWb9eMqgORkZwTy
 kgh+RS/87lv1hm+STZsK2vsz9INWPALcUQSF+hps7K50+9ZhmymkS9FiyMlP7r85LnGw
 c+p/NUCCZxkBabE/vMpq+5w+yYQz9vYBaIo4LquoDDqEAtcwp00D10B/MOBAksDL59yz
 WgzACEmryWuGPlDU4oq4jdu+2Xr+yXcWjDT6Gs6+2x5ERSATZhEzvhUg3BGhHa1Jp51q
 AmQSN65Ei3cdVNGdTR+dGdg59L/ohJx87D3DoB9R/WgKgg8LOZE8eU6RItmYgLAR57/K
 Pi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765810863; x=1766415663;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y9i4vm28QqnfKB/h2bL8hZlt5D8K0d/uFHOLRuajd8c=;
 b=czw0lF9MZlsQeGurRGB/2Uha5PchdSmbrq5pDgMf9Dr0j9854KlAibMloCaodVSxcP
 hs0X16O5vyTtcGF0PPETMXmRHxyRS9IZFF/3CRJXeX9Il9lNJPPnjItHyO5FewqKp/sY
 sBz1RmWCTsieniehA6iFHrdY4xhNwH7Mkw4G3JYh5iQYUhjvtP06ZTB0+Zf3RYzesAY0
 jvSOO+P0pDtSQKQN5UGEzEU269GWc+xY0jRk65iXdyTk/w5i+PaIFyE8GPhUOUd0GPiY
 wsWJ45CVqXrqDmA17Ozz9w/q6p6YoVq9ZbyLaGYA6iX/XdoUwh6DZKUE9zr/H3GwF5RK
 VKYQ==
X-Gm-Message-State: AOJu0YzUtnL2AgRai/P4+aXZIHqKXT4xkmuJ/nHU4ttyJk++Pf16dzFB
 nRIaJVlZCltYIwriRPSn3LFxNOGSOaXzQ1JbSIN+eJijiUnyoimtsEkOAeRYonjHM+c=
X-Gm-Gg: AY/fxX6zbfMCzpyZvSdxqrj0Hiq7M38GRVMC3TJxYk6/cMlY5ekhrzlQPB9pgWESlRE
 sG54xzp9uy0SbHsRox+waUj5Lt3Jwokpt7UOF6Ck+TKzTiVvODNk5zFhh6et3xtTPEIrFdx3Cng
 UFBwrI1sPoOb7Lv/rbtxtnZKspLEIuXTaA5DigD/ZTCdIP++lzhd5QdBjGfnSt/ZPu00kXfqJWa
 lJDcRjfNQfodVGEj9h0kt+xfbnY0f2UpsowapEhTAxHwr9tTzV1re2/EGJ0/6sTk4uFG5DsH0RG
 6iQKQHXTadUuXwd0MVwu5SjRHarmOp9ABe8Roqt5P/5yjRql/eo/VnAghT5Ax9zZlF+j/iH7OVP
 XjQ4k7pJYwYvC/QHmHN7fGGx9Yc6RB8jGe2Z0jMVcpmj8b/pusnM4fUPEBwoGMYdN6+kvSqsQMe
 1jfuzqWuqXeO8XjAbnov0=
X-Google-Smtp-Source: AGHT+IEdLQEcgVzfdJwC+Fn/vquYA+af4NBqs/ObwEO6AAsWjYJbEu2aKn/N47bTFReZS738Wz3tDQ==
X-Received: by 2002:a05:600c:c048:b0:477:8985:4039 with SMTP id
 5b1f17b1804b1-47a907fda7dmr87828585e9.17.1765810861245; 
 Mon, 15 Dec 2025 07:01:01 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f39ce1esm74158905e9.1.2025.12.15.07.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 07:01:00 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 15 Dec 2025 16:00:59 +0100
Message-Id: <DEYVPI1SEKQ3.1O8WHL9757UD0@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Li Wang" <liwang@redhat.com>
X-Mailer: aerc 0.18.2
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik>
In-Reply-To: <20251215143048.GA267467@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

On Mon Dec 15, 2025 at 3:30 PM CET, Petr Vorel wrote:
> > Another *important* rule concerns artificial intelligence. I've noticed
> > some beginners submitting LTP patches directly generated by AI tools.
> > This puts a significant burden on patch review, as AI can sometimes
> > introduce a weird/unreliable perspective into the code.
>
> > Be careful when using AI tools
> +1 I like this title.
>
> > ========================
> > AI tools can be useful for executing, summarizing, or suggesting approaches,
> > but they can also be confidently wrong and give an illusion of correctness.
> > Treat AI output as untrusted: verify claims against the code, documentation,
> > and actual behavior on a reproducer.
>
> > Do not send AI-generated changes as raw patches. AI-generated diffs often
> > contain
> > irrelevant churn, incorrect assumptions, inconsistent style, or subtle
> > bugs, which
> > creates additional burden for maintainers to review and fix.
>
> > Best practice is to write your own patches and have them reviewed by AI
> > before
> > submitting them, which helps add beneficial improvements to your work.
>
> Hopefully the last paragraph will be understand how it is meant. Because we
> really don't want to encourage people to send something generated by AI they
> don't really understand at all. I'd consider not suggesting any AI.
>
> I remember briefly reading kernel folks discussing their policy [1]:
>

There's nothing wrong with AI usage nowadays, since it's proven that
they  can shine on certain specific tasks. In general, code generation
works bad, especially inside the kernel development. And in LTP,
obviously.

But when it comes to correct commit messages, learning what a certain
code is doing or understanding compile errors, they can be useful.

Said so, I like the Li approach, because it gives to AI the right place,
without expanding its boundaries which are well defined and well known.

> > We cannot keep complaining about maintainer overload and, at the same
> > time, encourage people to bombard us with even more of that stuff.
>
> And another one I can't find any more talking that it's about the trust. If
> somebody sends wrong patches generated by AI he risks patches will be simply
> ignored.
>
> Kind regards,
> Petr
>
> [1] https://lore.kernel.org/all/1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com/




-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
