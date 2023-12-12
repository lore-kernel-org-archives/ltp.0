Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126EAC4332F
	for <ltp@archiver.kernel.org>; Tue, 12 Dec 2023 14:48:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 254863CF758
	for <ltp@archiver.kernel.org>; Tue, 12 Dec 2023 15:48:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1BC23CF6EF
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 15:48:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B41C603473
 for <ltp@lists.linux.it>; Tue, 12 Dec 2023 15:48:23 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB85D22511;
 Tue, 12 Dec 2023 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702392502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PAfGpOfftQeO2akfkq9FK9oVv+T8+yemPjH2JRXj5U=;
 b=OAzQ/fBeKayU3RkQjr2ypXR3zml+0+EZ0WaezUv5U6nr+ndBWSNpJq0fvao0iuDUhzb8TZ
 gkwc8JCaMDtJyQ0BJ302QWW+iOmuqU7JbmXq9WIg4ySzNg4W2O1k8XpH81yrznTKd7qNpX
 7rJL9C0ceTLf7stuBwXd4WGEAEb4wQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702392502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PAfGpOfftQeO2akfkq9FK9oVv+T8+yemPjH2JRXj5U=;
 b=qa+P4IzoIAJNNzpcfKiizNZhfIT78Uhypo0WCy1DNJWwriGancaNN+l6UVx2XZWllUY3n/
 J3v7taZJfDWMqMCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702392501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PAfGpOfftQeO2akfkq9FK9oVv+T8+yemPjH2JRXj5U=;
 b=uTGa5y8KauYVRlm4Is9n1afxzu/Kogooa3fjZWIE3E20NdEthA57GCtpYACYB4jy6stCxn
 QY22IrDVVbT3GA7wf6S5KYUxbuXssuykDwvTOFQH5eBRhTxNdIv8sQIZEu1C81uJxyDr3r
 j7BwcReTPSeBfdEAGEZEJXa+4WYcZO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702392501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4PAfGpOfftQeO2akfkq9FK9oVv+T8+yemPjH2JRXj5U=;
 b=OpvHJSgimr05uCMDcMCdMRuQv33sbnoNfu6WBQlIkl8cohrFm6xEOPxsUO5tbMnUOxJjWY
 D0NIoEx7LjjkBoBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF036132DC;
 Tue, 12 Dec 2023 14:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id R89wNrVyeGU9WwAAn2gu4w
 (envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:48:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 845A9A07E0; Tue, 12 Dec 2023 15:48:21 +0100 (CET)
Date: Tue, 12 Dec 2023 15:48:21 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20231212144821.rji2to3iiedyqxlm@quack3>
References: <20231207194011.273027-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231207194011.273027-1-pvorel@suse.cz>
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uTGa5y8K;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OpvHJSgi;
 dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [3.10 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-0.975];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.19)[70.97%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.cz]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,redhat.com,suse.com,fujitsu.com,linux.dev,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: EB85D22511
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] Add support bcachefs filesystem
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, linux-bcachefs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 07-12-23 20:40:08, Petr Vorel wrote:
> Hi all,
> 
> @Amir @Jan, could you please have look on fanotify failures on Bcachefs?
> fanotify13.c, fanotify15.c and fanotify16.c produce many errors.
> 
> To test, just apply this patchset and then run with LTP_SINGLE_FS_TYPE:
> 
> # LTP_SINGLE_FS_TYPE=bcachefs ./fanotify15

I suspect some catch with fsids but we'll see... I hopefully get to this
tomorrow.

								Honza

> changes v1->v2:
> Two new commits:
> * lib: Add Bcachefs magic
> * statx04: Skip STATX_ATTR_COMPRESSED on Bcachefs
> 
> Petr Vorel (3):
>   lib: Add Bcachefs magic
>   lib: Add support bcachefs filesystem to .all_filesystems
>   statx04: Skip STATX_ATTR_COMPRESSED on Bcachefs
> 
>  include/tst_fs.h                          | 3 +++
>  lib/tst_fs_type.c                         | 2 ++
>  lib/tst_supported_fs_types.c              | 2 ++
>  testcases/kernel/syscalls/statx/statx04.c | 5 +++--
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
