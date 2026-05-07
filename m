Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89814CD3439
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778160085; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=IZLz1/WeXQb2/ey0GOFDnPfLSy6MWngVfBXgtjmf+1ncFljpduWY9iVT1tUNILxdmoRG7
 DPuwBJhqZT2Hp/jB4RtH+lDodSqY4avDcEcT/xryL+KsMN+21TszYgtPJ24lv4zwWE7e3qA
 /s07G+c/jxmOErmhwrUS/VjTfO1pl3Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 211723E614D
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 15:21:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4C233C5F0F
 for <ltp@lists.linux.it>; Thu,  7 May 2026 15:21:02 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5674110008F4
 for <ltp@lists.linux.it>; Thu,  7 May 2026 15:21:02 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48374014a77so10228885e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778160062; x=1778764862; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=AqXTEra9e8TZbuJXCp1gLOp4OhaliNE/uh3X6JL3ZDbdBNHMpdiPRjFXNufO4sR41H
 SjShmTonTAQi8Xc/RoYGbXex7yyf9NpjAAG90dXpqp1s+naw+oTwGrgbiUHJVlClBFat
 41Z/TuhKkd/pw/mNLDT/Jpear6drfjc5LqycpFN7QPPylDh4S0Elq/1y0g9bk6OazK9l
 MbqQMuH0Z3WbcUHrorq6yF6spWd/S82PgyrJBgEQsMrQM3Q1vgSAFilC0BWYeVcfxZcu
 hoBQ3p956rTX2sUaM8vO5uEabyXVWQZzKNU7Kco4lhoG4w4JgB5xGKvmJval3lkhekrg
 7viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160062; x=1778764862;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=mdNGUG05UwBfJ39U7/gjf/d92H0ji3KKvHUckt1BC/YrTmFpAp4gsLc7Z8687g1Iun
 MmpkPwhfT6Qk+ht+B/94V/LgkMV2yyegxiAl1RDS3cuhTLM0Y94Fi3en5sILfEw3Abun
 sPoAtDHPl20MxdMnBhXZZ9k/jas9ZiNiYfXTqIy8dcm812d7VVTPvk9zTFWm1DSHuFrf
 23hkqDO0vsmI9lOLbnW+8zp2NPYvdROlp29eCzqfTbqIu3y6sV0fZRA1lIzZLcX9PAgq
 CiexadUIfge63T+qUF/Uwv5jvl2e1DjAAClS4FZ5Sf1mW8HtnuNJs/i6OlW8WuF5zsf3
 ObQg==
X-Gm-Message-State: AOJu0YxJ0SdcNXAimtI5GLFB0t8R/MisFKUtYr7yLB4RaCdQymLIcPcN
 dNiD/s9nB2GivjTdeFdWv0Mel1LAMTu1R16QqeEchjHGQWFexE1moWwh0PW7tpqGLXygS5vnJ87
 7ukaZJx8fUA==
X-Gm-Gg: AeBDievEM6CUe/AWER7egxgyzf4MeQSL1MTYdrBkTo/0Qw0mtrcGZ0y7ArUugrPGbRs
 nFt9Xjk+lYzMUkGDEIeOBjzZTlpA3BfK0aGNHvDwJkuMEXwG8Al90jHVtjA0yTmDUHmMjDN6AX2
 78/fWz8kN6R2jrS2gDwdJ38kh0/X8eUyXquFlVe21+TB7sJMXa3Qw3wmJ2lMp8uc1adx53A0YHm
 aSiLWw2206GwRZG0tXt/hwAjEpEIj74Ua5VFzfBHRAk6xxbN3mCIG4bqF6a4TXx6Fh34yrI4mYN
 N8DbtEN6l+yxhx6t3mvijQwIGBSVvfO+TaKIZ+E3UGC0aanB8Blg6YhlHPwq++GNZeTWaVamOYK
 1TkQnKHwz3oWhzgZzaS7l7l3gvj/CQ4VtkON5+lfHf0JbtER+q6sTDWimhM6braauLJLYWPexxz
 8igfmN6zFwIT2G7Wb8/sZzZjALW9U/b2+lauzScoH3/puLkc0QW0FxYnewOB5CVw==
X-Received: by 2002:a5d:6282:0:b0:451:be9b:5f79 with SMTP id
 ffacd0b85a97d-451be9b6047mr8072426f8f.2.1778160061584; 
 Thu, 07 May 2026 06:21:01 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03d59sm18582896f8f.20.2026.05.07.06.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:21:01 -0700 (PDT)
Message-ID: <69fc91bd.050a0220.357a7c.b8ce@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260423120309.18049-9-chrubis@suse.cz>
Date: Thu, 07 May 2026 13:20:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 8/8] syscalls: Remove old epoll-ltp test
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
