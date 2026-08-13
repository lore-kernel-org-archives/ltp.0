Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B27C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786603300; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=B3mjxUyLUyxmU1Zk4KnJYYHY9sEa79jE27XlZBbDLOT4M/WJvFgEztIeOPDe+e9ftxf3e
 v1NcxxxeBSjqALzITL4Y94Cn7qBobSW9nlKkzZHePDjgDGPjqnn48SnZLSEC238qaWSi4Z3
 Pk/hA/DsD36EUll3CcPu6lX5I+GoyDc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A5173E6C04
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:41:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09CE3E6BEC
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:41:14 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2D3526002D4
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:41:14 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-499840a2575so412745e9.3
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786603273; x=1787208073; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WCmDn0zVhjkrgZZmdS9G4YoiMxGtptoa7z+nUeKhJMR0qyJBbIs8CNnLBgTiVK6OaZ
 U+7EqDyZ56i7B28mxOjXWu01pW+gc/A59YHBv4Q7M/wcniqXQpdm4pUYlobE/yd/4M1C
 R3HH7etX+NM6lCV+ztlwf37bn1s9MwtVaQOESFQgszBx8a5jp/Yid/mVDCDSt6m+9jId
 QydN/kNPyWDn1JorgII+KVGOGZkZodsd6v0x3bZ2JpffQXLoB4hHgbxu5aT7R/jnnPau
 rAMIDBH12uORJ9UxI2fW5ptlWcM+eUkxRxUcsZlRV/ih6V6oP2/SQ3Y7OlTVlvFbryte
 kvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603273; x=1787208073;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ALbjD/kxT2UhNTKCvK3AZamLtc4S3cRntW7Fo4hkq1OmUu9ZBqqrI0rmDz3Y14bhUH
 a5irhusvgZSvhAZkRrJQGzC/Pnf9G05cGFs9IZ13uxcEKUDRFwIrB5e6AsgpPgQnlaGV
 hEK5SzLezyBq9yu73rUucV+NiN4ewlDPwOOMKjzJqdwGBaVYn3BSlNOXzeQJNU1vsp9K
 JUqjJGDs/Bi83AIh1BZ6EtdSk29gq7qfArT/nNy1MV3inejKqqK3Xbf1DH+I1GbLLO/g
 XeRtSXpw1NkLfnmyqddMQVtmP/aznNxFxnJtjnK2sv06DPB5s4lYH7+PNUzJdzPCFeCD
 Ovkg==
X-Gm-Message-State: AOJu0YyymY5b9eiEBcmkwM7EqqhODsPACbBgUpnDn3hqsD8pvq1K3wW6
 YKOmfZ7hlDY1WoJNgG5HHFW1KKvF1iU7c3Jz1S3+Nw17/XeM+47yyfIaSzaq8JDmonE=
X-Gm-Gg: AR+sD13XlBwU7zgXDjp/sTLB9kHedwhReCk+Itg8Efw6tlKLoV1VXvACAuzDX8urzbq
 LEr7SxIYoT6WqxQrh2zZFX3jpMMgRATW3tAsaHqvj2QTdemVfUO7cXzWjKAquyT7NGTBuj33Zhq
 PZ72VUOKd05rc+5QPE4LQ5pHGGafTO2P9AIHZvmK8uom2Wa1xRgPLg7NtBW0z12kJTuN/FALNnm
 8vfd9+Ttxv/PcuyCGy8IpZhM/rqsZg+AMl28t4Hr7hefQXuipgf8eDKnuK4Cui4Ve/NDl5iACar
 RaEYlFfQVP8lYHWPPCsna2xz3Swf16lHVzYmUkFoyBiGD9Q0c3e7Ol39eNkqd5qHsVZepHK6tZV
 w5+WUde+0XEHTk9xtQV90tzUbWZJBH/Lqc7YmFJbkmbYANvW6z2nCpjW06S6dKI1r7lfcUf2Ui9
 bidywCAObCphmcAw9vsV8RlxeG7W0AuUYYV/iuZqKOotq+Ofo95LmN5K+w7J4UQbqG3dAW6C4=
X-Received: by 2002:a05:600c:3541:b0:499:7312:2d5f with SMTP id
 5b1f17b1804b1-499821a971emr29719475e9.19.1786603273474; 
 Wed, 12 Aug 2026 23:41:13 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499821217acsm31808445e9.2.2026.08.12.23.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:41:13 -0700 (PDT)
Message-ID: <6a7d6709.51d65a57.3545f7.10ad@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260811155202.1744316-3-pvorel@suse.cz>
Date: Thu, 13 Aug 2026 06:41:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] test_macros: Add TST_EXP_PASS_OR_FAIL()
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
