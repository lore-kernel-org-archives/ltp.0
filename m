Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F53FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777447292; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=XVtDQSwnf1DEvGouB+dXnsK/8Lcmuzk/zarbYc/WqKF1PEP3mobX79jUCt9BPgojv3a80
 SZ+ZJl4mSvSmpekc7jD/MoRkeZs5KoJr4rXdZYWAQK3PLshk3vpTWzs9J2pV6qIUprFtb1Z
 ajwCJALVyM9kfMqgNwY6146vMOGzPis=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61AD83E289C
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:21:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0A6E3E2114
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:21:09 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 581C66012A2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:21:09 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso111552755e9.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777447269; x=1778052069; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=QcDBVc1TrR0Sf7ETtsLPW31HhKX3liMmESu3CmZS8A7p1ozUTtg0OSVutxF5WKgKhh
 LgKwmPUNFs3ZOxhDw/Vgj52wXnN+O5mLIElU2rTdNGorrtrJDfCu4QwETBYxB9LxS87X
 oHyRg0wXZL5TxzcWmI3atOtrYHaNuAdjx1raAvjYp0zDYah4aKSwt93C6nUS3fJKMJsx
 31gBZBkBwIs9YvVi9W5qVHLfojoRfGGrXfHmQSiSL+85YumZUB94EJ0SqSM49YEFXs4H
 J8E5g8Y3jDev1BSnSRZOxghmWNW7/aV8Vx9P0aRY4ky5h9CZujp39lElZ/YQBcTRFOQX
 EneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777447269; x=1778052069;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=JEoo1ED7/56uRxXK1hCq1lgQWHqaANNDRDcuGPcwV/MqF4Y428S2LVzC/ENJKGnQ5K
 e9rL727Gow8SrI0OyvVKoicqJKXA5D/yRTKs0ckFJWkbVaYn/aNpez68IZSYMwEXe6Rt
 9Ob99XaG6F1jNA7V1/WNIJrURNf/UjPzGXxp+gB/gQfYWxgUP8UFQuZeWNkpQtoo9t7U
 pJF9qE+abiY9z7WpUlxMWwTsXHfqmDcOoJeVBhNbNHvFEgRez0vYNOe2NLjJx8Md/CRd
 /7ppvxlTKSLB1q/g1G8u3OA7IiUGExrIfQ5dpF8VrhvzxtFK78rKM5Fvg0mTRF02JHje
 hoSA==
X-Gm-Message-State: AOJu0YzCseomx4HA8LvDhoT5xMV5wsDehQ1ZoxuzISBLbG0Kcchg/wSo
 8nwckF7OgZFPJLbzbV8VmkOVVTKSEwT9IM6QRVgDxkrcj7w1yBGkU286doCW8BQOLcMtcVQaSk0
 WDiktvbm/ig==
X-Gm-Gg: AeBDieuGYdavva7lnhGC7Z8kGSU3hrl3YVr9CzxdPbxdxhCGFOt+7thxYqFaKLMGFdH
 oE9iPpjIUABJAgcazUk48j2kTNRfa0I2tup8xRFytYplhEY26byrws47DC4X3UfE1qnhPOiU1g7
 7eEfgmEVfMDPY8uMMZVOYCx/cw9YJCvZidM+0CbxCkLxXIXLDFMSypZ481QUYwyvbnLapkd1C29
 AxVKTvZKKJWOFqlaEVcg247b0mdG7eIdxxMt28BFCC1MVhbzIvbk8Y2dO/NPLXl8d32XcBgyrkh
 3D8Vp6S6s/GGy+62p7lKlJIG+jJUlLfkTElgmtEd1xVMl0dBWWBlFR6kHKeT2jG3wHmWMj1sdcx
 Jm6GIvWqFfbTOlr50xhOindbhQSqUddo135+VjczL4co9cq31//AeVlnorW+yb35wD5IKRSzv3I
 w4XvYJOVrJXs/zXHrzrXUSWEBIozfWm23Cd9OC4QnLH4HUzfgl108eWPmG4wusl0aJvnV3VCtJe
 vKKCwTfm5OCMMjqHEydqk4jOxMoQ/PYTMPAdIA3AkSREj+8e4DUl4/QxRmtaNdQp2YkrmZ0eNwB
 j/0/gn3bqqwc141/zjDvHLA=
X-Received: by 2002:a05:600c:8b2f:b0:48a:58ae:9933 with SMTP id
 5b1f17b1804b1-48a77b1990dmr96227195e9.18.1777447268622; 
 Wed, 29 Apr 2026 00:21:08 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c316d7esm11598025e9.24.2026.04.29.00.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:21:08 -0700 (PDT)
Message-ID: <69f1b164.050a0220.3d0977.5145@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260428143614.69724-2-sachinp@linux.ibm.com>
Date: Wed, 29 Apr 2026 07:21:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Rename statistics page to 'Supported
 syscalls'
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
