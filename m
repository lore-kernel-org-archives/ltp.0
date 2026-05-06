Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E51ACD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778082626; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=I0EBCzKqFIrBnOTfd1MGOn4WC+DgRfcdGP3SBjs2+MFn2NDNWjMZZYINhZiINlf/fRJ/k
 zGx0ye2RR9m1Zk1eseR/U0dMZnuBmySS+KBPp/uaqkRmxZCYjVR5Vm6lyh8MC4DuHH5x+0x
 MbC/1oqawAUsc5mAr+OKXuaxES6dkzc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E8D43E6168
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:50:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D83EC3E6AB0
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:49:53 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6FEBD600BCB
 for <ltp@lists.linux.it>; Wed,  6 May 2026 17:49:53 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ad135063so62873295e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778082592; x=1778687392; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=eq5zDLlEYMKKxDZ+zvBOsJMwqDGa2yuKR1kA9bc9d4ihpS7GnGtX7XiI/E69IPFcFa
 Nd0OAmEARAJusxd04MUbgQBeL0h3i8i1rsLpRlE43G8X5Au8WhfQzKQPW9P9R7nMtuwx
 Cl7a9gvisotRaICwfiW9vZpU6jBFHzakSFJMGlZhcePuVlX8tb2DlFkMbTImqnRQPrQh
 8BIv9lfEYSzR75unWBkztE8/APgNhbqQIrNSKxj44bPxOcl8HJw6GL7SyryXgSBYkixf
 0QrRqdd1BXzXqSeL4aVlMS2XVXCJC7HEbE4CAlkqCJUM3Uf9ytFai+IGxP2QGTfCD5qw
 Rvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082592; x=1778687392;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Gr676B9Sh+Vd1r/DKpX7SnzG+kk3ay/HwCEXDmpEHjgJtB3f/AyYCA17j+wbOrZuQh
 3GM8mibWnZtnR2A12rPWUuLcRdAf7zYl6CdWmfZoIO+xwZlTsBJXYwLrRFZKA+6rbSbh
 e5qj+wpCuPuFGRrKgwrU/Q+8G7vFnhWnxdmke34ciSQQRRuAzONgDzyhc9tcnpUsImi2
 2TzNFstdzVfKkcns+p+efoZaI9hP4WxGJlHuwMzeIPFpz2I/GgMz+eyf5guQ1T+6ABo5
 /eVlZH0NFbpu6ztaiQtIePxRjIqo+kHAypwbGe3EDreg2qEkMBQIlqNJVg82f1o7GIAn
 cAjQ==
X-Gm-Message-State: AOJu0Yyb7xlIJdSCoDIK1b9KYkQcptbTV5y7I5wEyxUvKkKKH3PviCmI
 rNMVdRHDYDTthIdhfd1nsM/cfZ7HuehlS0fRZNEZqKTcIIfY8DDQq4J8pgbaf9ycyf6C95IXmoq
 WpCLoQ2LFcg==
X-Gm-Gg: AeBDiessw0em4OeWknbRV+zukzfcZM9CwtCrDQUJqn/NtHdWFlf6A76C8b/V4XuC7zg
 cBVLeYZTkgWiuRTxny8s6rU/j07son0Y3dBVIDueNqFz4JCgkF6eg1bet0G7c04yjY+17REYFbI
 nikf5r4kAPM8CN1FtZzWLOR+kFlRDLVeSp4uQ8SBmVbRA3Y54WYwXTMY4+gsManCxRlmM7HrLD2
 UtNLSCYvoIIbWBGUF8KrlD+/WLZGqlfxplzPWVMMhTcljqzWzz/CHDtlyxMDuxEMcYupOaDYqKJ
 L0N2JHJd4JpWPX+P5buJ+MSqz6JGDUSsfkHd29/+WawfrWjR5I7kolq+mhVfZVGa7q6FahAs8ly
 FG3XPqTTpLkmKBZwOg/RTRusfqdnJyRCpau5b4AIkMpLUh6LQECjoMepdIWjm2gsikHdG1lB15n
 cLGqBiwnlyBpqjFdXOAnigQr5S5LbHzF40dG4NQWJLMZIuub/NYDCL9zLx4bXvONMkSve52FwG1
 VZXDb73jppoGasgBx8dRIVzZdH12OQrpN/i4DPHd+HhIo1AmJ2abxul
X-Received: by 2002:a05:600c:5291:b0:489:a4:e58a with SMTP id
 5b1f17b1804b1-48e51f3818fmr71663475e9.19.1778082592542; 
 Wed, 06 May 2026 08:49:52 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53116a9fsm29154185e9.8.2026.05.06.08.49.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 08:49:52 -0700 (PDT)
Message-ID: <69fb6320.050a0220.1fceb7.9beb@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260430063326.53566-1-avinesh.kumar@suse.com>
Date: Wed, 06 May 2026 15:49:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsmount02: fix invalid-flags test
 failure on Linux 7.1+
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
