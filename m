Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1441C88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789111046; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=VTgd8RcuNRg8CQ1NUjlGRy9dHWpe5R7XgdRWGVqkmQmypm2Gb1mMd9ltXVXiX/9qM1pS4
 GXtmE6e2k9I13KDRHfVY+fgE3cRjD0WzDtPtxSyQLz5q/jZgO4+JVveuxvHqr+FMXtc7IOy
 X2h/YC4fdlLcggmqfalFu65/sY+7jLI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5623E30A3
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:17:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 582283C876A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:17:07 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCE48600944
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:17:06 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso5106865e9.0
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 00:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789111026; x=1789715826; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RMTW2TIC/JT/TReI6qfd/3VdRqE5jIs2dHO7UQwJcb/kpGHJTT0X1rdks/9VIjiUsx
 ziXiyGP5yjIuwWBSUDAyaXNbnHMvf5/lCPiVaNvDBAAus33R3bk+f8IkaZu2hPLjLZfW
 Cidj0VJJBHnqsNK2wkfr61zQPubecLw+sLjDphBVulHYlYQit7ifUY3kIALNscBP+uAS
 R3eK1z+9iGyFcFWZUrntWtOTCz6KSBEBreU5xml+vz1KuNEzWqSvqUA0ChmyeQ0FWKCI
 wWJjKchYxLP0Ytnd2JlezqsICyizoNQ+e+6SJUS6jzZwp1vcoVTAj0/+5+o4121kLlgl
 WJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789111026; x=1789715826;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fcE1BZqAe81e7TOWB8848ibkCdJUCeSKDBZkUT13dH3XrClRg0i2syLdB9RMFnEAmX
 d7bUoeufSfkySKQkqBloWXLa5WEugItNWWHWQkqzLuWih+TI5R5dukhdrcCtRTs+UDNq
 ipQKTmBreXoaUkm/4XOuQkxCAmLuIMfm3ni+G6aTHkbP8kXiCky2JlWeM9tbYIPDO49b
 xJq7e18C/Eexsgr15p6rm+ONJI4PADGeLtX9Yvc+mJucrdBfyi/+0pvFH2PYSF0h+HVe
 brg/8ToIjLrthB53e6swh74+jPiuy+tAZ6aFCaWfgl7zBu8EigRJObgTn/TAjorWjS96
 epdA==
X-Gm-Message-State: AFuF++mzidEUE35QpIpUc0ZMKb9IboUcYzUmgCqvvme+6r+C7i0Jyrig
 8QWW4QoJTqRZtfYfjcTUT5j7VhCxEeePN2ZmKikoaePLbVVfoHkan1zKPo8PCRS6pqg=
X-Gm-Gg: AYBFou0hJ4zO3+s7eN9UiygA7yL86Trgenf1KkwcUiXSBcRhCPDYlkCax77kDyAZfIO
 RlZXSj+M/z+3WlQuCnTtHxpmk8WoecWszmbHOvcjtxwMYTb0tJwibDu2HRo/kBeBbPRUyffXkLG
 j76htBYLcFqTfXNqIVeUnpaZcS8hU3D5hDuMBgbastOwmZBvTE3hc/loV3CfwssFQTYB80x/m3K
 E7mHFflC66GHYWdvS2tTaeq+esjfpVmy2ZLF/msKb9sw41FyNgEKUMpjV2ZdqjH4Wf4u8NtqtNS
 C0jQFfbf437XwGA9/64K41QRwFi2YfS1QOC/nqv3W1REmev3qlW0ZevAL69UVLZQJ/leZb499UE
 zC0loHeBn7jRwv9Gs7Ux57B5Jr6KlCKf1z4IKWNRXdeFj11flrkaC6OxQYSLztG8fNyh3nT2QF8
 vg9W4wF8uBPuVWsnsY7FkI0AmSJFv+49CvnvqVNIHvGdtdVptLWtbqxBHWlfYVmt1+HjZh1rdGy
 6uGfbFM+bzfyAFSfYuX4pCOhVdXKs2Su8au2+KNatLSEBJcV9WnhNO/l36gx2S1m+u0MVffhGED
 fhqkqQ==
X-Received: by 2002:a05:600c:2314:b0:49c:fc6e:a3d6 with SMTP id
 5b1f17b1804b1-49e619bfeb1mr23551495e9.21.1789111026251; 
 Fri, 11 Sep 2026 00:17:06 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac411asm53635075e9.8.2026.09.11.00.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 00:17:05 -0700 (PDT)
Message-ID: <6aa3aaf1.c6467f05.1c4f3.830d@mx.google.com>
To: "Michael Menasherov" <mmenashe@redhat.com>
In-Reply-To: <20260908092248.15774-1-mmenashe@redhat.com>
Date: Fri, 11 Sep 2026 07:17:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] read_all: Fix buffer too small for long paths
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
