Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7DDC433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 14:28:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03CDE3CA93A
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 16:28:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2EBA3C9586
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 16:28:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DCC9A1A00932
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 16:28:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7E791F88E;
 Fri, 30 Sep 2022 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664548079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKtEfS670SnchJQ8rcoXunpOjyHBD4Dd72i1ZRP2GmA=;
 b=mfaB4txy+ADTA3c12nK1Jzb1Y1hHtIsMW2y0ktomDFVof43xUaoiDThiqaOX5RKXwH2YSt
 7BFC1LGvgG+mXwIs93NXDo1Pq+U1LVSEx/weAO2ML6GvSv98AdsBpp52IuENfeORov0rut
 qweasl645y0oaHAM+akI8FUHpVJ0csI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664548079;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKtEfS670SnchJQ8rcoXunpOjyHBD4Dd72i1ZRP2GmA=;
 b=5otOAgyzEQhEmXL+G+seutwW/kL4ioZtG/26hZP4qEgm/J1LAMIFFcad7ahDsnvtxXuvOE
 IfTsK92J6rMvydAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59D5913677;
 Fri, 30 Sep 2022 14:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Kq1ZD+/8NmOtWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 14:27:59 +0000
Date: Fri, 30 Sep 2022 16:27:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yzb87NdckmwzQiWN@pevik>
References: <20220930112434.13038-1-pvorel@suse.cz> <YzbV5JFPNNoVmqth@yuki>
 <YzbbgS6O0vBPUXbp@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YzbbgS6O0vBPUXbp@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Fix missing cleanup run from
 setup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> > But we should at least re-run all shell tests to make sure that this
> > does not break anything. I would vote for this to go in before the
> > release but after you did enough testing.

> I'm testing with these 2 patches (this and zram01.sh) in my fork:
> https://github.com/pevik/ltp/commits/ltp-202209.2022-09-30.pre-release

> I rerun whole LTP tests on 3 SLES versions, most of the shell tests on
> Tumbleweed, I'll also try some shell tests on some Debian version.
> Also CI passed (which runs make test-shell), + I run make test-shell manually
> (covers more than CI), but that's not that relevant as we don't cover much.

Tests results looks ok, looked into the output (not just the exit code),
thus I merged this. This should be the last commit, we can tag the release and
the rest of the release process.

Kind regards,
Petr

> > And also it would be better if anyone else had a look.
> That'd be great, but not sure if anybody jumps in.

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
