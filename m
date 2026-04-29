Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA51BFF887E
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777473458; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=xSN8OolG2VojJUDjzvAsHv2jbiMQh0wSgGZCE1Ja9Wk=;
 b=UifMMCOB424iLQzUoveG/OZ/5KhEsI/2qVweLm9XUD5+4yepsmWMoVzTu8i66sspJIU5q
 FUlnkKD1AXGiMn4ppabMIymGh4iKqoIeBCtH5GjlaHb2ULsW2E2Q6RIEwpXyyNnL5mdCvP3
 edo/SbA1PDoyW776dGNTZ/iX4Xq18Uw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CE193E49CB
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:37:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAF413E210C
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:37:15 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CD8860096A
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:37:15 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891f625344so11131075e9.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777473435; x=1778078235; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ahq5YMQGKIWYwMSMU0RiKtu6ogJoxVRJQBTF/tWo5UM=;
 b=SFW582NcHpDLs/pbQ8fyAuK/CXkpLaKVOHUOThR2JGSRV+CzOzvUJFC1MUXe04NFPF
 q+1/pEzjF8367gdurmz4ew/k8X2oe6Rx+x36nbbhzOnYtswJ7Y6xLCWgR5kOCVHdoITR
 hqT+zI+uSJ83zrXXCXNSKVdYmb9pivra4THVQGsGDobOsxGo6JH7ixrDUo0/2rOen5x1
 pS86bEHYMk/m7mOlITf6k4a+XXMysGLpJEx0AHFKCAst7FMtOsFLpyZbeCzwwp3OYjVm
 JwhfKcxtlX0xiCUY4cgTlCE3mpEXe6gPW7JJMhhMAVZu2ddF72mi/140SKkPM/mJxbqX
 H2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473435; x=1778078235;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahq5YMQGKIWYwMSMU0RiKtu6ogJoxVRJQBTF/tWo5UM=;
 b=WqO752pX16RY9Aiukej4KpbmPHG6CPwQf+IINOQ0g8kn6g8KnELofcDuPhOEj2h2xD
 V4np3xDqIKOq6WM5ygUEyIWuawHE4nkbu6wE8MRBs/qMngohHChEiM4iXxKbO8tOrR/X
 BQ5axIRg/QiSkirX/4lF7valhZtDhZ9Gyl+a+yIUSst/bRDc2zavN2d2O2BNGt7eQ7hs
 +haPUpdqikRHCtEvHt52pSBabS+/BkOjuE/RekAbXTdQ+/m64uULKBNEGKOSLCbqweou
 3n4n+jEtkPBtCu0FrWtcJmvnAUGGfegndEBsew/O1Q0VA7boLmjifZ6ENrKaZXj7catC
 IgQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bLFiwGAeEj4pWmxiBoaLf8+0oMUzClvo8Znc2iMzHyjdGgKjrL1s6Sd6HdKYwlrDg/9A=@lists.linux.it
X-Gm-Message-State: AOJu0YxPPkRgnQDR+p9/5j1c+4bdy8TpkVpn20fbfMSzKWHfyddudAcI
 YsGL1StKdxcv+oWEE5HjkISV136S/MMNyVfAKhlP/YexZVR+srOdi+yG5p9dNYhnuILuaYNQHW8
 fS57ngMesdA==
X-Gm-Gg: AeBDievgx2f2PX6E2N3JrRWV3l/lzrz9KGgEULLQlgcGOrubFyZuKsv0LtI2ZjHEFgQ
 xQ5mAc6AjSJKgLzgEGkYlVjpxlGdvaXoUaaKILq2Kw9Z2OCnJHE2xCgatOFgMN9GbhInzYdLqAj
 mmwaVeqFY72wYL3eKskmWX+XaBqd8WH0SY7u3C+PnTDkwB3Xo91pA0o2eThqZirgyM5C+gTkTQe
 F06NFMCqx4Q9RONs1Q5rjNBmjURADjyhuEXT/K1hOAKVOrq3As7mO0T3lVZE5BdYCD+np3pXx8M
 IzHTlJaRtlZotr4KqeCR0tQ0ZeOjAaCFwgRLjMoijCsg2R6muaHVDlEcKQ9zvRwzbzOEcwlE+3x
 fzOJcdkCk/+JyBz44I/EmrlU05i6bUvLSlR7eOXA2pChYqHhz43V84FcSJUO7NnapVRu3suNoIY
 B5EqPA3dU1nzgarnUA/zOGU0cka0KRClzvWLodxLp/5VzxidZw+w==
X-Received: by 2002:a05:600c:6994:b0:48a:5339:a46 with SMTP id
 5b1f17b1804b1-48a7fa98aadmr12309445e9.9.1777473434560; 
 Wed, 29 Apr 2026 07:37:14 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c32afd4sm20487355e9.36.2026.04.29.07.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:37:14 -0700 (PDT)
Message-ID: <69f2179a.050a0220.23837a.873e@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <69f21738.050a0220.2bd76b.a4dd@mx.google.com>
Date: Wed, 29 Apr 2026 14:37:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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

> Hi Ricardo,
> 
> for some reasons we didn't receive the email from the review
> agent, probably because agent was still work-in-progress when
> we received your email. Please take a look at:
> 
> https://github.com/linux-test-project/ltp-agent/actions/runs/24280634858/job/70901877922
> 
> it spotted a couple of issues.
> 
> regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

Sorry I was reading the wrong message. Please ignore this comment.
The patch LGTM.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
