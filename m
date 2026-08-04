Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA562C55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 07:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785828865; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Yo2aGeiGQG4ArI/Xv8WtA4WjWTJjl6BfzzIcXU9NbWT+/a7GgGNFEQ/0lQpKFh2fnI3F/
 sUlOzDCyOyQMA/Z7a1+wCrxPlC+Zkm6yZ74sGQh9f85bCIpi/mItyRE4IfmG7GL5YqmJs33
 rvXDiq6XL4AoSYy3RSKBMJjExM+dCGs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D6F73E2D2A
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:34:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7666D3E1A22
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:34:06 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CBDCC1A001BB
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 09:34:05 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso19572255e9.3
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785828845; x=1786433645; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=VgbpV7tKQ0ZRts2Mj3cvpfGWZJdV04nDJxSmci8EsLyfIl33WgIoFhwdEmQB93VGXd
 brn0Npqt6dV3fHhGhAIR5NnLd7H+wpSl5WvhHRYRpiWO10x7z4LJxY1+4ElmJZ3L/YpN
 ZQGEaWchek5Gr3srV1YEBmln4LgcvSci7vkD/685io/DYGv/zuf8Aa/o8zFUQJGOX3Kd
 swW1SPLdQJBVbX4AY+AverQCQXnsaiQQjKjoLmV5hDjW/Quaexq+vCJTfN8FVBuAK4JL
 BlGbh45tUkN8fl9QZTlfFKhsDLLTAZ/YUk03jxQ/q3WRvYezySx2lMhQQtAu0lfIP0ew
 t/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785828845; x=1786433645;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=GG0nf+mIz+flIQ8iSFIMCZsUifQhHM5dWzr/SeQyqrDlGFPmgE3WlwjZaSgowDh3Ag
 BQf2A58mYbhuJM1DnxYciTy3xXnZjNPt/i2683jRk3qpWsct5A84CKDXCbJ/vP68p3m0
 aJjAAwXRZhCeDV1Iu1I2BgH2vnHqn/i73jUSGNJN9KDzg9XTasKmm4OVltpGhRxr6BlP
 c305r8PXFi51xZInaXIxPsRysnjkjrnP87LXy45MJgnBYAIBVwd6dd6U+I4Gb9G627DF
 K0kDAgQHq5FyNjzf8wW63CIVYZhKlNNKE5IAZ7dqJjaAvciWxA7cpiiXVWKjXzz/oGc0
 8jWw==
X-Gm-Message-State: AOJu0YycrUAILBwK1XFHuUY388KfzWqluNFdpSaXjVZ2e1bdbDsVrPms
 JbQxNscQumtUBfdTpJ86DWjkY8ZWv/bOlH60IAMIPhI0afGtrE1X3QkEwHMrAlrdU4U=
X-Gm-Gg: AR+sD13uptksz3EBLNjgsDkWc8w8Hl0Cp0TcPT4S2r7srLNra2jbK3vSIVXZH8horGS
 V8wA/Jd5eLGS3nGDozdwU+aR6FTGPRwQeTYdBHcqzv9lVmKSIL8davEIJlJI17qBlj5g7sDlfCn
 RWZyJWxI5BMp3+H29FrqMI2q4OzK83evQcOX+CTI6PxWjt0B5sl2mVApE1Xvh0aODo/7m00KHgt
 CWmngHmzBSOOaNWLzTt/XaWwvu5d8IvaOLVRjXzdxUPxttNlq0hL6nY8RFO4nuubpe5SKrzTyAj
 a1lFqfSq7cywJTh3Yp1avLfymIJkyX5XPsD4txqI9yiikUYHgHtPz5VeFQUThG6LIS6bqVh8axQ
 8LtyaoG3dA0z3UAELJEQFrTB2FcTp/J8A9kwEZczbpeXVDIuT+6+NwW//U0M1OYqaCu+3EHx6eW
 FJ7RA1mz/UVHXVQEhVk3GxEKPG6TgwpQ44gYFL+93VGJX1zbXC9kdbouN6IGe9fpnuMjYpje2Fr
 MwAgJ+4235wQO8DewNH8O0xywSlLI+4EAFsaoShhD8Qyn6uUAdoHquuakJG+qX47HpQUNg=
X-Received: by 2002:a05:600c:2153:b0:497:fe58:d714 with SMTP id
 5b1f17b1804b1-4980c674df7mr187739945e9.9.1785828845168; 
 Tue, 04 Aug 2026 00:34:05 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb345sm61599705e9.6.2026.08.04.00.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 00:34:04 -0700 (PDT)
Message-ID: <6a7195ec.9e856a68.164ac9.fa9c@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260701-landlock_udp-v2-1-b1a2c71be093@suse.com>
Date: Tue, 04 Aug 2026 07:34:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock08: add UDP bind/connect test variants
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
