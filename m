Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0734CD98C7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781524259; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Gzec4DoZfxQ0tzojjqOrtSkIEt7c6qg9Lvbmyo+8Aas=;
 b=QfQB1QUQk3RclDYNcUwpd8R+oJDf4euVkTR2ziwNbhtUfkcfG9CbHz4qat7ehAS62hWGu
 NBLIkmp1qodxn8CJjl858+w69bh3/4tb/9HxuYmxAuoXk8CSS9cqbECi+948wQetcfrM4LD
 fbES953GWLppD4ylY7VwIfiNp+5sQuI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45A373E5CBF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:50:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35273C72DC
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:50:38 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 38D90600A1C
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:50:37 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so21016165e9.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781524236; x=1782129036; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+X2Xj6N3tvzB8l0CLocR56lSB+KVp+jV6pND4NHKae0=;
 b=E35oWsBM63ED6KD4yAOnJcR0IFJNLEOP7AYybhF68JViLaT2UBI5JaW8N/KRhaJx+T
 i7s+kOJpFgXDnJSEz0YIk1cIIK57i38oemLph+fBYVZ7IweMemdb276KwksaJ7NFHcoR
 0ThzWNUHjZxplUpxW53p5INZD8LdfLHjyny2FXgdBNNXsAr7l5vhvRIGt0A7vQwUk+aN
 bkLKE6445kDyvUNu4L0gSpxT+pin7GMAc/dKrLQXLLuj/WbTgLvbmrHgzxIZevh9RSmD
 +Uc1r3l8YX9l7/NrfI8PZVHovnQxWgLaSIqt4brn5fhY6RNfqIbON8feaNRfc735R4hC
 O/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524236; x=1782129036;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+X2Xj6N3tvzB8l0CLocR56lSB+KVp+jV6pND4NHKae0=;
 b=Npz9MpfkqTl7RLQwDCgaG6DSuN0MY0GW+EtRE1zfskgBbhTDhsUSHqY5VareJMEWN8
 6xGTYGsnfgJ7m3CMds+hTvY3kXJqzzJIIsTaPypYEA/EPVKpe6T4fw2sIMcBO7vUzWKu
 EWs0Y1SE9Z+Btwm9ZASJxsbpNt0yLhRaDgX3qzoilT5zVbXAuNf0sAzzIZQwDH6M+GIA
 yD0vwdo4Yv0CwqTnh+rtfkSTa8+genOgzoA0ecFCJNsxKc2ZdELMpYi8cgOMH8LgUByA
 Cwnl5X46M45C7e8FQHezLJRc8yYrds2zOAed/HVDaBANORD4Yzm2HPRplp1vjFLCWswa
 G0nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zMs90W/NyiLEAlGyDEfa25fWbqlOsZPzIlFO2zkPs04OX41sEQ+e4/17oc2wbhvQxAYs=@lists.linux.it
X-Gm-Message-State: AOJu0YyiHuVcP+TOSB3lo0X8IfVlGdWUclMnllxvhtAXE4D85zTXxkjT
 9rpmPnJK0nCLnILXhn4UWvD2yV4zxyWohwa/1MDk50U0ze2E16KT87q7JUJy2ThWFME=
X-Gm-Gg: Acq92OFvfROiXcgDMBzM7IK3nk3AEI9RqxMyO6tUiiszPizxPU17XKu0Vp2bfV6Jf/m
 4C2QggtBE1TzW2z+IvDRulgTPv4KGzgkzmkRyqNrseb9W9frtyhGhrgS7zB4bAB5rGGFthT6tHA
 oYLX49n6RM3b8CX4Sia2R9izu4qX+dYSbQ+DQ5WlizcdgJQFCbxKR2fIxQcHeYDD658PsOPnXOC
 cUs7bf3FW4jqMqVuWP/z1NCjCc3JJ9JSMfsJCkRgz8f+fooOhjmb0pQGN+nYTOn3pfjwOBvcSBa
 F1bKF/vFQt8ExX52jclTD6JqzzZj/c0QR081FsE7HJJMqyAP6dayoLFgSM2FfG00ygf1e+d4dy9
 Kzf+r5gSdtxt3WQN3xyjAHYk64CbJdPhxCBQXWxuLD6j7zEWR0BHNeTGLFBi54rqMNXKCtW6Frs
 ntUNP/ZY+n/kOlSCPoQ8yD75jG+cTwuMue6aIEEc6vGpehcj3oqRAbcuv05RpSZ0+81HV7s9zZ
X-Received: by 2002:a05:600c:4ed0:b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-4922008485fmr129526795e9.7.1781524236389; 
 Mon, 15 Jun 2026 04:50:36 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm38006519f8f.28.2026.06.15.04.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 04:50:36 -0700 (PDT)
Message-ID: <6a2fe70c.795e137c.199b4.82ef@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ai_i7H1Vfoy5H4oP@yuki.lan>
Date: Mon, 15 Jun 2026 11:50:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] fw_load: rewrite test using new LTP API
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> If you are splitting the tst_res() by the fw->fake then do it right. We
> should drop the && !fw->fake from the fail above and use a variable
> only to get the right bit from the result:
> 
> int pass = result && (1<<i);
> 
> if (fw->fake)
> 	tst_res(pass ? TFAIL : TPASS, ...)
> else
> 	tst_res(pass ? TPASS : TFAIL, ...)

Much cleaner indeed, I will fix it.

> 
> I assume that we dropped this because we have
> tst_requires_module_signature_disabled() later in the setup() right?

Exactly.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
