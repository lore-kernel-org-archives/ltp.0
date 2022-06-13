Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B1BCCA47F
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 13:46:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E84B53C9480
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:46:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3864E3C257E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 15:46:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 340C61A006F3
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 15:46:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F49121B2E;
 Mon, 13 Jun 2022 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655127974;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0jI4lvQntYU8y0yUFk7YX48jw7GxlrNRT6p69uLXF4=;
 b=LDxuuuDQJ6gzQiBttCgmSE769ljF+O+F0u+74UrHtHLS4uNl2z+5V9BNPJwdYjMLHxOnrA
 VFF0Aq3H5GAEWedoD3zRHrkFQ2sbXIQGeWGnsyNGLl7PCFAcqjXtZvbgdcyn49gKNEqNAk
 /9ifwwUOkaOwaJV5NO6qxxbNFj/jLDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655127974;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0jI4lvQntYU8y0yUFk7YX48jw7GxlrNRT6p69uLXF4=;
 b=1pjnIIRYiQ+jIPCUBFTnYj88vO+z0EslyZg9acxHtLEwyfPB5MrgWgSxGoDLwEWOolkRjb
 NelNRIUVJkdC4JBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ACCA134CF;
 Mon, 13 Jun 2022 13:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id doiYDKY/p2IjMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 13:46:14 +0000
Date: Mon, 13 Jun 2022 15:46:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: shatur.linux@gmail.com, ltp@lists.linux.it, sturlapati@vmware.com
Message-ID: <Yqc/pC5DsdyoGmqT@pevik>
References: <20220607221816.50955-1-sturlapati@vmware.com>
 <YqLZoyKV2Y8VDIya@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqLZoyKV2Y8VDIya@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] run-posix-option-group-test.sh: Log and exit if
 one attempts to run tests without compiling
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

Hi Sharan,

> > Currently, run-posix-option-group-test.sh erroneously
> > logs "***Tests Completed***" when no test has actually run if the script is invoked
> > to run without actually compiling the tests.

> > Check if the .run-test files actually exist before attempting to run them.
> > If not found, log a message indicating the problem and suggest to check if
> > the tests were compiled. Exit the script without attempting to run other
> > tests.
> Can you please describe how this happen? open POSIX failed to compile?

OK, you noted this in the commit message.

Merged with fixed bashism, improved style and commit message.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
