Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42ABC77B78
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 09:19:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A75A93CBB47
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 11:19:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA7CA3C9ADC
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:19:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 766A620098C
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 11:19:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B7D4219F8
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682500756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=S1cvmL+gmoRaOOBd9v73QapWKQgtKlA6SVdM4VKLkYE=;
 b=PNunyOJT6LJU/DCAS8t6gNtCEfk+2EC4uXwmVOYETQnQ38OAw+V2OV/pzGpnvkEy/1Eyls
 3WfNnFQgBjCrigx3XT2B+nnIz55CyOvZw3XoOC6PPZMkXX6/utUeKxI5ByPj0W3FSzCZ6d
 nkmKDUwb/MX2EL5otz2KJ4ruFRdZZgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682500756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=S1cvmL+gmoRaOOBd9v73QapWKQgtKlA6SVdM4VKLkYE=;
 b=pLPrPIX27+DSdyf+OuLqUpTUgrDVeFcu3UI/0VHrB0b5UQFNfv6fXsYmV4qbEplOmXYE7s
 dEEvwzhZ6I0HJ8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37356138F0
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PhIWCpTsSGSPNQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 09:19:16 +0000
Date: Wed, 26 Apr 2023 11:17:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <ZEjsKC6ESB1+mM0H@rei>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I would like to start with LTP pre-release preparations a bit sooner
than usuall, since quite a lot of things have accumulated in May, e.g.
there is a SUSE Labs conference right in the middle of the month.

I would like to start with reviewe of patches that should go in now,
freeze the git somewhere at the end of the first week of May and aim for
a release somewhere in the middle of the month. Does that sound Ok to
everyone?

Either way if you have patches that should land in the upcomming
release, please point them out now, so that we have a chance to review
them.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
