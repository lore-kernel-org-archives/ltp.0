Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C981BECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:56:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A41C3CAA78
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:56:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF37B3CA598
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:56:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B75A2001B3
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:56:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB9291F88D;
 Fri,  9 Sep 2022 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662735371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sil+gpnkRgV2QQ1qsee5doSI8frWcgOPzK91+SG4fFY=;
 b=ze4jd4AQx4e0yjb7jMWDhbvJRjCQwPxpbeXQvhmFE8dKJkvWyO8nt+Ev7CMXOpRznw3VNx
 Jjj03CIcQl0hGpp1L1OZYxsJOPLxxFCp4HM8faVBI505egWoktCCKP9VmjqvbkY2goDSkm
 vFzLtzZraG8FpKpDunnFbh8a00a+0fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662735371;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sil+gpnkRgV2QQ1qsee5doSI8frWcgOPzK91+SG4fFY=;
 b=5DNRy82pjRbVP+IIV8NFjzN973k2ll7mtM2yq8qNTHVgsIOgriyhvI0rEnWmd06l9lJxdr
 CgqrrL1Jj8hg9FCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFA5C139D5;
 Fri,  9 Sep 2022 14:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XsBoLQtUG2OoZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:56:11 +0000
Date: Fri, 9 Sep 2022 16:56:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YxtUCgHYWD1bqRTe@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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

Hi all,

FYI in minor fanotify cleanup I just wait to get acked TST_EXP_FD_ERRNO [1]
It might be usable only in fanotify, but I'd keep it in tst_test_macros.h
Sooner or later it will be usable by other tests.
I'm also not sure about the name.

If you like this idea, in the future we might
add more TST_EXP_*_ERRNO(SCALL, ERRNO, ...) macros, i.e. calling TST_EXP_FAIL or TST_EXP_PASS
(thus name could be TST_EXP_PASS_FAIL).

I wanted to add some documentation for tst_test_macros.h but that will happen
after the release.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220906092615.15116-2-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
