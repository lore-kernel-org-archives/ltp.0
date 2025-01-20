Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A91EC02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 12:40:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6E403C196E
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 13:39:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26DC33C1845
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 13:39:43 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E9BC625B93
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 13:39:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737376781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCcnx0a3gxDpmvvJppPgkqXW+7nSrw3Boa+vWHsC3kQ=;
 b=fDlgpmBmPGJ+ldi8XgbitSFjvdKzdz247f3k1C50LwvBUdxlvJqeMRnUOH1rTME6R6ra7o
 V39exUKrve6CxkIao6w9n5FkhNiebMeWYFFTWxNd1K14rQysXQaVYjJhyk9nXbj3QhDeDR
 oWXKgoJy81OXO/0esoZkvNpcfztA4VY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-RMgBKAbIPhKUml62D-l2qw-1; Mon, 20 Jan 2025 07:39:39 -0500
X-MC-Unique: RMgBKAbIPhKUml62D-l2qw-1
X-Mimecast-MFC-AGG-ID: RMgBKAbIPhKUml62D-l2qw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef9b9981f1so12577768a91.3
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 04:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737376778; x=1737981578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCcnx0a3gxDpmvvJppPgkqXW+7nSrw3Boa+vWHsC3kQ=;
 b=LK5Mq3cbKnK6n/KYU1msJmjquCZTxfj8WRPI566YdI4YPOMZdulbDsC3PJ9ygvxg9P
 CR11QUkGJL9PoF14yJs3wHhIcju2L6VsLLVxdYxkQG317lVxjbbMq7fEFR+iHLJ1gHp3
 4W58TmwJ35pmtinaUhTRZdvCac2LKRUBsTgLe6OzbAccY5TZXOv5Huqg7ncmtPpD7rwZ
 90pA6rSw0ywClhpkoZ1pDw6uumjbigOfZlGHFJ59Yeqx3eqIc79uEmfQwE/09rF3pAT7
 +nGdIQuP+DmLmnHS/xYC256z8dE48adT5JLhl+0tkyI4gr7V6H0TmFHacsEt6+nsvqA+
 gLAg==
X-Gm-Message-State: AOJu0YzByE2/LL7VdNYyPZdXs/49syn3pStonwvG+z4VjuJ6G6dYBeNU
 i1RwE2q6ZVMQAQ2JrMcS/cEMOm+BvtZd4rKrmLwKdvFmswBGsNQMpnuVXxUQELMXJiN+hBd07Us
 bJQ5XHQC9JWpbgvJraPgJEmrPBINSCEQhOciQTkzoM1xH6Nyj5cX4+L0wL3SYtJzeYTkh0arPp8
 GT0AjZhTvl+bHHbtyu14ZuS+Q=
X-Gm-Gg: ASbGncsUJ5JAnxunPjnCJ/bWu6mdcBzzumBfvJlsw9+LZXLcg+WQvURXKWnP1fqTVVv
 p4Qm/DgfEo6Er1LdxBuIvkuxM5I2ULPHjN5eEozXoL9E460l8Un/R
X-Received: by 2002:a17:90b:2703:b0:2f4:f7f8:f70c with SMTP id
 98e67ed59e1d1-2f782d4f17emr19463018a91.28.1737376778576; 
 Mon, 20 Jan 2025 04:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNS5w4sLMuXweB/Rlyb56A7VgvdEe8eLaX7Pg3WWWGLGr9mFz1PttZVIVmgHNDyCMNdk6jRvwktTFUni1/Nkk=
X-Received: by 2002:a17:90b:2703:b0:2f4:f7f8:f70c with SMTP id
 98e67ed59e1d1-2f782d4f17emr19462989a91.28.1737376778316; Mon, 20 Jan 2025
 04:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20250120120606.20145-1-chrubis@suse.cz>
In-Reply-To: <20250120120606.20145-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Jan 2025 20:39:26 +0800
X-Gm-Features: AbW1kvZIoRS7fmBs3M36sA78SPaxzoBlvlbRmYXsWx9tPzjACAbE_CNKuytpDPg
Message-ID: <CAEemH2cCg-Hz0AY5vOuBBoQxj4EwmUDHXM5iHiqwkR-=MCfJmg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aecUAXL0TfXF8Q1fcgKTUl4uiXrzaSfyJM1A2b-Pl-I_1737376778
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: tst_has_slow_kconfig() cache the result
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

This is awesome!

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
