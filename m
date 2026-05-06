Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04342CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778070258; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=UzZW3QjlSw5kKmLJzcuNxpbiWGpGw2h0/s5Hqh1b97W4N9OE41PhudaP+m8MOSQgBNJH1
 BknyDXMQBJZ0jroSEMKm6fN6a5q+1DuPbOYpK8kEMJ5Qx8mhAQX+0xNCl5+ZxRPvk1WLxgJ
 JIjKCQMQr/kJfY9rtV6e/VZ5JVVT0vk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6D73E6167
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:24:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 804063E229C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:23:55 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 788F81A0090C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:23:51 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso8556335e9.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778070231; x=1778675031; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=GgNQKL0AOqj3OK/N893gHLzUGpSaIcaVt25h+gmojXcBW6GllAYIf4wYYcO7zI2A1P
 s2DbkxhvLlqGqKRPc7Aw1S75RYWggll6chCr4Hn6ny8tq0Z/Jsj4qiqqEAEtI5VBB3sl
 wA5vo2BUXPNvSsl2TR2seQUQxlWBLJVQ8xDproT+Fk9DMmOhsT694pkMcD5QZ0GkMJ7t
 kgxZR/7rYOH/it5NeqEyF9jsek133XwUTsD0uFqCwkl3YPYhGCbd7U3QIOsvOXZ/b+FH
 y1V0Rz0yiqbjd0rh1nh8cgXx2lI7ytSi1RGIzqlpWBY9SV05OnmxwGHmgGPr0VUVL7iQ
 QLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778070231; x=1778675031;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=DDSHasCzUSnS5QSdk5FWkWMi6hZp6mOlx3zBGAVtxi+zYt7LVP2VlYz5Xoo4R1LsgK
 T2cO98tsYdtrDI9cnLZkvIklLRsWkuu1wZltajzyHk8IuG2LSnx0ksca9yzzLfDKLTKi
 JPEC+xyhqjnN22/NuIqN/fLJZXTxuHh1ap50vnun1TcQOcNmhizt2k7P/632o7VkaoMQ
 y24iNuWHDN1F4PhHBdVmJiWyCSrL6QtXrHxJJ2z1B+esXgELWROSliSxK6iQhzUHDRYQ
 RBFH/ome5RXBFWJt3onkh/BMDD7ozOXdL/IGpBjK8TCQZZ/ZtGEN9xjrtNAmsvY6GHKs
 8aLQ==
X-Gm-Message-State: AOJu0YxQqH/7RpBptZ4IKIs7N9tR2/1Atj/33kPKtH6hNipLp6/6PkqC
 DmxREYPMU3NaDtiGq6OlW5nY5bloCxt+hcqU7EJTCT+JBzzCbXcMeeUXuqv+P39c1Pg=
X-Gm-Gg: AeBDietx+JmKfepeMIdLn4Mf5DCoSJJFMD027FaOMPvCVC/6e2PWWDauayzaYrWu47/
 jdg46GK2kQVevTiDgVqsTa7fCvj1incHStcIcWXKG6vKElTZ6E3edKZoWXGMeIkT+6/LaU9ZOoR
 j78ivroCZ3VIWndMi7Dd6pWj55daU0rgoVTG+NaYBzxnCnY3Hj0rn7pyxRv+iL23/wHMzuSdoBM
 4u9Z4NYFXdfD8wVcDMRI+lPONUIQHkTvVVmuur0wdscgvwEAFUymgVZloSGJZnjIBk1XyjX1U24
 oOqzvZFoHG8YH1ZUKfmH8uGWERlFEM2XZkm/kWz1yib2q23cwb7wTDDZkrIKV4JUvXL/s6VKjDP
 F/qa/upHisTBi3oKKEumPFeihQOfVKDaJRaYETwH0FePZO0Br6KHyJ1sUlpNxJdVZMp3paua+Pu
 n/BQ5WhJbtSFmOFDyL/oIlXOqM7+3FBGlkrr6fGHKlyutKiM4Ct7mCmASODAqc4rLnSjDcBzhMN
 w9rkN/omr7SXjRRRXJFfAUN2shm//7wtaKXI9zlJvk2YEq4A/Qhy49cfCvy9yQswIOBBFymx/47
 Viml0y+Z8JGG
X-Received: by 2002:a05:600c:5291:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e52285af1mr42575565e9.6.1778070230870; 
 Wed, 06 May 2026 05:23:50 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5310930esm23023525e9.7.2026.05.06.05.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:23:50 -0700 (PDT)
Message-ID: <69fb32d6.050a0220.251417.6a10@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260429145314.79256-2-mdoucha@suse.cz>
Date: Wed, 06 May 2026 12:23:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] aio_cancel_6-1: Rewrite test
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
