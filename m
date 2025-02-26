Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7679C021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 09:22:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D468A3C9C9D
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 10:22:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C42F23C26B6
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 10:21:45 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AC7C1BB9D81
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 10:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740561703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9vR8tqvspgPjj4nZ3Tmz0IAgfRk9pK/47yHriWmI4q8=;
 b=QBEi6Y9rq6jJaOVSIO90dFtw4mv41Famq98jMfaRSUaUAXmyufDx9aKYy4m++7wtgczyIa
 BM7CrK7z+cB+JOURmkzM+kIBZFsZUU/A+/i/4eI5mInLQH6/dK6wsYNkx8aEPkxOaOFUpc
 LkiN594MO2tFlZj7TItADdXuAYA+t+w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-PwhdV5p6O7iizYiAqZYZAw-1; Wed, 26 Feb 2025 04:21:39 -0500
X-MC-Unique: PwhdV5p6O7iizYiAqZYZAw-1
X-Mimecast-MFC-AGG-ID: PwhdV5p6O7iizYiAqZYZAw_1740561698
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2f81a0d0a18so14249324a91.3
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 01:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740561698; x=1741166498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vR8tqvspgPjj4nZ3Tmz0IAgfRk9pK/47yHriWmI4q8=;
 b=mrh/uS8bAHFQl+iuDEscSgwG5klxJ+VOJhXOBbGC2ZSjJ8nnkqIcr3bkZqPReJCBMW
 gEsVwKdiWlpcD3OhLRo6cvtRa8IZ1w52zJQjp+6ISZFmTLwp/7nwWJQfXnSz/uN10EYD
 CzEutHxXVord+RhGHQBuSZ1L5X2/4ji6Wi7jHrLvPY40uS3+xYJsjkDHEoJQS1VcR3zC
 ZT4AJBei73xhTBqssHnW0Nsk8yg5j1QLkfN3GUTYX5xKKgT4zDq79ZBDKDWMveGpKLEb
 8KkbrcoPfcZUaVqY+O0ySv98i6gPnuvyNOxXV4tQk+j/gBjgVTQjYg9cWt2AM1JjhKPo
 U9hw==
X-Gm-Message-State: AOJu0YwbGPMu+FAHoIKq6fJjOJIt3lKtixLdyOhFpq5qEMAHaThi/jbx
 US91Kz2bDTjR6TebkYFIW7gMRGB9SwDfiQ4U3RPYrYQpSfCS1RsFHDpjMpjOb4PsR2iM4ycbjKc
 G9ODQr3fHmSrVAX5lSngbikUYqYfTU4mSJ8ksnz2CPq3/QpI/g4y/lzSFWpbhMqZxoYwCyUtXTs
 gERq4qH1+ERkilb3aw6H245Ss=
X-Gm-Gg: ASbGncvYzpi+bWcZoNVNMkR79iHOhuIXzI/EbS1jA3RAfsJLH6HFxwxQzgw343awxvE
 V9H1AKL50GkeYA5qRJLRg5v+P/NC+HozLbi2a1MufQnUA9SXZovc9FZ2iYEhOF2b/8a2QTSs+yA
 ==
X-Received: by 2002:a17:90b:2710:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2fe68d0662amr10342608a91.35.1740561698335; 
 Wed, 26 Feb 2025 01:21:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz09N3CpPP4G4hwHIvg8N/bS7+nRFRLxZi+yFSU0yEVMlOEFUWdewnrWKrsEzcehX2b934/QNb1CR034JY/hs=
X-Received: by 2002:a17:90b:2710:b0:2ee:e961:303d with SMTP id
 98e67ed59e1d1-2fe68d0662amr10342584a91.35.1740561698008; Wed, 26 Feb 2025
 01:21:38 -0800 (PST)
MIME-Version: 1.0
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
In-Reply-To: <20250224030743.1567840-1-chwen@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Feb 2025 17:21:26 +0800
X-Gm-Features: AQ5f1Jp_Eoy88kQVeiK2WkF4kgQsovZ1K67Gjer-Tmp3r_EPzuoUEScvffm0Zvc
Message-ID: <CAEemH2cNtq_Mh6ax_NnN4WPfSi9qw86GBo3=sfK-Lg7vfPHJXg@mail.gmail.com>
To: Chunfu Wen <chwen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yuxvGzxTq2UYYDWUE7abZnX8MxzKikbxHfI1aPLY4vo_1740561698
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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

Patch v4 looks good, and next we can move getrlimit_u64() definition (from
getrlimit03.c)
to the lapi/resource.h, obviously this could be accomplished in a separate
work.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
