Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139C9CD4F5B
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779202188; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=OoJDXs1n7DfoPKGhVjRRYIAmLHR1+Ee0y5mJMtqhCiU=;
 b=YvMKlSM0RpC0+VKxw154l3xjnZ9EY+cKiyK78A2ZUQ25fNh674E9uXNdOK7C4AYwMtIvz
 O+rt0MuVXfGsoH3OQsWdh91qt3VmC3fCKbm61L0Tj7jDVwP+eNODX8dZw/cEz/j8nGlsMON
 18VN8dYHqbVWBXJwa4hSSp4d5orKW/U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90FCE3C6FDC
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 16:49:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FAF33C6FDC
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:49:24 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26D9A2003B4
 for <ltp@lists.linux.it>; Tue, 19 May 2026 16:49:24 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so996528f8f.0
 for <ltp@lists.linux.it>; Tue, 19 May 2026 07:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779202163; x=1779806963; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yU8g/kECdx+jNSlvW5qxVBN+uEic3f4jWFN1/cUEVxU=;
 b=I5JGHQzb0m+SzcA6HFmozPoJN2A4MsGKhIXlTZiCPXDkLtH+pvf4xBVACYNyV7w+61
 atzEBtiyLgGNcy+mNUQOF3dVMUMsGtubSMZ5csthNXTwma1NRi3+5EzgNPyu9tKeBex+
 qOxSaD8FRiTE5IQvBflbIRNZndcqQ3DVjCev5KvniC6Mnp7rOyhmhn/Jc1x4RzAi3qW1
 8UrFWQ78KmjTM94eShn16KUFLe8CHIkVTLmeqxbYyijOTkSqwMFr4IXNydOxViKPGutE
 i0Bz5f5qF/l8d/bxsViaFGdACddgDagbNKEw+Bwr0QASL1T3kCIELnO0TstiOKKJFZh7
 D9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202163; x=1779806963;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yU8g/kECdx+jNSlvW5qxVBN+uEic3f4jWFN1/cUEVxU=;
 b=VsvqLrgclqREgCrx5xjv6EjY1Prw3SxvWMgTgaE9FnmYjoYywhT04DLGYgpa2GD56C
 nqV2mDaf7PZ47uWQuSwvD4NpcHkrUhYLnGxQ1nQ+EW8gQI7b7wJqKkp6/iaUQ/p1f+pe
 7XLBflxxq02AvnjV9oPzpFAuLcPKf4S7QJGnaCyrgPjMfsWRNlT4IzcEHkHM0DoxtFdu
 mTWo8PTaqenott/oNXZGWONDRLsUOaw2ZHx1+8SOmBbB8D/77h11v8aqAgKUArPPt41+
 CA54DJIfrOxfuU32IQvQydUHECjWrsEyCNQBXRw1xZwWls/ffQ12k7918c9ORsO+M1xs
 k7+A==
X-Gm-Message-State: AOJu0YwzWLkBIdyb1+HniNKpTNIMnoWBBu+CEUP0oTe+c/6MRb/OIAvi
 iADS4DEoxvdot1IrvuDEzNtb2IHNjrsNiRFXwRktKTYzh14J76eEfhBzxbPjM+tzTwcrkGubKW0
 HfqOBvmaimA==
X-Gm-Gg: Acq92OHm4at1vLT1AD5o1VD2kEfLiKPCbb/KNqUmrTmjp4jpws/LcAn4yKvocvP0XHq
 z++iuykJAbXAfmzdswaOHTSeyMoOaf7pgT3Y/9KvjEryHsF5LtMugfyr+U3t6vawJhxFuqmSZ/8
 FZ8s/Xwcc6sLuuT34TgD9DpdD9tegEdy0/WbloA1MV6oUHCyft8SyuBE7joOy4DJdPD7F1W9tTO
 0BV3OqzB0pmNadp2Q/PaD+IYy+dX+VDIlnlHrjZsiORIkX0qGLZOTGnebd7uiNKj9j2bxXz5tWl
 /UE8IDQgLIRSR/SiDnGFFqvYYC1pGvRHa2BIsZoc/+x6U1+incLoWin/iGQeH5yKBw+Z5/Ycs0u
 dTdyulBjnL1vi++aHle1bGVuHqw5PdcLiIyBMaRYTZDteIOlQwZe8TcjhVBM06UMN83ssTIQZjH
 gLZhP6rcDiJM468PA5K2A37cgQ20NkmK/FiGDHmiQQDgyV7RZ1OLNN6uVsWAEj83mSJ+PzKl9/
X-Received: by 2002:a05:6000:290d:b0:456:d5bf:e24d with SMTP id
 ffacd0b85a97d-45e5c35e415mr32936118f8f.2.1779202163226; 
 Tue, 19 May 2026 07:49:23 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13b4sm46642455f8f.28.2026.05.19.07.49.22
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 07:49:22 -0700 (PDT)
Message-ID: <6a0c7872.795e137c.21fb8a.79fe@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260507111809.28934-5-mmenashe@redhat.com>
Date: Tue, 19 May 2026 14:49:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] futex_cmp_requeue03: Add EFAULT error
 coverage test
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

same comments of 1/4

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
