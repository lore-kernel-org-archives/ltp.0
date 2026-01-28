Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C37D46C04
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 21:22:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39C5F3CBEC3
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 22:22:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C96B3CB493
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 22:22:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 037D16008FE
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 22:22:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72C6D5BD00;
 Wed, 28 Jan 2026 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769635330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iIX5vnOUau53fuIQN/jURmy8FBzjVAgFK4hj2pyyIw=;
 b=UF+rhhIsMvUk28wq4YFKXA0SEqkL1p5sAiyqxyaFox9SnImk0+2EJXTmUbNaNPLSUmmdyw
 zqg1jTVCDT5nzc+r9S03aKeyGW5bsvJDm9Bzw+5KLzhsbE1rY9BJS6Js/yG4KL6irCRCBo
 YdxdJx2w8vaT9ngUWjZhxT5kPR9wZnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769635330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iIX5vnOUau53fuIQN/jURmy8FBzjVAgFK4hj2pyyIw=;
 b=iJA5seZ6pEtgli6VX5nNyZSx6rpawlgtxeB1Kcf7A2k+UTFxPUadoAYik136HhznSqsSH1
 SKF9r+2f92WdrPAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769635330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iIX5vnOUau53fuIQN/jURmy8FBzjVAgFK4hj2pyyIw=;
 b=UF+rhhIsMvUk28wq4YFKXA0SEqkL1p5sAiyqxyaFox9SnImk0+2EJXTmUbNaNPLSUmmdyw
 zqg1jTVCDT5nzc+r9S03aKeyGW5bsvJDm9Bzw+5KLzhsbE1rY9BJS6Js/yG4KL6irCRCBo
 YdxdJx2w8vaT9ngUWjZhxT5kPR9wZnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769635330;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6iIX5vnOUau53fuIQN/jURmy8FBzjVAgFK4hj2pyyIw=;
 b=iJA5seZ6pEtgli6VX5nNyZSx6rpawlgtxeB1Kcf7A2k+UTFxPUadoAYik136HhznSqsSH1
 SKF9r+2f92WdrPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0766D3EA61;
 Wed, 28 Jan 2026 21:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NO99NwF+emkHCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 21:22:09 +0000
Date: Wed, 28 Jan 2026 22:22:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260128212207.GA60105@pevik>
References: <20260116022507.204549-1-liwang@redhat.com>
 <20260116022507.204549-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260116022507.204549-2-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] include/old: rename legacy headers to
 tso_* namespace
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

Hi Li, all,

> To clearly distinguish legacy header files from the core (tst_*) and
> extension (tse_*) LTP APIs, legacy header files have been grouped
> into the otst_* namespace.

> Some legacy header files do not begin with old_, they still belong
> to the legacy header file set. For clarity, all legacy header files
> are now uniformly grouped into the tso_* namespace.

>  include/old/{old_checkpoint.h => tso_checkpoint.h}
>  include/old/{ltp_cpuid.h => tso_cpuid.h}
>  include/old/{old_device.h => tso_device.h}
>  include/old/{tlibio.h => tso_lio.h}
>  include/old/{old_module.h => tso_module.h}
>  include/old/{ltp_priv.h => tso_priv.h}
>  include/old/{random_range.h => tso_random_range.h}
>  include/old/{old_resource.h => tso_resource.h}
>  include/old/{old_safe_file_ops.h => tso_safe_file_ops.h}
>  include/old/{safe_macros.h => tso_safe_macros.h}
>  include/old/{old_safe_net.h => tso_safe_net.h}
>  include/old/{old_safe_stdio.h => tso_safe_stdio.h}
>  include/old/{ltp_signal.h => tso_signal.h}
>  include/old/{old_tmpdir.h => tso_tmpdir.h}
>  include/old/{usctest.h => tso_usctest.h}

As I wrote, I don't like the whole rename but I will not block it.
I guess it will be merged after the release, just not to break anything.

But is it worth to rename whole old API sources and headers? Isn't it enough
just to know that 'tst_' or 'tse_' are new API, the rest is the old API or no
API? Each rename means that 'git log' requires '--' because the rename.

Anyway, IMHO it would help (as a separate effort after the release) to describe
the prefixes in doc.

Kind regards,
Petr

> No functional changes intended.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
