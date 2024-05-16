Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8BAC25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:50:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B319A3C0B8E
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 16:50:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C12313C0B8E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 16:49:53 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 546711A02363
 for <ltp@lists.linux.it>; Thu, 16 May 2024 16:49:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75AA05C574;
 Thu, 16 May 2024 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715870991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyAUNcNiKDA0X7ymDTuAwMwwo6mXEVahJ7kPyDE0xuw=;
 b=dL3yKl76tpFlZhwulK7YCROlaBXp6qPvFXcPBNWaQVgi/Nn5f4XO2FhfuNko6YrGl5AQ1F
 IqvRwQF3ej22CfZa/2pKKaC2fizhMAJnfR2G1UFrxKI6RiYoqKNYljdSi8VRvDtpjk9Vkf
 LED1RAujttYm58lzP/UR26ioIn1Lti4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715870991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyAUNcNiKDA0X7ymDTuAwMwwo6mXEVahJ7kPyDE0xuw=;
 b=aTHfWx/V8k8XMA9naU51blo0JBfoQe/KurH8/ZdeSpIZj3wJvRfV+p7iTS5kwfGScRMUVO
 w5kg/+x2qB8kPsCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715870991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyAUNcNiKDA0X7ymDTuAwMwwo6mXEVahJ7kPyDE0xuw=;
 b=dL3yKl76tpFlZhwulK7YCROlaBXp6qPvFXcPBNWaQVgi/Nn5f4XO2FhfuNko6YrGl5AQ1F
 IqvRwQF3ej22CfZa/2pKKaC2fizhMAJnfR2G1UFrxKI6RiYoqKNYljdSi8VRvDtpjk9Vkf
 LED1RAujttYm58lzP/UR26ioIn1Lti4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715870991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyAUNcNiKDA0X7ymDTuAwMwwo6mXEVahJ7kPyDE0xuw=;
 b=aTHfWx/V8k8XMA9naU51blo0JBfoQe/KurH8/ZdeSpIZj3wJvRfV+p7iTS5kwfGScRMUVO
 w5kg/+x2qB8kPsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DE60137C3;
 Thu, 16 May 2024 14:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +dMEEg8dRmaLaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 14:49:51 +0000
Date: Thu, 16 May 2024 16:49:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240516144945.GB317330@pevik>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
 <20240515093349.7347-2-andrea.cervesato@suse.de>
 <20240516013048.GB260285@pevik>
 <d06e0e62-1827-4699-838d-8ae961ca2905@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d06e0e62-1827-4699-838d-8ae961ca2905@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 01/10] Add SAFE_STATX macro
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

> Hi,

> On 5/16/24 03:30, Petr Vorel wrote:
> > Hi Andrea,

> > could you please fix these?
> Sure

> > testcases/kernel/syscalls/statmount/statmount03.c: useless tag: format_device
> > testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount03.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount04.c: useless tag: format_device
> > testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount04.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount05.c: useless tag: format_device
> > testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount05.c: useless tag: needs_tmpdir
> > testcases/kernel/syscalls/statmount/statmount06.c: useless tag: format_device

> > > diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> > > index 8de8ef106..43ff50a33 100644
> > > --- a/include/tst_safe_macros.h
> > > +++ b/include/tst_safe_macros.h
> > > @@ -503,4 +503,11 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
> > >   #define SAFE_SSCANF(buffer, format, ...) \
> > >   	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
> > > +struct statx;
> > Could you please remove this? (unneeded)
> That's needed because in some distro statx is not defined before reaching
> that line causing build failure.

<sys/stat.h> are included in lapi/stat.h. I wonder if <linux/stat.h> would fail.

If the definition later works it should be fixable by including the needed
header in lapi/stat.h, right?

Could you post link to CI job which failed?

Kind regards,
Petr

> > With that, you might add for this patch in the next version:

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Kind regards,
> > Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
