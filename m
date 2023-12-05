Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE82DC4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 14:58:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1F833CF5B6
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 15:58:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78E793CC152
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:58:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8ABEF1007C8B
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 15:58:39 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AE9022067;
 Tue,  5 Dec 2023 14:58:38 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A0D0138FF;
 Tue,  5 Dec 2023 14:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id /ytAC506b2UEEgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Dec 2023 14:58:37 +0000
Date: Tue, 5 Dec 2023 15:58:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231205145834.GA96988@pevik>
References: <20231204184817.3570465-1-shr@devkernel.io>
 <20231204184817.3570465-3-shr@devkernel.io> <ZW8DVo6UfSofc9WP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZW8DVo6UfSofc9WP@yuki>
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 7AE9022067
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] add ksm test for smart-scan feature
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
Cc: david@redhat.com, Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
 oliver.sang@intel.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> > +
> > +	while (waitpid(-1, &status, 0) > 0)
> > +		if (WEXITSTATUS(status) != 0)
> > +			tst_res(TFAIL, "child exit status is %d",
> > +					WEXITSTATUS(status));

> Does the test fork a child? I do not see any place in the code that
> would do so, did I miss something?

Ah, I also pointed out this is useless, but forget to point out that
.forks_child = 1 should be also removed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
