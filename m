Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED17EE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:31:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 840B53C262C
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:31:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6BA3C1929
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:31:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 984E11033A89
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:31:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E61751F393;
 Thu,  9 Jan 2025 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736433076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQJ8iScbIK6idVxrvQSatfuaqGbZc7EjdzT3jDy8bfI=;
 b=EeLnkgiezpbkppl+Ds75FW82ZsGN703QMrVjZUh0neaNo/mpfYKO1FdoTCTjEXLfkvVmLp
 hI6pXR2LviHyBkZnnn8O79TpJCFAVQB4gNDW6fy/ct0x3ytBbQ7tMEXltHckrNKHU0qMhV
 arW7/oZMqC2TanWBS1/Is9QtEfA0FoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736433076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQJ8iScbIK6idVxrvQSatfuaqGbZc7EjdzT3jDy8bfI=;
 b=BEJKDeu6vRbW0QSHeorM5Ea9kUKqXXkW8oD/OR2Gp6moFbYSP72qIGcqnKVSIOKV/OT+4C
 RWGI7SrJgYqz3pDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736433075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQJ8iScbIK6idVxrvQSatfuaqGbZc7EjdzT3jDy8bfI=;
 b=h4Bla/YFXhiUVgjZHFLzD9pZYjIMvP4AiMY2PFLGeDgnM+5lYA6TZd1XMRP5MbQSlCRYBl
 /+edKYmdRGpN/dORt4lLYOCDCGTn5uXYGxJVvR/L2PmIRX3xmWPN/5OcEmkqnWqXZM+KTa
 VBWyP0+EFPSe4eWQquCUZ1NE/AqhE4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736433075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQJ8iScbIK6idVxrvQSatfuaqGbZc7EjdzT3jDy8bfI=;
 b=DBZFIquD4vuiBw+mN9GEt95ocurqk73zNHGq6sib5ZlVE6SH9QeIjPQhDmtpZIRnkaoXcA
 wdyvV8fT7zmCIXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C572D139AB;
 Thu,  9 Jan 2025 14:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CqscL7Pdf2fSYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 14:31:15 +0000
Date: Thu, 9 Jan 2025 15:31:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250109143114.GA327086@pevik>
References: <20250109142847.326936-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250109142847.326936-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] testinfo.pl: Properly handle NULL
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

Hi Cyril,

> While at it, add missing comma to the arguments.

I forget to note perl error:

$ cd metadata; make
metadata/parse.sh > ltp.json
mkdir -p docparse
make -C docparse/ -f docparse/Makefile
make[1]: Entering directory 'docparse'
docparse/testinfo.pl metadata/ltp.json
INFO: using 'linux' as LINUX_GIT repository
INFO: using 'linux-stable' as LINUX_STABLE_GIT repository
INFO: using 'glibc' as GLIBC_GIT repository
INFO: using 'musl' as MUSL_GIT repository
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.
Use of uninitialized value in join or string at docparse/testinfo.pl line 411.

Kind regards,
Petr

> Fixes: 946d20bdaf ("metadata: metaparse: Better array parsing.")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: if we don't want to have NULL in the docs (see e.g. hugemmap10),
> we can simply filer it:

> $content .= paragraph(table_escape(join(', ', grep defined, @$v2)));

>  docparse/testinfo.pl | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
> index 78433c40a3..487b7d5f22 100755
> --- a/docparse/testinfo.pl
> +++ b/docparse/testinfo.pl
> @@ -408,7 +408,11 @@ sub content_all_tests
>  				# two dimensional array
>  				if (ref(@$v[0]) eq 'ARRAY') {
>  					for my $v2 (@$v) {
> -						$content .= paragraph(table_escape(join(' ', @$v2)));
> +						# convert NULL to "NULL" string to be printed
> +						for my $v3 (@$v2) {
> +							$v3 = "NULL" if (!defined $v3);
> +						}
> +						$content .= paragraph(table_escape(join(', ', @$v2)));
>  					}
>  				} else {
>  					# one dimensional array

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
