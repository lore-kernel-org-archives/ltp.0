Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E0CA0EFB
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 10:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 823193D2837
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 12:39:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E84A3D279F
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 12:38:54 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCB4214098C7
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 12:38:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE3EF1F7BF;
 Fri, 30 Aug 2024 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725014332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3Oq2MLDZRF6c+g15dcwjQGS4oi8hCJTXgjsor95GYI=;
 b=B6C4qhZ351T+ubGrjEV/4lTP61IqSrLhBnPHxyN9cqHEO0ir7WiRXV4xDzYK8lqirm78Yn
 8gh5IJo1thWOkcXJ3RVQUugTQ1HtMwBl8p1eE1p/OS338u5RAnRF1mw5ZrAQViQg10L3Lw
 XNdbzAEQJlXRS/53eEl8/uC+7QvOzXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725014332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3Oq2MLDZRF6c+g15dcwjQGS4oi8hCJTXgjsor95GYI=;
 b=O4t0VxB1ZrlMnfcls915C0xDwep/41UPg62jf0RyOFhb8J/mbWsfvvmWilTh7dWQ468kQL
 1z1mHu/vJGZmAyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725014332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3Oq2MLDZRF6c+g15dcwjQGS4oi8hCJTXgjsor95GYI=;
 b=B6C4qhZ351T+ubGrjEV/4lTP61IqSrLhBnPHxyN9cqHEO0ir7WiRXV4xDzYK8lqirm78Yn
 8gh5IJo1thWOkcXJ3RVQUugTQ1HtMwBl8p1eE1p/OS338u5RAnRF1mw5ZrAQViQg10L3Lw
 XNdbzAEQJlXRS/53eEl8/uC+7QvOzXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725014332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3Oq2MLDZRF6c+g15dcwjQGS4oi8hCJTXgjsor95GYI=;
 b=O4t0VxB1ZrlMnfcls915C0xDwep/41UPg62jf0RyOFhb8J/mbWsfvvmWilTh7dWQ468kQL
 1z1mHu/vJGZmAyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B7C413A3D;
 Fri, 30 Aug 2024 10:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uzD+FDyh0WbcIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Aug 2024 10:38:52 +0000
Date: Fri, 30 Aug 2024 12:38:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240830103835.GA42409@pevik>
References: <20240830095758.20018-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830095758.20018-1-wegao@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,opensuse.org:url,suse.cz:email,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mpls01.sh: Add --allow-unsupported for modprobe
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

> In sle-micro we encounter following error when do modprobe:
> root# modprobe mpls_router
> modprobe: ERROR: module 'mpls_router' is unsupported
> modprobe: ERROR: Use --allow-unsupported or set allow_unsupported_modules 1 in
> modprobe: ERROR: /etc/modprobe.d/10-unsupported-modules.conf
> modprobe: ERROR: could not insert 'mpls_router': Operation not permitted

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/network/mpls/mpls01.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
> index 196b5b2f9..7f262d83e 100755
> --- a/testcases/network/mpls/mpls01.sh
> +++ b/testcases/network/mpls/mpls01.sh
> @@ -21,7 +21,9 @@ cleanup()

>  setup()
>  {
> -	ROD modprobe mpls_router
> +	if ! modprobe mpls_router > /dev/null 2>&1; then
> +		ROD modprobe mpls_router --allow-unsupported

I'm not sure with ROD.  --allow-unsupported is SUSE specific modprobe extension,
which is used for SLES.  It is also on Tumbleweed [1] [2] where does nothing.

If you try to run it with ROD, which quits testing on failure, all distros
except SUSE products/openSUSE (e.g. Debian, Fedora, ...) which don't have
mpls_router will TBROK in setup:

	modprobe: unrecognised option '--allow-unsupported'.

And I'm not talking about these small distros which use busybox kmod
implementation, which would also fail.

Also you remove /dev/null 2>&1 from the first command, thus other distros would
not see error message about missing mpls_router module. Without looking into the
source the tester will be pretty confused.

I would do:

	if grep -q suse /etc/os-release; then
		ROD modprobe --allow-unsupported mpls_router
	else
		ROD modprobe mpls_router
	fi

(nit: better to put the option before the module name.)

With this, you can put in the next version:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	fi
>  }

>  test1()

[1] https://build.opensuse.org/projects/Base:System/packages/kmod/files/0002-modprobe-Recognize-allow-unsupported-modules-on-comm.patch?expand=1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
