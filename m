Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FE6C021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 04:52:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEDFD3C9B57
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 05:52:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9873C093B
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 05:52:09 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A2D365A5DF
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 05:52:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739767927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rMz/0TbcfolD+DoFPUk0DXadUo/kzWpcVYbc0Bp6Aew=;
 b=Z2UC6Jzp3y6bwQpVhD0LrWvXhX3LgsYiewFFYIVZ6m6rZ+bdoGeuu4pV3ElmAUeUNMvruk
 FB2eKQygC1JTnscJjMu+4n8RJJ2yujch6PVHEKNKCJi5MEh2inYUP3Ex8mFuIKQBS09kF7
 U1TigwT8DxIChbrNbbixk7vV1DRz8rk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-UcdJG1xfN-uoEIoXR-lIyQ-1; Sun, 16 Feb 2025 23:52:04 -0500
X-MC-Unique: UcdJG1xfN-uoEIoXR-lIyQ-1
X-Mimecast-MFC-AGG-ID: UcdJG1xfN-uoEIoXR-lIyQ_1739767924
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-220e62c4f27so90119415ad.0
 for <ltp@lists.linux.it>; Sun, 16 Feb 2025 20:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739767924; x=1740372724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMz/0TbcfolD+DoFPUk0DXadUo/kzWpcVYbc0Bp6Aew=;
 b=JyGyBq8K4LZsBD9/c+24zuBYvvwmKWHu7R/ALGZdZNDWOq5IhCpNf4Xy1q0tcyMZ1a
 J0R/Wx1jkCB5y5LIYmvOM0sfmBYqG7XF1XMT+mJat6qxQFOTNF/DnBLTOuBolJOFRvx5
 E9ysk3bdE1sDnKKso9kthnBc1KL5vZ17ACZM7yMjgwsNQ9V/VChfHRil4s9vx57UhaYM
 4eAgWKHG7mE85pXePtYm57TGCSYK+4XwQ6QGXIY2cvvgD7Vz8RxoThxdzFiwb+59XHNZ
 hnM2+bHDYBElXDIATDMPnABn5VrzjJA7T/uPDXbTe468EwcyGRJBOzxqHDa/CgZUUWU2
 df8Q==
X-Gm-Message-State: AOJu0YxyamYhkSDQSXX1szV7hdPYYA6c1VAxlZWfoTEF0cGD8NdzUI0X
 sMBGxKuAD3aBB561Uls6nd8rrMnMJ9lQpOQRF+76WnKZBgCbZFrtrINw7bJ5RZ7XR1cYoRsQ0NT
 lunennhbaPF3kpk09SaSXZPl1SHfznQgDNvykfEjqnXNbY/0w0rAmZnDBnxuMYjBJFGJfAk6Q3K
 jck9/ZuChdHwxY9YClFeSIX8Q=
X-Gm-Gg: ASbGncuGwLZeOe34pYe2/4hk9kD/kkAIdY0UQgRbYt7mYcfuP9nYR6otp0eflIvm3me
 3j4e5GBA8WMKa3sJzqlzBXXm8YYs8Mw+d1gqCKjTTr0GISg+VFuw/aBlmQ1fEV1M=
X-Received: by 2002:a05:6a21:33a9:b0:1ee:7c01:d16 with SMTP id
 adf61e73a8af0-1ee8cbbccf0mr16996581637.30.1739767923875; 
 Sun, 16 Feb 2025 20:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3/j6xcHl+upPH/tUhNHW+KZxe4DSARchcXPIj7Vn8N2or9CFTFKsOlC21tKZyvKbVSvqI6tOEWKV6Aqu1GZc=
X-Received: by 2002:a05:6a21:33a9:b0:1ee:7c01:d16 with SMTP id
 adf61e73a8af0-1ee8cbbccf0mr16996557637.30.1739767923672; Sun, 16 Feb 2025
 20:52:03 -0800 (PST)
MIME-Version: 1.0
References: <6b486134-632b-42d7-bc01-b8f6905ee7ca.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQd1_URO66whTCnVd7Kd7EwNPvBrnE-eQQEvTqTLXGYTg@mail.gmail.com>
In-Reply-To: <CA+B+MYQd1_URO66whTCnVd7Kd7EwNPvBrnE-eQQEvTqTLXGYTg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2025 12:51:52 +0800
X-Gm-Features: AWEUYZksRqL5SbO_-FFPq6VejMZn-4mWkcLwaiTO-_pX7taNI5u4HX4OOObi0As
Message-ID: <CAEemH2eroaD4es23EdOWNmaD+NL-2HKffPieMgJg06R3NENbAg@mail.gmail.com>
To: Jin Guojie <guojie.jin@gmail.com>,
 Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 80_GBZrD6Z_AAgX96v2_U3B4P5Anq99IL2k0oxUU85g_1739767924
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Guojie,

I helped rebase the patch to the latest and pushed it with an improved
description, thanks for you work!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
