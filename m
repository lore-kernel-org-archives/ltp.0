Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A781EC77B60
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 13:45:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18D0F3CB953
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 15:45:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B5653C181E
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 15:45:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43F1D100045C
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 15:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682862307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUuoi76ymXRbrCComGdPjaO9YqBkxsseOkl1sjDa3TU=;
 b=UiNWcNYOVuUTgIEeV/c5Bmx5zaWcybuIdOoyGHMiMxLyaRXmjMiVvH3s0E9EZimB4YCiqa
 GuaAE86FmLUmtjVilgiDUQOjfkgNrhJy9x9IQvZ8MPuS2zfJOHi6MSl3gFQ5PXkzRVPhZk
 Mpp8LKr3fqQyeMT4Zeqi3AEy8zsXjcg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-8uQBjTHXN1OLE3L_utQ7uQ-1; Sun, 30 Apr 2023 09:45:05 -0400
X-MC-Unique: 8uQBjTHXN1OLE3L_utQ7uQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2a7e3466cbfso7172051fa.3
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 06:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682862304; x=1685454304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUuoi76ymXRbrCComGdPjaO9YqBkxsseOkl1sjDa3TU=;
 b=b7QEWKpHvdyrwmtxGzER20iQO7w20RiZKBTPRDgVurES+as4fi0i2izv7u44sozqkn
 vUWKNliMDGPlN7sooxUSgvAr2QyOc8c0a7B8vbmtqwymSN1h7pqItH3ZgsTwktV1QpxI
 JlZq+t7XGUzx/IP2aCmu/BMUZ11x1uK4O9r//blRN2KObm06X8KQkyXxuauXybliTlDJ
 5uHplUGIfg9AyVLkDoF3OpMTc7YVy6zW88q4jHEwMPpni9OgDzZp11CGGLw+zpJJemlB
 P70YQlvo0lUXPPMwAI7TVyrLxF40ldDOff8ziAD4AUDvbBjaHENOjlU2q/F5oKrh6hLY
 44MQ==
X-Gm-Message-State: AC+VfDwJ1viToDRpSMzboyHY2klVsF7O/g6pr6VNCETKaLe9kfTRII2H
 uo90i2O52VJ+FbU57vA1d6s9vGZZERxeCPZKsDo/b/w6KhSI9QOKX62HiIV5QHRY8Zph/al5wHH
 c9YJ6IkYW8tQqNsx2g3Cw7q8BCbw=
X-Received: by 2002:a2e:90c2:0:b0:2a8:b78f:3ab9 with SMTP id
 o2-20020a2e90c2000000b002a8b78f3ab9mr3128415ljg.1.1682862304304; 
 Sun, 30 Apr 2023 06:45:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rY02m3Nc6QoyvEehYttF44nIaBsl8LtnWhSAls+T3Py13/6oXZOzhzZSS3DX+QNMYk9tg3fAXTrk70tiRw04=
X-Received: by 2002:a2e:90c2:0:b0:2a8:b78f:3ab9 with SMTP id
 o2-20020a2e90c2000000b002a8b78f3ab9mr3128407ljg.1.1682862304015; Sun, 30 Apr
 2023 06:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230428101038.7253-1-wegao@suse.com>
 <20230430074811.29555-1-wegao@suse.com>
 <20230430074811.29555-3-wegao@suse.com>
In-Reply-To: <20230430074811.29555-3-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 30 Apr 2023 21:44:52 +0800
Message-ID: <CAEemH2eNc81uVj6xLF6NXUhWvvGa3WUnBQVH2oqmXDPJObKoFw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v12 2/2] cgroup_core03.c: New case test cgroup
 kill feature
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
