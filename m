Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68EBFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777448190; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=gOCjQHnuy0AYy2TccHxER9zOYF4BLbs3w4sNWnmW1n0=;
 b=OTs0uRN53gmV4FXsgMTeeC8p/ZFInAVbq6YJwKjPiC235l0meStL590qRYCzNk5iIr3JY
 DbB55H1MPkhrHdNybpKmx+EJfeLUROxvI2/lKOOhenJLwmcJMoZMgcgooNawgq3i4M+CzBg
 7z/JP2EXwDQEBoAShNwX1uyHS/pt4+A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A5B23E2537
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:36:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40D533CA104
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:36:07 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 733B81A0092B
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:36:06 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so7068982f8f.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777448166; x=1778052966; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PplQbj9Fh4kKFsWPAlYSoPJumhTTOm9/e1+GNekhygA=;
 b=RvwGJhtzGxMoIWoOdQpN6uXT6vAvFB8fsKshRzg52u8QtWjRH0sH3zquZ8SgrTBhvN
 N7Ge/ZJERpTWZv94cPsLH4ijXPnOVvkPR7mlOQTmAHThePhAQ0IIM06r/NOBr/tX+Poq
 Ze/8gHTwgajo/6WlWLeZL1v7XC4E7QnqhFbn/WzuogKMGSfvAcGjvyWi/fs8HVxrYYtM
 dP0nUH6jfF/5nEcsRsbmHTHs+SzknNyKYXteSKifkjPEu2+OxJUYqqxLDM8WQFFPX4Cc
 l/8/KoXiEPKZOkETPsgaaVvJvClH2cHNADE9v/kkZMXpbgD0qKV6H8O4aH/dk80ENBBu
 FwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777448166; x=1778052966;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PplQbj9Fh4kKFsWPAlYSoPJumhTTOm9/e1+GNekhygA=;
 b=cQZL2MjODnNI5AQ2jWk0iiuwDEBTnD2oxjH6TaIuEc+dQsOagAm3wHJU5dj62/cD24
 rKUbZdXLmh5AiiJkO6icPjK9xtuG+IgwjTU5htdMrdL6E+9+Pd/mh2NJjgFdCLEmU1Na
 2xQNGrYfH7Man3oHJOGFO9Y2GmFk3B52W9F9AcBGg5YFXQ4bpWH69aKoVa4fFgTDUrx4
 8pGDY9lrb3A33+ilG+8ZKoprNUaMaLZ6MZ4bnc8ZzT6YzZOfhkpGtDGcviZDfR9j6bFD
 UeQOItLrdU2fJpb8Xwo/+g6vGz/lDn1Ac+4utowUxh+V04FIoNyKMpTLWCT07L3mTC+2
 oDvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PfeTCNLFRGAsobj6D+t4NDdPUBDzeQ0I8st/HXdQ8Yl9yk/QMvos/18r7eOBw+1ofCvE=@lists.linux.it
X-Gm-Message-State: AOJu0YxK0ZbuKF0VitwSAPUO+FnCp4f7kSc0YjY7n8ceuTlR7LxY3UKl
 yqSFvsMUq/629rcRu2JEEDmnb/6r/+DpFK1Dw//O8HI0Sr3YpXpDVhPpGa4DNEa97tb4TRglcyE
 aYgJ1104TCA==
X-Gm-Gg: AeBDietiN+K+K2UnSoGuTgXZ3efdtAZ9tu+QRdt5CV7Chs9tXFJTtiKLu9r8EJ3+333
 Dq4HSAki+T4bqpTiXgOuYBt/WH5vJXX1XCnq8gKdjGa57ixyeYfZ9s8Iv+7OFKUAcGMf3fR9jRG
 olP54AZEc9aSEPp4rioNUQLhCVPYXVToB2pTXT7EieJVT0fU7WsX5btI7/rWa3QRjpjrlRuoBBg
 XeUydsZ+FpxodWh2ypPnG4fdge6hSCi9mxfF+c6wrgLO8XDFJk/rYwIKCgxdBplLA5frKYHIjvv
 lr9VlgXSG2SbWBxXjY8VK0Rdi/GsR/qE++O2KqOyW3HdgfD/F2olgJTMDS74ErFdey/1Comrjec
 EBixigrG6UGtMAwkZMA2FyMfABONDe0frwb6DtHZyffud+s5Ur3YMmU4XPyECnayZH1Z9taDwjA
 QRa0MphXE6Y5xOAfI1xse7BTuyWW2j8vsncRc8Zdm5y+a6Q7KvyZgm/uGVPkCwqzHHb2M994G4S
 tfISeuixkhYcFASGbR3+bBhIyFWOZvafEHnHDTCCcb1w20IcOJdMt/CP6Z9+MXVzOodNnrZwMIg
 +hk2+jfP4k1d
X-Received: by 2002:a05:6000:200e:b0:43f:dd94:3c30 with SMTP id
 ffacd0b85a97d-44648b51105mr11588529f8f.14.1777448165710; 
 Wed, 29 Apr 2026 00:36:05 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca64ffsm4158041f8f.37.2026.04.29.00.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:36:05 -0700 (PDT)
Message-ID: <69f1b4e5.050a0220.1891c8.b404@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260429073109.3901-1-linuxtestproject.agent@gmail.com>
Date: Wed, 29 Apr 2026 07:36:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/userfaultfd: Handle ENOSYS in SAFE_USERFAULTFD
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> The fix is correct, but since this is a bug fix, please add a Fixes:
> tag pointing to the commit that introduced SAFE_USERFAULTFD without
> ENOSYS handling.

Please ignore this review, this is a corner case that needs to be
updated in our reviewer agent.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
