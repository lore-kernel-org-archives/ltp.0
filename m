Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C53C61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788173410; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=pheegfJFA6TUd4REyHKul8mv+LJSRpNkth+ZQMTDJGgnu0uL5LQKu54T8QsLBdqMwATUn
 U2Y7EKBevJG3CdgUhoCOlACnsdLYLSs5Nhl3oabaG8tlIA3+flqG9RZqcNUL1S9m01WbhNL
 qutDccQJCRr6Aj6you0CSdHJqyzL830=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CB8B3E96B9
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 12:50:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE2853C5816
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 12:49:49 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D9F6B140019B
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 12:49:48 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so31162945e9.1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788173388; x=1788778188; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=KUmxfJnyzYgjW6nYG0oksMiWS6ijLqZ+lwl3fy+0rmXkgRE0huNP2/7Kswkr8B4ezv
 izqo82LanPL2Ljan0mtcbdMSt5xuAjXnbBGIRYTj8IL/zK8HebiFHMtt0+4ZBzicdZGm
 Pc4GHtWj/kdqq+u5qsGhyXQs/wAyAjI/8FmPDZSNh8ziwf8wvNjpsHSR3k9Iu0t8Xi+e
 fxyvxr2TRxX3HF8Zet+KDDJ3HKW73WQ1vFaWjdDA6k6ej04EFDSZcXrYMJXG9uyxOTCi
 P6RAR2lzjSs9kf8QfZBtYQ5Efkb/jVt8cqFGufCUeLvCQdZP2eR4AXE9ha87P2OgyhnJ
 OkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788173388; x=1788778188;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=FiUyIry7Pc+QpToTbDx92mYF+P3ToXetumuxUfhV0PfkN4T1oHoYaUZqech3rEH5Gd
 bXbc4R1nYYJYnKevCyOA6mOtKdPOTBNnnfXk2hP8bWuYQ+KTYkVPC3f35BbFWjTmEj5L
 yHc2ikAC8GClWLmfUcU6m4En0JkWME+xWlCARA2viJg0nlJvtYWEbTc8LSH5eJImWGsS
 qUHCHdRUWu0zJh8or/vO7rIlyI1IZpg6RWIZvsBkc5kGA09GRS+UITq05bBp+HR0xjXq
 GYxCEV/zqDj1qYDSl/EgWiz1iufY5ikRA9cQkm2obuj9e7S8arUeVffKyTA90/gqDI9Y
 Hq/A==
X-Gm-Message-State: AFuF++kyjZryfzaPCxc71fXn5nR4enjOrqcvEBAsPImDEOsSgWpcMCCo
 ++/edvbfQAj9gmwAz+/3BsXiGBf3w17JheTdfd+Zdw6q0mH9iMkq9B57zfl2qcoRZWc=
X-Gm-Gg: AR+sD127m5OXaiKZWdY2b2HmNIRUgNri2DAmM/1HYljAVYUmKE9+i37QfBGaLK4KDH7
 gbEkYZB6N2RGi+Vrltylwg6Bsrdm35j+oGapIRPCSb/ORhlnG4pZU4sOmUoMzVGJlAg3aHN1H1w
 9jBXBp2pQYoArONVlHYb1dfiIFKES3kw85A4Ww6r+tGiurBsOqRLf+v60qdL18u2YgLDcEnrDBj
 y5qXm2VSmc9Jh+qg9KK1v3Kw+q3RYP6rYr60RcB2aBgrHMnai2BfNONj1/OAodcO+t9091C3SKB
 gmfNz8fCFVGw0BD+5QbMmReHkbod9mwrpwXlHEpZsVBOVsOpM+4RZ6XOgUv9O9/VjvAuq0zKfkv
 ctks4A/vNcRgUBV93iCSo6sRfIrDPm5zNDvEZG9DUFNTeUu/Wyyi2Ac4yR4h8Fg1LbEz0wwr1SL
 ArzveFlB6DRWZKK3bauYKVbFWYI3m9zaH2kP5uLBUexoDp43iClxOyJHDQmVsKughs+d6B1sGb8
 uqbG+f5pv5V6s99G/1hm0SRYfDdBDDF3mPJ
X-Received: by 2002:a05:600c:4744:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-49b91c2479amr379233445e9.4.1788173388202; 
 Mon, 31 Aug 2026 03:49:48 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49cc6446sm325199055e9.7.2026.08.31.03.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:49:48 -0700 (PDT)
Message-ID: <6a955c4c.a9b7157b.2657e3.c2eb@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260828230924.2635548-1-wakel@google.com>
Date: Mon, 31 Aug 2026 10:49:46 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpufreq_intel: Check for per-CPU online file
 presence before reading
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
Cc: Grzegorz Jaszczyk <jaszczyk@google.com>, ltp@lists.linux.it
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
