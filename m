Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F51C61DBE
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787743878; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=gKmIOpPniv9IdBVHhUvJdgPdgwMkAkVqi3KzgzhbPcM=;
 b=rOiTK3yv3bwlAS0Vg/Vah4h/h/y8Ew+QLNZB8KfkYPSwBEz6+kBqaw5m1u6hQ5q9lqQhJ
 kB0u6E3WANLR6kXDo+AnfN593iwFCBL522NqB0muVr3VXaC4zStgOiYYb6yfHtI6d6c2Erd
 IE6wC1dwH96fm6pipCHzladDdtPiCgw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 509EC3CD74E
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 13:31:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCBE63CAD64
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 13:30:56 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F2B661400BD7
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 13:30:55 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso1516798a12.3
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787743855; x=1788348655; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7T67/Gb7o+tkWT99EP6yUpj5R62vUWMZSmrQwOPMLE4=;
 b=gbzd4bYB9qlhsdfvyEg4ECfeU+BQCPUbmzjOjcWRCZQgdA/Fp7IJWW28k3By3JIHLY
 BTt1JjBQzJdl3i/+zeXYR0cI6yqqvghprDSOdthMwHepG7LTw+esYZ0PTUn7lokNU1V6
 7rjBFf/8ZzqtpdCDSNL3W1NMidWEcw0/Vzfofzz4rLMS4EkL0QTkgFXskg30m1GE7Ni1
 ZU1Zq80jAhNXsCLaCI5qro887zuSyHV+BX4S8cxH8zxmXD7TYCTwE+Pre2ILXuMRTzf5
 +sQQUqJRRPZ8/9MoNmmBvK8KQGoxAKYcM1HYyniilfPD+kTd0lfc+RZyU9qw4zEeveOE
 RTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743855; x=1788348655;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7T67/Gb7o+tkWT99EP6yUpj5R62vUWMZSmrQwOPMLE4=;
 b=k3tfeuEdQGasEjYjQ2M2MqvlyRaa/q33Mhn8+k6ba710GQwmIh9FQ+Swu0ikNf9JSF
 JGe0emC13+3w21kGPRWggGcmYwp5GDN9yEnGcIl4wSBoUqqzWxyQAvP+N9JkJKKpxpWi
 CD9LZm508w3/23qWHtF+p6wcOTUS8o7eSv5RrPXOWrB/bEU9y6DNOf6Gn+/GZtdv+8Wm
 5/J7x4smxzRZUcgtJcH7H+Wh74qwjD5voF34fIwd0lVojMrZBm2U1K9j/XfkUNJAAxFq
 4SF9X6ll514u3UceMgItKh9x+emCqJUp7doCQHyeekHWBWVLLxahVbe+gsNA6jHxYuNl
 B3BA==
X-Gm-Message-State: AFuF++lwGdjsM4Ef6xhV4UxbXvOgXkjnpGdVdiNMsNZ0CP4cPnKaJ/Ge
 /02uvYnJs3CH3/haLNehzYRxXxTimy4oXIoa3i6BGNVkEKKmcSeDpiT0PjMvHM5mGBs=
X-Gm-Gg: AR+sD12wgfHbMeLlDHoeBdZkySm+6rK3L5n555KqFQX+ojtmIK4TO0zOrXxjHXIDetH
 BN418BHBuhQP9tq3WV8zL7P0e+47wVjSYSgzRTa/UzB8fxkJVCs2qpz9XGxnAzCjXSATROWg676
 JxckfCu2okkrwHYm028S5HLX+abwt1RtWDhQFVBU11jKYdBlJtB+bESy7t5Pyb4Q7FIz+0tqq2e
 6Sty8BJ/8NHjo7F+YZMb3dAtHvTHpVgYxZwcKWu5/IvQmiRXrlijJrBcptRc5qt+RTIClydf78S
 4FRNTAUiUu01nULMUPM7gjO10STGCXpzTLvB59NwV+1K303hTD8uwpbhqKGxBuR0fZ7Tyt/exWA
 tzMz/5ABSH6ZgHp81eJgDaMieXp723sdWCMCZiiZywOTlBs9oGt1yQGN3YCYzQo/ylyI/qvllYk
 VOkjCg2O97aW7EufJgZl6dCvvwZZrE+XQqIP+pYqdMzr2LjNn1tAIi0UiLnwxRw5kwlYiUS8oE/
 lZ4EZgfZCjoyDTJAp1FqeUCwmnw+04uNv95
X-Received: by 2002:a17:907:5c3:b0:bec:64d4:3872 with SMTP id
 a640c23a62f3a-c250c3cc2eemr730356766b.24.1787743855119; 
 Wed, 26 Aug 2026 04:30:55 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25258a0438sm210000266b.22.2026.08.26.04.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:30:54 -0700 (PDT)
Message-ID: <6a8ece6e.c5f98925.1b714b.4e09@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-1-dcca6d4ac0f1@suse.com>
Date: Wed, 26 Aug 2026 11:30:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/7] mremap01: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

With suggested agent feedbacks

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
