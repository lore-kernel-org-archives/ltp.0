Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC61BCD342C
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777891284; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ek4/Rz8Uk0rOFBGoyHrtNCZMYI9GiKPSxYxySHMZLdo=;
 b=eP0HJ+sXkNkct730d6oTFfGxJeNxrpplfttPet8MzigUMNtH5iqYsVKR2hwF9Z5iqBPF2
 ipkapPYJC3/8JoBGu8kXi9qoZ/2NOU9VkFbiA56/VdwoDuBklboiv57/ug9ISUT8lNfYU0a
 ew6Y5eQ2c6YzWrQxGvOh3F5op2TwUeM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80CF03E29AB
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 12:41:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DB643C843E
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:41:01 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BCB641A006EB
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:40:59 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b150559bso26295785e9.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777891259; x=1778496059; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iFfCS1z3tbmYAaGsJ9XruS1Gbn+g4i1fDcvCRyPPPtQ=;
 b=aWQXHsf/YfYsbdumnRWkmDfjHa03di6F4QpxfnsZ26rBfb+vIceyu7CguDQfi1jMY6
 ec0il9goAefIiHzvCN6YNTMk4nMvN1CYax63ImIFvdauiF4o+6pzP0o+rsp3mUBZVb2a
 JwkmPYdJiRXDT1Oaz0Y+coKSX2+3knbgvd55xu5zdibxugte+55RgFr+74JwYgpYgDDn
 RQb4N6QbMiFpcGdqWBxc9dx4tj4aXk4yKfzocyhzI/wR4cT7WStXP02UhsrU/RbRK2/i
 tYd6H4thl7hR4WEKkZ/csvKIB14hYx9Td4ucy1hLRrY0CTXL/GiQV6BtTLnWVwkTUcfu
 QB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777891259; x=1778496059;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFfCS1z3tbmYAaGsJ9XruS1Gbn+g4i1fDcvCRyPPPtQ=;
 b=V+rQdidMnyrSeyQwcFnLP7DVe7DLZPdd4fsG4fvhcIONrjKeP2jghUW2YVIeA3kZ5W
 WSbEo9mVFQYi2jt1GuodDPomZTVogQdBEDXC0kJGYCRVBbxvV7v83optpn9+DT+b8Vo1
 P3IA0nIVHRYGxPiL+wuce8HdCEzRykLuijSRNZnJsXjdscL9FUtnqZ8kyYGvdNPZ36Nx
 RFwAYverBBW+lPiUPvWo3f7Ihu76TRnE8m5L6ZxVZOX7z9+f/bKQtK9km+opqfulKDBT
 WWrm3WcxF+FTrj6c1nRpwttcYLFcshrzSg2USQhrjDC66H2HAGp3tnil/3TtkuVRtoZG
 MNQA==
X-Gm-Message-State: AOJu0YyjaWyKXHrFZE2698XZubOGLiFmMhcJZfmo+9TBXdJeRwAWalQ1
 4EDZvBE8c6IkXYd+kQLE63dBRg7mlOVnSVmULlz0tmS8KTzzLT8EzUWj80heD07zDIo=
X-Gm-Gg: AeBDies9x6zX5zONzT23fa6GZj5n7gx3VnlylJ6oCyjc2GLwFQ7dOxKcGepOrSTKDSM
 R7HjYVJuv1r7SA1rzX30geIO0KPUMh8wHVeykWkWVhQWQApv7aSZsz2ZVzKTfsfCiGssQrRe4pV
 dvjyazyBQ5WMgwbq6XUp7IlYJaPJpe244vQQAgoCXW3FvICJvXylkHCJSzJ8cQ78lJbmE1W4BTa
 IL8vxCT/O4rmtZx1r9yPlciaIdV8+phJMT20mAcnkMkdYQoimcfvfWsQK+69uT0r3B1+amgZ+B1
 tc1Uki+FUkKtJXd9U+mgVtuo/mLZrAIgsixRsMqXjkSy8jm/1nvveuEdUa/lnmaNomXI0AWzSda
 mY6bYhDJBaUF36yyp3QXDazQQFwbKtGoFjheBWPEBa1Fd41z1wXKoI6WZV2CtaE37tAmrSDxHKj
 0WD+b9gvfKLdirYgWFLZSInrIB7wCP7I3/WZ3+3MAjOTPuSoTZj/hx
X-Received: by 2002:a05:600c:8217:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-48a9852e568mr165785365e9.6.1777891259138; 
 Mon, 04 May 2026 03:40:59 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebc4201sm418967715e9.15.2026.05.04.03.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 03:40:58 -0700 (PDT)
Message-ID: <69f877ba.050a0220.133014.037b@mx.google.com>
To: priyama2@linux.ibm.com
In-Reply-To: <20260501151420.1042995-1-priyama2@linux.ibm.com>
Date: Mon, 04 May 2026 10:40:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] testcases/kernel/device-drivers/nvme: Add NVMe
 device discovery test
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

Hi Priyama,

The patch doesn't compile:
https://github.com/linux-test-project/ltp/actions/runs/25153014278

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
