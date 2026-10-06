Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD02CCA6004
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 18:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42BC3E9CCD
	for <ltp@archiver.kernel.org>; Tue,  6 Oct 2026 20:53:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F67D3E53BA
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 20:53:28 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3B73D1400BC8
 for <ltp@lists.linux.it>; Tue,  6 Oct 2026 20:53:28 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-93497257b7aso148084085a.0
 for <ltp@lists.linux.it>; Tue, 06 Oct 2026 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791312807; x=1791917607; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tO13MnIRDHfzwjG0WSghU3RiBMbmL3C87iocXYuovfo=;
 b=hgCjAhR7bkL+v42xFd6ihqe845TAGTQXzn38Uhb52ow86WUf9ucwrQCIXx6S5EWEnp
 D2Skf/O4QoAfAnRrWWqONN+7zMFYI8h8IqW86p80Khj5rZrd3cW3U+Uce6lhs/naJPUh
 6iXgg9V9psswUkgUfFAnneVekjBnPWidZ6DZOby+cgMOvmWdhq+ufIo9cL2wXJrofXII
 qCXBgV1XUXDCDIVmhwzWmgS7LmDNeEQu4mxNXdBMC+9rGhKxR0MYEEyhLa/CyMidwU53
 cVnUwwtfJLbXWHbIy8DJ6XrNze6VqNAJfOf0QKZWy8plZN+BvTiJgLiXosGnpxhx/+5m
 RHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791312807; x=1791917607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tO13MnIRDHfzwjG0WSghU3RiBMbmL3C87iocXYuovfo=;
 b=aJiax9e4XSD5mn5oagdin0LxQ2ZZSEqEKpA6QczXbd/Gx6l9v5hOLp2cKvR/YaB+7a
 nQtZSAb0WdcvaK3XX27Zy8tJfs6AfBYsz8SAAPsjfq/ZHwVppnZmaNtsfAMIMHNnHNaw
 EtiO0Y9R1uSJjapRpCni3XBL35tmgc9CQJZNFxhfWLmc2AAmkAyX6CPS8i5JGqNa1m/O
 ZUzt4wJX1Z71dVETLILfZVCM3czL+xXcRFNNCp7tDbnQxTUNtBE8g5Kg0wxfwiyQcoPq
 hgJCDA+RcKwXCTRedwTzLXhIRhZr+RfWwgJQmwZmhQmluQEcw3dlLygC/dhQseEv7N5K
 p9lg==
X-Gm-Message-State: AFuF++kzmlTQrzsdofShFSUjfjmlEiF2m6QFgaALS2ulvlGjtvOKSQWd
 IC7/DNgbSFjqb7ENXBF64a5BWjHwDcYAzaDi6ayMHyHZzIbx3EpZkarR
X-Gm-Gg: AYBFou2bjt8JvXIyQxed4Eqqpc7jXRjSOKbrLsxVDDq9WmvKPO/u0hmw8J0y2C595pp
 uPLdXb22oqWV4FGlQRFQfqb6vq5x4ZFViF6B868/qozSmkzOe8HTVv6dXjvQ0/Vy8VwK4lzf0HY
 Ad7lFXkWpc9FS8q7DtDUsvEHfJrki6HW7DL/tAsY2LqI72QGrShH+83JSm0WvyTYuG7iwr05A7S
 xIbFe01r9bOUn0sNXxQWN5QLxvQcKxwwVDu4YKA0kLAEi3ar0Wp/6skRJAb8YuhEewANLV9hvyj
 GCRqSQGS1z62NHBaNImnje3DfxdcsNYytXYUtrrWQEf2+ESBB+GoAsxfURcFC82WW3+hSmdm6Gg
 zyith2NRVYct3etPC3LuEwgGAnpnenH9MZ1bdCP9+WxTbUijKI8ydv9svMoKlKEwV4btKI0cI9w
 O6zUdda2MHKfboU3acn3prS37hxo+DuanjIPJcgsrl5FRtqSu0jQ9oIk8UrHg4Xr3dN6vYQFgLh
 MHD74Z8uhVBuMSJre8mFi5n79SFl/LpbUwfPgkbqlX7jpV49a7UZE/FbZCRnJ/w1K6h0mUiXcrq
 dIHnMGstBW0=
X-Received: by 2002:a05:620a:17a7:b0:93c:7fab:c44e with SMTP id
 af79cd13be357-93e8f5387d7mr433777385a.63.1791312806432; 
 Tue, 06 Oct 2026 11:53:26 -0700 (PDT)
Received: from
 runnervm8df0l.mdtce0mt4ome5kzwfyfkzdq1na.bx.internal.cloudapp.net
 ([74.235.90.84]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996d52f41sm470356d6.34.2026.10.06.11.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:53:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  6 Oct 2026 18:53:25 +0000
Message-ID: <20261006185325.8520-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-1-c94199a46ec5@suse.com>
References: <20261006-fix_simple_bugs_core_lib-v1-1-c94199a46ec5@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_timer_test: Fix out-of-bounds array access
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On Tue, 6 Oct 2026, Andrea Cervesato wrote:
> tst_timer_test: Fix out-of-bounds array access

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
