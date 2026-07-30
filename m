Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691B2C55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785410268; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DSYJCVY4RGuJ7ntmzgZqlj8qQe+z2L8YZDTql5qELaU=;
 b=kkYKBrXUe7chzJyfThstya08MmxuBjkYp4j3a3Jj41qWewgvsfXGGbSOcGlaT95c8tNOa
 /w5ucPz6+HxyG//RcE5wZk13nIrTstFWIwU4h43Ec1BGmVRnVtxDwwHAX6LFtmnzBlV7Fin
 xzmwqmpQ9fyrF1BpHxRYsK5cVp7uGl8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB67E3E7266
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:17:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F3BC3E56E7
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:17:28 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C869B140097E
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:17:27 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso4802225e9.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785410247; x=1786015047; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5YEEAvdicxPG++QTzSqjAqfF3Rajql1Lt2jqYt4Mbg8=;
 b=d9EtecmsMfVk9GTc90IyXS0ThdabE9QHvDDqcZ4lI561Hkz3TNw+Dn7od9VBbhQuqq
 eZNf0nzK82crkgvpyxX+RBy1i96du000Ynx/haqICveg0yEv7Bw/UKN/MXZOIu+j4yMc
 EBXqRJUDDQEVRpZCSZ0cOzmX+nKf/EzRcv34GvLBhEU6+v+3Y93vR7bZ5DHkr4zmLOP8
 btdp2UcB2hjGQjjub9mFmGRz8iQEr7fz8jiCDT/qXDksLX1DT960VL3hL72fIt9S9x9D
 QjG1IGxyivaeARfQR7r7pDUlorqZNBx2ZK3sa3tHZlkVwwsNOO2sgnsUZEntV/1Oi0+J
 6ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785410247; x=1786015047;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5YEEAvdicxPG++QTzSqjAqfF3Rajql1Lt2jqYt4Mbg8=;
 b=P+B3Wpz1jWZTTdi/+vvFDtZSXicETzU3W2nMIEcEr/TLscfI7ER23EgrF7QrTQej4u
 nA3OZqVy5tIOx3s8VEDJ5U3/dhay5is/eJHoQOTchBVBfb0v+vlHBLCN94MZla5YvRdJ
 9h+z6549p8eB6y/Zqfe8KTKHZOb/o5OQ7VmBcTMwtIdOURxtLYehBImquHkfbFOLoPd3
 0QwEQRWyi5wAggrBb+HDlzejWp2QDi/GCYvfPO2EP6AS1BJFAXxuu33XbkeyLZDxFPCC
 e53JMcyxRlXO7+EHuhrXFuw6e4BrTiILzEwO8nDjMoV2mEkYdqiO276mcSQrU13bQUEg
 rUpw==
X-Gm-Message-State: AOJu0YyICS9h2Nk5cmBk2QqlXGIgk4SbSiiAssjza9af8IVWPVUUKZ7A
 PaCAiIWRp9m1XdEnzsolw6N6ODWsdTTVfez0araN8zWKpnAMbtcUojvqzhwkBgHrS6voikUrmQA
 gpnbR+fl7DA==
X-Gm-Gg: AR+sD10OWis+EwVw3sK0sv4brXQgZ+npsfLK0SOlfXSfeEPkRa+yhmRfOorMQ9maJYe
 yVzuT6fPNuB9+rY9i9b5DrnA6QPGtr83XT597Ca/FzL9ZZD5yKbyXQdtc3YyVLS04Euwt4eG19g
 x+QGB3RIbtrY+SbyMmfzLmr4vEJVIQTbC/RaNkPKLc7nL9KuNDhyoIhRXILMwqm++uKWg6ctHhu
 Cc0lDpUaHTSO3TU/UYGjABkBEU3oOo1mO4N0ZIIOxtr6GPtp/nDtqhzns6sVxyK6yAvWSbCEy/l
 SXSnIM0NdjMW3L44BXk/U0Q5N+oVUPwSsQ5vliIpsYwHxIIPgy+QGCz6sjz0bSgDZQrNbhCWaEl
 OUkPkFIhHY+5+MLTAg9V3meXP0BTNrFObi3Io+v0GooilvBspb8A5T85cClngF1GgnC+X9tyL1s
 OsA7SITpTFcpVTTdCGJJBJq7EK1cBNvCJC3iORHiDT37gnGfFbLNVhFVpPgWcuTgSWgxt2RUfvq
 iIeljTc+KXlIGyZmBjiAtfjRmsho7YeCq68JsgoSvUMO0q6
X-Received: by 2002:a05:600c:4513:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-49801f24221mr23090505e9.16.1785410247167; 
 Thu, 30 Jul 2026 04:17:27 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011fd5fesm48250345e9.7.2026.07.30.04.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:17:26 -0700 (PDT)
Message-ID: <6a6b32c6.cfe55ba5.193c31.b821@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260715123612.1684984-6-chrubis@suse.cz>
Date: Thu, 30 Jul 2026 11:17:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] syscalls: Add epoll_wait16 EPOLLEXCLUSIVE
 test
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

When using `make check` i get:

CHECK testcases/kernel/syscalls/epoll_wait/epoll_wait16.c
epoll_wait16.c:91: CHECK: spaces preferred around that '+' (ctx:VxV)
epoll_wait16.c:94: CHECK: spaces preferred around that '+' (ctx:VxV)

Same comment of epoll_wait15. Otherwise:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
