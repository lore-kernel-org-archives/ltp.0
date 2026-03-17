Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58C1FED9E4
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773762593; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=izyR1yIAtG3NQ1dLqObHUvuL898ASL8Xd1Vprk2kPgc=;
 b=ihDPQR03rqJoJU5Rkom0SH018A1FKbK28JAOlguERmNOKwjodXAiDBLxT7T+wJqIs7iz6
 mYpdHW5uHpzS9gxJCMYOCAIjpW3eka8dMB+WNAKt1IoVzrdp81NuH3v3lOWyiDgwZoa0IUl
 KIZQafcWEevSwvwrf8Q2cJ2Cnc2Jomo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A4083E2740
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 16:49:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 512BE3E1809
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 16:49:29 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9BE17600BA8
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 16:49:28 +0100 (CET)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439b611274bso3703637f8f.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773762568; x=1774367368; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=98D6/mdtMEp9FOfqrLL0VLHz0/K0geR+6iBqmJy62Qo=;
 b=TnlOB0KXHNwFcGW6+KeJoUMV1eFzcYXxFpoygg34ShH+7YRoXoNuqkx77JWPOYxA0b
 NauMptoGeJHm5MEsVBOVyg32OJpvCJVmL5SDTgnEARNY3Jexz0QM47CV0iy09F7duqft
 WqYKG5SLokxeJEjRjqjlAtftVU3ktatqUSiAEZBy3nHwWqCT7cv6Q7AQ17DvnNTF/lzi
 4ICOs5NmlMWWtPGKAPfSoMDKceJ8PbuVSTA/oMcPH5icnZuxGmXe+z8gFAJkRTsmvTDk
 /9Te0CsvcydeyZFjrasK5CWyiAAj+18Z5f5PAvlJzkJB78+BtwFJvFdsbOI5lVip+dY4
 605w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773762568; x=1774367368;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98D6/mdtMEp9FOfqrLL0VLHz0/K0geR+6iBqmJy62Qo=;
 b=XpLbPslXE4HuheZ7VIHGn+BH60dU/RakD1hPPm4zf8WE0Lf+uQLDAkNuGVw1274bx/
 65hEU2zpYa9VvGglWRd2gG2TnEu3xOrdcvrj5HHyyuZzbV0l1D7N/44lgNnnlKq7271o
 1CZ8i/AcE1iEpWmo1CiZGaf56g1Gr+K25VBhtyRMsPwyhQHd9FoDegb24lt5Sa514U8n
 y+HTnYYsNgbeQ0u/rx54dVfFTn0tb4jEIb9B0YisNKcKNyAWO/gTu/K3wmN7gkAtC60c
 WeLgoPRI44fg3j1bMIq3cKAVLdgISqpG7q8W0kDF5LuYdJtghaD2cnzXDGAv6hIdgQ3t
 MClQ==
X-Gm-Message-State: AOJu0YyQn3pI+P7Ypc85dT2wmfcXC0FWMNdcVY7fXe6AeH9nptqpaYfE
 c4nlx5axap6/qQm753SQn5iR30vg6giLwxfKDXGJ/qHVBkVgqmGtx81I78oWMxEQXUg=
X-Gm-Gg: ATEYQzwx4pcw+7K8QJUeJKtX2IiJG6iw7Z8DFieod/5ApUHt+qQRfBRXHF/Brmw0ptb
 wPUaI6T3iAVd+sPnoOQl4wAyTUWbrjOGtvSw4lBQ1UHqXmvsvBwMIlOi1xrRl71oDoUHBHtHhOT
 d8w6vC2oAfzMtzUiC+DJLfLguWd3vOS5TcN8F+5srNCbV9pCJqrYLN7eDkb7HM+BcksnTtsySm/
 QbJCVu2HT2tV69B2v95xPrKLXokyyPtD3e7CAooy2PC3VimYER1rCi7vl6DjuBPXPm6GGzh01vu
 xWoBlg1XADUot9MQRcGqsUulCRbz2ICx993dikyGilQFHSAIuf/O+BUZiW9hOfFqSOPqMHvMCcW
 Uy2sStC3eYq3Dsipd3Y2VsVetSAStCUnJs4g3F7IbwfQi5DREjYV3F9sQaKgV3QM39qG6TAymHE
 nic+Eex1AklWmJvQiZyPLMxgSIhJcNAHLie+mHUIAO9qTTMvzB0g==
X-Received: by 2002:a05:600c:8486:b0:485:3f17:410 with SMTP id
 5b1f17b1804b1-486f444862cmr139965e9.16.1773762567836; 
 Tue, 17 Mar 2026 08:49:27 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557c6ce2fsm118020795e9.25.2026.03.17.08.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:49:27 -0700 (PDT)
Message-ID: <69b97807.050a0220.26befa.70b8@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <abl0DkVFXKT-pS34@yuki.lan>
Date: Tue, 17 Mar 2026 15:49:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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

Hi Cyril,

> Hi!
> > .. and tests conversion for tests which are smaller than 200 lines of code
> > requires minimal (if no) edit. I will continue to adapt the ltp-convert skill
> > in order to tweak and to improve this process for bigger tests.
> 
> I would disagree here withe the minimal edit. The old tests are quite
> often garbage. So the human in the process should asses if the test is
> actually doing anything useful and guide the machine to implement better
> test in a case that the original wasn't doing anything useful.

That's indeed what I do. To blindly accept everything turns out to produce a lot
of trash, but in general it's way more easy to refactor tests in this way than
before, at least for the smallest tests. With a good set of rules given to the
LLM we can produce good results at the very first try sometimes.

> 
> > ~~ Said so..
> > 
> > .. since this process seems to be quite straight forward, and with the usage
> > of LLM we could easily generate hundreds of patches per month, we don't really
> > want to flood the ML with garbage and to overwhelm who's involved into
> > maintenance review.
> 
> I'm pretty sure that you will get this down to smaller set as long as
> you actually spend some time thinking about what the test does. At least
> for me I'm able to spend 30% time on a test conversion because LLM, but
> you have to spend some time understanding what the test does and making
> sure it makes sense. Otherwise it's garbage in - garbage out.

I counted a x4 times faster conversion compared to the previous manual process,
at least for 100-200 lines tests. Bigger ones will be more challenging and after
a few attempt the conversion time drops significantly.

An another thing is how we want to push these patches in the repository. At the
moment kernel is using some special tags to identify if patches have been
generated by LLMs or by humans. This is something we should think about,
because we already have a few examples recently (i.e. your ulimit01, newuname01
tests and my listns() testing suite) where LLMs where doing most of the job.
Also, we are receiving more and more patches which seem to be written by AI.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
