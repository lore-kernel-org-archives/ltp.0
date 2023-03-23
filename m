Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5968C74A5B
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 16:25:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E60A83CE2F8
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 17:25:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 065AC3C0214
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:25:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50F81140004F
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:25:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64037337DC;
 Thu, 23 Mar 2023 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679588701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0b2NabCznqCTDTGwpf5zgOdKcBUs3ayAvL9LrE1I2Ck=;
 b=b/nP8R82ThflbQ4z1v19/a3CPIenZIeKpL38VEOQHc9Shidkyew3V94DibdhEtONHP3Y38
 DTWh6GDDuIa6eJ5o3OxoC0mTmTUfe39hSNU1rE0KHYcUIggzyLWOK8vMPN90qc9JxzHEwJ
 12Nc4l/YxBJACu+yAKI574HGTTK+st4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679588701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0b2NabCznqCTDTGwpf5zgOdKcBUs3ayAvL9LrE1I2Ck=;
 b=u82NuB+IDD2LeWyBd7KHM91HBqZllDVSnJZR0ND1q32IAS+FxPu5tUyKzdELHZocEIsmfT
 /kzEqX6kvVpt2TAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4259F132C2;
 Thu, 23 Mar 2023 16:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LNQ3Dl19HGQmRwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 16:25:01 +0000
Date: Thu, 23 Mar 2023 17:24:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Message-ID: <20230323162459.GA476022@pevik>
References: <20230323-override-unpriv-userns-sysctl-v1-1-0b62c71acd43@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323-override-unpriv-userns-sysctl-v1-1-0b62c71acd43@kernel.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] containers: override
 kernel.unprivileged_userns_clone sysctl where needed
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

Hi Seth,

> Some distros have a kernel.unprivileged_userns_clone which when disabled
> forbids users without CAP_SYS_ADMIN in the initial user namespace from
> creating new user namespaces. When disabled the containers user07 and
> user08 tests fail.

> Update these tests to ensure that when this sysctl is present it is set
> to allow unprivileged user namespace creation while the test is running.

Good catch, it's indeed a problem on Debian.

Reviewed-by: Petr Vorel Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel Petr Vorel <pvorel@suse.cz>

BTW it took me a while to find out /proc/sys/kernel/unprivileged_userns_clone is
Debian out of tree patch [1] (The funny note from 2013 "This is a short-term patch")
probably refused by upstream kernel (I've only found 3 years later one of Debian
kernel maintainers Ben Hutchings talking about it [2]).

Kind regards,
Petr

[1] https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/patches/debian/add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by-default.patch
[2] https://lore.kernel.org/lkml/1453510799.3734.153.camel@decadent.org.uk/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
