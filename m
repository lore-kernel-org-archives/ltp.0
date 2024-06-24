Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B5C2BD05
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 07:54:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A18C13D0FA8
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 09:54:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C36A3D0F73
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 09:54:29 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 86AFF601B32
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 09:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719215666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hQiZqTU8QzGxurXx3w2mPV/9HaoZVFFcUZH0iC/r/cs=;
 b=TSFldyolJVDFA6ZBZQQ5T8K+Imev30g6a8wORPVzbrJuNopGVnTSJpPOh88/fltJueFMNq
 slBxo0sC97jjBQA62mp8m6jW1Dh0w40ScmSWDMspm0bvw6CYu0yAtWhhAzUCENxfhvxckB
 3Ql32Ax3Dwq63YCG6CoyITbNsVKmnTk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-9YKwEzRTPRuOvxntYa1PBg-1; Mon, 24 Jun 2024 03:54:23 -0400
X-MC-Unique: 9YKwEzRTPRuOvxntYa1PBg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c7a8949243so5059075a91.0
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 00:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719215663; x=1719820463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQiZqTU8QzGxurXx3w2mPV/9HaoZVFFcUZH0iC/r/cs=;
 b=mizdV2paAFbzw/+NRQ6kocgQKQeBR5SQyIxG+DqOxZJEbCFsxT9Qp1ZQo+7DIPz1Fv
 3fCMy5ZkkDEaV7w06zl5zU5KAC9Y+WtbvN+t7Oo2IfmBx7pDKyfDzfRdsNa3Kbq8mZSp
 HGHo6cqDmWB+SG/MWeY/6Gq8IVrX2Km0//zYO3gYZlOMJ9c12/qqDsEkDh4/k8kSJN1x
 AEaJi4NhJvKeah863LqvT+Rj3zuujS6eQuftWu5Ghw4HVaHMaDvr//unuCS/0vRbzYZW
 etll3w5dRArPjbYAZgCVWxZNojJ1P9IR0gYhYlzJTwv1+QbnBstZld+FnXRGg3WoDIjz
 WXnA==
X-Gm-Message-State: AOJu0YzMlvDVXUYyiHJnfLsHkVwKPq730XmTwvkZjJMPxlmXFmZhWREt
 hvL7wDCWPnqhmy/ArJl9ZL8sY4uPEPUPBN2pZISq9e3zoFJuPMKYx6dvkXdrS82TgGVB59EXe1+
 z6DfM+ClsXD9E1MfVZHp0M0olaudywrE+uS1h2+qvLWpctWIlp6Dka3y4BtDmvwgyjV/uIx1KYe
 VYqGAcJSjGSvohqNocE8QTPQ0=
X-Received: by 2002:a17:90b:4d8e:b0:2c2:97c2:1426 with SMTP id
 98e67ed59e1d1-2c86127e2cfmr2493043a91.10.1719215662846; 
 Mon, 24 Jun 2024 00:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbbyzMRmCvjn9U7ssu7s+ni4XOI7o4TckN6+Hw+JebGcfFO1jdcKPBvuNn9+4aupXsrxqrM+EVdDjdGkyZCzw=
X-Received: by 2002:a17:90b:4d8e:b0:2c2:97c2:1426 with SMTP id
 98e67ed59e1d1-2c86127e2cfmr2493027a91.10.1719215662327; Mon, 24 Jun 2024
 00:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240624071723.23480-1-mataotao@uniontech.com>
In-Reply-To: <20240624071723.23480-1-mataotao@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jun 2024 15:54:10 +0800
Message-ID: <CAEemH2eFmg7CUwLhA97O22cvdxKks7yy4cPcCx_uE6mg3GYjtg@mail.gmail.com>
To: mataotao <mataotao@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] shell: add echo command check
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

Hi Mataotao,

First, thank you for creating new tests for LTP.

But from what I know LTP now is mainly a face-to-Linux Kernel side test
suite,
rather than the userspace or command line test (it had some but slowly being
removed from the test suite).

'echo' is daily popular used but belongs to the coreutils package, it's not
the core
of kernel part. I guess maintainers have no passion for reviewing patch
like this:(.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
