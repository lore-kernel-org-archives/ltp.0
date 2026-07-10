Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0990EC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783688164; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=MsbhzWaXxbryH0CnNZKdmYW4tfVgSj/LI/dWIbWGf3U=;
 b=UqiBnpIBoefT4zZ8vtdvSM3fRCCpi+EuzMI9N10SIKsjE/FccwS6+bXlu1NrJb5zSiMb6
 tvfJb/pumTCVIxIlzwAC67Nw9X7lM9r4y0kj8ywWMbmRo+PUH6CP+Pu+auGoRiRdBIgLN7I
 zBfK8FUvOhCH4T5a3MBHaCas+F1buu8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605843E5BC0
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:56:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C28AF3E29CB
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:55:44 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 648D2600B6B
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:55:43 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so608408f8f.3
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783688143; x=1784292943; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4vrZe4IKjMbL9TiYdub3jf73nZp35sSUEQTgNh3TQYg=;
 b=I4fgq0EjxOPBz2b3rHelF7eeHTuYx1hBSQv7b7kvxZR+p/ZkrSk0henLMijcCtoT3b
 MC+s0laFwz0XeQsCLz9NmXmWBb4nHRJVP3nXS3MRLiseIigOSBUErLHkpvhoLMg5s4b7
 tdkWJQqB6uHvV6dxpkhdevFcEPg2irnIYB7rmWdC3YVtDyZQBZmuOeHLRezow+qEyJSE
 f15/D7aum37t48KmtBUeCM5rAOH4whGLxeGDtI30zhu5tjoyl7Ix1Y3EaLnnbtJvVtRw
 gSDBVKMI7rCxxmcvD3mMyVLfX9G2hz/9xYRUPrRm5ey12ZXCbCbjXZMor7b6O8QhTuba
 Xi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783688143; x=1784292943;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4vrZe4IKjMbL9TiYdub3jf73nZp35sSUEQTgNh3TQYg=;
 b=amwVkWdNI/vIctOqYzlGK9oplLdpZNvakvfkzjcGrFOJ8hw4YUtuDYMgwApHtzVZpq
 YXdL8KkPpRkpd5XVN2P8MMfJv9Bi0Z2b/Is8tWikjau2vZDtgv4Pyk1yEx0fd1ooVygV
 vvykzCwrTSyDk5jESyJx1gEvj3y3gA6G4tn6AhMUmIyKjU3WLBDCY57eCpl+NufVpsUq
 iYGQOwxy37LMI3hjiW+OWWZf9VuDc3yL/rmdauvTVKwJpvD+voOOEc0eZeebjd+69drW
 gIru3UIOJn6yTve5zW7gr9C8V3KcXwR5QGl4DyGYw+mnA8Bew+/p2ZLflsGgMTjsbhOu
 lX0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoboT6RB+Nuy5NJb5Wus6yZMha30NEb92skgcYkfDbmYhntoCRprpHkxU0BB3NrEJMdpck=@lists.linux.it
X-Gm-Message-State: AOJu0YzXgRn13Yp/26wYjwo45Wtap+B5OP5FD+TMzi3ZRZXEfdAQKkeY
 ywsf0i6HMV0lCc0jIVX0XMX6fOlPFDYwJIwDD3hX1fWOgpTYZNOzaYp9we49Pf6+zV4=
X-Gm-Gg: AfdE7clI7HbaSfzPwDMgbnecehxz1AlMEzpOEwFSCMCkEjxdwPRDiYOEuGI1tXmh+RI
 Zz2krJ5osKUkhNNlDeFnpSUoaTPmVfkRSVM/rJHIUDHzl55JKhN1A0MebEotYlScfoknwvG3Wf0
 pQ7JsjElSAqinWX573Uz+fqOOE/NPRfIcRsBxu0LckGH66U9GQql6EKuB4gY5/J/p8Sc3hHzH8h
 xTfQsD3+v/52ctfbMwTaIMH9FQ1/cBYRXLohRyqoDNJ4n/ms9QmCCCD1R7NJnnnM7Frb7larHbK
 F4LsHwnc0L0rCM8QfnLbkG6lE0xoid5pK83c64QykYKshl5rsmS3FBEp6JsoFPQZEuc/jkSEGQ9
 IzAOxrLSiKo/INJhR6o3Bwt9NOUeg/xahmp/3C1DnwFOjAq/P9C/tb5vBRaz3mNG6pUJ0EB4DLu
 zDBACcrnR0eLn39pRZEPByES1KassvSbg9QVD9
X-Received: by 2002:a05:6000:230b:b0:47d:eddd:a90 with SMTP id
 ffacd0b85a97d-47df081e31fmr13023434f8f.61.1783688142739; 
 Fri, 10 Jul 2026 05:55:42 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm65380418f8f.4.2026.07.10.05.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:55:42 -0700 (PDT)
Message-ID: <6a50ebce.c9089686.76aeb.e15d@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <alDpW3YzuECdGmG2@rei>
Date: Fri, 10 Jul 2026 12:55:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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

> Well either we do that, or we skip the signals that dump core when we
> are dumping into the pipe.

To me it looks good to skip the signals which are not allowing child
to be killed after coredump. It's a systemd feature we can't workaround
in this case.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
