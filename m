Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E08E63C8B
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:42:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15A33D0EEC
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:42:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11FFB3CE781
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:41:44 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51E2B2001DB
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:41:44 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso35339765e9.2
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 02:41:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771843304; cv=none;
 d=google.com; s=arc-20240605;
 b=NO4xhRcyq36sfpjDWsD+XovkZklr0iKgK5sy1UJROcWbDPD4+ElV518coY+biFKhFd
 6mExdjzZYMalmryctfwJ4f/N4JczwnD+x9Iwa7nkAriYlzd+M/WzxzBbdROTJe7moeB6
 BL08ei5+/DdUFTkncHMrpa/ZL8/3L2kSL5AP70zbTURUb9aBxXXxDoVkWVQbufTglzg6
 3jvM/S2/GP3BCZ1DzXRSRHF/PYoGn50k97z8OggCOH2p3z8cBC+RgOmsj11iPZoF/HMn
 IK9L/kcEjpnbKvVe7UDrPV/D/IHBeH0JD7L07fgNx2ftrWLjLQXgejxrdXJJfSFTr96N
 NHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=168+WTZVJoh3kxdp/XLVQdeC8TGmd/Hb9qr8+rvA76Y=;
 fh=W81DXYHq/rxAQZGDGvCsiY/k804rHe5Ve3wad1JAgC8=;
 b=ktzsKJ+DrZ7SgQycDwaZUKEPr9iU2p7DxuFD6199Tpdl94MifpxOA8AmX4DOJeRyKG
 B+brrlCGt6Hu3YSJgsGgCjrxOjN+TGZw2bPGanakAMMQSPuoES/X1AP1oFHYNafOBJD9
 sIe4cpPvGogVZ324CRuWaycCB4wNusSA89OuO6voZkQsKWoV8SptR5nGIr0fG2kRWer1
 r5DKBPacUTmnUEZ7k+ltO2slKlKv44AralpWGi1wTu+IgoSE0fHNpoMM4c5O5XCVKvm3
 Ib4rwiT09uKotKHwK/ON01nzbgHjKVl8Dj6Jj5W/7uO49u7NFEppjSNdP5VMXe+sTaL2
 5LBg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771843304; x=1772448104; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=168+WTZVJoh3kxdp/XLVQdeC8TGmd/Hb9qr8+rvA76Y=;
 b=bKiqFzUD9ZaJ1zyiVNRk53wuMhdcIaVo4+itz2iy2yvrpg/R3FyItZfJJLp0yo34MJ
 qxFJtAG1/zfJ8maXp7xs8VUVFOcdfy4FoBY9O4/OEikbiSJZm82wuSYJ+d05QXjhmbN4
 6GGPBE3tVd7iuLiFnC/uw0Sufv16kuF4fAX73KInDDU9fA/3sOKP65+TQEWSP4YgqrSw
 Viu42gf5XOaYn48Xixfq1JqvQTyvsTM2O1EWd1TraVSQHiojRRjOQn7DcYIsca6GhgvT
 IYrkIZKzdhBrsSZ6oNi12BF6+x7A77h13qGCV4pIlmEbJJ5RjE07pUMlB7V+nn26jl70
 cZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771843304; x=1772448104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=168+WTZVJoh3kxdp/XLVQdeC8TGmd/Hb9qr8+rvA76Y=;
 b=QGWAH6T6o0QnfwrDK3ZT2noymsnQDPxXq3aBotqtEedGGKfgaRUoyBgGZplNZXIEgC
 vECReJh8MIF3wDgqf1GjX8TR0vu7Sz6Ng3p4o3Nwf+Qjkda3mSS3a214ILA56EsFaWBL
 4WzHtpdi94wGC0Lz7Ywfo18wbduTz0TgnmmIhHYDrK1uzkXTYQsIdlACs0iGckQ5BucE
 T7+qrSG1moDCWGaK/mgIbSqVZ6naxtrPKvmH4JIHRxCyBUF9PhHc9GWxShFixCeYDZWp
 gL34tx9ZwZzP2afakFHRAE2yIheTQygM/HLBTdPdIOMbMhVESXyI8tqf8Ayt2RNdaqJ/
 tEfw==
X-Gm-Message-State: AOJu0YwR5iM9raQFftAjxW/nux9BPnCSgjyVYl9pUqFSym4f+QpIz92m
 PuUVeItWWT2w6sFsK6i31ZbZfrvb61XtVWTEsAdXCcOxdM284EO3cf8tCq3p6dIgWXp9uewnfGq
 XftMRqu6FvAT25ZGYpDUi7g3f/jWJ5iM=
