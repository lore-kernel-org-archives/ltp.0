Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB60C433EF
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 12:59:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5A93CAC43
	for <ltp@archiver.kernel.org>; Tue, 24 May 2022 14:59:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 051913CAC04
 for <ltp@lists.linux.it>; Tue, 24 May 2022 14:59:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B8CD1400DC7
 for <ltp@lists.linux.it>; Tue, 24 May 2022 14:59:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 586C91F921
 for <ltp@lists.linux.it>; Tue, 24 May 2022 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653397147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCzkFaT6R21bQzI1FNl7JAgJ3RwIH1K1uk5Cvx/nzT8=;
 b=QAhQlXrzpCirVaykQgxLAHak4qIVcUmVl1cckGqcHUA8GYIHaEKHffDfsSU5DK62lSeT7I
 z73YZZ7QTV5WpZWkbiuvQm7+TjSu0Rhrc1+xDONixbSHNvtzs6tuSBHNpDUwKRWfO5T2z2
 FaQNpQzEygDP+fGZ4Nc40kTeur6p2L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653397147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCzkFaT6R21bQzI1FNl7JAgJ3RwIH1K1uk5Cvx/nzT8=;
 b=NxQ+wGDesXTKlni4fELMOidRf5JR3uMNcTQPYwDHi/ik7mNBhopSU/jL8vSXDW0CJyAVQe
 aKVjRsAGqMkc61Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F23F13AE3
 for <ltp@lists.linux.it>; Tue, 24 May 2022 12:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HtoxDZvWjGKWagAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 24 May 2022 12:59:07 +0000
Date: Tue, 24 May 2022 15:01:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YozXG/f0HHSrhm9E@yuki>
References: <YnkOEruIKIwEeC3M@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnkOEruIKIwEeC3M@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
I've finally pushed the runtest patchset, many thanks for reviews
especially Li for his careful review and tests.

Other than that I will have a look at the KVM documentation by Martin,
since it would be nice to include documentation for the newly added
library and as this is not a code change it will be safe for the
release.

With that I would like to release at the end of the week, which gives us
chance to re-test with the runtime patches on the top. I will run a few
testruns myself just to make sure that everything is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
