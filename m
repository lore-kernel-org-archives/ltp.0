Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD8C55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785412732; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lWtCkGd5M9yngHDHH/2PrR+1mDsI4fsQT4qUOfX7ba8=;
 b=CXTR3cV2dLj6Dwm1bL+ORu8P6iBVYSn+S12NiFQJm4Jos5QVhpkpQklJoTeFvsSdr5Gs2
 MLbALAp16P9oEZvWRAw5RZ/6fInXrRA0OzxFUQnGcC8KOrCuKQtDkQqDeiM4FiS/Wmdm/bT
 7lPb5K4+xhYNHbExUppA6NUlyf0vZ7M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2173E7241
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:58:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 141D83E2037
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:58:33 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 753321A006E5
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:58:32 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso13438225e9.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785412712; x=1786017512; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RudiAAOceTGhBxrYyxzyzDz8pw0hct8k9amyx5rzx4Q=;
 b=ZDKyryMEh5JP6URxHDm6a9byZRAF47wVMlFPfjQEXp0cqUYWLXYp8pBvas2H0EMTSY
 6f2AZaYIswzaJM1tFozw8jXFO4yc+3JvCsWGNTCfZuxfAFcZ8nbKK7KVjXnRnCJoLt/R
 FFSXYqzbpDQFoqyn6PyS/0gi7sv4Z2MssMuNgePURSk5eOAGLFlfOQUCsafSiUmvSVxG
 sMRYsN+aHwvUO8HgOR2Unk+AWGFWWGPFC82NPnNcRSSm3vHltRJyOoi1Ap5Rd22QNEXn
 ua44z92ckzxuueKLcSR0Xe1teZTm54n5XLPBc1Ymk/BGEKR2xwrnkDh+KP+vT96EYdYP
 RffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785412712; x=1786017512;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RudiAAOceTGhBxrYyxzyzDz8pw0hct8k9amyx5rzx4Q=;
 b=TrqctyKj6VYi1d4sW62LQLNfEy5YaJLvRGYyxaFwSuAtG9EOF9TpWZk4ld1nIJ0bvA
 bYniLuv/CmoVSwJWOY4Q9C1i3kMLCohke1E2NoOMlfbE/zJrQcEP98+iAeG32/JHI1my
 IwVhVBxFye2YYWP4fBEMtlh5z8nEvfyxZRPxR+yJN1JS72iP6sJrxBxKhJQfVkXpDQ/c
 3pmA0uQpz0RJ2KqkaDEzthbQ4/QgSQO+hjdR/FmBpNiwRxMGuJ0VLiFlcp+YVuIo2URZ
 9NIRzi18BJC6CoJcGyFB/9TH5FcYXz/yLZeGVIOkvZuL7i2ZZSkl5HDZoI2EiRudrz1g
 58iA==
X-Gm-Message-State: AOJu0YxrUGwySLOxIVPsU/lSQtGD2GbuH2746xU8WRkyprJEwFyosNtx
 nX6Kur446BZI/P9E0Umypaf7R4GgNkwigxiWMMkOi5I1XWZBTF/MR9oqP18peC4mONE=
X-Gm-Gg: AR+sD10xbCOrE6+iy32+vP7mL3l2h1Rb5koKMVlqssmGHvm7KK74jhnnwN5GqKY1Xp6
 8MhNeqiABlLI/q6UnK9HtWO5qsPic5dM4hCHwR/xHWLo0utm8q0evC9MC/XEYH8x8X+ZACgwKwv
 SLFNZGwS6cc3Q7tdRbeCHw/aLLgpS+F6DWkf1BQdLbcxMvZiasxIfM4/VX7nuo+k9Qf95NBdV0A
 YaJiQb7MT7+solTUqGXaSDXrv/FImzTKhmWiMJDb/hAxxrO1TaztVPtP+JpJ07WllNLmuXR82Wp
 pAJWi6CECcfEPxWZsdzsz05Zrrzjv9z10JiecjswPovQ+YFJXTxWXcliEA3aUq2mncMBZWeQ7lL
 nl9OWltoL3cTJUM42Wxm8ayZl3Y+mmy6BrGY0p8zyYws4xQQNC5/cXoc7DSsSYXeqoT/VemgmNp
 Qks5zGvVmrgYFsrNrIlxC3w9d1Y5Im5Yzs3VIGny6+EqOMHqercGXy8aGv512UgLl0X8oNreRQJ
 lW1UlP+9gwSOjbTm77U/6s0LFqt3FnViP1gkQ==
X-Received: by 2002:a05:600c:8b66:b0:496:c1f3:e8f9 with SMTP id
 5b1f17b1804b1-49800ea1378mr29654175e9.20.1785412711743; 
 Thu, 30 Jul 2026 04:58:31 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f1a7f7sm65775845e9.5.2026.07.30.04.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:58:31 -0700 (PDT)
Message-ID: <6a6b3c67.89544747.5cba9.8ded@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710075548.1167519-1-pvorel@suse.cz>
Date: Thu, 30 Jul 2026 11:58:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Remove LTP_ERR string from error
 message
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

Can we merge this?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
