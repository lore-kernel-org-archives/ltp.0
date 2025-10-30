Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEEECCF9F0
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 20:17:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86173CC310
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 21:17:54 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD3263CBBD5
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 21:17:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3ADA560048E
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 21:17:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6177C337B4;
 Thu, 30 Oct 2025 20:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761855457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aa/kkMMSxnEdmTECqBHTS9S56OaM+mX03T+IpG5dbGM=;
 b=szzj0jE3GA0tRU8ELxnfhiOZC/eVjRCpiIL95SuQt1S1L8s/fb+zvV3F+Mic31IlunVXye
 R+x61b/QqmZvkyJl/D3UVcHi6viubDhf/Rabo3vbE5mJg0ggwPaMcWEU51DGxG5QWcHGRm
 iH0Z+lJ/W+LvN8eR/feK7bcT/5jCD+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761855457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aa/kkMMSxnEdmTECqBHTS9S56OaM+mX03T+IpG5dbGM=;
 b=wgu7KI1ETjE0eGtoSDRmyoEQxAUme25TPxBPwYeY0z913XpDvKNXCvcvbE14mSZLrM6n1m
 GRCvdxuixOB+umBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761855457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aa/kkMMSxnEdmTECqBHTS9S56OaM+mX03T+IpG5dbGM=;
 b=szzj0jE3GA0tRU8ELxnfhiOZC/eVjRCpiIL95SuQt1S1L8s/fb+zvV3F+Mic31IlunVXye
 R+x61b/QqmZvkyJl/D3UVcHi6viubDhf/Rabo3vbE5mJg0ggwPaMcWEU51DGxG5QWcHGRm
 iH0Z+lJ/W+LvN8eR/feK7bcT/5jCD+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761855457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aa/kkMMSxnEdmTECqBHTS9S56OaM+mX03T+IpG5dbGM=;
 b=wgu7KI1ETjE0eGtoSDRmyoEQxAUme25TPxBPwYeY0z913XpDvKNXCvcvbE14mSZLrM6n1m
 GRCvdxuixOB+umBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B23F21396A;
 Thu, 30 Oct 2025 20:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9g9wIODHA2k+dAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 20:17:36 +0000
Date: Thu, 30 Oct 2025 21:17:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251030201734.GC753947@pevik>
References: <20250529105156.2564268-1-wegao@suse.com>
 <20250924084223.20597-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250924084223.20597-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_filesystems01.c: Add test for .filesystems
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

Hi Wei,

...
> +	.needs_cmds = (const char *[]) {
> +		"tune2fs",
> +		"dumpe2fs",
If you don't add packages required in these 2 binaries into scripts in ci/ it
will not be tested in GitHub Actions.

See
https://github.com/linux-test-project/ltp/actions/runs/17971580970/job/51115261638:
2025-09-24T09:00:56.9304198Z tst_cmd.c:268: TCONF: Couldn't find 'tune2fs' in $PATH

Alpine: e2fsprogs-extra
Debian, openSUSE, Fedora (hopefully): e2fsprogs

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
