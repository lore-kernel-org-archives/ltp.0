Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3138C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 10:39:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3513C3C9280
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 11:39:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A8AD3C9255
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 11:39:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DABF31000D20
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 11:39:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 26F901F384;
 Wed, 22 Dec 2021 10:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640169554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8EDNcS9XsVvPDhWpJs5rnBpKaKAOnnjh8m96//gSH1k=;
 b=ED7NDFMQw1+SPBwxCNZOyM5QC8X/t/EOQ0a62/eOZESMg/P5D0YqKxsj4VbZ7RVwqdWAkl
 O4O1BVK91N34MhDJUkiNwk56sAqNx2+6MH6HhXX6Q4wYYCtlYpbGYRF8Z/gN+438jwZ4yR
 bHAnxbZl9AVHDtBycKftsR1p1KQO8YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640169554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8EDNcS9XsVvPDhWpJs5rnBpKaKAOnnjh8m96//gSH1k=;
 b=voxIKxexew8na2AgeXFyIiVQrECNyFpnngOzzkewFgIyDKa2XMTejmcWbD68zy8f9vfOld
 +HtHf9BVNBkquXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E24F813D02;
 Wed, 22 Dec 2021 10:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ygsPNlEAw2FlfQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Dec 2021 10:39:13 +0000
Date: Wed, 22 Dec 2021 11:40:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YcMArVLw7UbLT/wi@yuki>
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
 <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
 <61C2C02A.90104@fujitsu.com> <YcLeaPJmSvmUJwJO@pevik>
 <61C2E3DB.9070004@fujitsu.com>
 <CAEemH2dpLJ9N57TpMhW3wMkd-V0cZMPWyH_sXn6KjXoWJWUC4g@mail.gmail.com>
 <YcL5XG6azJuGTys7@yuki> <YcL82UGphHruor3+@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcL82UGphHruor3+@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> We use just FILE_PRINTF(), but we check the result and TWARN, which causes the
> failure in CI.

Which is why I argued that we should add a version that does not print
anything and just returns if the operation was successful or not. I
guess it could be called TRY_FILE_PRINTF() or something.

> I've sent v2, which checks CAP_SYS_ADMIN and CAP_SYS_RESOURCE,
> but feel free just to bring simpler solution.

I still think that the most acurate test would be just writing to the
file and checking the result.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
