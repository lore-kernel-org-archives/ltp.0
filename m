Return-Path: <SRS0=YPcq=OZ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B92C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Oct 2021 20:24:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D466142A
	for <ltp@archiver.kernel.org>; Tue,  5 Oct 2021 20:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02D466142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A54B33CA5EB
	for <ltp@archiver.kernel.org>; Tue,  5 Oct 2021 22:24:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6123C265F
 for <ltp@lists.linux.it>; Tue,  5 Oct 2021 22:24:34 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2554B1400505
 for <ltp@lists.linux.it>; Tue,  5 Oct 2021 22:24:34 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so1496838wrc.10
 for <ltp@lists.linux.it>; Tue, 05 Oct 2021 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to;
 bh=M3FpTVktQjAC/nzYFnoZC6Rnd5+t8T0HsHKJVNPpFwo=;
 b=iy/XXgRy2CZXc6PX5IllRJUmZWb5e1dZmrNyarC9NUJSSYvnOotKyPgnqXwvecqw2V
 fWRJp8cTlCUlr7qLJgUs79u1VHzHV+jhLUXdIpkeJulbf7ZiRvEAbkWZQcBr7BZoeCBh
 Q97I34oeY3OM3XKxPB3FzHbYp43lyV3sfN0e98fPXiPVRrOkmLCuPAu0Y0mpTKYJJp92
 N49lhhfLITtJyINZO4WKAiuSSMtuslhG7x996ArPmaiBghNrJeL5WpRQRAON1JlcfwIq
 Z7wzfZqWkxRTw4oo85n0Mis70a+Bz3Rq6R2/oTqMBi9R6fuLWDzHnS8MpSSzaaUeSqOm
 HMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=M3FpTVktQjAC/nzYFnoZC6Rnd5+t8T0HsHKJVNPpFwo=;
 b=v0VtUsWkR0g+mFg7IhmKtdBv38dCEYOs+/WraZum9eEEZu9zfeyfSqg3xDQpva375k
 zpOGSyn9z5nxohv7pALmThEaWkqfUI0Rre6aTeGd0x5nJSXp/Gw9EMbPGiXN5u5C7S1p
 YMqdPG6XmeqOcZtQR8+3KtLMES90amQ16avkgfqjWkrJLQhpjtHl29vZoTeW8GJjGrIF
 CNuAxKWHtp3afHcrQJsHTdLkg9ZKYAcwMiVL4HDvJOzV/5eAh6Pek3zIY3PoG1VtiZwt
 iwZrCI1pm7G/pescPeS1AjISwyLSk3c1XV3QEXjicoK/ERDaZb8CjSCi+xl/aVLUljQH
 m1vg==
X-Gm-Message-State: AOAM530jbZztcAKamTRobdDbCbhdgf/UeXWDd0Gk583brAXdbmiIlF5O
 BUEB0+F72UDPBPrqoVs1DII=
X-Google-Smtp-Source: ABdhPJxuEcDRBeA2GBYG1zdFtOuu8BjdJJ5wqplFLVZfdRWGOFmBasG4/ovQnCWuxOKS9TlLgIlr2g==
X-Received: by 2002:adf:a289:: with SMTP id s9mr24616555wra.260.1633465473659; 
 Tue, 05 Oct 2021 13:24:33 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id h3sm11588144wro.42.2021.10.05.13.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 13:24:32 -0700 (PDT)
Date: Tue, 5 Oct 2021 22:24:29 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Steve Muckle <smuckle@google.com>
Message-ID: <YVy0fTqiKM3lCCQj@pevik>
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
 <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
 <YVtBt+WeskISn5+9@pevik>
 <2a6a43e1-25da-7eef-f212-bfe0371275d3@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a6a43e1-25da-7eef-f212-bfe0371275d3@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: Sandeep Patil <sspatil@google.com>, Martin Doucha <martin.doucha@suse.com>,
 ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 10/4/21 11:02 AM, Petr Vorel wrote:
> > I'm sorry, I was wrong, I meant GID "nogroup". Looking into the source, there is
> > no "AID_NOGROUP", thus we need to keep using GID "daemon" for AOSP instead
> > "nogroup". IMHO instead SAFE_GETGRNAM_FALLBACK() this should be set somewhere in
> > the library, so that it's for all tests.

> Hi Petr, I've created an issue internally to track adding 'nogroup'. It may
> be a little while before it goes in though.

Hi Steve, Martin, Sandeep, Cyril,

@Steve, I'm very sorry, I didn't interpret the changelog correctly. As Martin
notified me, since his patchset [1][2] merged as dc84a2490~..7d4fdf3bb the only
groups queried by name are "users" and "daemon" (these in
SAFE_GETGRNAM_FALLBACK()). He actually removed all references to "nobody" and
"nogroup" in the patchset, tests now use tst_get_gids(), getgid() or get the
primary group through getpwnam("nobody"). Thus there is no need to create group
"nogroup", please close that internal aosp ticket.

Looking into tst_get_{g,u}ids() implementation it "The function will fill the
remaining (size-start) entries with unique UID/GID values.". But the problem is
that it expect there are no gaps in UID/GID values. While this is true for
traditional linux distros (not sure about embedded distros), it's definitely not
true for aosp, see AID_ definitions in libcutils source [1].

e.g. tst_get_gids(test_groups, 0, 2) (from setregid03.c) returns GID 1 and 2.
But on aosp getpwuid(1) and getpwuid(2) fails (I verified that by running code
on aosp 8). There is GID AID_DAEMON 1 ("daemon") and AID_BIN 2 ("bin"), which
has been added for aosp 9 (8e8648463d7 ("libcutils: Add "daemon" and "bin" users
for testing only")) and IMHO no use of tst_get_gids() so far does require higher
GID that 2, but once higher ID is needed it will break (and even adding GID
"nobody" would help much).

Fix would be to actually try to run getpwuid(with expected id) until
it's found, but next GID for aosp is AID_SYSTEM 1000, thus it wouldn't scale.
But it would work with aosp < 9 (not sure if anybody cares for old aosp).

Back to tests which use SAFE_GETGRNAM_FALLBACK() (used in chmod07.c, fchmod02.c).
With current implementation, it'd be possible to replace it with tst_get_gids().

Kind regards,
Petr

[1] https://cs.android.com/android/platform/superproject/+/master:system/core/libcutils/include/private/android_filesystem_config.h;l=43?q=AID_

> cheers,
> Steve

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
