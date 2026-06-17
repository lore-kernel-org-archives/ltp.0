Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4032ECD98ED
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 21:09:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E1C13E6BE9
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 23:09:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CE163E1FB6
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 23:09:17 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76701100067D
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 23:09:17 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-9159da9bba5so21096785a.1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781730556; x=1782335356; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSqV93qcbYgU0gmF08SDV6wN/cQtPN7JqKbVm4+z+0M=;
 b=B713neAD7VWvUa2RcP3jD3DMgH6liYQwzjXEPjRxFZsCFxPNydHuQve7lIWTZCgWga
 h5/jshh07CmyATdb8O2Dtoy/rUK/6pLsQFRYsVx68y6ZWrBwJHHCgsXK9SfTg9KOIHwu
 AmVAlMf1K/TwV8eYh9hIwaxsSIunWONGz9LvPArxSq68BV6ASP3RkX5ic8O786XRxWBN
 q9gYwdxs4n9MqdFUoEbs3nH99hPx783Yzv689mDRSy9dn8ArAMlxe8tLjr0fFsUZjPxA
 SJNSC1boug3uOYpjakl1ON9erdoSn81JOocZChLB8pBxkd+tsbb9MbDyem1jWo7/KWpA
 IkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781730556; x=1782335356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oSqV93qcbYgU0gmF08SDV6wN/cQtPN7JqKbVm4+z+0M=;
 b=KifcrfKQaihkF61jaSFchYWQiOwoTb2x4qgtyRy8rLazBHriBJF7w8tbKtWY3HkP+h
 TgQvKhFccrc9tZfXwhixyCtd3FXtyCC7I1579JXC4e19rm97RQCElTgtmnaS6i7xEP0T
 ILzavu++yI5spy7x8DBd3HcZUo4WmM3cTQnJ0OwPHJ+t3wWXj0dT48ZBt01btR+5Mj8a
 wS++sKkR8i/udRqSf6Floiux4oycv6dGR2UxylYouzSF/VBsjCkxGo4EIHqRf62X9lgG
 N80qOjnjxroVDUoOKm+aEwNEp/n3Xe7YTUAclPLcKhMw1Re4z/Ni7X5BvTqiZKLJ9fep
 gyPw==
X-Gm-Message-State: AOJu0YwX/i/U1YHcifJ53zU5zOO5uI/lYFNZyUSQL2KsAOVYh9ZB2MqC
 chkUX+OsKoU1WtzQh0WREYF1YH4w4FO4EH0/rr4bhbAAs+ZfLrA7TIDf
X-Gm-Gg: Acq92OGtUjXaDGeiYY+NCH0fFYJ9WZlgbw7DiqAqgL8QL0mmoEUAKqirv8nraFJH4Zm
 KPkZh9EW74N7IqQdWq4+MKtxyipUu/lGp+wdbzaSSyfGLoUpaySv225R8Yi+I5ox949cWbTJpoN
 T4HdWCZhBpaWMLEmPtgs3yu/15HT3FHYv4HS3r+/9AGoMJprsYK8gp+pt1/y6xBxKTIa5L+V+/u
 tWiFkQMzXsX/l0H3E3Bimb440xIFFlwcKcxKiVDHhXsul9dHUS0EYG0Ypr4lx5elx2ZeA42znV1
 JPvfmuTgKzHKDHcl3Men28i7gYEFKq0gxWP/8MkPwcJdc/XZHNxgR/E5HFW1vJX+c7KUR4418bo
 u+QNK0o1+eL4TWsQmJwMOzPOCcMZcPv6NwnXWp1+/WheiaekkaX5/AaYj/jwYdRg0ARysqb+1Jh
 qrchIZNqwVLTTW2sHPDZjpPhAhSP15UqV/q8rtOvG+AAtN6lrgxHgswRppBmPg0qsvp66XYsSyq
 ZuzJda7ziD17EeVnGdCtQ5Rw4eC
X-Received: by 2002:a05:620a:c42:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-91d8a7f1464mr1041293385a.7.1781730556060; 
 Wed, 17 Jun 2026 14:09:16 -0700 (PDT)
Received: from
 runnervm7b5n9.30ctfoctnghuzkbs5ahlgug0qg.cx.internal.cloudapp.net
 ([74.249.78.162]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619f05fe7sm2016883285a.12.2026.06.17.14.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 14:09:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Wed, 17 Jun 2026 21:09:14 +0000
Message-ID: <20260617210914.4021-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617200309.176925-1-avinesh.kumar@suse.com>
References: <20260617200309.176925-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fw_load0[12]: Skip on Lockdown and Secure Boot
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

Hi Avinesh,

On Wed, Jun 17 2026, Avinesh Kumar wrote:
> fw_load0[12]: Skip on Lockdown and Secure Boot

> +	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
> +			tst_brk(TCONF, "Cannot load unsigned modules in Lockdown/Secure Boot");

Two issues here:

1) The tst_brk() line is indented with two extra tabs (three total) but
should use one extra tab (two total) per kernel coding style.

2) struct tst_test already provides .skip_in_lockdown and
.skip_in_secureboot fields that perform the same
tst_lockdown_enabled()/tst_secureboot_enabled() checks from the
framework initialization path. Using these declarative fields is the
idiomatic approach:

    static struct tst_test test = {
        ...
        .skip_in_lockdown = 1,
        .skip_in_secureboot = 1,
    };

This would replace the manual if-statement in both fw_load01.c and
fw_load02.c.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
