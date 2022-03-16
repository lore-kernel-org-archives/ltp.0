Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A7EC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 20:11:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92BA13C93F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 21:11:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41B123C793B
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 21:11:13 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 333B910009AA
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 21:11:12 +0100 (CET)
Received: by mail-yb1-xb29.google.com with SMTP id h126so6520475ybc.1
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 13:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P5ccPjlwvN6G7YG3kMJjxNTOj4bP6DWTa06PH7G9E9U=;
 b=OT1j6OmloLGO5NfXQzmTa69nmEPpf+9cAkNKdgNZpTGdw1EKwYmmorkVaCCFCVWxoD
 YcYhqPhBNd6Zlb9bQGNg4lg/OIN+plybOgzpwEoyRy4H4bfzah87RtgGVeT1g2HvwybK
 ZU2TdEHiVNQCxPb2zjETjmL2zsyVa1lmLIKvTMa4kUJn9kdsgLFACL2sX9IVZh2ilMmU
 z7Bm3rcxUc9QaKh4pCLA/Kmm+/qarBV2/kcoMqDTso0eQAfxKFPOFVsGFwOh/JRjVo+m
 dniNO8KO373rHqWv7JiEIiz/9A5aEuYzWlFQSDW1tLm9tjKw0j0/CjQSDJu2JK7DUkOE
 3SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P5ccPjlwvN6G7YG3kMJjxNTOj4bP6DWTa06PH7G9E9U=;
 b=qLTv2O3lPGMSgKgmPBx6lavW3xdeeKKs5wwk3CaUa+DGlO4/D8tHj95nHYOpJZKrln
 +J5ZL90Qn/9Xe7fNdQCrBSEwCH3UZbHK+MzecMZ65HALbJYVZTgLIvekM6lz3+bRlqGv
 lksaIEIKcobefEktg3ttkd6bLyletHsDNJpRXNCD86JGluGMPkTKP/+kiRQMqrgvM4dQ
 7HRw0ptehkzOxbX4WaEj5fC77d1Kv7VItdLj0jytUFPNvC3kg+XbwpTNyaL1Jf2VysBK
 UwamhedXrN2tBQAMdEMwZa3CMz3o+/u8rPJTY0UmqCSTBswNEb/E++ZXjB2HxtMF8Dz5
 +qTw==
X-Gm-Message-State: AOAM531yEYGM0SLYUC0D123WAH7tO8HeAC7EfC63x9oV0/qn+uY5E1/w
 ZR/Q5xrDtzyH7jgFaxe10HbEAdYhJOFEz+MX5V9wXg==
X-Google-Smtp-Source: ABdhPJwmrPANuOf3TT0IN8v8tFOnluLCYR9U/RecniklTnAmIDVF+bPBEGqrEoDekO5yKUcAY7i4QWzIKpDmCA7PC4g=
X-Received: by 2002:a25:5b57:0:b0:633:6b5c:86ad with SMTP id
 p84-20020a255b57000000b006336b5c86admr1839977ybb.113.1647461470801; Wed, 16
 Mar 2022 13:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki> <YiDB7wO3Se/vN15+@pevik>
 <YiDGvzETiI/nxwW/@yuki> <YiDLn3GMNFu482XG@pevik>
In-Reply-To: <YiDLn3GMNFu482XG@pevik>
Date: Wed, 16 Mar 2022 16:10:59 -0400
Message-ID: <CAKoutNsc-JWQd1MOTFk7Hd_MgsFKj=6qi=uusKez2HgatTNCdQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
From: Yael Tzur via ltp <ltp@lists.linux.it>
Reply-To: Yael Tzur <yaelt@google.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 3, 2022 at 9:07 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Cyril,
>
> [ Cc Richie, Li, Jan ]
>
> > Hi!
> > > > > > I this case I guess that in this case the change is so minimal that we
> > > > > > can add this test into LTP once it reaches Linus tree.
> > > > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > > > and put keyctl09 into runtest/staging now.
>
> > > > I guess that we still did not agree on exactly how this should be
> > > > handled or did we?
>
> > > Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> > > test must be moved out of staging." ?
>
> > The main problem is that someone has to make sure that it happens and
> > the process would be prone to errors. What I proposed instead was a flag
> > that would set a kernel version in which the ABI is going to be merged
> > and put the test right into the final runtest files. Then we can simply
> > skip the test on older kernels or do anything else we see as a
> > reasonable solution. At the same time we can easily add automatic
> > checker that would look for these flags in metadata into the CI which
> > would, for instance, send email to the ML once the flag is supposed to
> > be removed.
> OK, you're missing that kernel version. OTOH things get sometimes backported,
> thus it's not error prone (if we forget to leave that flag after kernel being
> released).
>
> Also version is hard to say if you use maintainer tree (which applies patches on
> previous rc1 than what is being in Linus tree). Thus maintainer's tree would be
> left, also IMHO next tree has no specific version in uname, thus we'd only
> support rc from Linus' tree.
>
> But anyway, if all agree that this is better than both solutions Richie
> implemented I'd try to find time to implement it so that we have finally a
> solution.
>
> > In this case it does not actually matter, since the test is guarded by a
> > kernel config option that is introduced by the patchset and the change
> > is fairly miniminal, so I do not think that there would be any changes
> > to the ABI anyways.
> Correct. At this stage IMHO we can dare to merge it.
>
> Kind regards,
> Petr

Hi Petr and Cyril,

I wanted to check whether there is pending action left on my end?

Thanks,
Yael

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
