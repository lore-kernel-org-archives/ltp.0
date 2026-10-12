Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED82CA9ED5
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 07:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE33F3E6A6A
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 09:20:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 284A93E2D2A
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:19:45 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA88460074C
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:19:44 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-3ac144119e4so87009a91.0
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 00:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791789583; x=1792394383; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SkUdCc3EZng+oGpJN9hOZanSuDjfJAJrR6vr+vrsEVg=;
 b=TvP9Exe96Cw1BGDeMs9NaW5VTesscVDJGZzmXRegRymZ9287qT2dNalXwXlRc51Hwo
 ZbCwGTjxDzprkIDG3LEbUN0OiNwgrihrgq8664bNFinYP00i/lVjcMSE9JzOTwayNN6S
 HHYYv+Gewxqrkc5EYCRtePJ9Wdv15h3GEV2OiTc9s9l8PjqSSJY6f/NAQLMbG7KR05uD
 OTWaM+zC4707m6AbiiW+A79DakHFlWOX2wy4CPBg3y8AHYK091a4vewpGhXwYOtJVWO/
 7YjUE+Jd4FU9fGMgXj3YO1VHXexx/GQMyOF1UyEOVs/amsx2M0GsPkcWmqrGUY7Y+AYc
 B5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791789583; x=1792394383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SkUdCc3EZng+oGpJN9hOZanSuDjfJAJrR6vr+vrsEVg=;
 b=b/u33UsAGuAY8/2ayOTVsinbRhz0kme6zMrJLOEKC3dXlOm+nVkQ85hZdD/vMOz24Y
 DMeWUKwVnMCkT6vDJoZpN9i2G5MK0Aq+ZZ7OgK4TmQx3cBEflkWQHdJ57G/Z/hdSDqwF
 5Ff8d+M0n2AQc+Vzts5e7Xn+h1+23Iuqu224EpgV1BGRYnRdgdulWNUqO07Q7lVimDj0
 9fqhyUfCoh7RHhy7m/c6721Ld3Qof2zn9Aq4oxuzs5B6LlUKxu37o3nEW204BMPTsFBi
 LfuQmP/Z/82lMINqAXs8h58LedMfcWCqFAorCEDukDD/MCqIfiHCQZ1nbYuxNGn1WdQc
 rc8A==
X-Gm-Message-State: AFq9FYJ/TnrW9IqjBLdS3azsMINTgT8Rl7xQ16tB6A4jalNmX5T7JWpP
 5lvB7BkRJZoPovlWfL44kkPIGJYMUahYaxm06X8yz51enlyy17TLZyhW
X-Gm-Gg: AYBFou177E3dZPZ2jOiHTWU0lEFEdetC+Q+9e3uco++JU2nH8RPCTFHPaDKIHJQFi6F
 /bQjvSoEYyw6uPorSBVUEL8wZfOKB/fp+xmnrAx5YkGiFk2dGPFwCJyERpscRkXAehEv9gHolv4
 atHHaC85gJ19tIEvC03cYu9G+FoegF1IumTDVFzq17VLT68rP/qpSYHjSL5DFPozCzdeESe3cAp
 GRUmPplrdIWws2DVnE52Gp8z55LXh8ggIJ9xsp5eHSWROh7JFQzMqca+7DrUmns5Vr7fG4I5zcE
 yjAJJIix05vLTJhBKkQ36EDT8+YAMKMjVysYa3yzeCRCKJ1Gq+LsyFEML8lW8MrSyp/F6bDS/Uu
 cppIWWWlqCDZfVcj1ZdjQyEUeqYAAG/bjjU4VGhGT3UUnKNTT/SntXhOCoN7QvVCCLyd7/p0ZsY
 4wVEM3I7GurTbYcsfY0nWpeYO/6ZeA0wrH/9KdW6BZfp+P8sUHfzuL8ZuJxScbgQDcxZ+tIq588
 TMw5SeVBmpl+m3dVsk7srUXE5IhtQgl0x3w8wu7aTk3p4utNt+gO9wY+ej9uffgxsZk/f1YiJYj
 t+MdZxXw/QtJXWdB2qQ=
X-Received: by 2002:a17:90b:1d48:b0:3aa:f2c4:12ee with SMTP id
 98e67ed59e1d1-3ab3a3001demr7424552a91.8.1791789583002; 
 Mon, 12 Oct 2026 00:19:43 -0700 (PDT)
Received: from
 runnervmmprz5.0smvpvknqsnennmz0dwbimyc4d.xx.internal.cloudapp.net
 ([4.155.69.65]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e1deb2sm3881078a12.15.2026.10.12.00.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:19:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Mon, 12 Oct 2026 07:19:41 +0000
Message-ID: <20261012071941.4197-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
References: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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

Hi Jan,

On 12 October 2026, Jan Stancek wrote:
> openposix: timers/twoevtimers: Wait for both timer signals

> +	while (!(caughtalarm && caughtabort)) {
> +		if (nanosleep(&left, &left) == 0)
> +			break;

Low severity, twoevtimers.c:113-114: if the last timer signal is handled
after the condition check but before nanosleep(), the one-shot timers
cannot wake that sleep. The test then waits out the remaining budget
(up to three seconds), even though both signals have arrived, rather than
completing in about 50 ms. Block both signals before arming the timers and
use pselect() with an atomic unblocking mask and a deadline-based timeout,
or consume the blocked signals with sigtimedwait().

Verdict - Needs revision

Compilation and runtime validation could not be completed: the generated
test Makefile is absent, and direct compiler execution was denied.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
