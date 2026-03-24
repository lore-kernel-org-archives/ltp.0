Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69BBF532FD
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 09:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774343322; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ZJC7L1qKtDtkhHm0Cvmg5lL8Y+SGAK+oi/bsZhB8BA4=;
 b=NHMgicFqXu0SxI/15obdPiON7r9rhQWn5C1rZ2/o1ehheY/fXbFhlBW6CDziLroEldT7M
 o4/vBufiSKS3xN3SLsYAEaioOXHC2dn43+K0+6Rxef9Yvn7AUiwuLOqbaMKacbiwGqjQVhZ
 19fX7GTNJsSiUURjCk1zqZxCjNf+G5g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6607D3E3004
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 10:08:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D69923E1C51
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 10:08:18 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D749610009E0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 10:08:15 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b44c0bcdbso5474890f8f.1
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 02:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774343295; x=1774948095; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7e/VAUcNepekmz0ORnv+AKxRsAZHsCtLzIk2T1oYo3Y=;
 b=hB12YeS4B5T6Et/0yQMbWHfRU51tsIINx3hNPpQhCr4Ig2DGdqdLpcct6SllNTjvvM
 qcrMGxxe1Xc/BgSUp2gYJB1JNLq480OO1ke9NLYFu1I0rJcTA/OQhAVr5j4tpmlLIra9
 4b3XwvmaVok4Ynhjbuxk9HylNPfQuDKZ61mp+0ER77cPz6gR6flMc/aaImzQA0fNe1gM
 D2NauWAvg5bO43VQmSCaLwKOTusYqfxcIqotxgE+Db9q7/5wt9+ALKaNbRZsX0VkE8KE
 lfrljJh9l9ZrNqIkixkSZ9CTNECnlLVikhWCPSGVmnA2WtLzcOLiNY8hiZ8TRjFKsdF6
 2Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774343295; x=1774948095;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7e/VAUcNepekmz0ORnv+AKxRsAZHsCtLzIk2T1oYo3Y=;
 b=JaKpvqam8Rh1lYIKxaDFafOjn3EDtrb60LuB0UQsNkL9ewqpktKM4X5mA8E75s4wLa
 WhTc2GtaBZcuC7BNOmhU+YCh4gRUYYgStfdIWZaZedu6GicXMTuDdpintEtF3RYq0ElP
 tb1AGU60kqzJUQGNI7y7o9OB43eQxmXOhd9+xg4gzBaSggpxMCGWcwmjRBRD/4R8MDht
 Ctq6b3DwfYBPMTXzxc1PBOYVUZvtnjXOci75adnvUC3ouzgLNur5TRzdrRMAXukV9rHN
 rkeJMeVMr/B7Nfa+OvGQ0t1bmQnk0nVSyICYsMEhCsFYzywHmZTlr0LOwHVnN1tfNh64
 roTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWJHQaMGAVX+zvc9YjWcbmvWUq6Wt6uJwSnNaUG4XML3TeeX36Ixz9r5UEXSDqvExzmE=@lists.linux.it
X-Gm-Message-State: AOJu0Yw4mbB+MkysWer4Wf53EteHhn/rropCqzaU7OZD3Qq3ZG7haWgP
 35F4M2vROZpBsN+RY8Net6f/sM3dG8aiN2Js7FDPXuTHsj9QYhPERDqZ/4Yx0axLLN2z4j1qMH8
 dBYV7uzM=
X-Gm-Gg: ATEYQzwWkx6KA0529TFYbzTbQHmn4uJABSC5TzX9Sxy7+ae/FJuvGYMcjB0giOT0sCe
 rmygViyt70UemunOduCSiZxw7z6369lLIjoJf6PfpsaQV61w2RpnR0eqffnq52tD9OA3eAXBvwW
 lAb8S7roLJzeVq7IthLUaw7lLZrUoLLeAXOXz6+20Z72KzSiFa+TnwYqmDNrvmARdq0ZnXdNLc0
 wQwN4ZkWwEJS2NNiADjYuGH2pR0aME4QLi/EGYuJjboQrb/Gl23qfChVNVmX3RlbIeEP9IgZc52
 /qCFldCRB9dGmySxyVbIRw5SCjmKJ8WSrj20RpNqB80TOuIb3NDApavg4nDOVPzhH3qp7YFQ1rX
 JE7vA+gieMAJZGde0anje8MUyGxVBaqpXUYdSDCnua5Z7xgu+HZ/JLya2M8c2SLwZ6Aki0IwCUW
 Xo4CkPGeC5uOhUeW3Kb/2F2qik41QfviHDZ6Sian4x0TcrgDPdf3fJPv6U0yBKlgaOyNGar0KXI
 4WVmf6tRFSWdGNR+zuO+vWJGHMt9NuWeHmjd1g+bZNEaFYeZ/TkxQaeQGt9YX0wK26bG3Rr9gkq
 uulT8ya9tMXc
X-Received: by 2002:a5d:5d85:0:b0:439:ca1f:3929 with SMTP id
 ffacd0b85a97d-43b6427a394mr21819449f8f.48.1774343294747; 
 Tue, 24 Mar 2026 02:08:14 -0700 (PDT)
Received: from p200300ef2f4fc9009d1d98240e97e0a8.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bf1c5sm39775394f8f.14.2026.03.24.02.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 02:08:14 -0700 (PDT)
Message-ID: <69c2547e.df0a0220.3512dd.98fb@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260324082047.GA36627@pevik>
Date: Tue, 24 Mar 2026 09:08:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dio_read: fix infinite loop when readsize >=
 filesize
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

Hi Petr,

> As a fix for indefinite loop LGTM. But why it happen readsize >= filesize? These
> are related to -r and -s values, but we always use -r 512k -w 512k -s 32M.
> I wonder why this happen only on s390x? (I'd expect ppc64le which has different
> page size.
> 
> Also that means that pread() is skipped when this happen.

I was trying to fix this sporadic failure on s390x and I discovered this bug
in the test so I send a patch. As you said, the DOR000 might still fail.

What happens at the moment is that children seem to stuck. This fix should
reduce the amount of messages and debug it a bit better. Let's see..

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
