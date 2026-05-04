Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B949FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777894125; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=P2MNuLxQh1SDfkgdFkeAdLeZmQeQdNEP0HwkJFZ8YEQ=;
 b=lCJz7JuTnAcLGp6FfZ5DAuRoDJeY2fpWO3ZMBTt2sy4ZWOsTUJzPl34vubbiAyM8BPkxj
 LZzUMoezVGqbRO9x7A8vOFM64zpE3QyF9NSboW/iIx+GkUolB7f/+ImdRjmZpNLlf2sGLY6
 NviFSxcRtgJH9sbqWGJ/eiJ/d0sTvqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCA403E6200
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:28:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83F43E1869
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:28:20 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1594A200763
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:28:20 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso28272835e9.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777894099; x=1778498899; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=AUES7k/2vEJ1tMjbnwzpJGSKnbkvx2acsfbnhEE6UZU=;
 b=fbAJfInz8PUb8mIq33QoVz1QmGDfD3diNBkQv1zw+n/A/9yVJIjye8y/HflBS6NMrV
 19R4Yh5lb4ZByYU4uMgvjNGQVu2OLxQH7mBkcv07VhTs3yjS8YVb1XKFEQdiVZkKB4Ao
 5tU478lLdMTE8hsTtAWmrBz3WBKTfthrnfUDxbJf3pzxKy/22b1n0zJeuDmhjOCN0fTd
 u3LjwsKsIBPuSkSMZj/1q0mF81wkyMpB0Yo3rw1iQNrJy8vmCBl/8B+LmL6A7Ol+dNoT
 yME3fc/IDq4ip95SLXVey730bLGcSE+3XO0mnCi+pIhKti2xvVZJdRzHq0MLJ7lSTYAh
 996Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777894099; x=1778498899;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUES7k/2vEJ1tMjbnwzpJGSKnbkvx2acsfbnhEE6UZU=;
 b=m0HSFTjSH8M0JM0EqTLBbR/5fXOzfA0108f0mRghukCF6pLMMs+VPiO/lzJVdpbTS8
 yN0FQnXsaYyF14N2wwXYaIvPjpaeTKrMfHQe7RARExcnLIVKXwTbysUgS4MDADMmOyEY
 V8jj/uYAuethsz03Df8gJxQC+Pf/hln7SdMRHbCNeYDFheAvYakfgJRE5LscEVpAmdSh
 bmf0eAY9mW4V5p7LSXhNzBELiRqsKqdn045ycdoTAkz6dLpTEIMOBIG0GhoZzWhm3+4w
 slbd6hoYVoix/vGvUPenybjA4VFY31siCgddt0Ua01kQgN+YCKs7pz6lQyouQ3GzfPEb
 thtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fEHakDYSgXYNEaSzLnZBR7BgmGwNR+JUoKirRZMv7gWpCYbR6PPcEnf66wUKWdmRIgho=@lists.linux.it
X-Gm-Message-State: AOJu0Yw57BGAq3lpTwzMxtE2VTOikbAoXUUX9X9Jo/xWVWYQbHSzb8Wm
 MAljUwDgEaDRmJ21IDUtFIgdxEzXQLVj4porqcaEsYMVhTNV+Po0+WVR/orUhtbSU1o=
X-Gm-Gg: AeBDievCBTyyNxASKP7eSTD6Cd3YJe2/Y6r6Jv0M3m/6v8OSUGmkSTV0lXH9I+tao0d
 SFKQQVyNIkp1LJKXV4H0UZiNtCaryhNlcpDiRYaKSgktPFgi0NdQQpq/CVEA9JNZqwnARQFRGU6
 oLdJk3lDsT4LeS6UnVdAjbiMibepdWzpjsoCTl57WDHXsZgSPROzeE9Jl6revBE+ux7fJq3W0O+
 NdyGaKEbx75YL3WJGTuc6gQuKzdh1HN780RaU9BuX7vkyzoMivlrsnxjUThth+/5g+aIi734Hfq
 285uoC8czf/EvuKGCPqnCpz8yTQoYb1Z40EGTbUTbnVYp9iNCz5ncrKvFgo8gn7q0ASjMHPPLUh
 eygUhVBtEod8uyM+iE6K0SkhGKbdvdBznH/QIqF8RwfyEMwe3HSBYNCTZiN6p4SdfL+0KtrtdkA
 98T3SWKnjhCDiFmCQeidiHhQLhY/t//1129s5hxFWimFFV+wAJDcSy
X-Received: by 2002:a05:600c:5290:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-48a988c0fd9mr171700425e9.24.1777894099463; 
 Mon, 04 May 2026 04:28:19 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fe93166sm76201675e9.7.2026.05.04.04.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 04:28:19 -0700 (PDT)
Message-ID: <69f882d3.050a0220.1640ac.969f@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afiAUXp-UY52IuKz@yuki.lan>
Date: Mon, 04 May 2026 11:28:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: Add SAFE_SPLICE() macro
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

> Why don't we print the offsets?

will fix before merge. thanks

Regards,

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
