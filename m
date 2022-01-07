Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180EEC433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 08:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 796D03C8DB2
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:41:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD7E53C12CF
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 09:41:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B0B3560077B
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 09:41:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641544902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yVHgIaAS/3ZlsvsEqW7DQfi3r40X79vpwgwisuSlhNs=;
 b=Pb4lN9SWOw3fZ6koqYGlMP948wYCsq3HDciQ46OC4beQwRQ8XdftwucHfi389kCuq1k6QK
 dHhUcgEfjNf8JG7uZhhZZg5GgN02LlvDQ7+CMIfZTpem/aCrmxrSGzV6o5LyzHYGeuEvfC
 rB//Syvs/PCSFnePWvl+zZlouZFwC4E=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168--6u2tTZyPemUlXhoT3Px-A-1; Fri, 07 Jan 2022 03:41:41 -0500
X-MC-Unique: -6u2tTZyPemUlXhoT3Px-A-1
Received: by mail-yb1-f197.google.com with SMTP id
 n2-20020a255902000000b0060f9d75eafeso10478083ybb.1
 for <ltp@lists.linux.it>; Fri, 07 Jan 2022 00:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yVHgIaAS/3ZlsvsEqW7DQfi3r40X79vpwgwisuSlhNs=;
 b=jiRtTZSH26WyuKaN8ihtk6Xn8E0D/yPz4dpLJJ4jEhcbWr1nZQ+zM4eS31aQsBjKcP
 WWrlpT6MfoHGEx5O26q7CmRrzwV1YXzNwr1lhzaw+z17eKYqbZjQQKmPFVQcsvTeWYVT
 d3Ykyvp/qrMitGj/IHmiuMthIgAMh/eyP+kEbbjB92uN038ur5t8Mi+NaYAQjuH9tdfT
 wFcGlLvvMGdm/AZiyU2/doOBGjQdEWlX3TdsxA43r+3AkH+GFWspaDhjqT/+3AOCZSKP
 Sk45pFufbWegmr3/TMJxuigV/o/rblF3GTewLrXnsmoIAz/0IuMAuSRuSgBQ16pz2A37
 G3Gw==
X-Gm-Message-State: AOAM530cdV7YzLKlLLpoSW3q87edJC5ZbIiey7TWxcaV92xs1fuFnhIo
 40TB3BSVrCmyeuJLJ3MeTmdW5cwbas2NfEOkgJnvgifHIVAZ5nODOyd7U1c4CUZaDBxnlHTZnGM
 671ZQgBmGrRgYpZOQOCMl1+1z7e4=
X-Received: by 2002:a25:452:: with SMTP id 79mr64978990ybe.421.1641544900796; 
 Fri, 07 Jan 2022 00:41:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQrHvmMmjiEsebWR4gNO5XV9og0j15etUYbOnrSU3SuolYLW4PRZDpzc1ldCDdRFZTFzS4Ff/yQfKPDQzbUms=
X-Received: by 2002:a25:452:: with SMTP id 79mr64978978ybe.421.1641544900599; 
 Fri, 07 Jan 2022 00:41:40 -0800 (PST)
MIME-Version: 1.0
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
 <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
 <61D7F9AA.9020401@fujitsu.com>
In-Reply-To: <61D7F9AA.9020401@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Jan 2022 16:41:26 +0800
Message-ID: <CAEemH2dryR-JbgK51VUvNbZbGgw_kK0oA3ry-W29zkBd7uR8ww@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Xu,

> > Maybe we can combine the arguments into one kconfigs struct and
> > just do once check? something like:
> Yes, it works well. Thanks.

Btw, seems const char *kconfigs[64] is not enough for a long
string combination, you can dynamically allocate memory
according to arguments size. Or, just raise to a big number.

>
> I checked the kernel config, it seems comma can not meet the CONFIG_LSM
> situation (Petr mention it but I don't notice before).
> CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>
> so I think we may TST_NEEDS_KCONFIGS_IFS variable and default value is
> comma.

Ok, I'm fine to keep that, and thanks for the instance.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
