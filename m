Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AC4C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 09:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A7A33CB8DA
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 10:31:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E14743C03AE
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 10:31:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 019D2200DDF
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 10:31:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E56512297A;
 Fri, 10 Mar 2023 09:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678440678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edtTulrhRCrpH2RYKZMFGeD+aKi7C8Y5NHO5B8GzheE=;
 b=Awkb0lKe3HTqo9+NvKFGeOmgi3BU83/0GUJlcWu8MtBBDPMjMjqNhxuQEu+e08DgO8Ilnf
 ccK49ggq4Xd3Q17djFNfc0VkRlagItOfQFTFXKc4sJuUPYjOYsX9bhqWnGM66mKOESOe13
 whTUz3BY7R4m7Q1WTG+dOT5ZkX5J3HU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678440678;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=edtTulrhRCrpH2RYKZMFGeD+aKi7C8Y5NHO5B8GzheE=;
 b=pyPkfnsnTImzjp0VQBKg/2qP61cFQY3rVX0yqtfLmIMdLxhb75B8NwJMUHTQfF0QrI0/W+
 HnlKL6fI2/cnZgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABBA5134F7;
 Fri, 10 Mar 2023 09:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B1mpJ+b4CmTuPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 09:31:18 +0000
Date: Fri, 10 Mar 2023 10:31:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230310093117.GA8713@pevik>
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
 <CAEemH2fLFYu8=ZRBbu0xgmfYh4=XHJSu07R+4=-qX_1ESVza0w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fLFYu8=ZRBbu0xgmfYh4=XHJSu07R+4=-qX_1ESVza0w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: ltp@lists.linux.it, Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > I wonder if we can get this whole mess of two different fallback headers
> > simplified. Looking at the glibc implementation it seems to include
> > "linux/mount.h" if it does exist. So most reasonable solution would do
> > the same I guess which we did before the commit you reference.


> This is indeed correct if only face the latest Glibc, but that might have
> problems when building LTP on a middle version of Glibc/Kernel-headers.
> The bug I mentioned in the last email was fixed since glibc-2.37~426.
Do you know which exact commit has fixed it? It'd help us to realize when this
fix is not needed any more (it'd be good to put it into the commit message).

> @Fabrice, what kind of version of Glibc/Kernel-headers do you use? and
> which platform?

http://autobuild.buildroot.org/results/4dbb72e1bf081afd3cd944571b9beeefc7608865/config
arch: arm
# Buildroot 2023.02-rc1-22-ga39e328bb2 Configuration
=> 2.36-81-g4f4d7a13edfd2fdc57c9d76e1fd6d017fb47550c
kernel headers 5.10.
Specific Buildroot toolchain.

> Btw, this patch builds LTP successfully in CI:
>   - https://github.com/wangli5665/ltp/actions/runs/4380739470
Buildroot often founds problems for embedded folks, because they use different
toolchain than traditional linux distros.

> And I manually tried with fedora-rawhide/fedora34/35/37/38 all looks good.
Thanks for checking.

> Maybe we can just apply this patch to keep everything with no big changes.

> @Cyril, Petr, what do you think?
Unless there is a simple way to improve things, I'm for merging this.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
