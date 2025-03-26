Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5323C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742978381; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=iJH6SLb2+HdqziBDp4rtEFPeO3sJ0DDYDgKeiek6+6o=;
 b=jLTmDLYmVVSJsTaTJgck3NhqAet+QBbl+mSqUkejF8eJ7Nk6/B9DXXVfj/S930/U04YNu
 v3UPCEseJApr4PcyE5oTZW4mDY7vgsU0yaWGaN7L7j7nG1nfS+TCFnse/6ezMAej0l64Htg
 ckrC02kwCvo653LllWcevJJWqlGSTLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F3223C989B
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 09:39:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075533C8FA3
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 09:39:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 429621B61042
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 09:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742978356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FC1vGFXMK0JoET0JB7i55EsogVgYaMakGoC3xqaH7vk=;
 b=bS1IVBsN3Zxvb4MbsCt2ONa28pvg1oJR9XuWGAgJXKyAi8Fr5cZjjBJlpSBvNLiRpVyfh/
 kgtbD7sTnNa2wm/57leR+ojklYIrQLER1pyO0Sq8sr3CGEAFPlPnDHdAnuEqawkAkgBDAw
 uh8LTyLvp54C+6wfrsO5cx0HymVHbuI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-9avKL2wMMieF8ohFIo1ZjA-1; Wed, 26 Mar 2025 04:39:06 -0400
X-MC-Unique: 9avKL2wMMieF8ohFIo1ZjA-1
X-Mimecast-MFC-AGG-ID: 9avKL2wMMieF8ohFIo1ZjA_1742978345
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff53a4754aso17942381a91.2
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 01:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742978345; x=1743583145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FC1vGFXMK0JoET0JB7i55EsogVgYaMakGoC3xqaH7vk=;
 b=PVKtkvysZ9klmLk+Rot1l8iOSgEvHBn/+SSnKb2AewiOGhZ1CrnI/QKYuM318JV4GU
 ft0nnkIkszIea0iF7v7GeyS7a5PtX2yCyWzbTTurulTsA1kF2Cu9TI4hnnp5GOGS+TXA
 7S8Yf1KuMtZnlWGBq9N2rMzihAc3KZHJJRC9z/cZjtkb1iP0sZexj+CmLnv/RceNVjJ7
 9FYA1UMU98kNxZ88ng5dVSdW6ciJs0bxCoSFTFQu3189GwlYiILBgjDaftVAmfHCJ1Ms
 kcbuppVKYHYKqn/T8Q8+okv6bUInK5CUS0IXE1tbsqaY3CxSNMsROtYdtUpM0NabXlYf
 irwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8NftFLZVqAtFMAKtp1Ka0W86RIkJuv9cq3FoN3AQrWVxPMJfUl41PNtw3yQzrusKgWfk=@lists.linux.it
X-Gm-Message-State: AOJu0YwZgBXMIP8P9cZ6OgLDiqUIEQbscOVY1v4Y41d7QFhX69MShocQ
 dxNJ447ALDSNCekm2pEwi9QEUZtFNWS/XtOG5y6Egs44EKX9tsThN3eAm5yyd648jmCbfy+Qkmg
 oBTGDGwXLPQKBEvmDvNs6vbzKM8IOfhPQmJVD0nW961Un1QJ2ILCMotqd4Lv1ZuW/KXp67w9X4M
 Sy3ma1teZpRFVzT64ji4V2X2I=
X-Gm-Gg: ASbGncv4ddi91bN+VdRQRe/xSeZGfuAgC39SsV8ICvMYUFgERwf5f/Mda8jRUti0WsJ
 66gfzpD3wqSL6UnzmZIUDKZP9DLx6sKe+1WzAv5uJ3UAS9bVMUT0t3Vh61xSH8mo833xWHoDslg
 ==
X-Received: by 2002:a17:90b:4c52:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-3030fe8647cmr34251281a91.11.1742978345157; 
 Wed, 26 Mar 2025 01:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmQlFoRnP5XlliaRVWE1ezspXk1mpbxXDNyjCgy4qk6VKZ4cnaB0zN3tH6zkcDCl5JuBFNKRb2aTHuiN+lAY8=
X-Received: by 2002:a17:90b:4c52:b0:2f6:f32e:90ac with SMTP id
 98e67ed59e1d1-3030fe8647cmr34251235a91.11.1742978344547; Wed, 26 Mar 2025
 01:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com> <20250325140018.GA448693@pevik>
In-Reply-To: <20250325140018.GA448693@pevik>
Date: Wed, 26 Mar 2025 16:38:51 +0800
X-Gm-Features: AQ5f1JoWV1_GdxTm8vBBxMUg5PsS8g7CCOgatU3I2vfiyrH9V4Ns-GZccQC73kE
Message-ID: <CAEemH2f=BQxRtFuBj7+xxGDXgfxxmCXwOe6SE6PKrenEePRAiQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FIPgKEPmuHjGac6WVeJcVoqcGB6GolaTr7dxQOUCGeo_1742978345
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

Petr Vorel <pvorel@suse.cz> wrote:


> > +static struct tst_test test = {
> > +     .needs_root = 1,
> > +     .runs_script = 1,
> > +     .mntpoint = MNTPOINT,
> > +     .needs_hugetlbfs = 1,
> > +     .setup = setup,
> > +     .forks_child = 1,
> > +     .cleanup = cleanup,
> > +     .test_all = run_test,
>



> > +     .hugepages = {3, TST_NEEDS},
>

This line is equal to `echo 3 > /proc/sys/vm/nr_hugepages` and check the 3
is there.



> > +     .needs_checkpoints = 1,
> > +     .needs_cgroup_ver = TST_CG_V1,
> > +     .needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
> > +     .save_restore = (const struct tst_path_val[]) {
> > +             {"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TBROK},
>

If we set .hugepages then this line is redundant, because ltp-lib
already saved/restored that nr_hugepages for test.

See line#68 in /lib/tst_hugepage.c


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
