Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6C2C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 12:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B200B3D0997
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:12:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 659763D08C8
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 14:11:47 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A4E014098CD
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 14:11:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC9EE21A73;
 Wed,  5 Jun 2024 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717589504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2W5lOpxaDY9OG9/8JZNLx0cUbgedK/b+uOsYpcr18I=;
 b=exK1eAP4BVfZposFVMsbs/7arjDjJ+tn6IropdBeolXEBrZPhGzwXV32VCKCU8/Eo99f+g
 vT0NhCtzg5kcX7NTU5zEz71FW1WnO90UNTCJxd71CoOFqqg8G/IZWf7PruOr5N0XC+Ml4m
 Y6bHAMkZpcX76j3MBbA+C+IsUH5LOd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717589504;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2W5lOpxaDY9OG9/8JZNLx0cUbgedK/b+uOsYpcr18I=;
 b=3pr/zgscI4DslOcFahERDKMp9yJ0eDIJhDOmBhGBTTlHRGMPju3Bv+Pf01eCHPusMIlIjw
 WFe2XN/nn0ySFfCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717589503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2W5lOpxaDY9OG9/8JZNLx0cUbgedK/b+uOsYpcr18I=;
 b=f1vvYrg7OPwCaUew0y7QW0iso/+G3OPMW6HGYsikTp3Eaw090vVRzHCAVt2tdiaSGtlFxO
 h3Ojfk4kvFi+MItxhYZt9LG+5ogVooz/ciVPllI3Sr+9qoryzqSuvjw0LkCiiIsWkJQDL7
 5RCm1HWuWydiGtXPG6BQYEtKaFCEtYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717589503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2W5lOpxaDY9OG9/8JZNLx0cUbgedK/b+uOsYpcr18I=;
 b=eKRfl50RP+GVER6J4LCw1jLe++MGzCkZe1tkpJ4QPV8VLcjtWNYUaGAvAOqmer2oyfSvSx
 JpqoopfpqeD37bAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C8A013A24;
 Wed,  5 Jun 2024 12:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6aUpIf9VYGYdBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 12:11:43 +0000
Date: Wed, 5 Jun 2024 14:11:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240605121142.GA387399@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik> <20240605073806.GA355314@pevik>
 <8aef8014-e4ea-407d-9b88-423449612665@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8aef8014-e4ea-407d-9b88-423449612665@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> On 05. 06. 24 9:38, Petr Vorel wrote:
> > BTW shouldn't this test use .all_filesystems = 1 ? Or is it unlink() really VFS
> > only code? I see some specific functions in fs/*/, e.g. btrfs_unlink() or
> > ext4_unlink(), which are used for struct inode_operations unlink member.
> > Then, obviously also Andrea's check would be needed (otherwise is unlikely that
> > somebody would have TMPDIR on vfat or exfat).

> AFAICT, .all_filesystems and .needs_rofs are mutually exclusive at the
> moment.

Good point, I completely overlook .needs_rofs. That makes things clearer.

ATM we have 3 other tests in syscalls/unlink. Not sure if all are filesystem
specific (I would say yes, but not sure), but at least unlink05.c (tests
deleting with unlink()) should be tested .all_filesystems. unlink07.c and
unlink08.c test errno.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
