Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D63CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778079060; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=lHyFrOVDDkz41rIQyrwZj71v6IDd2e22vGgmkJ8pzF4=;
 b=nFX5JSrmShpsge0YyxRN3eE7cHR3Wd4egMvNMyzob3/ZThzI3VMXCjI4618TjAgiofeyj
 /s8duHSevC313n+NcXmAGVPp6kVziXIlBUI9+zjwjgZORqX6+9hvHWXH2OAr659yFvsF+7h
 oQx57mhnhPxiQgqjTOYhTrU8sx02DSA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 366363E65A5
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:51:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 968A43E1F3A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:50:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1A3D46009D1
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:50:36 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so100658555e9.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778079035; x=1778683835; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TzbcUiEYtXwTtA2o6gLd/6KgIX6VyK1cq9iqe+qYflg=;
 b=OBtJDynl1y6Jfo/DqM1lC4PQZaM7tS6HbkP5iabANtVcHgiRuNB5DVJEKZpU2xEWuF
 tLG9lwinomfBAcbGTUDk8R6f6n/M7KKA5inOggK7Bnf8FiuxxyiwXzcZymAkVgSA6DQb
 4EHuKC65VMaRjdxwZ7+O6bICjsAJHlBj31WGT6ZIp37qzoxJz/4k2FiaCVwfwYuR6oiV
 vnwcHl1+Fy/oXJB+ItmZrFzsHb0r/1fv6HRbdLLAz3NxX0WSvhlZ413jFJ0ubeZmNVSy
 y+g4QP/U1viFPQ+Sw1Ky/2Uv+q5LNwyBCTMxNQ/9G5DkwtQaBQTY8MpylmNIQMNh8XKk
 2PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079035; x=1778683835;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzbcUiEYtXwTtA2o6gLd/6KgIX6VyK1cq9iqe+qYflg=;
 b=nEQiPQJMJBoc+Wfp7cBlTFl5M5V+d1adUhu+JrLAkfds5gAXGsjz+u9MftP2rimPc8
 CTzYpX+Ti5OCLLgxU3yv5nqCom0eR1ABhSPlkrMB5hfx10qfSHWHCJsi9nBZ7zq1k57/
 QSkBA7kaGqJuPVnfePyu1p2NV/GjgiVhvXzfzOPFQvsPFsRBi8eMzYDhM9FLzrDYt0ag
 PpXNwj7N8/ZI+IZC4FyjJlPV3fE0Vi7c0KJ/ySYY81FvuozcSNrGfN5LoCanFozMawxA
 9njubnE0qUSCUfROh4XCXrOb+t0EHDvFWbviAOlb5eyc3NpNvxseEDXDEvwQwdTIY6C/
 Q52A==
X-Gm-Message-State: AOJu0YzcEJbcKh7uIRmXWRQgRv/GL8mwfikjxTPuX+XQGHBP42rcomCn
 GIxgAEfr4FSj3ymAA7LDbz+IBPZAnpYlKm2SLm3mA6Pa58QBO6b8brIsQuc/6JoUdQvSPpsT9Lk
 g43ZDr8e4sA==
X-Gm-Gg: AeBDiesc+UjYEmMHJR5UC4GcSscYpWlCNWFNZo/RKsmBM14SVaJOLGW9dpxK5okhhnz
 asjXJekwOvg6JHhrsxoi78REM5t2bM4N0m5E9SgDxq8Ejhrl29H4lFDIrCryOqFKY0ksAioQNl/
 lT5ZlHlWIFayf1uAftw4wjYmXlnZRCk/d4Y0kp06MeAXarEpiCmOIhq3LNHJzBYWVPa9AyOORVj
 wGShsm3m7I3aQTsDzTCIwvhZxVg8oVx3y8fi2iQrLRC1gJ3KTqgVVLYPRK5fULcq9KR1LunuG0g
 ymhiujqFzxbI0udyMrPCzxH4i2618CnD6CAEZIadx6E8Uar7vPglC70mrudyrq5liF23ob7GJnX
 loXUjOOqFn59QQc/v8BcqIVeWivt8uRjf2pod+PJm8xVa6XShQMniqYxX8/VTqxFElyofEIEb5Z
 m2DaTXbfHPA0L4RRT66pMDDAcuG3G0K10tPxsOnmMfClpQU1IGxZSSgRNwKXUYwLmOMoWwNKpvX
 ucOSo+xGubk8OmEaFIBbsudicImSuT6n6ggpXc9WrTi2sSs3179i7mG
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48e51e196f9mr62253335e9.8.1778079035226; 
 Wed, 06 May 2026 07:50:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895f0asm57468795e9.2.2026.05.06.07.50.34
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:50:34 -0700 (PDT)
Message-ID: <69fb553a.050a0220.230394.aed2@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260506113655.10797-1-mmenashe@redhat.com>
Date: Wed, 06 May 2026 14:50:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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

the whole patchset doesn't apply on master, hence we can't review it
https://github.com/linux-test-project/ltp/actions/runs/25437329126

Please fix this and send a new patch-set.

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
