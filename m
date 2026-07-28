Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926DFC53219
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785241743; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+0J7t6XfZSNgurKRbCXHKAUyO8nsqH51hEWPTPS1bE0=;
 b=GSUjgCg6N9ZIqwVsups/4gP7fpgL1VMqXKeow+Y7NKMyiiP0EKPKWZ6AF4gAgF4hiPHlj
 z8m9oFL9lP33aB1Bo4RQ7r0286odzjRNho29MRGeL9r/LTWBwDSVp6mQJ0bDrnLx1Bpf2Gj
 JeZRBZxmX/IcKyIj6e4hAxm4vxWyArY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA0283E7497
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:29:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A068B3E1AA2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:28:42 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DAE22600917
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:28:41 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so5623653a12.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785241721; x=1785846521; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qrdRN/UIrRsgbfYDHPh3WkqhGIH/yUmSMewI20gMOpQ=;
 b=GhfAvNDvG+2kDj6WxH5PeElXFfvDfyvB3ttV3FPtD2uMxq9T/Siif2Fpfpqi/r64RD
 sVgvRcV7ZI+bQ4G3i6VGbj9M24juOzEXNZb1vr5vaxvYSOV6dTL500//QSSJ4Wd8GpO8
 kd3AM6U0Ax6O1MWNOh1bMRx7+f7U7g3rkeal9IU10r66RXjybCnZ4DVXshIAdF0U4xKL
 91CXK1n1y209TlTEKWa3JuMT4o8MFe9qE7/X/mLgsZsTynsFYhUGIx0fW5HWKucBd35x
 fdsKcjr5cQM9xuinyzZrd4rfptp4Z0+iB7kgvbIbaf/PfnXmTsZQjR6ansz3XxuGJgda
 t9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241721; x=1785846521;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qrdRN/UIrRsgbfYDHPh3WkqhGIH/yUmSMewI20gMOpQ=;
 b=LFJzfXzMIJ09HzMbgbMUgikngkgMmwk5BWNzLq88yo7upFo6aEoDv/KPdofdAXyfE3
 H55biyluHT82pDx8rLqUGS9EZRnxPiy/dY0i/Vu9uUW823bbzcybpEovavihLPtNFibV
 v9DCzTCu7aiy8kOx7fo0Kw/EP4pRs1sh1b/BZlRaspx7areh7ClCJfIUGF0oDDazFyDN
 0pPXXJwfAcKWjuom3sw0nrr43795qWxwWeNJYSs6jpFWDQG4zPgbreiN+M/gfuYU/ofV
 JSWg71sDjrZqv+CSqoTQCVJZPXPANgy9Kgjj7wFJz0N0/sVjkPNZ/VAV0eh7+eYclhL6
 i3iQ==
X-Gm-Message-State: AOJu0YwX5OSRR3XaQdrHa8BMaggQFCjRi2yJOTeFqMkRW/o25iyWy206
 +ALvAWU0LhaTMkNCEdwGdpCfhcc6yX2Y+uAM1LI+BO4cUkMj7nvysWf1g0OKnA5YFEs=
X-Gm-Gg: AR+sD12wgMJ/oU741Xo+0+uiOrGhI3oeX4FviOFjsxdI5Pz5ANT7OX9RUO/Tjx7wm4Y
 vA6L/YiUd/715JOd8p7ISZDXGlm15r4H99pzyL6Kv+DAGnlQPq6g6EPWQyKvq9rB7KF1wecSSwP
 DAMSfVlhG+H+8V3VziDF8dxfKrZG6PboLeeIDFYjpIH9WvtAZULGp6QVdzoCZMUnXD9oFegB/v2
 JcyRH/YtZo8wst7kI8r6c42q5V5Cl9iHFRU+YxYUZt61S0r6/h1WqvRmZDIl9HYn82AuCpE3Tlg
 FnRkSxqa+FmBm1LPf2I94WnFt4jyEtjoUAsLMabjnjBQX829/fbjgLt4TsfVMLN3WZNmvEAYnC2
 8Hu0UOBCMjYbyUgpR9yv0Vpo92VrNM98v/vKhRqpDqERLsIy3hYjT6kAfjFPjHXUuFl783lIEbL
 ykCwMzvyFt7cgdQXpXQnQUFQ==
X-Received: by 2002:a05:6402:2696:b0:69a:9355:ec36 with SMTP id
 4fb4d7f45d1cf-6a034a869b2mr1095458a12.42.1785241721187; 
 Tue, 28 Jul 2026 05:28:41 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm3905867a12.15.2026.07.28.05.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:28:40 -0700 (PDT)
Message-ID: <6a68a078.dda25a5e.283880.f17c@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <ah-addBCDNf0e7qc@autotest-wegao.qe.prg2.suse.org>
Date: Tue, 28 Jul 2026 12:28:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
Cc: Wei Gao via ltp <ltp@lists.linux.it>, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

please update the patch according to the last two patches I've merged.
Will wait before merge.

Thanks
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
