Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B53EC352A1
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 07:52:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8CBE3CC100
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 08:52:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30C663CC0C3
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 08:52:43 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 510FB1400422
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 08:52:42 +0100 (CET)
Received: by mail-lf1-x12b.google.com with SMTP id c1so27426964lfi.7
 for <ltp@lists.linux.it>; Tue, 06 Dec 2022 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G2X6/x2Zh83sZHmia+Pwkl5wCoNcLUH2/O3aM5sR8Hw=;
 b=LrLyTTDkSDY1zS0Ki5dSflVGZZVDOYqD9DL3Nt7MpQJK10h4uYLc0NsCqBRLWLktT9
 VjCbQgfCAx2FiWK9jr9OzYXQQYCkEV7hfMIff1CEAiYvt52DaehV+k632CfRbsOQin14
 WiQ+srmce1DHTJedwQIBDszxD0iShQ6zHB2t/jS/8V8cHV5LmwkVIb8on28rg1oXueg1
 xENaQiLU/L6s0geFEXowfZ/9yfJhFG++N2kChwHcHgRC8G1JY8tdhFw/3CIBrYBLqxbL
 cNSUzDPxGAAUE6GEOGpzOtyq9A1SrJclKPrKanXXY0ZqvzotND3g0mO4BFrbHBpp6sd/
 JKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G2X6/x2Zh83sZHmia+Pwkl5wCoNcLUH2/O3aM5sR8Hw=;
 b=VYQcuSC4LlWWvccSwEItstcU07x6PLPSP9OXCOQU0Y3nj+RcHPdh0jnzdcj6H4S10B
 93WlbJNGYa858hI7jOcXfVBfI8xT1Ua5+tEb8I5if+ch5pkp/lcMfwyPs6MZYTUUx9bY
 ArT7uT3d5udO4xRmKcKzYLSRKvGwRdMAyO8HWXlIkdd0wMB2T7PPZP9jkqwEhynO5eTI
 G436G2os4mq1ULgm1CyWd2pZXhikqhjOGnHvGgct15P8wyQuOBZQwa6VwE2934ZKlekQ
 O8e1ZiXcxWUgMECIKRvZb0QxjJ8qOvjCvqr9HAbQc5HNNzO+6y08RB7aIgjKGEOVrgU/
 EqOg==
X-Gm-Message-State: ANoB5pnOzeGURpezvgfsa/CBN6v98x/3AlrI0fo2HA4LmRAiP9409r2/
 Blqp0Fa/9qgIsz6hUgPGuZO7KgM4/wmwkYRgWspPbWggnDg=
X-Google-Smtp-Source: AA0mqf4BoxO4OgWXruBl6OXlUb2E7IscAd5fW7t7BDQAyDr4BNHkf5oskth6ebiWQLl7PxUkN9qoMmAf3ZI9G1l9vjU=
X-Received: by 2002:a19:7b0f:0:b0:4a2:3bed:2008 with SMTP id
 w15-20020a197b0f000000b004a23bed2008mr32206578lfc.88.1670399561277; Tue, 06
 Dec 2022 23:52:41 -0800 (PST)
MIME-Version: 1.0
From: Xinkuan Yan <lucky33newman@gmail.com>
Date: Wed, 7 Dec 2022 15:52:32 +0800
Message-ID: <CAFQkDybMFX16dSaW+eZ0rC7TAwD5O7RnCkSuTS-ka9zZwKjC6Q@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] About those realtime tests.
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

Hello list,

Green hand here to ask a question about thost realtime tests, I mean, tests
under this folder:

/opt/ltp/testcases/realtime/func

I surely knew that those tests could be started with 'run_auto.sh', and
most of them provide reports with PASS or FAIL.

The question for me is that is it possible to use the script file 'runltp'
to start those tests?

I have read the doc ltp-run-files.txt but I did not quite get to it.

Any guidance is appreciated!

Yan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
