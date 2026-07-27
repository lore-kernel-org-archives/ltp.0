Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD77BC53200
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 02:53:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B8793D0360
	for <ltp@archiver.kernel.org>; Mon, 27 Jul 2026 04:53:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0B303CAE57
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 04:53:16 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5CBFB1400335
 for <ltp@lists.linux.it>; Mon, 27 Jul 2026 04:53:16 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8eec5a0bdf7so2823856d6.0
 for <ltp@lists.linux.it>; Sun, 26 Jul 2026 19:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785120795; x=1785725595; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y7cb+upXq5oqXcYY73yq4GhgEZlS6vMcoAmAEkOqPOk=;
 b=CeP1p146nOCjZ/KA3yJ19C74dTK5ACy4c7n3L3vEASwsoeYsEAZ/ebybJfCSnRNnx+
 323Nuga1ubopwI7jII4WiDUyacZ7ZOaGvmcUWDU1L3FVqHRepNVZAKDqIDrcdbAgV326
 M1XVrM3MOajlLB8oxozBrh7k3fBc4CnTMqMhOSuYGdzkq7q8MYZUQmNkuf6r726fPvAc
 aoaWS9EkuwB0dohkB3i4hxLhaejfjDSgjegogtoYsWhndLMH2FZyXCB2sfjFEklzg5UX
 wZ9ZwBZcvFbfjCE6p+darbb2kOQkPQ6lzAc/8FuW4Bdqmjp9BwtuFSw+zocXQEw4mKnH
 /6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785120795; x=1785725595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y7cb+upXq5oqXcYY73yq4GhgEZlS6vMcoAmAEkOqPOk=;
 b=YiwP9KPVhqvh3bhCghcKzAwL453SGgzTXfNGowf2HE11BJ/xnTzMR8GZ15QJZJUFxP
 i4iTKA9Li0kVolUipblcVKqXw5o/ZU7mCDCkP3L8K8Ii3I0prwNf6z8bOxtNw6r+4ZZK
 2dI91WD7pNTDfZvU+inR2gRUqRkFLXwV/2BQ9V8g/g8yE/WIcNzNUdlOQ9moJxeh4bDp
 oq/gh+QjFbJdgoZH2TrRn93dJKMtkmmkNB62zVIosMlVnFwlk1kyV3cJszWtOfsUddtj
 9rZa3mrUhG38anmd+bcgCeQPGSg10PbWQ7/LNiVW1ldxAh0MBQkCZQoxRByZTm1qER7U
 V6Jw==
X-Gm-Message-State: AOJu0Yxk/3eGNswPLOtGxwg6yRXaqYGX5+KAlKUjw9hsXxJgAK71vW6n
 BKKtt1byT5fcNxdC90xYiZahLcEHtn/rd/TtXfhPDUqs2c8rPgvkSBHe
X-Gm-Gg: AR+sD11YRQ4idkkqN2IBLykoEdNT+25IkX9YDqjteWGaGc1UaMW1y3jqsw1p07u3HyD
 BOSFwTGm/eBPFjjnk8+bwX7wncfmGRH2tA1foAzW8/z5OKJ8lBdMXZRaUOcgXvBufHG6fpwbzpj
 XP7WmmqWBkcJYVesDFLPigIucjDbEJMDEpLu4PxHNtcD2jX5Oo4OgfMs30JeLmrsrQkpTDoUrb8
 k27xo78k3RU1hTpVDTNh0AD631StRwio9s5JHAz4pfyEMuF/gVjQ0rhFylAyFw5FDhLQmuH1skD
 iE1nLpQhUqHEQU9b8QvIF/QdZf6nAdoMhqvsiT1qlfftkfaJ+BlX0oqX0YZVmiNE4xmQK712971
 mo9Xf5111mwyD2gqpxJrfk5ohK3k5tsu5Q1pSimD/4wRbNq0wm9YMg8p3JwgsDtfNCgia72lTxg
 zXS2ynITHC8QHVD06SVdqMN7VBai5OTn5lgg0ZXo8Poa4GfdQNKzp4EnxXLp4thaludo59Egxla
 ZIGMEjg1+p6yQhakA==
X-Received: by 2002:a05:620a:4114:b0:930:a2ba:d6ad with SMTP id
 af79cd13be357-932df00a295mr708398385a.33.1785120794730; 
 Sun, 26 Jul 2026 19:53:14 -0700 (PDT)
Received: from
 runnervmvrwv9.zrqr2oex231ezjigm0txkepa0a.cx.internal.cloudapp.net
 ([20.161.28.106]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de541ac8sm509488485a.16.2026.07.26.19.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 19:53:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 27 Jul 2026 02:53:13 +0000
Message-ID: <20260727025313.7576-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727022554.7966-1-wegao@suse.com>
References: <20260727022554.7966-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: Scale cgroup memory/swap limits dynamically
 with page size
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

On 2026-07-27, Wei Gao wrote:
> madvise09: Scale cgroup memory/swap limits dynamically with page size

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
