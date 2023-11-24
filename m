Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32E0C61DF4
	for <ltp@archiver.kernel.org>; Fri, 24 Nov 2023 08:32:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51E043CDE14
	for <ltp@archiver.kernel.org>; Fri, 24 Nov 2023 09:32:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC56B3C86DB
 for <ltp@lists.linux.it>; Fri, 24 Nov 2023 09:32:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 19593141CE80
 for <ltp@lists.linux.it>; Fri, 24 Nov 2023 09:32:27 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 830DE21AF7;
 Fri, 24 Nov 2023 08:32:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 62689132E2;
 Fri, 24 Nov 2023 08:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 29HVFptfYGWXQwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 24 Nov 2023 08:32:27 +0000
Date: Fri, 24 Nov 2023 09:32:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <20231124083225.GA107564@pevik>
References: <20231122211318.31358-1-pvorel@suse.cz>
 <20231123-okkupieren-vorurteil-3ae308cb8f73@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231123-okkupieren-vorurteil-3ae308cb8f73@brauner>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 830DE21AF7
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] diotest4: Skip test 3 and 14 for tmpfs
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
Cc: Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Christian,

> On Wed, Nov 22, 2023 at 10:13:18PM +0100, Petr Vorel wrote:
> > tmpfs in kernel v6.6 got support for O_DIRECT in e88e0d366f9c ("tmpfs:
> > trivial support for direct IO"). There is no reason for tmpfs to reject
> > direct IO of any size therefore follow the approach already used for
> > Btrfs, NFS and FUSE: skipping test 3 (odd count of read and write)
> > and 14 (read, write with non-aligned buffer).

> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---

> Looks good to me,
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks a lot for your ack. I'm sorry, already merged, but I was not able to
reply due planned mailserver outage.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
