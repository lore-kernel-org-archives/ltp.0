Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A4606A319
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=MvNqYgir;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=E2RtUGt4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575291; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=MvNqYgirxeMDtJjKJknHgDcvvIyPaFIh+1hiAMpKUncS/XAzEAYdTuFezWto4lykpfqcw
 WwHFS8sGqWdOOap7+jIYSFbkTAaPc7Vd9AmKHcsEg+41OZTn4c30rDXKxvjWzUwl7k73Bdb
 LpKO6NGlDBDhz40o96ibRsC+OxSXgcs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AAF553C1AE0
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:34:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F7F83CA3ED
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:34:20 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD59A1000347
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:34:19 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso1097142f8f.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575259; x=1793180059; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=E2RtUGt4X1LREe3GIAPrS5qkU2d/HH2PWllvsNNI3rgqiSPb3tX0OMeHhjf2q2gGx9
 vLId6Fs9PoVl4RVxJeUT22rYlmYgO+5u7uxUo3IPTx17Xkkual/Z4SQd/pUOrAKIqGU8
 bXkod2ufk4FAkjbrpGYTseIluquKi8ZNzxBeoor3bhRiL/wNxOHe9lUIlU6RPwWqwZ5+
 Rl2qJlPuf0XXSQ45QEcdwebKG6XgEBFVz+FIybqtnLK8QNj1weG53eqf/g/2lAuhg/HP
 cFmX4AKxtpULHQKLxVfC1eWe7W3kgt0TkIMBrL+JPpKbhsddzrPrBlMTXt3TZ9h5vADD
 kSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575259; x=1793180059;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fOtAwVVSf8MZw5I3Yr0jEe3NzHb1LvYa503i/47efjJdqZeI8g4OpfvuEnsN/fc1aW
 pZ7fQ59EpeB3DTOrb6dokiA6YvrqoLD1e5ajzE3/HteJqxYsHYF2bBysEkiIXGGexJnJ
 1yJ07kAVWDcdyOLlKjtHZ0khiiR8EL64ylI/CowPn2lihmE52O8LyJL1zciwjFtgcVoH
 BrSlySY3sSqi9K9KWm63j4vDBID5SwG2wqLRfv2vxYaF/hz/+QmnBK6jaK7Ns0kHHhML
 QMWiypOYuagAOJrwDVpnrQdhltbWEGemmNSCMwOc2W39w5mX9+tDRP1XvETJD33Qo6Sn
 GBMw==
X-Gm-Message-State: AFq9FYLv286pbUoZw1ZEoasx2IVFBbpTP62DRes5wpWdEBVs74OEXxZa
 DY5gK031FuRxm2lkCSK2yVV7PDeo4xy3UQ/0+9ZKzBHArZJraokX1B0sNTerdeo0deI=
X-Gm-Gg: AYBFou3CpGmKQlvvSMHwA7X5pF30D987LWKO4lT1pGeHQiG57pPPX8HS4OBj0k3SFi2
 B61wE4d5IyPp4TTk+92p9WkNGdK0QneGSXLRTfXa0/uFzi/Pnc5U4pcjj1feYb81muga0bw7zqG
 EJlHkC908t9gTAJ04MkCrp6AuBenvHhYa+jWiUS3YhRB507rBFkljr9/0olwaztOgbgRF8fblic
 X0+jhhg/0KFFj97BddsS7nfxTYs/w8ces6EOT2O8Gtm9wVbf/FeimYUC+uIOHv1B22U+q9AxpDc
 JAKIPDVMl5wLkRlgdxtOu05fgX/VW0v3hsGk/SJBkkc1ss4JHJe2efVvstt0w9qNtwrgvxLnFtF
 H2tdjOhxnayrwsAFfHwUHP+ew/H/b3XRp8h2iUA+3EJ8SFpxKUjcvAjOUav5qEveIpDqvrfs8nY
 DVee3zoXpUPhcXMxwyVXn/rXO5fqOcdcgyhz1uiqIc11RbpDYNJMWswJdj6hsLi82zpBOjbGit3
 D91+iPkp1H56HYG99YbPt9WpaBa8ThCzWIJ9aVcRpjMcKtH4cLgzcsY05C7owt/23MvGZT+lwE2
 ICGGA7NLG6L8OvxP0G9uzx5JBrs61P4jiS0lfgseGU7kpOqXeemxjbCB2QWnYrOE4PX6yV3ngtW
 M/j1K
X-Received: by 2002:a05:600c:3513:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4a1fdd2461cmr30019985e9.13.1792575259092; 
 Wed, 21 Oct 2026 02:34:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd360e4sm29531255e9.4.2026.10.21.02.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:34:18 -0700 (PDT)
Message-ID: <opjqEYQsufhXEKJSxCykACIJaNll0SHcWeVt@localhost.localdomain>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20261018160115.154430-2-avinesh.kumar@suse.com>
Date: Wed, 21 Oct 2026 09:34:17 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] openposix: mq_close/2-1: Use a valid signal
 number for mq_notify()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
