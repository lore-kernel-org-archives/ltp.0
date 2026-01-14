Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CD4D29FEF
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768391951; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fIZT22tBeEH2dyWEyWIRnvzQ4xeNa/S9IgHfTalzkPI=;
 b=FIJtqL3jYmG2HWq5isLErYN53fUMGZQmnEfLFO0IdxkxO8k35RQVbEF60qb0DhkQ75FlV
 jwFYAXVO3b/Xs37l0RH++xEL9OueKLjnh6yz4/X/abKaGeHrRx0wMr22crFFq4KoiNwMwBa
 44dkmH/uok/T/uUDKYsQuZZXYebe/pY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 567DC3C9B25
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:59:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 176DE3C99BC
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:58:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99581200251
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 12:58:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768391924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NH1Fm8QRZPY+XwDzMRKDkuqq1tJmxmto9W7TE/IE+0=;
 b=PT5Kh3Yqpe5L78dIdtGLLaxEOVtfTgx4rKmar9SMUoRRr1RH83yj/xVFfzELORgvhO6rYD
 K3lur7mtua2s8zatkNxJlZNenzbyH5hbN/TrAOx6LaGIngq38VlsoEEZNcXUe6zbRhdocY
 NkkqVLpkAh1XWTxr02D8UVyqk8PaNTE=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-8bQ98AddP-mg4dDQhFTfwA-1; Wed, 14 Jan 2026 06:58:42 -0500
X-MC-Unique: 8bQ98AddP-mg4dDQhFTfwA-1
X-Mimecast-MFC-AGG-ID: 8bQ98AddP-mg4dDQhFTfwA_1768391921
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2b47ce772e4so4026087eec.1
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 03:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768391921; x=1768996721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NH1Fm8QRZPY+XwDzMRKDkuqq1tJmxmto9W7TE/IE+0=;
 b=erme9Djbhq4eTDf1r6ltU8oo1d1gA0ZmSU1+3+Lr3Vqydo6c8E+GivCFyLjttkvVHA
 9G7xtvxGu+1+6WwNwKHAPGn3w9RP+4our91+F7wJ9DO9kUEApLrdxBHT6s1/93tsZiIv
 WZhW/4L6e1F1iZ+2ScNEZMttvPsXFldQYfhSyV0Wb1nEa3nwCUu677Io7ehs+epUzuzh
 UAxnC+ZlaWRzMWj5W/oe1+t0Uejntrh9rm81ae/O0y/UYwuUkBRJasUsaScoMHTBowS9
 qfGqT1WeKotIcxPRfsiQ2UGqB2f6utlBzsgGkFv+5KO0bo03Ikqwzju31hu2CvwgGHZw
 MarA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSTtvmsdGUCRlfNBEw0utrVpIDQJ6DV10NHIGnjhxvTL2alqKSHKNlzCLjTtq307MHHWI=@lists.linux.it
X-Gm-Message-State: AOJu0Yxsiq3q/HrOPWeMm0DKw8vxP2pqYs25P1FYNprXXLTZkERVcFYW
 UrI4pw3mJcorUieHIl1xaLdAwa9v77U+/koyCoQpJNkyFSrcSbr0nNu3TR1SnBwM+0C+R/4pCcf
 QPpdrotPU1Vv8kNgL15MAYWwozJuQJN4NwMOnOOLVBMVsQWNA0EpQG9eyfHZp4m6ggoV/4mHPv/
 xNe0WpsvcpI9XzVWDHp0R5b/brUZw=
X-Gm-Gg: AY/fxX4cODEk1EHxsgQPS7bjAbZmPhl2NRx0gtxnenpVhtcw1hWRnoHGcaub+tHlK23
 VTDFGDbqIZk96AlJ04P6/RiKBlQjra5ohpu6Oq6ijrUASZwl27KjeNWSQ8Dz2wIXn/tFidVCvvJ
 NOoB4SL/SAvypJOqdRb2zldJHhDe1cAUbAD3HA10aAhBpbV4KSAX3Yq7N1I0jb9IbpXlg=
X-Received: by 2002:a05:7300:1897:b0:2a4:3592:cf75 with SMTP id
 5a478bee46e88-2b4870691femr4361142eec.25.1768391921279; 
 Wed, 14 Jan 2026 03:58:41 -0800 (PST)
X-Received: by 2002:a05:7300:1897:b0:2a4:3592:cf75 with SMTP id
 5a478bee46e88-2b4870691femr4361095eec.25.1768391920855; Wed, 14 Jan 2026
 03:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
 <20260114085116.GB334250@pevik>
 <CAEemH2e1MVNjLJR+_h9Bvkk3b0roVxhtJRvedFhxH4ckzhW==A@mail.gmail.com>
 <20260114113349.GB344144@pevik>
In-Reply-To: <20260114113349.GB344144@pevik>
Date: Wed, 14 Jan 2026 19:58:29 +0800
X-Gm-Features: AZwV_QjqTU353dWCnNFcAO5zWO6tjXlZLQgh4Y94H6jnoOM59dornwyy484gxk0
Message-ID: <CAEemH2ezNaopkxYA4k1a5sryLsCyAuAx3rZvHwW4Wru7V-+f+g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QU-UykcV5TreNMvk8xKgeET3bKCM8z7MQdQYYiRvl90_1768391921
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Well, we might subconsciously think that libfoo.h means an older version,
> > but we can change that minds. Something like "lst_" can also be used in
> > older APIs (and implies extra libs/).
>
> > Furthermore, I believe these additional 'libs/' directories will continue to be
> > developed and exist long-term; we currently have no plans to migrate them
> > to the core API,  so explicit naming becomes crucial for maintenance.
>
> > By now, the situation is, inlcude/ contains different prefix header files:
> >   'ltp_', 'old_', 'lib': meant old LTP API, but should eventually be dropped.
> >   tst_: meant the new core LTP API.
>
> > Next, I hope that we only keep two prefixes in LTP API:
> >   tst_: new core LTP API
> >   lst_: extra (non-core) LTP API
>
> I'm not a big fun of 'lst_' (I might need time to get used to it :)) but I'm not
> against it.  If we agree on this it'd be great to document it, so that new
> contributors will not have to think which prefix to use.

Understand, we can treat `lst_` as an alternative. This approach
allows us to replace all `lst_` values with the desired prefix using
a single 'sed' command.

Here only demo lst_ for an overview, I am still open-minded to find
a proper name :).

     include/{ipcmsg.h => lst_ipcmsg.h}
     include/{ipcsem.h => lst_ipcsem.h}
     include/{libmsgctl.h => lst_msgctl.h}
     include/{libnewipc.h => lst_newipc.h}
     include/{tst_numa.h => lst_numa.h}
     include/{parse_vdso.h => lst_parse_vdso.h}
     include/{libsigwait.h => lst_sigwait.h}
     include/{libswap.h => lst_swap.h}
     include/{tst_uinput.h => lst_uinput.h}
     libs/ipc/{libipc.c => lst_ipc.c}
     libs/ipc/{libmsgctl.c => lst_msgctl.c}
     libs/newipc/{libnewipc.c => lst_newipc.c}
     libs/numa/{tst_numa.c => lst_numa.c}
     libs/sigwait/{sigwait.c => lst_sigwait.c}
     libs/swap/{libswap.c => lst_swap.c}
     libs/uinput/{tst_uinput.c => lst_uinput.c}
     libs/vdso/{parse_vdso.c => lst_parse_vdso.c}


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
