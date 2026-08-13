Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A85C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 07:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786604669; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=jKtuXPDZeaFxtI+DslB/++rpw6mQy7y3KFby69jF1yk=;
 b=QMAlvSFD2KIf+azPYxxYG5b1ybxHk6SLpybpjqxpauFpfIGA/kDs/se9I94YEKK8AOW5Y
 UrhdVW4SfTxJhjsRM88guC6b5pOwWTtNS4eIHGw1RWRKsdvbv3aFlqBx+BGAfegB/OZ9p2K
 rgHhUqCNuoMes98stvWM9chwJQOxAuM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C32E3E6C00
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 09:04:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F254E3D8567
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:04:05 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 535A060073B
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 09:04:05 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so13199995e9.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786604645; x=1787209445; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8Zm7Nlck7HFBRGZL/Tu8+h526RaEM5626ur87REv7u4=;
 b=Gxf0IQLYXTO7MWpmcfIhUP7OmE4sggLUuPel7G+SBjwNdkXBdGIu43mNku09UphkOw
 3vDsBZp3rbXlkcENABQIXBk+Y50wSL8Bww7F7TRUHly54rqqHKX3DJ2oh8Scff+hyxQN
 5cFUui1N0s2kXiNUjPPwK6FsxtmdLnSn0OIxuPWAuGprFA6ZoedWCZF5rB0k+XxTj1q/
 nvl8lrPbxHusErbm1tUvWGhAaNvXcFy1i2WRFEZ0mFGXC9l7lcPtvasVPL0E6O9tsY0M
 sYPb0hTl1Jj7jg26CQgFlu8oyEYB7IdUQ1tUZBYuBb0a/URg9MqcDvRF7uoYdfU+UiGu
 4VJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786604645; x=1787209445;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Zm7Nlck7HFBRGZL/Tu8+h526RaEM5626ur87REv7u4=;
 b=g2NL6bzQtVT2b7Wb9hYCeuuR/cAQgL+Nkg5jwn5lFlAGKoeWC5tuOLS+9B97y6u/fJ
 l7RlSCI8V+Wu7XfsSNTWGtfiuxw8nwhDPbZ0BjLOiwjnoCGW6LqXwNaFViFkm2MucnGW
 2ZwZiKEWyujxhx1wcpij4E/IAmB67bEeoVY6NOZpX7pyt6+2eOvB+Vlj8/XLRjEr31h3
 CPbxp2U8KpyIGKV2hQbCWRqeV6AaD9wkfYfGFG6zQgrpLnIrg7GFqdNpBqnQuYLGG4hp
 qqKjqyVHRCHvzhNOtxKpkHSFBmFGbGN1Cp1r6Fv56hMco5ILsILpaSAJaav9zsPUJySx
 OP8g==
X-Gm-Message-State: AOJu0YxDOMTLiTcPrGBoiWcDsRAC9a92s2TwA0UDoofdKfIRhqC5RCbC
 Ym+VKQKssZVhipV4DbiKoflAAX7QJc4M6HWSHiOYtb4ci1FYMvoP83ZAf7CksB+J+G2SxhKVaRN
 1JMylPmM=
X-Gm-Gg: AR+sD12Tp2Fsw2Y5mRDBtAGHNcvK2uLeEqhU+hrOOs3VI5k2YQANei31ZhJL5cqzv0h
 qCB2JMbEw4hib+N7hG0YMP7AXtDi2Q9JLX4ymqgstHDxtBPM+qP014Rdo0zfgkSQjxritAuSGoe
 NfhtTsv9simafDUls6s/m9iWeDXy9JS2yjWHMdsgtUAzy1WXlUteySRRSNDoYu31MI7u96W0Gmh
 T9/b2kQn2mmqPO26KuLBgRNdH89XCpeiGr0ZmPDPb5aFPdUbBdIZczKRQbSsQ4frbpBZhv6bIcg
 ZowWcAysYeuFylTyjtXgJfMf6JiMU4MCAyuvRV0wNYVFEO66TdUYJOvyrnPyWRvo/++0pHDq1F+
 EWDUjbkF2nrNA0tSD7xQIjp9C9o69gGxLNM/jf9Ls9BzKZEIx3eCnD+BxHmjNoFwjrfjdd5EUB/
 GXa/F97+O48Kijv+/3HC4NBS5a39hdRTLjyFwklQlaYFayW4FeBKBTJhvZlEODzQpAOZjBV9Q=
X-Received: by 2002:a05:600c:8b2f:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-4998219fe7emr43996075e9.17.1786604644691; 
 Thu, 13 Aug 2026 00:04:04 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e2dc44sm67124915e9.2.2026.08.13.00.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 00:04:04 -0700 (PDT)
Message-ID: <6a7d6c64.d419c4af.f46e6.7360@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260811162856.67654-2-piotr.kubaj@intel.com>
Date: Thu, 13 Aug 2026 07:04:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pmc_core: add test for pkgc_blocker_residency_show
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

please keep the commit message straight to the point, without
adding too many information. It's basically describing the full
algorithm in details, while we already have it in the code and
description. We need to understand _why_ commit was made at the
very first look.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
