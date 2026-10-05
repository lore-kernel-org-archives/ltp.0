Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E437CA6001
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791202244; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=BUjeLkX+fynL109HgrxFxHe9V+gQCMooxvFKBXg1gGeBL6unuK2KaV7XlZSRkMpZqeovh
 K4G51Vw5+N32QFsYL4hZ7v+uhHCmyWoiFI+wimWM6JaVKfsPZeDEijXpRdSucsVEP3YN0Ft
 LZr3YoeowER5gXGd7LazFUTe0dZcqr0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6C943DD461
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 14:10:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C24A03C2ABE
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 14:10:25 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 56D5710007AD
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 14:10:25 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so10741105e9.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 05:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791202225; x=1791807025; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=QDzE7Q7dYmlZYni6wqrqXGuhjV64nL0OQMxRw3/zuClkKyQ52IhWSDV73HhKtcGl1H
 JWvVNsMzTznbULQuqS23jxaAHTy9ZoUPE28ZmGAPT9nZxURTaOCFW6gnuU66R0TecLSw
 GjyqAOthukqy48qRgOVSRWUuH4ock+uljnwdwP3aPw9hRVHT2/5U19EG/Dqf/ArHBioM
 NfH4qQeQn7R5d21QqIEysjodbgKK6/BluH42H4SqV/CCxSWOg5niXP5syD5FtMgW0H4R
 d8ke0JqTdCJIKKlhM4fDANKhAQFoIC/gJwHYyF6djaSmUHqoqsgT10s+tPlwHQJxkB8n
 g+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791202225; x=1791807025;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SuCzbYTXkQuE7LARdZxYh0yc3SJ90mWf13g4oHzdQDrukMDXKyl2klo3muxLBukIXe
 THZJosjqQxeuZ4HihaF3zKHD1E/vlOZxftxf7Fpzc01jDtVtrjntgW/iVYKrg6YFw7gk
 hnjwEPMimOYP0rkD6kU72ruXwwrEOPuud7dX0sKmEG8rbma2KSkfpKCkkmHTG171l5o0
 R89Gh9PTfWG5t2OTijW7zyJ8n5jcDR13B5M42w0Nz+sUq2tL4JNduOs5yKbe7V+BOXGo
 xOhVcNlxtsjetq6i0wlK/RsbdXTCNGhtj/zfoezw3IBxuXC5w/KIxFCXL0B7oHFXYxLi
 5iCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzODRAS5fvTWweZNi9F6yNlzPDhGIYQjcQpJXTfKff8Y1f1TaXO3CH6SBYMrSED2YkeWhI=@lists.linux.it
X-Gm-Message-State: AFuF++krZB0B2u6AChM0tOlsEJvNd7mKRUFgnGztUVj8UxfIzjBidj9u
 rQAqZ98Pai8XEPfJKNwNEN4HQNL4ebNb2YLZ9v3j+gU+9bVkPdLz2u239bwXXe7jytU=
X-Gm-Gg: AYBFou1yQaN07aBXiKgrYwMJ/GMCeWNujTf785uLP2mg6dmAVAcFViiCbe70tk82qhV
 lscWTYgg6xcdGAJY2Pu7bP7d7tGsTQyPmt6ATZe7Cj7eHyyO4ItzORbmFzZ7yESOZmIHs69xPqd
 PDkMbnYgB0uLN4Styf6as1IGTp0OvQ2sjPhajgvbkV5Zk9a/NjJy0s+7L5K97dCCF6MRxdKjItS
 noxa197sxT31fm+usW1GCqzKpujBubXqx6/XZwz+q6ouFM6fY4dE03z+4wW3chdXWof0DceS8Or
 k8PMgsacZo0fnCyzl0DNiDhkKyPlYONnDza2Swn04IXt4blFJWz72Z12Ey4ZAo/dNZRYG6HWHUo
 XzJqx+ULd5N+oPXpJx3jOBQg0JHgU1lJPauSvl8WWmeVzI19CF4qCaf56vpOqGhgP/IDSTfuAGJ
 wBsMxNCbb88yvuGZUxk+63QkibRuL2AD55+OwtZ9SqdB76rJb6x3vGgckyjSx6Z9GVTPZPJdKQz
 7YetRBpTFHgk+cUdf3SJAVOm0A5CkiClXufLtQclxHTdbtedFvejLP9UA==
X-Received: by 2002:a05:600c:3103:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a0276b9b77mr166931745e9.33.1791202224611; 
 Mon, 05 Oct 2026 05:10:24 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0a6e894a4sm303199575e9.5.2026.10.05.05.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 05:10:24 -0700 (PDT)
Message-ID: <6ac393b0.c193e8a6.2540c4.7df5@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260929070605.34590-1-linuxtestproject.agent@gmail.com>
Date: Mon, 05 Oct 2026 12:10:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] open_posix_testsuite/sched_yield: Fix
 sched_setscheduler() check
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
Cc: "yang . zhang" <gaoshanliukou@163.com>, ltp@lists.linux.it
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
