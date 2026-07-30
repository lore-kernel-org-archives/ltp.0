Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A03C55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785416142; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=GLpS/6YIrSXIYwaVdl32sQfMfrsLqYrGVWE741O9Cuo=;
 b=p3214bGKJ4yz0TVZtRqWtzpyzXA/qNm0bJrRACCa/XgqMBvv9GakQNCU39+/EPBUY1/FG
 2xP/l+th6EQOgCa3YsfQsDQuCm298Y4C65iek776d3fm0dewSUVBtJjViNgwW3D8mZV9RXI
 PWVkw0lMhgjjY99QN6W20s40x9/ikUM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745A03E7240
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 14:55:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 226E63C93FF
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:55:22 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E371B6008DC
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:55:21 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1424395f8f.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785416121; x=1786020921; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4pjyLBcVc7Ov90u3en+04/2L3fS3x8gZ2dOTG+M31ZE=;
 b=Kc1MA5+8QMXm79npcbbzpdKSfz7k+mGs/V6uTvrMLRtOu7CyMkezTh8+aeJQM90nfJ
 LuuOb1iANaGAeTiR7yIF0uMHMMZNIem+rRF3+iHHzuBNlE4PbbES8iwh5pWYBWzz4VRR
 osFrGHGui4FyzYI52IfeKEMNZcYJoa0Cxv2325D10ZfcQL98psUzuD+nxkbJ5aHBtoat
 A7+ieX6mBDuEg0WbroeB6GI+9rpenLJ1w1WPjUYGtdIAQaJRwQf6GzxEwQAp+rgEzR9C
 9WMw+qPPZ7MOuFIJoqNwKXjKx4wAt6lVu7lJhFsn0L7kRDBV1UxfYLkqpFImbN29g9RR
 /VGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785416121; x=1786020921;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4pjyLBcVc7Ov90u3en+04/2L3fS3x8gZ2dOTG+M31ZE=;
 b=fYnjxcghFw4VuK6Iu34qgKhq+T+z8KspYMyf+UXwS39y2qMJT3pbxHl+U5Rdo9bVrs
 dJgPkVT0J/6IOce/ONzy1v9ZGfFoKlBMKM2WQ5areE52YNoOZnMTXUmyVA80zCrwqrGy
 RGh3giBAR5K3opXwvIXMel7EEc6thulHTsRLykSxXtxF8frmRuWzAZmQc1rpMdzT0eyn
 GVnIeGFFE2GGpvqTb7bQPxyMcUmnsHLtlLFbgRm2OPzzqSaqKmYBLDxn1ZKN1W0893L0
 JnrzKZuack5t/JPq2tgefHbnUSB9kmu+XvdixeGaIylF/AXMVKcTzcILeOpIeo0l7rCC
 5IHg==
X-Gm-Message-State: AOJu0YxMgjfB6hAONJV9UNfhXylgPNupqehKFFrvAITYSuln8rZa1CAQ
 ek9UcIhw9KgG0LsU0/5qZgCHm1CmwqZwWCg5td8zHUi744TL316XZpEtEgQtOeaMjKjk+oY5rJA
 RABXJ8oRORw==
X-Gm-Gg: AR+sD12Mttu0gzQNEyBG64+MuF7ImYWomdpMM1H4xYcPMkdRhwbK1DLQPFn/aLixhpm
 im7uax/DbFStkIJ1KWMGF5dg75acKVfR4cJX+jmGnZ9dBjhS+CHUi7X7/yQTHytawAM3LRrAD9C
 xAe5LZYBhZdmpwnYy2K/uVG4beKRwkgeEj6d0Eb5R0wW+NUl2lDmKIMmLqj1wDeKjkEBlrYxJsk
 biG4TTd6rrNEh+SORpGlSbTJr8owq+ovwhMzrVuwp2OuGnFqvutERhR/EmSwIgyiAy5T/kPiUWA
 vT6nv5xWCH6oJIINSd3IxoDCkCxO5BnbefPIe7DOPzWiGmwjCIa7UKmvHTWCUhw0pR0L6+obLca
 q7AWVo8S10XiNCn5l1rU/xYYXKMoLiprMrIRhhQCgOV1I1s0qspf1kAiLQFJyrYqfBWrb+wXY3t
 wV6kLKm1no/ac2INm7jxLqIYKmiF8u596+bzqwgUp5xCIWqZtF6Y2uMyghdr6fJrah5BStyXWT0
 AzYL7QhPUBeUXh44S4HHsFzdKwNybeNEEYCRjtN9ita8lvP
X-Received: by 2002:a05:600c:6298:b0:495:64c7:804f with SMTP id
 5b1f17b1804b1-49800ea1ea9mr34934525e9.23.1785416121268; 
 Thu, 30 Jul 2026 05:55:21 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498010aade3sm62523625e9.14.2026.07.30.05.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:55:21 -0700 (PDT)
Message-ID: <6a6b49b9.bf927062.1fba35.28b7@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <amtJFVYrok5gb5q2@linux.dev>
Date: Thu, 30 Jul 2026 12:55:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] madvise09: restore cgroup v1 memory limits
 with numeric values
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Not exactly, the logic in setup (save) and test (restore) are
> not identical, one reads the other writes. 
> 
> Or, did I miss anything there?

Uops :-) feel free to add:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

and merge then.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
