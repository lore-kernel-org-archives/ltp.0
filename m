Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A72CD582A
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767781683; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EhX1SAkKP7LYIkaGi/cZsFO7yWDwJVyB9N2MPTtfO54=;
 b=eWMTDN5uODVp9SezRnk6cD8qaoVA+I+OMFX2G7jXhbuXzrPmgJzsspAyT7KVudQ4gCkcQ
 IMmKkNdNdFh9BGgOrmYMT76t7opCQFifYTo2q1GWGn2wC6qhp4P46r6ZDPC9rofp7k2WnpT
 QU5arVdcmTKPKjDJKuFtTfz0kOB3WwU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0A8F3C2E38
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 11:28:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53E3D3C298C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 11:27:40 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90475600136
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 11:27:39 +0100 (CET)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF8433F915
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767781658;
 bh=OUYDuqlyjOUG5gkcazKoysZWuYRcqhH90Kg9AtPSCXY=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=fzMO5nKBfw7nL8LvipII2eDNJUp7nbalWeS7c1hbAUaT8vVP8djSqMJIK8FdSPKYr
 PthLr5jW+25gRWW8Z0lcL/1zqSbJiNBdzcL9+Y7pYnLqVhT5zsPeXJf+qACKDyZT2w
 u8PD94LUME4W2dS8ZNL8X5Gzd8aFgJrpNI2uUc/E2A3z074ZchFvndjtfg+1zkhpFU
 /KENkpNjWXJIAI2ZBCMP0WlVylEyAohwH0nrxFglhk1Gg34uIq5QcfmRUGKnHGxRSp
 CxVe++KgAyPXRcgq0FYgyiQRonXdCoZ9stXZ/jW/mXyUWye+vHoBJuQ82ai4rnLH17
 HVUFudW+MJRgRaSlhyBSUbcIdgenf0Vm0Lfm8hUAIXCB9EJAAf2rUsXcTA4IevEuis
 G7jzMmLmCixaOCUvN5ttUNDJnZwf/N2iHLTMAQU1rWEC5VqSmDoDyTF/nI3wL4srFp
 c6E07ikMyZOSqPqiB6E+1/L8ZwqYyXwgMCcEW5CZ2rJmrksubqc0OSfLQAX8qxXfGf
 50mSF321g2lSBKP2eTMIaPm2J9gmUbEGYWQjv8ZJdYjyt310pALSnOevyOPOurA6WT
 5W6bxQpGWk/jDPAeSNHCY3BYcy1nP2oCN2GIxO1uEgDKoeLP6mMCs710IbLy1F4uhX
 NO76/V3NgHTiqDMqdlbwAb3I=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-64d1b2784beso3346176a12.0
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 02:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767781658; x=1768386458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUYDuqlyjOUG5gkcazKoysZWuYRcqhH90Kg9AtPSCXY=;
 b=ZaSiVIoapjSO06/EFnKna9GnAkwytSkH08W0KJVVOMGoZwMNUnMeJ1DCoaLt1tvD99
 q5lv8SXRyp/BjwkiLzFieCMzAvkGNiAjyt2qkBFDcWO06rgbRFv1TK3qQTH1ynP/vMlK
 KWfDbONGEAgOC2F2TGUIRXgJoSYDwn/kHfnhElD9xmm29aIBhtjoVTB56dq9GQ6l5M/n
 T8hsD3p021uKmQuw6WYsdqSlgUurPRxbAriR9jZY3AEnUe3SJEUSM/I+RciGxMqon9Le
 /ZAnvXphpi+UJ+UX3jwU6srYmO5bHcPWvVSckdY/iGDqF6sExmUqeg0hlbIxrRsUsBD6
 qiHw==
X-Gm-Message-State: AOJu0YxVK7Woxq6nHVCPffjCx6f2XDgGHvFawLpD6NcWsphR3HLdMueT
 eS+agivwlX909+DsVO8IdY6pyU4E8VUmgvYd7BVftxDxRMKuorfOQaGW1FayQnUDcU69r5/8uwJ
 avLkbLomV8lcl3fMATNoCOorroyic2zrp3UGcnqLsz5dSp44XVIyaq+FfcHt6Je+Qtt3GETN2gm
 m2cwrZLbmeufGwuKUiPT6GYLexflAaF+wmputQCjvykg==
X-Gm-Gg: AY/fxX6aogRlFCjGvwjY1pVTNvOHtj9Ids8/aA/feDoj1Rpmo+FyCXoKsePkr5Q+lMp
 1IEelWQxk20yWT1eTqDSvCQNySto7wgiqpSRicFTZ+uiGMavWTMnOQHnOVXUdv4kWGlwqxf714S
 8vzetFKdlkmaooG/oUKS+c4xzrKTQaLRpFaDXMYPlZxxh32lblByulkTWlrTvwR3gqBAHpeMsVg
 dhaljoYXOUkrZcML6uWuAE1
X-Received: by 2002:a17:907:3d8f:b0:b79:ff62:e994 with SMTP id
 a640c23a62f3a-b84451e2ef2mr195709066b.22.1767781658404; 
 Wed, 07 Jan 2026 02:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeQfkyIy5emcqOL3DasegVC2M/smuqegiO2P6Bp2QmftzkblIdLcwL8+4jDUt99rmVMeBKWPv+WfnhwxpscV0=
X-Received: by 2002:a17:907:3d8f:b0:b79:ff62:e994 with SMTP id
 a640c23a62f3a-b84451e2ef2mr195707066b.22.1767781657754; Wed, 07 Jan 2026
 02:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
 <20260106120447.GB712536@pevik>
In-Reply-To: <20260106120447.GB712536@pevik>
Date: Wed, 7 Jan 2026 18:27:25 +0800
X-Gm-Features: AQt7F2peFIeSSuWHSI7nF_EWQAJMlfnk1DZZJfnzLAk2E521jTmG2UjPjHBWmTc
Message-ID: <CAMy_GT-hM3d=hwF8+e6H85Y4zN3PKH=XFAWCZDLFLc4pUEXpGg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 6 Jan 2026 at 20:04, Petr Vorel <pvorel@suse.cz> wrote:

> > The kernel change 78f0e33cd6c93 ("fs/namespace: correctly handle errors
> > returned by grab_requested_mnt_ns") from 6.18 has been ported to upstream
> > 6.17.9 [1][2].
>
> Good catch.
>
> > Therefore change the expectation from >= 6.18 to >= 6.17 accodingly.
>
> > [1] https://lwn.net/Articles/1047684/
> > [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.17.9&id=8ff97ade
>
> ...
> >  static void setup(void)
> >  {
> > -     if (tst_kvercmp(6, 18, 0) >= 0)
> > -             kver = AFTER_6_18;
> > +     if (tst_kvercmp(6, 17, 0) >= 0)
>
> Shouldn't we match 6.17.9 then?
> It's not about the fix but about a kernel change.
>
> Hi Petr,
thanks for the feedback,
in this case should I also modify the macros to BEFORE_6_17_9 and
AFTER_6_17_9?


> Kind regards,
> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
