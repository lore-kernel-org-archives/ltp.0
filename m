Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7946DECAAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 12:58:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 557E43CACCD
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 14:58:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 077A63CAAF4
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 14:57:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 407F2600642
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 14:57:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C07251F8CD;
 Mon, 19 Sep 2022 12:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663592273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Glz6guizUgbBVN0UNOdg0oYNTze/OGKhc5lnn+P5fL0=;
 b=WcAg2Sy1CKOiqyx5RSDxYNIZFhu3mniSPBOxAx8zRpEnNvaTwaiPlj4cOhnuEGGPCKil7D
 fRsxuH3z7xRaBlMbCM2NnHczRlYFuHiEpUpiqif7XZerNugaePbckVc4jk9FCpPacWG0QP
 wdRkpjU/kPJ2eW41kXv+OH0QKNTw4ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663592273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Glz6guizUgbBVN0UNOdg0oYNTze/OGKhc5lnn+P5fL0=;
 b=fOoOurHDRwEsfs/A0Y60c5ktjNoYj4OQZzApMI8U7fRvjREM31YMgB/IgNzDCDu7lzkmEs
 GuZ4I7RbJiKGTVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 971BB13A96;
 Mon, 19 Sep 2022 12:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lWH9IlFnKGO6NwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Sep 2022 12:57:53 +0000
Date: Mon, 19 Sep 2022 14:57:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyhnTtDE5Mh3w04k@pevik>
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
 <207b6fed-27df-6d1d-113c-6f9c771cabe5@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <207b6fed-27df-6d1d-113c-6f9c771cabe5@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Cc: Martin Doucha <martin.doucha@suse.com>, lkft@linaro.org,
 lkft-triage@lists.linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 19. 09. 22 5:13, Petr Vorel wrote:
> > Hi all,

> > > ## Build
> > > * kernel: 5.18.19
> > > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > > * git branch: linux-5.18.y
> > > * git commit: 22a992953741ad79c07890d3f4104585e52ef26b
> > > * git describe: cea142b
FYI talking below about this line.

> > > * test details: https://qa-reports.linaro.org/lkft/ltp/build/cea142b

> > > ## Test Regressions (compared to 98140f3)
> > > * qemu_i386, ltp-controllers
> > >    - cpuacct_100_100

> > > * qemu_x86_64, ltp-cve
> > >    - cve-2018-1000204
> > OK, 3252ea38d ("ioctl_sg01: Add max_runtime") didn't help.

> > looking at the log [1] I don't see anything obvious why test timeouts:

> > tst_test.c:1524: TINFO: Timeout per run is 0h 00m 30s

> I do. The line above is supposed to say "Timeout per run is 1h 00m 30s"
> instead. Whatever LTP version this was, it did not have the ioctl_sg01
> max_runtime patch applied.

Hi Martin,

thanks for info. I expected the line above document LTP version, i.e.
cea142b73 ("df01.sh: Convert to TST_ALL_FILESYSTEMS=1")
which contains .max_runtime = 3600 (i.e. 1 hour runtime + 30 sec for basic
cleanup). Although "git describe" could mean any git repository.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
