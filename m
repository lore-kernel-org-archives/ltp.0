Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74099C678D5
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 11:10:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DCB83CD955
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 12:09:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 386E33CB828
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 12:09:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38A431A00783
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 12:09:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A09521A08
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678273785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5G4X4RiY0UQ2pXLHbUw7fvqPc0bf01K00Jm439PUENs=;
 b=rrY1P7E1Zp8Xfw9Wu4brQa7ThtIXuj91o55v6EpDO7yMDsOls46uVfMbOBWE3A3B/xMDcS
 kgcnFlH2CH2b5dToGWl8WJXNafRIyLsGvQyikfC7v8RooBzdFgRCWoIxJoDufbEvlLdUUy
 8kIq2HdIkhCaNTyQLPwxyHPGiMn3mCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678273785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5G4X4RiY0UQ2pXLHbUw7fvqPc0bf01K00Jm439PUENs=;
 b=drqgMVwAGtX1OtnjZ4QH9Tzl+mMU3Kjv6uQRqMeoinORViVJgzHh1A1jfR0n/iLb4Cqtxp
 N6ZvR/WRagdA3xCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED9611348D
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 11:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LSthNfhsCGR/dQAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 08 Mar 2023 11:09:44 +0000
Date: Wed, 8 Mar 2023 12:09:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230308110943.GA30945@pevik>
References: <20230308093219.27090-1-pvorel@suse.cz>
 <20230308093219.27090-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230308093219.27090-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] insmod01.sh: Skip test on enabled lockdown
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

> Lockdown patchset does not allow to install LTP kernel module:

> insmod: ERROR: could not insert module ltp_insmod01.ko: Operation not permitted
> insmod01 1 TFAIL: insmod failed

> Therefore skip the test on enabled lockdown.

> Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1208920

OK, this is probably our downstream issue in openSUSE.
And because insmod01.sh was the only one shell test which needed this,
even previous commit would not be used.
Thus marking whole patchset as rejected.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
