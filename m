Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40578C55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785827955; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=lb7/tjvFx/oC9pOWN6xkzKpp00D57UsZsAkQbKRXIa9gOfWIFxt23x3C/1lofLLdH9bgW
 S6gvFzGf0j6E3t/L20+Je7Df04OotGmZi9c9Ca5C4FDMYDQ106M91Zlgr45n6Oy88MwKohu
 2zIFzzqsIVnSL8kimXp9NZQnMzEKyNo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1254C3E2D2A
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:19:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3998B3E1A22
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:18:55 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2FC9B1A00A39
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:18:54 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso33561175e9.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785827933; x=1786432733; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=YyS9RkoghHeao80rqR21CgxKPsacZEyt1wKqNPC7U+QDJnCuwSqBFVZF+wj/2rX1MR
 YtIvdpH+vrVGYh5Fx2cpQLpbRwtxDcBi4l6XTLEM7YbRRkveeLBY/5k0L6mLf/Grl3uo
 GHRb1MALK1yRfPmEbH4IKh25KM3opRPPqsVTWk9GVj4eP9UNVQZaeCkdaw7fRJUkJnHl
 vOcXm9Pe3atNlR8hYr/EFwP3GgiyYCLv2Vs2IxUoIDQ55fsxHKBYoF6pPeutxO7cZSHo
 g1OkF29xW2MdpCzwQAJRv0DBu5PjRspwmyMOO4Jvg9RPfNQoM1e1eusFqBZaQ4q3YL36
 YxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785827933; x=1786432733;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=QGPli5YqVrbXgPEFWIBX66wlWoioki0QdIcZCAbiUfD6OLR1Q50c36K/bdn+OnJmcO
 rWP9duwwRRf9LJ94qham9zTHak5VJUkEAr2HKhYVyCKRQZ1v6A/jAgCb53oP3frhsarm
 KQ2oLJ1ZNPPF/at4VoJ42ffk2VsCAZkI8gMZWWydJNL5YNovuHTbXpeyfj7G2Bfi/WT5
 zkZiU/yfUjpy4Ef4qKhk0bNNJx/L3IvKHXye3GYNdW4wmFQK6RsuC9d+A7+zO9nHnvTw
 Xqv8HAoKNGrPrx4dYNu1gy6xHUFyyyg7jXB+FDCBGa+SNAq452alimKkY2wJlgXp7HL+
 DpHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTv+MHSdMEPyI3aghx1FDydYrCLavnvOtU1sg6z2vVMa2Cng+eSszPZ08qwqZ8iQvdLnI=@lists.linux.it
X-Gm-Message-State: AOJu0Yyh9C7Biflnu7NH+kuzFnoY743bxfyh/87FE+RMI50D53B45dC3
 hAA36mjyLanwvbuU8bRc3uihPx+3TsSGlfYAtxNlB9ZKG3cgm2t97k6Thr0A1vFkkYk=
X-Gm-Gg: AR+sD11bheWDtrkvH1n+Lw7OfiOScmddUHkAydnmkx+X/ghZHja1oK1tr3GOCXBWVQ8
 Nm9as9GDvyb2K0Xw5LxLiawzaw7CcjZzTO/IQ3soAW6wxd40Y0SOe8B8K9/a67GO2T28v3KQQEJ
 ROab+Jl4HWJ00JkVtK2lTVc2qpd8ph2F22xKGcrxp6kO3RcRK3DnkpmHOlfrFzeQyGVfAIPNKZq
 yMQ/7TDCB8EOUaIM9jMUwGcT1wenHfp3OE+0T97WFs/P6M0dICfwLxYqNMEWNRZVcFjJerkwNt/
 INsxyv7EPNXecxRW+6U9RZh+pCEO3GgOHBA9mfhvYCHzAc6UTRJ0ybzpr2daWm5Nq3npT9SBq71
 BaddR3SWXfcqEf2USnw6VmIGtjTNut48vHLC9eM2OzkPwb5nKnLezkLcUfkFvUGRSspbbh6yv40
 F5J2XXr5h0QRrq2IiTtgquITa0CWRpEAFxBuwNGZ5ZHePxnjpFCHs8rAAQzInei9EWJQBGG+VnC
 Bf35h9KFcrnvt1kIhl4GdLa8k06XsJV4djmoJyPmEWZbtTns+WXwieu6PNd8oIcA6edk0M=
X-Received: by 2002:a05:600c:840f:b0:493:f6e6:ce2a with SMTP id
 5b1f17b1804b1-4980c66b75cmr278748905e9.2.1785827933275; 
 Tue, 04 Aug 2026 00:18:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b73asm37949032f8f.29.2026.08.04.00.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 00:18:52 -0700 (PDT)
Message-ID: <6a71925c.159d33f9.a396c.4a37@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260803115821.238704-1-pvorel@suse.cz>
Date: Tue, 04 Aug 2026 07:18:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] MAINTAINERS: Add IRC and patchwork for LTP
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
Cc: Tim Bird <tim.bird@sony.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
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
