Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0810C54EBC
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 16:14:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 609F23CCB4F
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 17:14:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1D7D3C949E
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 17:14:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 317BA600845
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 17:14:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 015E36AAB1;
 Tue, 10 Jan 2023 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673367257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzwykhkrP4pnoPHB1AdJSFCMIy6fCFKN2TwLmYRDRsE=;
 b=o+tPBe2pX9cSbCtwPHpygQxLYxwNWbCIbRDiRKeQ/gqXd8Q1ELfE6Rvy9/adPqIPM1/Qm6
 QRQiP0+opYDhUBCaF5jjKC8xd0GZKPqgFf0aZGMwdgaytQ5lpmfmWbD6SgK+fqnxIwN16M
 XOGwxYXESMhzokgGVf1Ftk2Zg56rxIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673367257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzwykhkrP4pnoPHB1AdJSFCMIy6fCFKN2TwLmYRDRsE=;
 b=sYuK0OjnKYOFe8c5baCI01xal6bSns1v9nJsEESImZ4YC89qfFjk9OLCKIbvAxO1DM4GgF
 Neop3WJwG7yGYGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BDD013338;
 Tue, 10 Jan 2023 16:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xMTiHdiOvWMsHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 Jan 2023 16:14:16 +0000
Date: Tue, 10 Jan 2023 17:14:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y72O1pYaHt6u1FvN@pevik>
References: <20230103124505.6611-1-pvorel@suse.cz>
 <20230103124505.6611-2-pvorel@suse.cz> <87lemaivkv.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87lemaivkv.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] configure.ac: Update AC_PROG_AR related
 comment
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
Cc: Mike Frysinger <vapier@gentoo.org>, Zack Weinberg <zackw@panix.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

thanks for your review.

> >  AC_PROG_CC
> > -# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
> > -# 2.62.
> > +# autoconf >= v2.72a

> This reads like we need the def for autoconf => v2.72a. How about
You're right.  I probably thought this is defined since v2.72a,
thus not needed.

> # for autoconfig < v2.72a
This is much better, I'll merge it as this (unless anybody objects).

> Also which distro(s) do we support which have < v2.72a? We maybe can
> include that here *if known*.

I'm not sure if v2.72a (alpha?) is shipped to any distro. v2.72 haven't been
released yet.

The reason to update the comment was
1) don't confuse with very old version (it's still needed)
2) notify users once v2.72 is released and shipped in case of problems.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
