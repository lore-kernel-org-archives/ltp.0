Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37E6C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4393CAB98
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 10:38:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3043E3CAA8E
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:38:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 899B5600C60
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 10:38:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDDC734998;
 Tue, 13 Sep 2022 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663058280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iniaS+yETXmGRbGOxnW8SdeFJmRLhOvB6cSBPFNNXSA=;
 b=ylei4zPzUwDXUZDl6cPnH431SkjmsqDqB1fVghJ1ArnX5OcEk+o1gLvuaGcRySdqq5RZtV
 mqzCyYdcrZmSMaYJBiu0lxgkt5eDbzegUxSCFEcq7jo4VNsXrIjT6hbZpQF2D5arQlq9PC
 BEh77Pq0hRPDlu5oneQxjJJkcch0s/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663058280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iniaS+yETXmGRbGOxnW8SdeFJmRLhOvB6cSBPFNNXSA=;
 b=pUG6xBzlaHFY15Ev6i2KwoIIrkOLPnb4xNMJbX0Q58YVSv1TqF++/O4ZAuUAiWoUrMwaD0
 /Za45qq0qv4tutCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40715139B3;
 Tue, 13 Sep 2022 08:38:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OodLB2hBIGOGHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 08:38:00 +0000
Date: Tue, 13 Sep 2022 10:37:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyBBZSRXHdOG4shY@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-8-pvorel@suse.cz> <Yx9QFWuRMjDUAafp@yuki>
 <Yx+Q0+fUokI7jlhT@pevik> <YyA8JQXmeTBQVbgY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyA8JQXmeTBQVbgY@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 07/10] tst_test.sh: Introduce TST_FS_TYPE_FUSE
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > Also maybe it would be a better as a function so that the code does not
> > > run unconditionally on each tst_mount() call?
> > Do you mean e.g. tst_is_fuse() and df01.sh would call it?

> Yes that looks slightly cleaner than adding another variable.
OK, I'll fix it in v7. I put it into tst_test.sh, but if you prefer to have this
function just in df01.sh (called as is_fuse) until anything else needs it that
would work for me as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
