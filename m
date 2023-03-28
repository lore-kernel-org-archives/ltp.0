Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939D1C76196
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 08:17:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FEAD3CCB34
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 10:17:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 712C13CA4EA
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:17:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95A6714004FE
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:17:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE861F8A6;
 Tue, 28 Mar 2023 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679991432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAEk8v9QIxtxhGDUMPdqmKA1BtWL7PqhptkaXd6XItI=;
 b=fZCQ0iNFQGocS8wG8eM07i6rfN+lCJ44CW9g2rs/5T8CgBAytyL75wwt1qeLJOpNee/LL1
 brzX6q5qfT/mTh7RHbWvivv1ATcdvUgwe8J1H9E07oL5hMnuYbzaMsvhejBaROCdSTfi8E
 TmLHREuPfzgk4pgpZhiRY/sukTX4SHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679991432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAEk8v9QIxtxhGDUMPdqmKA1BtWL7PqhptkaXd6XItI=;
 b=iDK9pEfGFTurmFKhdyECfNRjVQKDVZNqU8hDHqHPbU0Tu1jrthqKHNC8EQCtyfMU2bxYL8
 2HLcMySpecUs24Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A7B01390D;
 Tue, 28 Mar 2023 08:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GPr9DIiiImTkHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 08:17:12 +0000
Date: Tue, 28 Mar 2023 10:17:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230328081710.GB743322@pevik>
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230324103334.GA557284@pevik>
 <CA+O3cCRGPfMP2EVigECgJ8c0Uo-yd7JUm64wSgvvgxoRqe7-Jw@mail.gmail.com>
 <CAEemH2e69a5DOq9eqJVau8YCENZchm8miOH3upQY_Pi6SUFyng@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e69a5DOq9eqJVau8YCENZchm8miOH3upQY_Pi6SUFyng@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Paulson Raja L <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Paulson, Petr,

> Paulson Raja L <lpaulsonraja@gmail.com> wrote:

> > Hi Petr Vorel,
> >   Thanks for the comments, I have just started contributing to LTP, and
> > this is my first patch. I agree to merge it as is.

> Good to see a new case for MAP_SHARED_VALIDATE.

> As this is the first test to cover the new flags argument, so I'm
> wondering can we add the functional verification to check if
> this works correctly for mapping a valid shared memory which
> equal to the behavior of MAP_SHARED?
> (or do this in a separate patch)
+1

> But anyway, I'd suggest you send a patch V2 for achieving all
> requested changes.

Li, if you don't mind, I'll merge "v2" I prepared [1] (part of
paulson/mmap.fixes branch in my fork). Can I add your Reviewed-by tag? As the
work is already done, I'd prefer to postpone the work you propose to separate
patch after.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/blob/36ebc4d8900ea8438dc7839f03b7921f0ed9243a/testcases/kernel/syscalls/mmap/mmap20.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
