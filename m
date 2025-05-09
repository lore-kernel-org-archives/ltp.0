Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D3DC3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 10:53:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A2923CC1F7
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 12:53:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3542E3CBAA2
 for <ltp@lists.linux.it>; Fri,  9 May 2025 12:53:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA8E71000611
 for <ltp@lists.linux.it>; Fri,  9 May 2025 12:53:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 170FE2115A;
 Fri,  9 May 2025 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746787981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukkCCeYsrqC6/cVgAkItGwgwLaUReX6HfiF/rZgbRuA=;
 b=jQ+p/dmOkW3SOX+NYwbmBJi/S4zo8TO7vn6re3zpuLLJENy3eqjy69ZRpxgE8xXxhRJMH1
 XhQt5WVejMgbUx3dL8dBw29i0jtCUuHJi9EW/sXFYQ6JCo2a8BM90pOr5C+RD5254Q+Yy5
 +XCil5hSmiHBSegl3Pzt+dvQoTjAvyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746787981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukkCCeYsrqC6/cVgAkItGwgwLaUReX6HfiF/rZgbRuA=;
 b=9lCx20hJOUVVjxRvP2fZ255623OXlcy8dD3s+PWrP8s8jxIvGWAHCexIyhdk3/acCwIjXc
 CQzj2D/smL8Os6Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746787981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukkCCeYsrqC6/cVgAkItGwgwLaUReX6HfiF/rZgbRuA=;
 b=jQ+p/dmOkW3SOX+NYwbmBJi/S4zo8TO7vn6re3zpuLLJENy3eqjy69ZRpxgE8xXxhRJMH1
 XhQt5WVejMgbUx3dL8dBw29i0jtCUuHJi9EW/sXFYQ6JCo2a8BM90pOr5C+RD5254Q+Yy5
 +XCil5hSmiHBSegl3Pzt+dvQoTjAvyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746787981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukkCCeYsrqC6/cVgAkItGwgwLaUReX6HfiF/rZgbRuA=;
 b=9lCx20hJOUVVjxRvP2fZ255623OXlcy8dD3s+PWrP8s8jxIvGWAHCexIyhdk3/acCwIjXc
 CQzj2D/smL8Os6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9A2E13931;
 Fri,  9 May 2025 10:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1MYvOIzeHWhaCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 May 2025 10:53:00 +0000
Date: Fri, 9 May 2025 12:52:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250509105259.GA238712@pevik>
References: <20250507154543.22309-1-mdoucha@suse.cz>
 <20250507175328.GA182617@pevik>
 <415deb45-88d0-4717-b062-925c394169b9@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <415deb45-88d0-4717-b062-925c394169b9@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap_24-1: Change vm.max_map_count if needed
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

> On 07. 05. 25 19:53, Petr Vorel wrote:
> > Hi Martin,

> > > If vm.max_map_count system parameter is too high, mmap24-1 may get
> > > killed by OOM. Set the parameter to a reasonable low value so that
> > > mmap() quickly fails as expected.

> > LGTM.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > The only thing which bothers me is that writing /proc/sys/vm/max_map_count
> > requires root. But I'm not sure if it's worth to add more code to check UID 0.

> We don't need a check, the test will simply fail to open the file and move
> on to the main test case. But I'll add an info message if that happens.

Testing without root with too high /proc/sys/vm/max_map_count will fail due not
able to lower down it. But sure, explaining message is IMHO good enough, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
