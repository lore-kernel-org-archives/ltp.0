Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B1AEE3F2F
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 14:38:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B79B3CE69B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 16:38:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0DFD3CBF28
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:38:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5CA621A0239C
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 16:38:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91962218D6;
 Fri, 15 Sep 2023 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694788697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mb6lpSE1J7vgYd3qpShgj/4RHEDh2MUHnmWy4pJBHh8=;
 b=srHLsP0l/h/6XdRMnE1pPBFi+hQsCUt0rNrt2er+hXFTO1KnLDMqZVVKn5sV6NoXW+rsTB
 WdgGjWgKdzArI9WTAUqvWxioKdZLZjjQ4vtvEi7tNJwFEh6iNvjEIi4axS3BQU9mpKdDyx
 E+9JxxuktRY1YH9xHw4etNTCnFiCYSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694788697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mb6lpSE1J7vgYd3qpShgj/4RHEDh2MUHnmWy4pJBHh8=;
 b=1P7NkWltQJIITWJD69rVrFKBLWZadjqu5M7GDuB6ZNQ1Lf8yo3vwxDKZ/NrpbKpOP4EQfC
 u0+VEYhG/pAyedDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E62913251;
 Fri, 15 Sep 2023 14:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RhkMDVlsBGU3BAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 14:38:17 +0000
Date: Fri, 15 Sep 2023 16:38:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Martin Doucha <martin.doucha@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230915143815.GA23761@pevik>
References: <20230728132120.17322-1-pvorel@suse.cz>
 <CAEemH2fq1zGiB43uy34uAQYBSugNXryc1urEMvLWJ1=LvNP8ow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fq1zGiB43uy34uAQYBSugNXryc1urEMvLWJ1=LvNP8ow@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] shell: Add TST_SKIP_IN_{LOCKDOWN,
 SECUREBOOT}=1
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

thanks for your review, patchset merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
