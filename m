Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1C9C6FA82
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 20:53:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A8F03CAC05
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 22:53:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 604193CABD0
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:53:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DCACD10009DA
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 22:53:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A20365CD8B;
 Wed, 14 Sep 2022 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663188779;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ego8ifQvVr4WW8+qQDC8GkzekHqiXnunMV91qT/3vHI=;
 b=cOPcxZNi1MuaD9tFFZEI8acCjZtXp9G28wBPXNhyYSQEedGQx5YGm5PxzZImhBCQtTpVvO
 48vcy/chcG3yYhwLaTvBzVHjHOaCdrck2vlqRGDl8rrNmrD7QC9gCZANiJ5YX+v3ylmoYp
 O5IIuctTPi6xjsQGuhVMB3cYp/0dths=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663188779;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ego8ifQvVr4WW8+qQDC8GkzekHqiXnunMV91qT/3vHI=;
 b=Wk6S7nNSUnXsKExg8IIsh4R49bTEiClpvw24goh/ByGxKIxPE+nZ1OcntBA1/bP723X0fp
 DsMX5XaSZThHkBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75B89134B3;
 Wed, 14 Sep 2022 20:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MnMfGys/ImPtMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Sep 2022 20:52:59 +0000
Date: Wed, 14 Sep 2022 22:52:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YyI/KU10+zSi7Fpj@pevik>
References: <20220720104430.8614-1-akumar@suse.de>
 <CAEemH2eCd43jRJmYgEB6RpACqcd3gXudSE4UM2p2SwsOjMgN7A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eCd43jRJmYgEB6RpACqcd3gXudSE4UM2p2SwsOjMgN7A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getitimer03.c: convert to new LTP API
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, Li,

> Hi Avinesh,

> Thank you for doing this. The code achievement is absolutely right but
> we can do something unify to better manage the error test in LTP.

> My suggestion is to combine this invalid-argument test into getitimer02.c
> by creating a structure that populates with arguments of getitimer(). Then
> we can traversal each item to complete all error tests for a syscall just
> in one testcase. (see madvise02.c)

Avinesh, do you plan to follow Li's suggestion (which makes sense) and send a
patch this week (e.g. before git freeze due LTP releasing process?)

Kind regards,
Petr

> e.g.

> static struct tcase {
>        int which;
>        struct itimerval *curr_value;
> } tcases[] = {
>        {},
> };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