X-Gm-Gg: AZuq6aKlH8GxlvFQPTUSrNMz/T3opCD4yd1LQc+Ura5Vyz1s1c2bvZEY07iDiFfct06
 xuZ07+tftXuE3Y5rUsVKMhi72+KvAm+VMFHBUKPyxA0E0ZUun6oBlCbWcdSEgko4kY3oBEPtEZd
 IQKY0FAuP7nM5jdzl2Q3lGX5tyIjNuWfyY8Y2OSgAQjW3Jrlms2m21evDl7+GBVFXrIHGZlQQsb
 p97xN/luuagO6uzAw/lurlFOX5f+BkDvWb6OmPWzCer9G6QdoESRRiaphMtXlobfd0F9uOTuaq/
 SaAbGW606ZsWrcO2Ia+53jcBdAxpSFGE2X7qtdaWsm1BRYOw
X-Received: by 2002:a05:600d:6409:20b0:483:78c5:d743 with SMTP id
 5b1f17b1804b1-483a9637a19mr90391985e9.28.1771843303549; Mon, 23 Feb 2026
 02:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik>
In-Reply-To: <20260222203442.GB417048@pevik>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon, 23 Feb 2026 11:41:32 +0100
X-Gm-Features: AaiRm50NUPnft_iEjrbXHMboEJMhzou7VN_E0FfMFFbMPr8smP__iNxKw6gGqfo
Message-ID: <CAJCsO8eTiS5Z1Upon-gUj6R9f=TW3BJaRqmDwdxEwSMyvnwB1A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, 22 Feb 2026 at 21:34, Petr Vorel <pvorel@suse.cz> wrote:

> Hi Sebastian,
>
> [ Cc Martin and Cyril ]
>
> > nfs_lib.sh checked key server_side prerequisites on the system under
> test.
> > In 2_host setup this incorrectly required server_side tools on lhost.
> > This patch keep netns behavior unchanged, but in true 2-host mode run
> > server-side checks on rhost via tst_rhost_run().
>
> First, thank you for fixing 2 host side setup.
>
> > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > ---
> >  testcases/network/nfs/nfs_stress/nfs_lib.sh | 22 +++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
>
> > diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > index 1ac8bd657..e52f96a5a 100644
> > --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> > @@ -45,7 +45,7 @@
> TST_SKIP_FILESYSTEMS="exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs"
> >  TST_MOUNT_DEVICE=1
> >  TST_FORMAT_DEVICE=1
> >  TST_NEEDS_ROOT=1
> > -TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs mount.nfs"
> > +TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount mount.nfs"
>
> >  TST_SETUP="${TST_SETUP:-nfs_setup}"
> >  TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
> >  TST_NEEDS_DRIVERS="nfsd"
> > @@ -186,10 +186,24 @@ nfs_setup()
> >               tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
> >       fi
>
> > +     if tst_net_use_netns; then
> > +             tst_cmd_available exportfs || tst_brk TCONF "'exportfs'
> not found"
> You would here use tst_require_cmds exportfs, but ...
>
> > +     else
> > +             tst_rhost_run -c "command -v exportfs >/dev/null" ||
> tst_brk TCONF "'exportfs' not found on rhost"
> > +     fi
>
> ... if you remove exportfs from TST_NEEDS_CMDS you can use the same code
> for
> both netns and 2 based setup (tst_rhost_run should work well on netns).
>

good point. I have tested v2 which I will send shortly.



>
> I was thinking about having a special variable for checking rhost only, but
> given that tst_test.sh is now also deprecated, we will have to solve this
> in
> shell loader.
>

I was also thinking about it but in the end I think it could be just yet
another variable to control the test flow, so one more thing
to worry about... and as far as I see relying on the presence of already
defined variables seems good enough.



>
> > +
> >       if tst_cmd_available pgrep; then
> > -             for i in rpc.mountd rpc.statd; do
> > -                     pgrep $i > /dev/null || tst_brk TCONF "$i not
> running"
> > -             done
> > +             if tst_net_use_netns; then
> > +                     tst_res TINFO "checking rpc.mountd/rpc.statd on
> lhost (netns mode)"
> > +                     for i in rpc.mountd rpc.statd; do
> > +                             pgrep $i > /dev/null || tst_brk TCONF "$i
> not running"
> > +                     done
> > +             else
> > +                     tst_res TINFO "checking rpc.mountd/rpc.statd on
> rhost (2-host mode)"
> > +                     for i in rpc.mountd rpc.statd; do
> > +                             tst_rhost_run -c "pgrep $i > /dev/null" ||
> tst_brk TCONF "$i not running on rhost"
> > +                     done
> > +             fi
>
> And here of course as well use tst_rhost_run for both.
>
> Kind regards,
> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
