Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA24C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 11:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 655FA3CE733
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:37:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2AB23CE6D2
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 12:37:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F40ED600435
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 12:37:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4325221E51;
 Thu,  4 Jan 2024 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704368219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1HDvDm0mOkNuR1vMoRN1WHh5fuIEpdW+e/x7w4eH4E=;
 b=dc3r4CfR+d6c1GNHHoYsP56hzOLt0soZtSlKmI8YqHxQa8+4FVpwiE0OgVP4/T1L8+ZG/5
 8qmc86OQDwlBA4luaguYdXeoLB+AKJ2j3cJmnaofxtO0GK0Hxpcf4g6DnLCbpF/3oIkw0L
 q9zT0eq9JohIDbczqvqZNeHzuxMLHcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704368219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1HDvDm0mOkNuR1vMoRN1WHh5fuIEpdW+e/x7w4eH4E=;
 b=cgE8twV+BH4WJV7cG1mBmtLtc3ErJ0jKf36Y2HmGTfw4md/ZwjaXKEm/pPooZ05RtUWZlP
 ZC0q+4Biq+kiB5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704368219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1HDvDm0mOkNuR1vMoRN1WHh5fuIEpdW+e/x7w4eH4E=;
 b=dc3r4CfR+d6c1GNHHoYsP56hzOLt0soZtSlKmI8YqHxQa8+4FVpwiE0OgVP4/T1L8+ZG/5
 8qmc86OQDwlBA4luaguYdXeoLB+AKJ2j3cJmnaofxtO0GK0Hxpcf4g6DnLCbpF/3oIkw0L
 q9zT0eq9JohIDbczqvqZNeHzuxMLHcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704368219;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1HDvDm0mOkNuR1vMoRN1WHh5fuIEpdW+e/x7w4eH4E=;
 b=cgE8twV+BH4WJV7cG1mBmtLtc3ErJ0jKf36Y2HmGTfw4md/ZwjaXKEm/pPooZ05RtUWZlP
 ZC0q+4Biq+kiB5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 160B0137E8;
 Thu,  4 Jan 2024 11:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ibPFBFuYlmUpCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 11:36:59 +0000
Date: Thu, 4 Jan 2024 12:36:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240104113642.GA1149671@pevik>
References: <20231214151954.840244-1-pvorel@suse.cz>
 <20231214151954.840244-10-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214151954.840244-10-pvorel@suse.cz>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dc3r4CfR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cgE8twV+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 4325221E51
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 09/10] lib: Add support for TDEBUG tst_res()
 flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> To print more verbose info. By default it's off, printing enabled with
> -D option or TST_ENABLE_DEBUG=1.

...
> diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
...
> +| 'TINFO'  | General message.
> +| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'TST_ENABLE_DEBUG=1' or 'y'
> +             environment variable), only for messages which would be too verbose for normal run.
...
> +++ b/doc/User-Guidelines.asciidoc
> @@ -41,6 +41,7 @@ For running LTP network tests see `testcases/network/README.md`.
>                            and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
>                            Must be an absolute path (default: '/tmp').
>  | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
> +| 'TST_ENABLE_DEBUG'    | Enable debug info (value 'y' or '1').

This has been merged. But I now wonder, if this would be better with LTP_
prefix, e.g. LTP_ENABLE_DEBUG, because it's a variable which is defined by LTP
user. WDYT?

This might be also case for TST_NO_CLEANUP, but it's rarely used, thus my
concern is more about LTP_ENABLE_DEBUG.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
