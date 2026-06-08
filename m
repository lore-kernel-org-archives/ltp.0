Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA05CD8C8E
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 04:52:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 469263E2B52
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 06:52:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C28A3C0970
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 06:51:48 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0E3031401224
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 06:51:48 +0200 (CEST)
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7e6d991991dso3351667a34.3
 for <ltp@lists.linux.it>; Sun, 07 Jun 2026 21:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780894306; x=1781499106; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1J/L63FGmwURLfuUgyExZ9LppXkXllzjbCoEMlkSi0=;
 b=Rvgt3Writ1vSzuFBrBkEeP2UH4deY7iB3kjd2opoNr4+WNBJsIPWgjnGN2oVhMZ7N2
 e/18wnry+VU3VzJbZzT08E4u/eMxZkMa+zY5VGyXg2rWGpo0qc4fsMVeGCFCeL7b5bhQ
 gSEHVjQfXiXIMhQjFiCqG0TfssglfSu3irERm6FYfxdotYxkH1Fv/G24gkjfDJhhPnWO
 VZFmEIEhXNzJ7PErlzVYi060HC2GfTaq58l0GeE/nhKsxKR9ZbM3gXTllab5Mli2poVe
 H7B98c6eZmLBdZGvIJcDLO1FY/20Vs9uyL6c5pRZuUyiDLC+ggx390ZjCxqQ8OQscJ8D
 nX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780894306; x=1781499106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1J/L63FGmwURLfuUgyExZ9LppXkXllzjbCoEMlkSi0=;
 b=SdhFJh8qe0w27zCK3SIBj0Y6GxR64ztW1cNuSFoC0jdOkAcEkozjz09qQtCs1JX7s9
 zJ/KIVTUOnu3vkZh232tfV+Ja0B2txK82XhBj1o8YNekMYngqRrYEefDARm+MWUk21EN
 bjk5GgibenOuLZWUBz5B/jGCyw70CY221CA6if7o7WlyGX9RNq7E9X8k90GbCrkjAz6W
 KwtnJb9kYVI4dOUfCOPQuj3fFlvARf4VXZ+x3nd1Du81VuPJkb0PqxMQuyCIg15IOMfp
 X/MUuu26SHWrdJe19KmtYcUhEShSInkk0HgcnoF4dhyJNce+eTZ5POdhTR0QvKh9Txgw
 Z46w==
X-Gm-Message-State: AOJu0Yz7m9K1ZEmeqK5yZEhH57i5FCGZ8pNU7SO6Dld2IzT+Ob//vmAE
 o3CYVU3kjrhtKs6reFAlgXiGKVV6xujmWb+7X7x210EDfNQCF8xbkvgH
X-Gm-Gg: Acq92OG4n/VXxy0dd+dCCl45CBOFaE33jXIHRIlK6rBhYrW62jVnSKbvLaYqYLxKdn9
 eT2kHJR4CB15T3+q3SwDrec0xvirhGVUWw0SLzoOlJCshiy4dJRpQd8Z9AiHDMIRrC5aNwWHMkk
 2A7YvZ7ozbaG49BpSxHDnVRiezGQTmvFa/KuwuunoN0RUgjQC5wINqr4+sO/TJU69oUc7Atnwrf
 3gLJ46CRFOS4HP+BlG9JOn2GF5jg07IKA10q5h+CSII/JxDDqk0J3eJMVIoZUFYzC4hZNXZWUYA
 O5BY0ZkfKFbVO9sQxz/UaSPJ6IRITJP0Zm7LP/Bkmif03wFET7z/qXS510dZrK/Tkj907u47A/d
 YU3lMbw6Uq37kSi1G6TjdUoXAnmh04JaWD04K9lC23P811mHfBKmm2Ze9Oz5tZeVq6Hvgc5aoks
 FAOEKPYSWg7HoE9khb1rZDShdzJfeBklv5lX0+p9No5BTZaFoNci4R3A2OgLBssYAHbrnNZKc9J
 x8x2SP79fIc4PvY6060tA5OHoFfV3MotfkAJu4QF0YC4Dzv
X-Received: by 2002:a05:6830:6816:b0:7e6:cdb6:472f with SMTP id
 46e09a7af769-7e70c7d4c33mr8982478a34.17.1780894306612; 
 Sun, 07 Jun 2026 21:51:46 -0700 (PDT)
Received: from
 runnervm3jyl0.y4nsap3eoa4e1fhrdmkj13m1lg.gx.internal.cloudapp.net
 ([52.165.58.33]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75ef0e4sm11654240a34.12.2026.06.07.21.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 21:51:46 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon,  8 Jun 2026 04:51:45 +0000
Message-ID: <20260608045145.4049-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608025234.1117-1-wegao@suse.com>
References: <20260608025234.1117-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On Mon, Jun 8, 2026 at 02:52:05AM +0000, Wei Gao wrote:
> mmapstress06: Convert to new API

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
