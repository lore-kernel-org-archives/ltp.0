Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF1FD2D79
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6473E57EF
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 14:22:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D45EE3E1420
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:22:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B4536006FA
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:22:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B69455BCD5;
 Tue, 10 Mar 2026 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773148948;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YDJtZGkzWumaxSA72AZSTq/6aMwiWwZQbbcAFHSvgc=;
 b=BrXqknQ3ZzrhG4yot9JWGyaOjyR+1mP9gMgapOSiOaV1eHGfk2S8uxZVMeQzxod7T4PKdN
 kbPQKOhKW7ODWs/8Q5HxurnYgYtnnJW/qQMZy3CFBScUgSHISnGImxofYW/dQwgLOhvOZM
 mFgRMYZlP9dap9UuFvuIO7UAbLS8sOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773148948;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YDJtZGkzWumaxSA72AZSTq/6aMwiWwZQbbcAFHSvgc=;
 b=KatcO/cBHESkW8tim3PMCJxH0D8QUfFpw+WXkE0UJyVCL+WK0cW9SOOUTb10VLgRjXIehV
 0hlf3iG7slVj4xBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773148948;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YDJtZGkzWumaxSA72AZSTq/6aMwiWwZQbbcAFHSvgc=;
 b=BrXqknQ3ZzrhG4yot9JWGyaOjyR+1mP9gMgapOSiOaV1eHGfk2S8uxZVMeQzxod7T4PKdN
 kbPQKOhKW7ODWs/8Q5HxurnYgYtnnJW/qQMZy3CFBScUgSHISnGImxofYW/dQwgLOhvOZM
 mFgRMYZlP9dap9UuFvuIO7UAbLS8sOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773148948;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+YDJtZGkzWumaxSA72AZSTq/6aMwiWwZQbbcAFHSvgc=;
 b=KatcO/cBHESkW8tim3PMCJxH0D8QUfFpw+WXkE0UJyVCL+WK0cW9SOOUTb10VLgRjXIehV
 0hlf3iG7slVj4xBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 908FF3F490;
 Tue, 10 Mar 2026 13:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p5c7IhQbsGkgTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Mar 2026 13:22:28 +0000
Date: Tue, 10 Mar 2026 14:22:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260310132227.GC39882@pevik>
References: <20260309172057.272946-1-japo@linux.ibm.com>
 <20260309172057.272946-4-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260309172057.272946-4-japo@linux.ibm.com>
X-Spamd-Result: default: False [-6.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 URI_HIDDEN_PATH(1.00)[https://github.com/buildroot/buildroot/blob/master/.editorconfig];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 3/3] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> Introduce .editorconfig to keep indentation and whitespace consistent across
> editors, preventing accidental reformatting and noisy diffs.

+1, I was thinking about adding it looking on kernel [1] and Buildroot [2]
config some time ago.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/.editorconfig
[2] https://github.com/buildroot/buildroot/blob/master/.editorconfig

Generally LGTM.

BTW I would separate this from the actual code change (not relevant).

> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  .editorconfig | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 .editorconfig

> diff --git a/.editorconfig b/.editorconfig
> new file mode 100644
> index 000000000000..ee9f49516e53
> --- /dev/null
> +++ b/.editorconfig
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Any particular reason for GPL v2 only? The default LTP license is
GPL-2.0-or-later.

> +
> +# EditorConfig configuration for LTP
> +# https://editorconfig.org/
> +
> +root = true
> +
> +[*]
> +charset = utf-8
> +end_of_line = lf
> +insert_final_newline = true
> +trim_trailing_whitespace = true
> +
> +# C/Assembly source files, headers, and Makefiles use tabs
> +[*.{c,h,mk,S,sh,awk}]
FYI we have only single awk file which IMHO nobody uses (it may be deleted):
testcases/open_posix_testsuite/scripts/print-pass-fail-summary.awk
> +indent_style = tab
> +indent_size = 8
When we use tab anyway (i.e. it's about how is the tab displayed), could it be
indent_size = 4 ?
> +
> +[{Makefile,Makefile.*}]
nit: we should probably add here *.mk.in

> +indent_style = tab
> +indent_size = 8
> +
> +# Python and Perl scripts use spaces
> +[*.{py,pl}]
> +indent_style = space
> +indent_size = 4
Most of our python based tests contain tabs, see testcases/network/nfsv4/acl/
and testcases/realtime/func/pi-tests/.
OTOH doc/conf.py would have to be converted to tabs.

Also on perl it's hard to even decide, because vendored scripts/checkpatch.pl
uses tabs (and we modify it), but vendored scripts/checkbashisms.pl uses spaces.

> +
> +# Documentation files
> +[*.{rst,md}]
> +indent_style = space
> +indent_size = 3
If this setup is used for e.g. code block, than I would say we should have
indent_size = 4 to match the actual doc (doc/developers/test_case_tutorial.rst).

> +
> +# JSON files
> +[*.json]
> +indent_style = space
> +indent_size = 4
I'm ok with it, but our JSON files (tests added by Cyril) might be reformatted.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
