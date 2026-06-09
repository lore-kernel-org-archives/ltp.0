Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EF8CD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781016041; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=luaOc6nRCK0lYuqdFBeU+Xm5h4o+j9OIFZHQrW1Mwrc=;
 b=RTxRrLZNDtKaPO7VBA3k9x3f+xbjyASYwS+TrO2cpPzFYPs09pjV2KnoVdIS9B7VBxuen
 HKAuce+PZ9F60nf03CTkcHWpZRhHsSrufn+KveCyxz/A/mMFfcZAxcW1GCivza/lUbLB9zo
 kRC3JrE4tGvaFgX/n9/0a5A0KB03rCA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E0D33E6F36
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 16:40:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2968D3C537D
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 16:40:22 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4623D1A00669
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 16:40:21 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so3925339f8f.0
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781016021; x=1781620821; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wYjzU8dX/zOKqwtcxhKktIdsJQ5DTXAAOOwhRZv/kHo=;
 b=QtVJuyHxauYCS5Ivs5XxpQl2wQ6zxMS/HO4AN92ksK53tOwTJm+TRL4LU4W8u0w/HG
 oFU/sYfn2rVUpCcnsdLAoYIyNnM/3dHfypiPAsmE98Dn3SNEej6sHklWcQM6nMnC6H98
 BQKi/D0R0Mj2SwAZa0Fp665+VQFNbsclNTP+jjQmelYn1E5u79/uRxYJUlGvcHwcZH7y
 1SGZmEbq5bfBlo2dudsNl70w8jYwABZwYSiJJK/5oWk5UHz90OSLLU1AisijM9uJoNsn
 tAMbs9RMn0FzDvwRFZB1D3ie5wpvRp0U8VrvRocDbs6ZzN8FtBs/Y1glArXD1BMjAP2v
 xFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781016021; x=1781620821;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYjzU8dX/zOKqwtcxhKktIdsJQ5DTXAAOOwhRZv/kHo=;
 b=TXopeuDB1MtPCDDeBTZHKYFupz3+1Yzo2BD23Vw1cAeiXEYEuqraoOp85fFsf1TXFL
 6HSRE9kPcdxksM69OJ7EYKBF1YoAP7VbDwQ9PwA4x/4QcVVXO4FonkK7bFBIGRcZ2GSB
 XHlTEna4KGjisaAr5UOIhk8/IXmMQIBc2DAMd5omE7WDKFrhUmNrC2/8hOr0p7F++1U8
 ce9u26haWDMPUVmsHKc1i0O9HHc1/pK+2pjnR/UobWMtcaqb+2bbiwNTP62U7p9ozqmt
 jP0cOzkjKRxI9605Zcn/sZnyrMxYiFNxlfIro3HKe4OWTOJ9yB0N2ONJtexiCdQiquJU
 lWrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lITysI0u8mYPMoBXJ4mXwKoDQXbmrxqH4uWL0X/GMMqcXMOksaqFe/wzeJQzgcBlFdic=@lists.linux.it
X-Gm-Message-State: AOJu0YzB42Ym/ROoLeZryzNfVRQ+poGYzMREKqwlTUkCA+Fsj/x8wVUQ
 JFUmrPpDr9wore2Vpuy5+Ef3JXojDt/HL3D1N07tnGoHDL5flNG/gqWYxHhu3K63cos=
X-Gm-Gg: Acq92OFM8dV4Rzv5u3dwcUYS7o9HetDkbcp0gluJ9ht5nCYoiqxXdLLDUnaMe0Oc4oy
 tkqJLGqvKMHSZsq5rZm7X7oQbZsCI2h3a9SPfs6gKkj5r+CquNF3eB1TJPOpH1sWWBG+JcRnNCn
 DQYJ+OcLybyX3sBph7T+sLG9sDlX73+0P9d3WsudY/qgx7P21ZbNN8Kt364dyDiMvc/ZnbQkrVn
 iNGHVbeiwRCyD904aMSwy+RPiLXXDMRnVhehKTvUuqqmesPvujc0eUZdu2dWIX01zEYGoiusMlU
 neIuJ5sEt7qtjxhXWSK7EbfxVtASZ7Fuq7gSV8VqbOWxjcpIKL8YKoCjdOVymui1lTDhgPWuW0U
 lNsUsUvZIyusw+9HMOrhPqUoAPD1FcNP2RQxuKdPC08WS8HhApq2HPEEA12F2mbKeay+opYekBx
 ZYcuBFPBhg9hYjcaRX8ObSluShAFF7z0sinGTfshZSu/Bnr7IkmZu+QbNQYiTTDzx6CUtgLCxJL
 39265J19Yw=
X-Received: by 2002:a05:6000:468d:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-46030643609mr21158700f8f.23.1781016020576; 
 Tue, 09 Jun 2026 07:40:20 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dce6sm55685763f8f.30.2026.06.09.07.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:40:20 -0700 (PDT)
Message-ID: <6a2825d4.1876c818.f852a.f8ff@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aigkpab-7FvQNIsq@yuki.lan>
Date: Tue, 09 Jun 2026 14:40:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14] high_freq_hwp_cap_cppc.c: new test
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

this patch is failing to build on Debian Stable (ppc64el, arm64, s390x):
https://patchwork.ozlabs.org/project/ltp/patch/20260609121840.61087-2-piotr.kubaj@intel.com/

Please fix the patch-set and send a new version.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
