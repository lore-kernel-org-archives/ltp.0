Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5698CC531CA
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784810380; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=XjGYzIj2NSh/rzf3E1vXL1a9V6RUKTu/E0oofdh8+2g=;
 b=QMfG0DeTCE0zRXV9KV8U1tgmAIKiL6G4Zwm4GmfNAt6rhOtiji2LT9ph8YvjWi8E/56yn
 xhMIAyEAyEv+S47kfky4Ph2KzbGSgaU3izHIcjkJvqWyHktVHqeJrfbKfRrpQc2IyM0J1mk
 7/Rqxu93kNovudLBrxNxl0IVPeAuDD0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47E243E55A0
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D6213CE5F9
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:39:20 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D760F601415
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:39:19 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so2497905e9.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784810359; x=1785415159; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8Wh3tKNj/cFTE/st3xvtBwEuvtcLUgd2QubMjNIXtmU=;
 b=Rw+tunti39AZqUJ/3kUmf0YwGjrcHXi7ZDjUckIDeE+wQ3lboGEzg20O9dQPXHzCzI
 IyqRqsUErPOAKZWkVtcCwM9tCi4877u3BrG1t6v8NlayaFTdpUnaWkWdjwPnls2jWsgZ
 Llfk+NB6Na9eibwFGku6TFXV0PyW8UMannAHueuMtIp9xUzWkITzVdqLkT3Gv5Ys4w7D
 lztLNMaxZ91vG541pHGFzJsGzXx721drfa0y9HObUZNekT5EWzSRRzWtkFOlkWAvjMGO
 0oJyIFUuIU9rxavVXo06VNqvJfd3HWvgm9I2oy+aEhhQy4srOakQ9/f6Yj8nZtVjGa27
 RDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810359; x=1785415159;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Wh3tKNj/cFTE/st3xvtBwEuvtcLUgd2QubMjNIXtmU=;
 b=ST/mzPPQq+QoJBq7PK+Y5jfGpOcDLeZpfAzXJ7ZzydjFw1MsonANzfR3QMqTTC2ubH
 mwJgmKI9mIUazydOgUvJ9GPYmpWZeApzNZ1RTj0jNmaCe9PJK1yv1RpAX1XqnpMbWVWw
 B/TT1PlTdiiXNEsYt8J7ZcUJLkCN6FGxNk8OWmrdEqrTT4evMf68odpPiN/NcM9mxoYI
 pPRqSqmn0/gRRB8WGkPnlGPYZzfGNsdmTQUQsuHZFJdv0G2BXPNv5fUgCaH0WLWRzRum
 VYCmjeOf2STUlAuKvXgQUR37eyD+qgFDCchBntgmC9tX35bNRjhesnYC3hkptxzMJ7ia
 W5UA==
X-Gm-Message-State: AOJu0YwFUKXFdgzVDLKQv+07rIJqg2r6NO7S8JPsyljTzDQW1dHonqdq
 wiH/W5lr1v8SxFJDG1FpHwG3NID4aC307kv4Je9adlnXeoflkZk5+RHpAGjJI6WjchKQtD6wqSX
 vKNrpsDt6dQ==
X-Gm-Gg: AR+sD13F+yd8G2q2nlY2PiVJIXlrIMM6mvTv4lFOag2G/Qb5q4v2zipMNTFB7yRZp4D
 vdvMT4He9oAMikp9peuMSy6518R0e1Cakk9eqWAZCPAzIjxEp4K0gyWIGK/vIaDkhrSm5SHQfv4
 rsi0KWVcSKxgI6BCZYqiuis6hcuh240Qm/xncpvRi0KkW1GJ+TKbByq8o0OYymtwI2bxs8FT3q7
 tbyfR92vosogl7uZ8lfM7vnG7Ac+yOQ0kSje3rUmbWZdc1sI6mwlepQsRtgFAtvR+WCRRoU0LXe
 9nvVY3bQ5vtN9RfG4dAiLV0zcXCzH6LA3XjDkK3lbgoz1LZ1Sv76GDOITn/cqB5Uk9y5xyuBdo0
 QS0glS3Vl9rT4ShQJzyq9T7zXOpEeorTjg2XKMd7F0UEEqL201wYXFk25MIrqNVx3lBd7WpQtjw
 Tl2NZMyXKnBDFX2ExS/cJBuYbZAg==
X-Received: by 2002:a05:600c:1553:b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-495745a732amr25814605e9.14.1784810359076; 
 Thu, 23 Jul 2026 05:39:19 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b03a93csm107012765e9.4.2026.07.23.05.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:39:18 -0700 (PDT)
Message-ID: <6a620b76.e9cff95d.a2a1d.8578@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260722044732.3547-2-wegao@suse.com>
Date: Thu, 23 Jul 2026 12:39:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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

Hi Wei,

> tst_get_free_gid_() prints the found GID when it succeeds, but it
> incorrectly includes TERRNO in tst_res_(). This prints whatever value
> happens to be in errno (often 0 or a stale value) which is confusing in
> a success path.
> 
> Remove the spurious TERRNO flag from the tst_res_() success message.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_uid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> index af4ef8cf7..b0b087362 100644
> --- a/lib/tst_uid.c
> +++ b/lib/tst_uid.c
> @@ -24,7 +24,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
>  			continue;
>  
>  		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> -			tst_res_(file, lineno, TINFO | TERRNO,
> +			tst_res_(file, lineno, TINFO,
>  				"Found unused GID %d", (int)ret);

uhm? technically it should print 0, ENOENT or ESRCH. That's what the
statement is all about. Do you have a log showing what's the issue with it?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
