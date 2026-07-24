Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C811C531FA
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 08:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784882040; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=7/2NknYsub/FEQWBLtzKCmP5pm8DuYeuP/mcHmDcAcU=;
 b=Hv1iwA62/Vtkbh9SEKVLUfZ97lyTIiKNjfdbBd4tLgL109dEm4ZbedsgSxllTWfrxpPyi
 xX9etysIK59l0YUa+shvT4BBQV5zUdPt6U+aOCbbrQHbG5wZaocFdrp28DkSaSLyF38DpCV
 AECDvXRM4YUVvxMqV5fHAOo8t92LmMU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70EC63E2BCF
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 10:34:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DACE13E0CDC
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 10:33:41 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D6A1E1A00268
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 10:33:40 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso1490035e9.0
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784882020; x=1785486820; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e0gDhsrSncb42QA3ooY62EMLvGrblic52gbaqMy/PHY=;
 b=XRXwWjFxtA/Rf7vtil4ipKQO5UN6H9TdeoI/ZJljACKf79A2qYi7CZMV83N5jbBMA/
 CnsKBf7pXFVBnh6CztaeGeLOcEmDGex+4+RhpJPJH4AQ8NkVMj+8XJeADGC7TBFHZ9GS
 qlSy62qMghm/vDdXP7YlT830R9H5q9CxuKZARjNJYFnMSR7rbjwecz3zNnsaUIsqYf85
 CrE6iCvAr557/ATpjfUxAcEbtiWPrPtiE0Gx5rPQfWk+TpSPa36Ue0qAeF0gNh54ESC+
 jXb3wGyOPjSGIT19uwQlU9ReVMbTJ5gwTWQEcCbHxjF2dyRAGzTcdeiK0eiINoNrJiNc
 aClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882020; x=1785486820;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0gDhsrSncb42QA3ooY62EMLvGrblic52gbaqMy/PHY=;
 b=VupoB4P9mTQR8Rl2YqzPsanBYSVYSsN1UZaOmcSYTc/U4cciOKRfHf0bIPoTrg939E
 7jQMSl1lqeUmdxijBAhUJVl3jlelYUlFIE6o0fGX1o7Oj9ly7GDFjRpXHu8ODctV0rbu
 M6mewit5hSQtHQQ6fvBhEOTwHd4KCgtqv70bHOZib+Q09YpsQTgmA0ej5JU302Zo5bTB
 9Txmk/npXy1Q6VMwNXdEELGswpN1S295/T+qRDXMdIR/E3oh0TXQajcBs2aeAbQjjU4V
 MOWVKPqSuaBNxzktwjFyN9BFWozNJCmTV1Yn/BQyFPPxK+uLXNMIQD2DxIaWHhE94p0u
 KZag==
X-Gm-Message-State: AOJu0Yy8NFlqaVC7fov8ZUh0TdZqpnMu/+GMCPeb/BqYd355nMbyAZ9J
 2YflD0xa8QjZ/F1jVfoCozCd2GkB6kQIHFgiR46a6xByr0swiu4EuCoOR+wA3YrG7ja5x6TsYWK
 VqPwnSyEFEA==
X-Gm-Gg: AR+sD105SvtIgstb7KgSoLWVJDEfK0vozV1nj0GwmA7Bx9pOh8puKBqw1I8RKUfZ0cW
 2p7VRXPsC7n8K2eKWk06JgKw6LJ14DhPGadtyv2SY551ApE+amAEzRgxVUWveG9aMDKcQ34YedG
 Mz/l5WjdMpXz3zlLkrWnvDlvCrjImAScnk2sSCR/E3xTDYmzWXfTWk8ZytrfplJHFxwzDae/9sq
 mUWvlZi7MWnNiQuipBr8D/FSuJajVOO2z7MB17fTkn0DJEquYXYWMHqyCYGcMyzeEyuCJsv9bLb
 0guxk48P8/y0pSKnUxT4A0LNCy62HyDF8YPEkGtvE4GJxO8Q9HP4/XXhMpYo27HDOVL+KyRecrR
 kwIG740idIzuEN7aWUYUwppX2dtyFYEjl6ajOqlT/2s2QfbnY/x88yygGL44RcYK3vDU8WmnhiI
 +p7h07Lw6uQBpF3K3Or19sb/udPQ==
X-Received: by 2002:a05:600c:4612:b0:495:5b02:23b0 with SMTP id
 5b1f17b1804b1-49573d0e601mr45249675e9.26.1784882020001; 
 Fri, 24 Jul 2026 01:33:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm21731723f8f.11.2026.07.24.01.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:33:39 -0700 (PDT)
Message-ID: <6a632363.9b582779.1a0068.38ad@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <amKpnQVIE1jjhY79@autotest-wegao.qe.prg2.suse.org>
Date: Fri, 24 Jul 2026 08:33:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 2/3] lib: New library function tst_get_free_uid
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

Hi Wei,

> > This contradicts the patch 1/3.
> This line is same as patch 1/3, could you give more detail where
> contradicts?

you are right, forget about my comment.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
