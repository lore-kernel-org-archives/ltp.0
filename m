Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02CC5DF6D
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 07:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787123493; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=JMYBvTr9AVZ9LuoNJKLQxLtTc5XQn55Ot6UVzDGmI3U=;
 b=nj3JXXL5zbYQ6KEX3E6pobpNQahcKX7zv03QHUY41ge9aYZr1+A1saAT3QkEfzlzhzV5y
 pJi9X49sMNOY+hLSQtT2SVVcPRnMzIj7osqT/7h/wkuvwuPALC4rgZsTWMhxjNyDCVnw1vX
 ood50ZZwdIguiBGplFiF7BOsH2ivbC8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B97CA3CD5FD
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 09:11:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B5D63CCAC2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 09:11:12 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD02F10000F6
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 09:11:11 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so6890815e9.2
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787123471; x=1787728271; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JFcDzXR58JpAp6/QclFSbwPpVAFprrSCXInr96VEsNU=;
 b=EqXRBKvD5fde5xh/d1nQSkhZP0BoOdHjCbQ4Xei8D1o/ck4GM8VJ0RLj/dkAXEFTBa
 9df3msMSsyO/Ajp7RxXBmUeclPOfNg0N7myNCIs3TRtSThhIAr6c/58TJYzEDO12pw8Z
 e2Z+B1nQr6UN1DUX6HXTDhbpqCI4BalXK/qkAiA5JoTIn56oWeKMoksSPXCTykNvzj5q
 LxaH188O+aGH4r3ImNZJQsPXSnZuFK8uywLvRTC2tFD3cSq4gbOux4PlGwvdOnlBll4g
 CUkWPsnMgA3yc30kVpoFnSffFthydqlaDdxVTmjwyhegzmJTxC26smJpm7g8OU3Rb5hH
 gJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787123471; x=1787728271;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JFcDzXR58JpAp6/QclFSbwPpVAFprrSCXInr96VEsNU=;
 b=oQeh+c7fJzWjYvYqKaN4ZELebPGXTFyk0LNGOYwcEClY4N9fx5hxlTIwNEDX57EeYL
 1X8UXkY2KU2PFxLFbyZWba551Sa1EqGhZlVDPrdp3O69D4Q+Ttlbz7EXfzQcFfrdycMC
 NTbKFUBo0p61OLrByX70A1T7gPYoDXJw+dHCx/uNxjCIDw7xJOAIVrht51+V8GxLBqxp
 01M22NUMB4/yhVtd2Mf/7kpmv4m537VPCc/N2EZQbNm7QXHQbTOiEO735XUlG3xIdS5U
 lfnbOsAXosjhIgHl+LjqcYeMjcnXnYWEDTBF7YreNqz4tK8UbvNKrx7+m4uMD/eZpe+U
 SqeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIerGYI84qwjt99xVb+o9pA9nt/Nkt8rxnkzE2bEhkysYcMaa0AmrhKA+aRVj5jzlilKA=@lists.linux.it
X-Gm-Message-State: AOJu0Yx81JFH4/stt/f80A2XxrsJJbsMm9gVrhg4Uz6+uAFs5cOn49E8
 0HQzdurg0kVpOCPEm6U6HU5eDWnVprmdG+w2zC+a++56ENH6ffnYelcv/K/Y0jtRZv9At8kTdF8
 5ITx1Drg=
X-Gm-Gg: AR+sD11Ogl9JQaDBnJVUTHcK83BrTu4YmDTXxzIhNw0SQ5b0svTEd3LIF83vLgnpyXN
 SK/U1FSyrS19ClXYiPnWA0j06dAtHp1+a7b/aOwQDQPHunja9IVL9mwPcReV/PhB8X+TacsmXVm
 zSn3P0MXYs7dBlAliJQDnlVmPThzar422xI+03TAEpzSoO+7/x97VkK7WIhRrXg92saodInkGY9
 H8Vb80tGCdSiiE0B/+5Yd5VQOAnF5uQvUzTwS6rP9kOhKIINrQHMdvAHuzWZUUWnsb7LbHatFzh
 RS0pZ4EvTApNnsudCVDBSOHzlHkCGXSpapy0BPKuomt8peaOpAJsrnebWW9aMgUDb00QvgMQkDQ
 rYBlGdXGG8RRcc6x+uyiE+nMmYfVEINT8iNLepwHI77Lx6qphOzFN3CEFIdImV8xUuBV13oz+Yr
 /ckgYBG6gRxF7/BisQ7bHetEqzX8dm6Qbo7nZWLnPgIG3+CLs3xuBz151vcOTTFzGBoAZg7mE=
X-Received: by 2002:a05:600c:6990:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-499aa1ba0acmr43149235e9.9.1787123471088; 
 Wed, 19 Aug 2026 00:11:11 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b802dsm3273804f8f.17.2026.08.19.00.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 00:11:10 -0700 (PDT)
Message-ID: <6a85570e.c9eda3e9.2eb60d.c6b0@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260819034819.8622-1-linuxtestproject.agent@gmail.com>
Date: Wed, 19 Aug 2026 07:11:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

Hi Wei,

> > #define TST_ASSERT_ULONG(path, val, ...) \
> > 	tst_assert_ulong(__FILE__, __LINE__, path, val, (0, ##__VA_ARGS__))
> 
> Could this avoid the comma expression? When a flag is supplied, its left-hand
> operand triggers -Wunused-value, so all three new compat-mode assertions emit
> compiler warnings and builds using -Werror fail. Making the flags argument
> explicit and passing 0 at no-flag call sites, or dispatching separate two- and
> three-argument macro forms, would avoid the warning.

This is correct, we can use TST_2_ which is our default way to avoid these
issues.

#define TST_ASSERT_ULONG(path, val, ...) \
	tst_assert_ulong(__FILE__, __LINE__, path, val, \
		TST_2_(dummy, ##__VA_ARGS__, 0))

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
