Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B543C79FBB
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9558C3E72DB
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 14:47:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2749B3D03B0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 14:47:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7FB3060086C
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 14:47:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D65EA219EF;
 Thu, 10 Sep 2026 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789044427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxYHMAKmfur2Kybfm7I1VCqjmJPa8ZyL+J8dhPicKjI=;
 b=DjF8wifMmYiWQL848r0m/7LTb5lAxghy/rdLbZ5dCh5sXGJMKsa5Os6esNmKTJrcRUazhh
 C2DBW+kf68OC0yNnO0WsDLZgpHC2L8WNWF+itxjV3giI+MPHwyJBxrwyMS6OYk2sigwpnh
 gA7r8EeCeUG2L3O2XGYZeqZ6t8UQ8VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789044427;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxYHMAKmfur2Kybfm7I1VCqjmJPa8ZyL+J8dhPicKjI=;
 b=x4dsBqUOOz+vMc2/aTmfomiThe2VqOX28Lx9RZVGcO914QTuAvltxpfNy8I9s6QEN9ShkD
 cVjatwoIFBzvXABQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789044422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxYHMAKmfur2Kybfm7I1VCqjmJPa8ZyL+J8dhPicKjI=;
 b=SZBF1bErU9UqUTNNA6MgkHTFN+TIrfKfHqTlCPRwxrbEnIsQ+xd8SgShavUizFPe4+SwIQ
 jtJzJq7RAd6MLUQW5PzoBNWh16YrQRBljoDe5yjXUNn4yaZLYm59D8W16SvYfjwqoomfBz
 WaJ9e17PGtWGO2x048I639UuoQtGKOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789044422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxYHMAKmfur2Kybfm7I1VCqjmJPa8ZyL+J8dhPicKjI=;
 b=xpvlx3vmLZ5HX1bUtmD0X4mldNpkfzsrY2CxomJaEwXVccKkDpj5k7AV6JJfCwxwddyYad
 42CqqrM+EzxhiTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4F6013180;
 Thu, 10 Sep 2026 12:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0+E8KMamomp/YwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Sep 2026 12:47:02 +0000
Date: Thu, 10 Sep 2026 14:47:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aqKmzG1kexhUuv1c@yuki.lan>
References: <aqKEqxlsRHagH-z-@yuki.lan>
 <6aa2911d.1f4fdde7.c7afd.7a6b@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aa2911d.1f4fdde7.c7afd.7a6b@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 3/3] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > +static void handle_note(uint32_t type, const void *desc, size_t descsz, pid_t pid)
> > > +{
> > > +	if (type == NT_PRPSINFO && descsz >= sizeof(struct elf_prpsinfo)) {
> > > +		struct elf_prpsinfo info;
> > > +
> > > +		memcpy(&info, desc, sizeof(info));
> > > +		TST_EXP_EQ_STR(info.pr_fname, "coredump02");
> > 
> > I still do not see a reason why this can't be:
> > 
> > 		struct elf_prpsinfo *info = desc;
> > 
> > 		TST_EXP_EQ_STR(info->pr_name, "coredump02");
> 
> because ELF notes in Linux are only 4-byte padded, desc pointers are not
> guaranteed to be 8-byte aligned. Casting desc to struct elf_prpsinfo *
> or struct elf_prstatus * creates a misaligned pointer, which is undefined
> behavior in C.

AFAIK the 4 byte padding may happen on x86_64 only for a historical
reasons and x86_64 is at the same time capable of handling unaligned
access. AArch64 should have 8 byte padding.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
