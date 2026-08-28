Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD80C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787916371; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=S6G5yDwmIwEgEwPAAsl3uTquQ/UdoPCNkXI76yGfEexVmxtyanEC+lSxMVOOx4l+G3oTg
 9EHW6td1pGity+9S/wWuH2eht9bjSXVBFoGvEnrSEV2i47fymkFPdjNsSyRNxCienzUPyZE
 5zwc9m4R2qWxZ+zQgpKLmqEV9rrDebs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 754FB3E5D7A
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:26:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 756983DD385
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:25:52 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5EDC600B74
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:25:51 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-482c58a8683so689435f8f.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787916351; x=1788521151; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=IhHEyF2Nc2U57czV/N5jIfByzKIKMfbTo6cQYnB7bsvrv1J7hLqRLz/UOqOUxddMBd
 kGtAnCvPNVgPCBVTRNZvH9O7NrPau8qWtisch39wLWD9g/2YXlOMmcSt0YwWCJTssApo
 FW3yDy49CXxoaXJvTYC1F8KbjRrTqNk+Z/tg7g917vx5Y7xsLQqE/7mua9hcJlFguBH/
 TOoKGhpvVi1p4LTiMBMvxEeBHXtYXulf31Oc3KzkLconlpjSTUR0oDwbCq890PieJbDr
 GeaAQliwOMZZgpqyr9YEbKx1g2Y0pAD0+dTeXSxLE6Eej0yiACDhtkrzjGpsKhCUcW62
 QQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916351; x=1788521151;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Jo68cMASQYE76JS7OYo1fTnv170ErUv1Oa1PxFHawjfufm2UuvOBelrxYNCluc1LJF
 DVNL92UXaSpCJCODM+LrEpoZZJ0pVQdxh2mc/5g1xZtuziK16OKb89/JF/GkyGKbOCWD
 Be5WY+VDKE+b9flsMY0n2PvqHb52qd0imv6wb0Tm/MphSmBcqHWFjdRY/+idINi4oLYl
 hxeVxeWOHo4/NWaO83qZpVKrNzJjr3ViLSvgYgQJOod24nPGL0fuE3Fzcntr/gfO6Iaw
 xv2ei/AMxvwCne5SJQ3Z8NdVRiyg0gv2k7JgDVRZ3nHyCheLIacF4JE1M6WT0OTWDW2s
 1LIA==
X-Gm-Message-State: AFuF++nWK3JgZN9XWc3CscDRvhw9BB6/nztLVTq5pRt3iwKbGJ6PsC3F
 a7zgfTTGVMXzhU/g2wPIGscv+xieMQtfwtjOeJwK+8nfLw4TurC6Rr5qbA/YokAjWJkGg8x9rKi
 VtTAZpYUNXw==
X-Gm-Gg: AR+sD12YUIiAsEk61KIBI4qtKBM6+tXSrkVbBZtYJrV7/dc3iWQeI7bzesCZ67vZSVt
 NI04sfmEfX4c6yowHvWKBw8Fj8pF7Xt7miwrgf5C43wkHXuyh/Wu2443NYrCquTYC6MDdniNIL8
 QiL5Id7QJ8trbsVPKD8iqFvQ9iRp00wnj7CXUN8HuWDg4hgCoxpDWkpRDA/OlFYOoePyQkuosK5
 X1xVIy/P2FxnVZ5Y93sBGJmoj5EjIw2jlbW4yBUsh4L6Xy/4XHdG02S9SWgI/S+z8FBxfDIMltA
 l/hMJxZ9LqwD4yyNehwsV4TESHRUgeLD7CfdKlyonwvT7nccoBDrrXdKUmcrohqSXWcGKYxjThh
 bz/iI+Rqs5EB6qRiG4SK3+UZmZ7+GGBVqlo3B4Q9JsqnKgw/P0gbYnxf/KMEJaeRXAGb19VSQKS
 HUkKyod3Gol8x76Av6rAIt8hPmr54nBZDtj4+O7sVA/T9sb7fP2NK89/QtngUC29aiOeGcp46Aw
 9xHoLu29MvWTj0PB24Fl+gn3AHmiXr+6sKHMHBQlazWRp4=
X-Received: by 2002:a05:6000:18a6:b0:482:d900:6558 with SMTP id
 ffacd0b85a97d-482f7984d0dmr7706226f8f.7.1787916351100; 
 Fri, 28 Aug 2026 04:25:51 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac4e24sm3310330f8f.9.2026.08.28.04.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:25:50 -0700 (PDT)
Message-ID: <6a91703e.53cb9477.e41de.f909@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260828095724.194900-1-avinesh.kumar@suse.com>
Date: Fri, 28 Aug 2026 11:25:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setsockopt08: Handle EPERM from disabled compat
 xtables in userns
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

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
