Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4AACEF15B
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:51:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE4943C19F3
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 13:51:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766223C14A2
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:51:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BBD4B60157A
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:51:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C20A821D01;
 Tue,  8 Oct 2024 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728388290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEmuvFoeNO22cnS9sqYYixRkFjNGIkJHBgcAFYiIX5k=;
 b=ui0jf0OcpRWYtevgDfM3/+jGkCXtBmLTG2teDgTOQ23AtKIIb8D0j0bZ0MECOJX6ShkJtG
 4oi1QCiduRmnOOIFPlsb5vWP7LiGJWXbj1SGXJPexEUK635L3ozFdC6X+loC+O3aBBsmLv
 ijgLbiCm5s95K0GVewsIH1skavmX1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728388290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEmuvFoeNO22cnS9sqYYixRkFjNGIkJHBgcAFYiIX5k=;
 b=bYc02l3PNTuUFpfGsGL2q9FLy6JgRuU4sp/SaWVKXboQOL7s2NnGFun1W33EfYk0pvcj6M
 /Q2F8Bt8Y9XeroDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ui0jf0Oc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bYc02l3P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728388290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEmuvFoeNO22cnS9sqYYixRkFjNGIkJHBgcAFYiIX5k=;
 b=ui0jf0OcpRWYtevgDfM3/+jGkCXtBmLTG2teDgTOQ23AtKIIb8D0j0bZ0MECOJX6ShkJtG
 4oi1QCiduRmnOOIFPlsb5vWP7LiGJWXbj1SGXJPexEUK635L3ozFdC6X+loC+O3aBBsmLv
 ijgLbiCm5s95K0GVewsIH1skavmX1Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728388290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEmuvFoeNO22cnS9sqYYixRkFjNGIkJHBgcAFYiIX5k=;
 b=bYc02l3PNTuUFpfGsGL2q9FLy6JgRuU4sp/SaWVKXboQOL7s2NnGFun1W33EfYk0pvcj6M
 /Q2F8Bt8Y9XeroDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2C4E1340C;
 Tue,  8 Oct 2024 11:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FICGKsIcBWeEaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Oct 2024 11:51:30 +0000
Date: Tue, 8 Oct 2024 13:50:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZwUchlGLpIWU9KgK@yuki.lan>
References: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
 <20241002-ioctl_ficlone01_fix-v3-2-7e077918dfd4@suse.com>
 <Zv_21V0x0Kv-ViJo@yuki.lan>
 <6b2ef410-f979-45e6-98db-22a0c6a5104c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b2ef410-f979-45e6-98db-22a0c6a5104c@suse.com>
X-Rspamd-Queue-Id: C20A821D01
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] Add minimum kernel requirement for FS setup
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
> >> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> >> index ee029b666..6b714c51c 100644
> >> --- a/testcases/lib/tst_run_shell.c
> >> +++ b/testcases/lib/tst_run_shell.c
> >> @@ -156,6 +156,7 @@ enum fs_ids {
> >>   	MKFS_VER,
> >>   	MNT_FLAGS,
> >>   	TYPE,
> >> +	FS_MIN_KVER,
> >>   };
> >>   
> >>   static ujson_obj_attr fs_attrs[] = {
> >> @@ -164,6 +165,7 @@ static ujson_obj_attr fs_attrs[] = {
> >>   	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
> >>   	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
> >>   	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
> >> +	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),
> > This is stil not sorted properly, the min_kver should go before the
> > mkfs_ver.
> >
> This is not clear to me. The objects are sorted mirroring the tst_fs 
> struct. Can you explain it better please?

This is a lookup table that has to be sorted by the string ID we are
looking up. Well technically the fs_ids enum has to be sorted so that
the string ids are sorted and the order of this array does not matter,
but it's easier to keep them both sorted alphabetically by the ID.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
