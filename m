Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67648C61D85
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 08:43:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4EA53CDEC4
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 09:43:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4966E3CBB47
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 09:43:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9427D100B792
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 09:43:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A33C01F383;
 Thu, 23 Nov 2023 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700728990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPhF+ZY8CmROxAL8OpGp8zjImiT9SPDK6BJZcJcqK6Q=;
 b=Dl5a0Ucc2cGDaYz5sfrnHHZx/sqhNYp7A1wam895GKXAawewIAdNAnZV8Vc5J2noZ6ET+m
 Gfh47Zvyp75PDBou3CiulTYJTnC6sZY+Vg0GoTB2MPhdKC1jdb33pedcEfEaTryz+UO5Tm
 rx8ONWoaqFxzr7obXfhzCm6kBUJCCSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700728990;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aPhF+ZY8CmROxAL8OpGp8zjImiT9SPDK6BJZcJcqK6Q=;
 b=zsCm5zUEngs0mTUIg315e889+WpoE2EeAdBBx0ZhlOXzehjEgFMToGAgZ3BTHap1VoS6ed
 axc/73s9IhltMUDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7812A133B6;
 Thu, 23 Nov 2023 08:43:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xJvqG54QX2WiBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Nov 2023 08:43:10 +0000
Date: Thu, 23 Nov 2023 09:43:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Hugh Dickins <hughd@google.com>
Message-ID: <20231123084309.GA27166@pevik>
References: <20231122211318.31358-1-pvorel@suse.cz>
 <27f877cb-1135-dcd8-7a1a-4f1c1b8e6e87@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27f877cb-1135-dcd8-7a1a-4f1c1b8e6e87@google.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.19 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(2.99)[0.998];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, 22 Nov 2023, Petr Vorel wrote:

> > tmpfs in kernel v6.6 got support for O_DIRECT in e88e0d366f9c ("tmpfs:
> > trivial support for direct IO"). There is no reason for tmpfs to reject
> > direct IO of any size therefore follow the approach already used for
> > Btrfs, NFS and FUSE: skipping test 3 (odd count of read and write)
> > and 14 (read, write with non-aligned buffer).

> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Acked-by: Hugh Dickins <hughd@google.com>

> Great, thanks a lot. I've never minded tmpfs failing those LTP tests,
> but had never looked at them closely enough to notice that there is
> this established way to avoid the failures...

I was surprised as well, Jan Kara noticed.

> ... but hold on: I can't look at the LTP source at the moment,
> but records tell me that the two tests failing were dio04 and dio10,
> whereas you say test 3 and test 14 - please clarify or correct, thanks.

These 2 tests are both running diotest4.c, just with different block size:

$ git grep -e ^dio04 -e ^dio10 runtest/
runtest/dio:dio04 diotest4
runtest/dio:dio10 diotest4 -b 65536

NOTE: dio tests are currently being rewritten, but diotest4.c have not been done
yet. Thus the code is using legacy LTP API and needs cleanup.

Kind regards,
Petr

> > ---
> >  testcases/kernel/io/direct_io/diotest4.c | 2 ++
> >  1 file changed, 2 insertions(+)

> > diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
> > index 45c677b5b..ad00fa3e0 100644
> > --- a/testcases/kernel/io/direct_io/diotest4.c
> > +++ b/testcases/kernel/io/direct_io/diotest4.c
> > @@ -270,6 +270,7 @@ int main(int argc, char *argv[])
> >  	case TST_NFS_MAGIC:
> >  	case TST_BTRFS_MAGIC:
> >  	case TST_FUSE_MAGIC:
> > +	case TST_TMPFS_MAGIC:
> >  		tst_resm(TCONF, "%s supports odd count IO",
> >  			 tst_fs_type_name(fs_type));
> >  	break;
> > @@ -443,6 +444,7 @@ int main(int argc, char *argv[])
> >  	case TST_NFS_MAGIC:
> >  	case TST_BTRFS_MAGIC:
> >  	case TST_FUSE_MAGIC:
> > +	case TST_TMPFS_MAGIC:
> >  		tst_resm(TCONF, "%s supports non-aligned buffer",
> >  			 tst_fs_type_name(fs_type));
> >  	break;
> > -- 
> > 2.42.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
