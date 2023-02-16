Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE89C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:48:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1CD43CBEE2
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:47:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E323CB073
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:47:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8525F10008FD
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:47:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CD23209BE;
 Thu, 16 Feb 2023 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676544464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFkzjsrOk74VzrQ9KA7QN6dsFQFxP3nOuRyW3v9DhrU=;
 b=LWIMYLnYRiChceIIfTKc09j6X2RwgIAuq7bMtffh/3k4qgt1DIcXIuBrfeOWfj6nNd022i
 Iktd9A29D1NUFDul52n+wlNmLjQzEy+vUf9l7K9YlBvfzS5k8DCiuwyz83IqlhK2azLRXW
 vV3JXDvCedfSPVetbR3qKsoHoihQnxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676544464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jFkzjsrOk74VzrQ9KA7QN6dsFQFxP3nOuRyW3v9DhrU=;
 b=rJDyy5/qW+kT6S4nQZ01Z3SDRs3n1q1nixEGcV9OQ3yqGyWeAFMnbJenppT+y32iqzS/n3
 zkOFjtNgbKuPYrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39DBF13484;
 Thu, 16 Feb 2023 10:47:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wc/cDNAJ7mMzTAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 16 Feb 2023 10:47:44 +0000
Date: Thu, 16 Feb 2023 11:49:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrei Gherzan <andrei.gherzan@canonical.com>
Message-ID: <Y+4KJ3tgxRiIr7JN@yuki>
References: <Y+zcqqNE01cNcm1Y@qwirkle> <Y+38qMc2Kdh2DPA7@yuki>
 <Y+4GEbRopmw5QA5r@qwirkle>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+4GEbRopmw5QA5r@qwirkle>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP fs_fill test on vfat - ENOSPC
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
> I did consider this as well, but I haven't proposed it initially because
> I didn't want to come with a solution that will switch all tests to
> Fat32. This is a limitation for tests that create a large enough number
> of directories in the root of the filesystem, so I wanted to keep the
> scope there.
> 
> I have tested, and we will locally go with my proposed 3rd option for
> now. Does that sound resonable for a push to upstrem too? 

Sure, this sounds reasonable as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
