Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14159CCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 10:31:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF6B3CF749
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 11:31:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE6B33CF70F
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 11:31:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 449941A004AB
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 11:31:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C282C1F7E9;
 Wed, 12 Nov 2025 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762943485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZgrPn/HwVx6v8Kc5YCPEA0qveQCLAua03IDOQJC0SI=;
 b=Eyl1KtGAmnbitSjlzvk2UD4EGWmqHgORXvvLL36LG/ld6hEw9Yx0X9A9KklXW/QsVVmIol
 a1c/28FXwSJG3WRh2rHRPE9h8Pafh4u1u5nrrUTlGd2/TYk6KchNsVS8pZThCZAHgnAmBq
 wYTg5As8RDMD0Mq1iIB+ZyS09vXIiZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762943485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZgrPn/HwVx6v8Kc5YCPEA0qveQCLAua03IDOQJC0SI=;
 b=1rBnGWoIlHCrrUG2ddGdjgvg88vNe9uTwOftQ6YkKcltttDMVJY3LQfoHdi9CPMnef9zLg
 SwTLdMpVNZtfChBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EV+j5Kqe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GAuGV4A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762943484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZgrPn/HwVx6v8Kc5YCPEA0qveQCLAua03IDOQJC0SI=;
 b=EV+j5KqednIAPO5kbcEWIigubQUNDb7qa2CFTBeeu+O140SghET5zlQTVh3AdL01+PR5pd
 bO72CavsHXy3J/RcG3y+D549XLno0Y3Zo4PlPOCRZaZjYKT86lHnNzwoA8DFR3swVkVB3x
 LpHL0ZRnRSlN+Zxq++hZYgARvErIsHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762943484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rZgrPn/HwVx6v8Kc5YCPEA0qveQCLAua03IDOQJC0SI=;
 b=GAuGV4A0Plwl8Cli9qVxchATzrFHtk9SAZRr7cE1x9Jev63mGnjCdZApRfaW0GzxLoqquN
 hbgfKHQF96CG84AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A70E13EA61;
 Wed, 12 Nov 2025 10:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rdz0J/xhFGl/PwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Nov 2025 10:31:24 +0000
Date: Wed, 12 Nov 2025 11:32:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRRiLUyES4M5qjOm@yuki.lan>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-2-wegao@suse.com>
 <20251111120600.GA50277@pevik>
 <aRQuc47d3PpTczVB@autotest-wegao.qe.prg2.suse.org>
 <20251112092236.GA80114@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251112092236.GA80114@pevik>
X-Rspamd-Queue-Id: C282C1F7E9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_filesystems01.c: Add test for
 .filesystems
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
> > > > +static void do_test(void)
> > > > +{
> > > > +	long fs_type;
> > > > +
> > > > +	fs_type = tst_fs_type(MOUNT_POINT);
> > > > +
> > > > +	if (fs_type == TST_EXT234_MAGIC) {
> > > > +		TST_EXP_PASS((check_inode_size(128)));
> > > > +		TST_EXP_PASS((check_mkfs_size_opt(10240)));
> 
> > > very nit: I would personally add #define for 128 and 10240, but sure it's ok to
> > > keep it hardcoded on 2 places.
> > I thought also use #define but i found and can not replace it in
> > "mkfs_opts = (const char *const []){"-I", "128", "-b", "1024", NULL}",
> > so i keep hardcoded number here.
> 
> Thanks for info. Sure, no problem.
> 
> Cc Cyril in case it's worth to fix it in metaparse.c.

The metaparse tool does macro expansion, that shouldn't be a problem.

Also metaparse only scans testcases/ directory during the build. The
lib/ directory is not parsed at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
