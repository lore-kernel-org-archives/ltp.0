Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0D9109C047
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774521142; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hpFlNFRK2q24Mz+g3uMVtXOFGIxLPAMyYRmhZhHgElg=;
 b=SJKpIc+nKv0+wX3sWWME2EEz3p8KfZn2asdKLD9uW9lePLlYareV+apBzJORorzIPC90M
 9M4IWK9d2jW4BH2bZUx1jEhg+fb0CJq0hCqgLvaEvdKnHSq693FtEq7TWOG5WDJJu2qzLel
 1jLsCP+cRCwQgT3JaOGqZfeCFI+veS0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D75B3C1014
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:32:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F2F73C1014
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:31:59 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 810B41A010E4
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:31:58 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so10243565e9.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 03:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774521118; x=1775125918; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KZ0cMa5gapbvugG3CbZhMApCq8gsyB7Bzhmz0kIEjSk=;
 b=Z9+KHyfZyjrqw++bxqRA44o+QnKvW+obSFTh8zf+VHO0NVNj6+YVj6KoXD63Gzgy5S
 xJM6iDAu0kk3DnoN8aTV0jys19jRGcg5onfMaN1EtxF3/jy3c4lkmyZVk16XCsgsH5cM
 z3xE7Yx83WM+tCYyeMlsiCtktPeBmraorqJ4oua1fCsAuYONHpwub7Rz43RKNJMBWhGP
 By9wyMNGGr2BLKMyhUtcNbloVZfZ39M0FS+r7ueuU0QhySScPJzH7TAeNbtl9PIsU2WX
 roaZIjBwg6pOSlH6t5qlV7KIi+sjVL9Q/1tR+/QjgGASdBgfUhXhIFs/PjJncgdqMxzC
 qIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774521118; x=1775125918;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZ0cMa5gapbvugG3CbZhMApCq8gsyB7Bzhmz0kIEjSk=;
 b=VEtnSFuxImP90LhmsODIgUOG0vg4plbBX1aHH0ZtkuspBG8VekqSxF9ANlPlzXacaG
 E313s23ySJuLFvGEP2j8+JqPg8dAJE6aBWR14AG7ESJuX95DcFh5RdFRGZRMK6FRd3RJ
 0unCl/laudSwfPCzakqa5+Xdp9QQDQtUwH4qweNIrnP3mB4rrsSLVVThJlF0aw/fqKZX
 /7kO5rOIk8Lpgsw2cKwAPjTxiIdYAAi3S7p5BsOzoLSjrnaWR/jUsqPWUgrD+eUEeree
 CsY3O09RHW7YZxA2ZWjaJuMK0BGCX4ZiuG0Hq49IJ+F4+fcqWa2rieZiGc7aX1jO7uKm
 nu6g==
X-Gm-Message-State: AOJu0Yxmhu6mwkPoUAihXq3u3WYDAugY8glQYhTtbyPqe0eRxiz146ip
 M/hb8/An0KPKnEA/zC8yJoUOQoNOZrbb8FbGbnzYh7Qmo8DZGpEHQ9cLCecAr56/2nLEo8+E0Mg
 VCqjEwH8Q8g==
X-Gm-Gg: ATEYQzwDXEtJjYiuUS+eFYnnhu/wEVzAT4r5xqfziqqAekyPxYXEL0ac6S/MXXLgNAv
 x2VU0clc8gnko9rg0JKcI5mrsRzx4vPXDBnBKPPsiKUjGiBeUnkFP4uJhALBk3H9Eak3GX6rDqb
 gqoqJaRgnwRO7YyRSakpP3CugIw3Zkr5bGg8kpsfDqGME7WJjdk4RchE96DrPUtbCyYQkPJihwN
 bRTONwyQRSPz4euWnvtTS2jkGhQD66w9zfKXCCMxk3XPQbA0x3LrXb10BUezURZpCCnTDWKb3pt
 l1kY23LPXW5d8gDOHY/WkcV8Z1FK8HkymAEde+32/9mar0+Chk6HZzihv4AkJTjZLKionjcUZQD
 zrPBfe8F6lKWx/pZBCq+Tfll2ihb5+yFFb+FmF5C6BFKouU8L2A4jLTJCk4T0FCqI3JNim3UxB9
 ZF0Wg3C0qdxsloWliV8s+H5DU5X1BivOLRFD5qEDSvRe5ofqYTekxPp4lcYq7cpey5ZV3sQfw35
 ZGu1XPJISlmd+2Oj4sfP2kwsKXJU9YkKhRuzuPord7yIQ==
X-Received: by 2002:a05:600c:1548:b0:487:338:b4df with SMTP id
 5b1f17b1804b1-48715fffad0mr112934205e9.15.1774521117680; 
 Thu, 26 Mar 2026 03:31:57 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919e708asm6336826f8f.36.2026.03.26.03.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 03:31:57 -0700 (PDT)
Message-ID: <69c50b1d.df0a0220.21d845.0ad3@mx.google.com>
To: "Petr Vorel" <petr.vorel@gmail.com>
In-Reply-To: <20251012194946.370905-3-petr.vorel@gmail.com>
Date: Thu, 26 Mar 2026 10:31:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] hugemmap15: Check for __clear_cache()
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
Cc: Hui Min Mina Chou <minachou@andestech.com>, Khem
 Raj <raj.khem@gmail.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Feel free to merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
