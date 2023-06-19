Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0101EB64D9
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 16:25:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 787E03CE206
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 18:25:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01E3C3CAB6C
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 18:25:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04E611A001FE
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 18:25:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E27911F45A;
 Mon, 19 Jun 2023 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687191900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LT7UmizP8056dwVVCz3st5ejeJyJrOumS+TjLx9cErA=;
 b=kAqbht8SAkYZib5xPF/wXH0xpUd5md5OLBUo7D0CZZFDpkV+1lekbZx33VPBlOC3Id1dZd
 IeQR4BvScvqEboGlHtQdtfFgvXukg4qXSKUH+KK3HHwcL1vXAdxeVl/oLm0MVpywTyUH7H
 Q9aBwMUY5J7INB5p0vqDsoUJbBPWi7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687191900;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LT7UmizP8056dwVVCz3st5ejeJyJrOumS+TjLx9cErA=;
 b=WpxXPs+2kciQWYRBAsRoSTomofXSZfOQnBfwr4/iF0H5M+v0RCk8tdln4yMn8Khi1spf1U
 tmrmqPp4ZdyiN1Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABFFB138E8;
 Mon, 19 Jun 2023 16:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sqEMKFyBkGQ4WgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Jun 2023 16:25:00 +0000
Date: Mon, 19 Jun 2023 18:24:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230619162459.GA226373@pevik>
References: <20230619113530.136332-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230619113530.136332-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci/debian.sh: Install docbook2x
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

> asciidoc-dblatex dependency is no longer enough for Debian 11 bullseye
> (the new Debian oldstable), generating html with asciidoc otherwise fails:

Well, this does not help. Obviously asciidoc 9.0.0~rc2-1 on bullseye requires
network connection to download
http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl (likely
this was not needed on 8.6.10-3 from buster).

The problem is with somehow special network setup on
github actions containers (e.g. ping -c1 8.8.8.8 does not work).

I tried to generate pdf with asciidoc on all our CI [1] and the only broken is
Debian bullseye (oldstable). (Well, on some very old distros e.g. CentOS 7 it's
is a2x < 9, thus generation is disabled). I'm don't want to invest energy to
find what is wrong with asciidoc on oldstable, thus I'll send a patch which skip
asciidoc testing on it.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/actions/runs/5313212040

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
