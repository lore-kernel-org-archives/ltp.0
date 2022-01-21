Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E99C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:34:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A33843C9714
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:34:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BC9E3C9424
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:34:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01A731400512
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 11:34:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DFE5210E0;
 Fri, 21 Jan 2022 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642761281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JzfSGdzDFB9SW7FRLa7YXpamZQnQbAKaTXnl9sK4ps=;
 b=rdcJ31p6b9K0uIwpUuH0M4IwSpZT+KB/M36n3jnRxtxSPfkQGP5ZUxbgCHc1+NmJXYLIQu
 +C8hhF4btUuoWUx38YMY2IGsfwCS3WN7vdIJ+fgdpLnnb16aEAPuvqFxiy7u+OAYKd4eFp
 V6sqff9jUTayMswdNzGU85dvWW+vFac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642761281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JzfSGdzDFB9SW7FRLa7YXpamZQnQbAKaTXnl9sK4ps=;
 b=+PZwiN+xUPnrmIKpcwb1UKshUyT/XIryoUUOXzo4CULSTLp+rrZW6gkFfIRRYoO2nOZyOO
 33RaSOyA6hEHvFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E69E13C32;
 Fri, 21 Jan 2022 10:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j7PMAUGM6mG3cQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 10:34:41 +0000
Date: Fri, 21 Jan 2022 11:36:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YeqMqtK0BziwRuNm@yuki>
References: <20220121100604.1072-1-pvorel@suse.cz>
 <07fa4901-8384-bfb3-fcc8-eb408b120f5c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <07fa4901-8384-bfb3-fcc8-eb408b120f5c@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> SAFE_MUNMAP should be called always, even if *run_child == 0 (which happens if run() completed successfully).

This is actually if (run_child) not if (*run_child) and it fixes the
case where the test is skipped even before the run_child has been
mmaped.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
