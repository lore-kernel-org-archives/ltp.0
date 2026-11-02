Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419C606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YF5YhmgH
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA8763EB025
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 19:54:23 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 394D63D2384
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 19:54:07 +0100 (CET)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 94733140016F
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 19:54:07 +0100 (CET)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-36a2551d7b5so5447155eec.1
 for <ltp@lists.linux.it>; Mon, 02 Nov 2026 10:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793645646; x=1794250446; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XwgHoAyLYQdz+tMAn09mTICSUqz6mJQj23reQqfGDgc=;
 b=YF5YhmgH/GkKXEM8BipRGZjPPfwn00SLxzvC8m/fagEwHftdJ2FQFXI5AwuHK+EJvq
 8GuWv2Vk4NwPRMJ6z2a9yq+xf434L3A7ASODq78G39rnRBe8nxxrB23UN1c4JD0cEc6e
 izM6pIWK7oqTuCHRZpeVO6FUAA5tR/MepX9ZU445MUKvhqcgF1jvU8IIBbmuhD3WRUgp
 RkTmIGpQXD6PmAJPt7hmaUcrbQ/KdyNy3r/6/gH0HF8T3yKqTZBCnrYixfTpdIqKiAIb
 YN+60uQM4/rHtY/mKL7Z4ruRsGK81TMpQKpVZNQqhQwKUK33rj5l0/NmxBQ18bGMigDD
 sJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793645646; x=1794250446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XwgHoAyLYQdz+tMAn09mTICSUqz6mJQj23reQqfGDgc=;
 b=Ko01IbqnH2F4b3dIQsIVn1uik8G3mf4NJ+fhExME6gm8pHFx9Ncs3FUMdpIrFTOU7d
 8tXkhHJdv+8ZmbC4vVBgtO+ehETcIH4ogXBhT5RA93KfzB91NQyLSokm0eROYoXJCsQs
 tiDAmVJZUm5+x3H02rakSjuVYA5KlZZfUhHcvxpUvJuWMEQpoqHpI6jrtZ50q7hHGvJs
 mPsLKA/xe0EAOUAK/UJEAP9eobNureUlB4P6zw9t8bmYrheFkJMKbInsiZ6o7d5hbm8M
 7Z4wfbqpXwLVci3bJraX0cniyOnESM1fTpMn//UPjX+N3etmtZG4W4JFz158pY2RUV7G
 xCqg==
X-Gm-Message-State: APuU4Z8n2B+aKCJLMuZq5ION+8N+1w9xltMXSFqXdCz8idfRzC2sYxCN
 BGxiA7xQ1/qCvZ7prW14Ukk+aRiZ/OtxT3lKg4Tbn91p2sA4zlhEJTzu
X-Gm-Gg: AYBFou0dqG482wfknH8AVo0DTCg7nhGCAYQndmaaSNYf11S1e4nRe5qO1ciaKm9mL/d
 tIsdfvSallWQUoeg3O5qeoj56Czi8bKHL7hOKdGldwMyFPlZuOz4+Wpnd36xrTdKQF2sdStw2An
 lPqYiEUok7FxHpw530n870SgWYq9ueIdYyradZnAFjRNuj+ip2vy8NCxUV0u6IS376LChib8PVq
 pGTmD/4gWRNLJmyu6o5IroFI33jSC13xT3PQdviAmI93z35VLmyE/9vzEvirBF6jVpZTtO/VZZk
 27D4GZ6P40ePcDx95S+C9l8U65kYbl8NAky0X8KAlTGwgZVIEkeTuDlNxsGHsINmEvqUTE21zSc
 +5/8kQ1PY8zReXAThqAR0u96g8MLxLnD2vp0EpP+LRFrOGOKoeGBWlpxNJreV5L0mJsv7Z5GHmR
 6L02iDNfk9mPvXWMZzD9B9sE8v/kyzU0ZLIA34UvyF4hUnl30rHLuJZSPP0iOI7fpTVc608DAwt
 PcNNkhKCvWvmoQyzC7e/h8zTDuji7urr+UwlfBxYKQaBhbEaZK9orWUKCRovpyFPZTGVzNMQVpr
 8sYGL+XUxNfivuGgg0OT+b5TRwL8sImK0AB9qoRX9euNDzKE1nnyOr8KFxVkSB/kB1d/H9D6kza
 ka/PQi5EJyjvxCzR2XypEKATPJpPvm0/BYcKqis7J9A8=
X-Received: by 2002:a05:693c:864d:10b0:362:2e2f:c261 with SMTP id
 5a478bee46e88-36a3b5fdb1bmr19670475eec.27.1793645645584; 
 Mon, 02 Nov 2026 10:54:05 -0800 (PST)
Received: from
 runnervmnwato.gr1dpnwfa0mupako0vfjb2jtxc.phxx.internal.cloudapp.net
 ([20.169.62.141]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm41657151eec.7.2026.11.02.10.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 10:54:05 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Attila Fazekas <afazekas@redhat.com>
Date: Mon,  2 Nov 2026 18:54:04 +0000
Message-ID: <20261102185404.3579-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102105704.1577364-1-afazekas@redhat.com>
References: <20261102105704.1577364-1-afazekas@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmap22: Bound child memory allocation to avoid OOM
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Attila,

On Mon Nov 2 11:57:04 2026 +0100, Attila Fazekas wrote:
> mmap22: Bound child memory allocation to avoid OOM

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
