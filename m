Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786C2C55ABE
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 14:08:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CF963D0845
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:08:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 001023C0EB3
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 15:08:35 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71399200149
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 15:08:35 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2aaed195901so10333575ad.0
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 06:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771596514; x=1772201314; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIWnf+/GAyezZ8X4kIcBw3NTfSg77ZNqpBuc0he4i+k=;
 b=AgirkfchdK/VFeQYM/qkBf7X28wgcBJy79So2mNzo84//RmnyqgUX5WLPi6C1BVKxa
 3BP/RihjIk56JnMfpll3tbStk6DBPLJJ/Tk0KdRF9fqMuvzwvSR63/JkNftBQT1kx4Au
 +KVzTj1dGdfiJnmuHHzAA6/1sEpWQ2b9+ENva345ge9PrYD4GcU9MkwjTIBS+70j1YUN
 JmFC2CYq6BTATNfUr12rEF/keb+cIJ5SueGNeGZvSgJlRxNTpTkZzKyHiIlubvms6YtV
 emyvX+mjiYoxYXFVtkiwbihi3eFneiXgW81UJ8xkvfD7IsDDqeDqmTY0Kg4oP0j9yZtr
 HPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771596514; x=1772201314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BIWnf+/GAyezZ8X4kIcBw3NTfSg77ZNqpBuc0he4i+k=;
 b=FOOW7Y8pda2xN+jmFvZ5ERBt5PpemFnXd/YD8V+w0qkRtkYNxhErFo4szY9HJy4Yoj
 FaQdIqOG3NZ9eem5YTE9QBxmPnTMTTdyZpD8H4qGjm0YqW9/CdPS9PRQoEpTf//0Wlud
 9al/8J1Pltczr6HZhQQ3wV2rnOdhr9X39x4ovSRktn5BShD2NlgdN7Bs/PqbcHtG9KqK
 KgbSf395fcamxEhHjALVtjOcagyWYPRWAZ1NNgGnKjUqfIRloLCkIpDMT3eCQ27gMFJd
 2MtXW8Od5ivgckhy1jLMKzT/U0xDukFnAGK/M1Y0mlBZAUf3hV5NGQk8fNZELNenj+Av
 WIZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg9w4BmSgqDfuy0Fn4zLjw03T5Ph1gp+EhyJxYhNWDFh0eVffBV/KNzWhJs1F0HmsDi/Q=@lists.linux.it
X-Gm-Message-State: AOJu0YyRZyvHyNUS/hOzFbx+SSuEZtQYQQQgdP152K0ouRJAeJrb9x+r
 d1rXUlRDB4jNHCH/IDsYjMnP0EJx0kPGY2EW+2p0VBYHSxXptjShq3s=
X-Gm-Gg: AZuq6aLcxkCm8E3IdiQHC8iOEvh8IzIIi5uIhBoSemQgqgt5LHAc0rGt/4BjeKd2WsE
 sejbnVChql/w5ylhpNFZomb/nBKS01/Bm/BZa2TwAb8YmxMn3i+2mzTZ7YTDAEq4GXI4H+FhUKl
 AvDCybcOeN5Yj2keVqiA2MDsR+qELVgiWvnxHAUHakD5sURc5YqVz1vHrNSdq5a6aEWAB9XT220
 PgPrvLgGFWUF4n2qNxCq5YNKWEZEwpEuVvbKr2bESw/kb3vJki24B/9Yn14xn5c9RZ0mfCC+ENt
 9oGYUtMTi4FR1Sp8g462TM3UZeKgzS+qtbtocGmA3UwgT84vDFybUFy2KDJfK6+Oin0nSlLnsai
 CmT1cGtjQZCzOdNvXiEuhX0wckR6ufNzDx8e57d6hyL4NyOKHcJdXXKNTIdSAAUXhP0e2s7u1Go
 Nahb0Cd3OlcNFFaGs3FnyswpHadLXExMLFNoC4eVvxnQ==
X-Received: by 2002:a17:902:f682:b0:2aa:e6fa:2f74 with SMTP id
 d9443c01a7336-2ad73462626mr1188945ad.2.1771596513759; 
 Fri, 20 Feb 2026 06:08:33 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aae9bb0sm184670645ad.80.2026.02.20.06.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 06:08:33 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Fri, 20 Feb 2026 23:08:07 +0900
Message-ID: <20260220140809.3981-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZg64qwkB4tG18ZE@yuki.lan>
References: <aZg64qwkB4tG18ZE@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] inotify: cleanup - limit masks, use SAFE_ wrappers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thanks for the review.

So does this mean IN_ALL_EVENTS is used (and should stay) in all test
files, not just inotify01.c?

If so, do the test files that are currently not using IN_ALL_EVENTS
need to be updated to use it, or can they stay as-is?

Thanks.
Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
