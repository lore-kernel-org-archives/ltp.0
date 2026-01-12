Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73077C9EC86
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768222767; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4GHSFvsLgbp77vZDZ6McAo9cj/G+5fq1e2lK3Vnf4ag=;
 b=UtfZuCwLydgD2BzRW+Z8pvVjP1c5b3Yck9U4fIpBbXwHyFm6dcz1Yi+t+OxhtdiACIQG9
 KxSwQuCbbTxKgzSPrrRTdtHQV24ENp71ksdEBILHPknXVk8wDkQyHYlPOu1H1w3gQ3oGpBB
 HkfkLi4rMF2VicPAm5Zsy6M3DrWTb/k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B67ED3C32F0
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 13:59:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07FE43C19E1
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 13:59:03 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6B24E60007C
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 13:59:03 +0100 (CET)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59b7b27ebf2so3448473e87.1
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 04:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768222743; x=1768827543; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWu3N2wLzh5c9FNJ6X+SKKQKaoykDyn+VGaBPqtLKCM=;
 b=VePH0aMu3V2HBkOoLqyFFx24q+FLo5ZCLD+TUyKI6GdGqikfbRQKeZQj+2Dt63bw+g
 fS9TPZWUdQb3tnSGHSXBpw8dbha7X08v5svZ04NpaeUdsE7HE+GJFoI4IXXbRHbalXhz
 O0H2NaQ8EPt0Ra18thMn0rCxbCwH387SS6oCV5Fmz5uEZWod7N+AgdQdw+0uHUMaA+ua
 N/68lc8X7moJ9PuJBJfwy3qEHO2yauBFAIYc8mndaz5QRTxw2kQf3qZdZdGzmgqyqq+l
 XNmvHv0Ip5NTMWWCipwX9z10VQcn08W8zTXnvjil7ksjzmrUygJwkhH1WmG7UoB0s7pk
 EbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768222743; x=1768827543;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YWu3N2wLzh5c9FNJ6X+SKKQKaoykDyn+VGaBPqtLKCM=;
 b=XVmtyMrn/IR/EqALJRd2BHsGg/wUM2w4BjeWMBLo06KYjhXlnLO8y2/7eGkQd5fbGi
 aP+mw+E2Pmj4LDIChO0pNS5tZ2FLblv8qed8n7Ei2gfIVySkIZtO8oRpD1DneN1DwPFS
 7N5vP2pgzmTIHQqRZG1DQupptPuL4Bx+TgiyURC0VUogqqHBuRIEjWxrUk8nAWBc6FaR
 NZ7xbsCSUgNGLpbHn6XMZt2VXOH5y5oxa6hWoOkGciQlg+26OiUg/+Z3RQrg32IfApSB
 hK6N7yerslljfh2w2ZtUQzV96r7A1Htz9hcqjEfppnuSbWQYqM6Ns03CYgOSaH+9dkgA
 OM8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcgX+56KnNFGDY2oqL4oypAKbeISFEv4IVR9ke8ubAXIfrc2U82xpmA4knhN/CH3DzhFE=@lists.linux.it
X-Gm-Message-State: AOJu0YzxgPryUm/snVBfrdw4SI0XoYi08x5i5k1Mpx4TAsqfgCMDNgEg
 F4CQn9ye8woLqNH/ET3BnKP63xGI/987MW7kILJJHCjPEOpIf4+VAQH9C5R0yQO8maQ=
X-Gm-Gg: AY/fxX5gXaigim+QBaYzyo4kDUKTnhZlPMV3hPoagFuIX5+bKToqrJYa0F7Gmc31Dc+
 lKyeFCik21vUGuBTp5tm5Ht3HkVTKbjW/xh40k5E5MiwGVymNV/LvDxJt5JvXnbtJwKUuPnNnk4
 g8V4w0UYxa7YkPfK2QBkcf8Ns7AusvPh/Jaivc9yHhyolekHecdhwnB4IfXrv3UfMYl6bwFAvQ9
 AjLT1n1UtxhueRf+53wrSRG0xj7oplrtD8DCfk0w8t0U0joAjQZAQkI8MbEwTvjtVxJKZxiOt5Q
 XglKm8+rO2NGF2KoeHy3GHeLmznlke/JbTgUCjqVAdCsxm5RhB5NPh0eaekiiWdf+LZs29pzzbP
 hNoI7gHihB/U6M4HDhqELPGdCtIYd8CQjmx3iJ0vXErF5SL5Es+36RnD3rysCPm301kZJHftKDd
 hx8biGhffrEErW
X-Google-Smtp-Source: AGHT+IG1rjsayewYrGiFIFbNDkBwLo5RD2YEWQFkQHfbJ3lTDQm9R00VpJig+YOZ0Z2vNjlVySzKiQ==
X-Received: by 2002:a05:6512:3b29:b0:59b:7803:c7ea with SMTP id
 2adb3069b0e04-59b7803c903mr4691962e87.45.1768222742511; 
 Mon, 12 Jan 2026 04:59:02 -0800 (PST)
Received: from localhost ([88.128.90.70]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b65d0f6absm4734958e87.42.2026.01.12.04.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 04:59:02 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 12 Jan 2026 13:59:01 +0100
Message-Id: <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
To: "Li Wang" <liwang@redhat.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260109023914.45555-1-liwang@redhat.com>
In-Reply-To: <20260109023914.45555-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

I generally agree with this approach, but I have the feeling we are
mixing naming a bit here. For instance, we have headers like ipcmsg.h
that has no functions starting with tst_*, while tst_numa.h does. Also,
the tst_* prefix for files has the clear goal to state we are importing
some LTP functionalities inside the tests code.

Said so, I would rather rename all LTP libraries as tst_*.h and to
rename functions inside them with tst_* prefix. In this way, we know
at the very first look, when a library is imported from LTP and not
from other sources.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
