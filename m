Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1DDC77B75
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 16:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C59D83CB6C4
	for <ltp@archiver.kernel.org>; Fri,  5 May 2023 18:55:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13F743CB670
 for <ltp@lists.linux.it>; Fri,  5 May 2023 18:55:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36F161000F59
 for <ltp@lists.linux.it>; Fri,  5 May 2023 18:55:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 694AE2030D;
 Fri,  5 May 2023 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683305735;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTSvR04rp3lhjzD5m+Qx3VocunQARal/B80lfvobqYw=;
 b=zEIuk7CeV5TLg7+7kT2pfm2F5Ko3QHDqmPSvgT68kSMGchTW4kP2VUp3qhNYyXqI3h/qIA
 Gf4jInef///uHkOkKjELDOf362gYOFVAliZ2t6AAWuR6/BK8ToY6MepFUfGn0TH6nZfVT5
 7T+gCn5EJWl9k/y5XiTcCbKB94Cy2pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683305735;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TTSvR04rp3lhjzD5m+Qx3VocunQARal/B80lfvobqYw=;
 b=vkR4mW36Qa3LBQrXE/CDBfFN4RpFIM3oY3exY63qd2JOYCXcre5Wf2mjriFIQ6UTmvFL9V
 VMJ2qseWuXhBDHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15E7613513;
 Fri,  5 May 2023 16:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zRGiAgc1VWQ/NgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 May 2023 16:55:35 +0000
Date: Fri, 5 May 2023 18:55:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
 Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230505165533.GA26135@pevik>
References: <ZEjsKC6ESB1+mM0H@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZEjsKC6ESB1+mM0H@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I suggest to merge these:

* Martin's patchset (first and second commit; the third one I dared to merge as
it's just doc fix)
https://patchwork.ozlabs.org/project/ltp/patch/20230505145626.2537-1-mdoucha@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20230505145626.2537-2-mdoucha@suse.cz/

* endian_switch01: Add HAVE_GETAUXVAL guarder
https://patchwork.ozlabs.org/project/ltp/patch/20230505162822.15676-1-pvorel@suse.cz/
Build fix for uclibc toolchains (Jan already acked that)

I'd also consider merging these 2 fixes:

* [v2] syscalls/sockioctl: Make buf a struct ifreq array
https://patchwork.ozlabs.org/project/ltp/patch/20230327110234.266785-1-teo.coupriediaz@arm.com/

* testcases:Fix the failure of shell script to get path
https://patchwork.ozlabs.org/project/ltp/patch/6b2a7ceb.4466.1874a537430.Coremail.crawler2015@163.com/

Kind regards,
Petr

> Hi!
> I would like to start with LTP pre-release preparations a bit sooner
> than usuall, since quite a lot of things have accumulated in May, e.g.
> there is a SUSE Labs conference right in the middle of the month.

> I would like to start with reviewe of patches that should go in now,
> freeze the git somewhere at the end of the first week of May and aim for
> a release somewhere in the middle of the month. Does that sound Ok to
> everyone?

> Either way if you have patches that should land in the upcomming
> release, please point them out now, so that we have a chance to review
> them.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
