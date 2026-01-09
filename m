Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922D5D232D2
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 02:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767926619; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8B7+J/Jcv1O7GBn1UH5Iob+CFdo+MrXMApcFoKHny7c=;
 b=GMRpHVIQrSt4/IKHLuY86RYv+DcfmbJX/ZauLwiplMkrjh+6Lidw3x23uMSzas0p3kQxg
 /6Mm/q5NVTFJZXiCCFESr2zFAVSh5MoDkrrFT8tm+iikyzj+UTC6QOnY1v3Sg8OwcWiLvAH
 uFIDpZO7cE86ANuKC1ROjKV4V+swsxM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A5ED3C6890
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 03:43:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A35803C6792
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 03:43:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 009EA14000EE
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 03:43:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767926592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azcVfh9uW7eJgVITRTHzBGgjMgJApmbPhstRgn55vvc=;
 b=ap6kQo6/xbtd3lfqIt9VGp+fubwWzEdHQ13I9N3QaPfNxkZ5ngcvVLDm8uFE3BXcAr2BP2
 D/DKbrXkUAJ6KkYdEkXmHfRAHR9QrZt4jlUenj9KcGW1ltB8PvpvPMjQlv1Riy3NrpR8/P
 J4aMdmh/N5fipYt7GRxcLhvHm3673Vw=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-g8ULr7_gNBSJMW0fruvHig-1; Thu, 08 Jan 2026 21:43:10 -0500
X-MC-Unique: g8ULr7_gNBSJMW0fruvHig-1
X-Mimecast-MFC-AGG-ID: g8ULr7_gNBSJMW0fruvHig_1767926590
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2adc3990fecso1349355eec.1
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 18:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767926589; x=1768531389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azcVfh9uW7eJgVITRTHzBGgjMgJApmbPhstRgn55vvc=;
 b=Pt5c4S3uCunhMUtxp4ThXUttDbH3LF6RgFVOyiFUqycUlocBXIEhyaTDkdDTyl1WYV
 bJn/cxRKWcAarFyXSVMDJ/mYDTgxOb8L8ZxK9TdSX49TQs1B2AyS/0Mtid+r1li+45rQ
 e0eSB2dS+keqyVWUbxPeWFQRnlCpcBi02ixXRbqck88xb+/Cs1t8Z1WldY+OnImgy1x5
 NVKCZozsRnGFzyQKsMWfQwTShQ7eRJl+//gjj+jnODwzgzTHvKYpID+c719KfVgru4Ef
 KXnGr9QrUHRZqWXnmROSBcAexUszV0DUQNDYBRl53L5xcIwLTaBp1ofwsMoPOWnlValn
 ha3w==
X-Gm-Message-State: AOJu0YweDYYB354/HXOV5TLdoYD+53t5tsCbNdoST2dvl048x3X34cGy
 7QsMN231KxiYH5c3yAGIfkPIvmbcsJgtZaz2p9wj37DAb+6eqHod7MKmv7wta2+2L33IX5IMm5f
 iWrepYG4axp3jHnQUB8uIMDTEI4TY7E3yKlDlaIsF6sVcyhFb3u0ab/aWWtl3zSsS84kN/HYhUU
 JfE4va16RqV6GnZlCdAcKww3K2ZUpxYxxffvurng==
X-Gm-Gg: AY/fxX53ZDzl0CnW1Bt6XEK1mT1RXZjwlbKn1eOahMHDisX7PSDeqdLMQmzYoAFSuDK
 bWPXPC3GEq0VTPtS0m/7tVNbtolzYmVOBeWyOXCm1vVrfGnnXrjIUXw3Ce7mjJcK8IW08YMWEpA
 yoc/tJwaR3b221vho19Hi7S++FHjVFUsqy6Yx04SAxxmXlwnMAqOMDUGRVbFmgggkd1lo=
X-Received: by 2002:a05:7301:1e83:b0:2ae:5431:948 with SMTP id
 5a478bee46e88-2b17c788f7cmr6837308eec.7.1767926588950; 
 Thu, 08 Jan 2026 18:43:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpac55/6HM4fVT0HbwAHrKeQlpyyNf/Bl0gA9iG8xETK4bFLjIsvLTlGXhCgvrfrRpWDAOPvkaJxa5Gm6y+Ls=
X-Received: by 2002:a05:7301:1e83:b0:2ae:5431:948 with SMTP id
 5a478bee46e88-2b17c788f7cmr6837295eec.7.1767926588538; Thu, 08 Jan 2026
 18:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20260108224409.165481-1-pradeep.susarla@gmail.com>
 <CAEemH2e4v8OUSvnT+cbSpWSqX_naSw0bAxphSg1ZsGfQk6zSfA@mail.gmail.com>
In-Reply-To: <CAEemH2e4v8OUSvnT+cbSpWSqX_naSw0bAxphSg1ZsGfQk6zSfA@mail.gmail.com>
Date: Fri, 9 Jan 2026 10:42:56 +0800
X-Gm-Features: AZwV_QhxoTefcmQd61XfFo1Ha0FEOLqK7Z1z5-feqFSMaVag5w9bNBqSiuO37pM
Message-ID: <CAEemH2fBDwk9eNnFVh2FHiiSwWqu5U=m67fOEq9jdHZXkW1wcg@mail.gmail.com>
To: Pradeep Susarla <pradeep.susarla@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1lWZ05kiwppl8ZOmjwjNoLF-YJqxFInwxYlN0clIVsU_1767926590
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugetlb: migrate library and numa helpers to libs/
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pradeep,

Li Wang <liwang@redhat.com> wrote:

> There are some other libs/tst_*.c that should be renamed to prefix lib*,
> but yes, this is not related to your patch.

To simplify your work, I just sent a patch to rename all of that libs/,
you could rebase your patch on this one once others ACK the change.

https://lists.linux.it/pipermail/ltp/2026-January/046071.html

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
