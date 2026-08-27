Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA83C61DCD
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787832278; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=kqGCCu+lYhwZZ8dVU4k1X4+jNPIULfZOy3dk1mEhvNUddVZFyjka5a16VK1goAqzja8J0
 2O7G60Okk4wWQXyLF5510Huyc13loVaOBMaFvXqUs+jaCtxFxSz3BN7lx0ReQkWRqfR+TBo
 4Zp3oOmpCSsGNtIY1p8c08RuxLDu4/c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E581D3D527A
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 14:04:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82D333C71FD
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:04:19 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDAC91A008BC
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:04:18 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-495590dde14so18696195e9.0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787832258; x=1788437058; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=P6iiEV45702Ov5fYYcORTAH+4QDjaCs1u7GDov4Kk1sbpnrYgdsMAVGU/I7EV/4Td9
 cREO3iR1t5gOkRMXFWFPteUxp7y3IYRLQ/zTX2ngp5PNIOtuw+YQxEyBN8WTXYfrqp+T
 j+yp66Wx3tN/xyGJNVbdLEMcEAYrBtuT3Wa/ZaZ+OtlpxaY8RE/zUfb2RSYtOUWMhlPk
 DvqDbUUIrvWKZAeHHrZ40vq5XtLs3O9OMMfSW904WbBegPwaKH/utoxYGbM2eV9E3zVc
 6fQsy3CanDNThsSbQAtaOvAjgWEd9/6LZaJrnUsBR+gXNS8CZjq0RJzWa8hDPbNumwKr
 PptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832258; x=1788437058;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=HJAFtqgNWVq1uKKuAEow8FHYqYHGj0rpy0T/cJQcYWjKOmWNfjuK/J/iOqO+cYtW/e
 RRLXMEx7A3CTgGbE6yyvqeAZWad970wq8EVxzZmN8plDe//GlSGUd3x6EyndgmOopDnU
 YFOsC0AW7J84MGNbAwxX8rcGsEBklE9FgqrNTepBacHYDk9No3w4GXeGQPp735fHuQr2
 UMVEKdGKDqbM1Z5EzywGB4iVfftknbpNwXsQQNgcxcA1ReHheMQJmdH2AqSxqBT/k+JY
 0jA7a51HQnuNVJZkKumAQDs+9apo5MTQHUEPekIU3poDQ7iAWgZmeGnIIdO0AFoLdpO/
 tmWQ==
X-Gm-Message-State: AFuF++m0uaVroF5jY+Ex2QKV51Pdck8KDkIIYaRjTlsr4Y9rgrSixo8j
 d2ALNvL8fxuE15RGcoZNusoK+7IrQOjKZ2sHNdrgebwEJO2i5WQPdz6pBecNq14wxN0=
X-Gm-Gg: AR+sD11BasNnnBjLrycRerOSeVnD1v+oI+Qbp2u1LYIS04X39xpfCJGpdl+T07RoVcu
 bG4wmfuUIs4QvzYCsZUJf/BUHLaBjWP0jegSaZePc5r35sMtTDGYK0zBLlXncTdLXmw+Eniqs6F
 TBRA6WPVorO84Tkjx9rNuiXopB9D7AarX3l5JYQUk28LlO3YOcZo71DbAesA9T7h5Zk5bQDNm/3
 nv1Ud9GZfWEBdB4HCLGviwOA/oBIrU4TEdhygP7wT36g7eIr3OQXzNN4kRD5iYuenyVxeqZq+N1
 SD8UINqaGewqNxmcgR+AQyvlR96beLP29zevPmok5stufQzEZEKm0qDomI91ik9OHWpO/VyDFTM
 LhJNzI9YYxe1RyX762bF+R8l4eoaj8wXUAPbdktqm+zyMS66cHECrXnFMCKrYujXHFvPBqUdLJp
 +Q1xD2/zJGNgYsGLKU3LwGG2xeUsxCf2zaJ9bkqEipNrJgwMwKcxn6GHvIvSQ51qLqA2r4yPH6K
 bpuBD0HyfpWZK8gYg7Ba3HVIizEmWND3apr
X-Received: by 2002:a05:600c:3e83:b0:493:e365:7630 with SMTP id
 5b1f17b1804b1-499dc823a01mr175230595e9.14.1787832258031; 
 Thu, 27 Aug 2026 05:04:18 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4923662bsm42653715e9.3.2026.08.27.05.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:04:17 -0700 (PDT)
Message-ID: <6a9027c1.d6e631ba.1b87bb.67aa@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260827-convert_fallocate_suite-v5-0-650ab2acdac1@suse.com>
Date: Thu, 27 Aug 2026 12:04:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/2] Convert fallocate testing suite
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
