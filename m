Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE59CD3420
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 09:50:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E8D53C4E8E
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 11:50:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F2343C4D36
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 11:50:25 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A85314013BB
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 11:50:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D10ED1FCF6;
 Tue,  3 Sep 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A4C13A52;
 Tue,  3 Sep 2024 09:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0ORUJ8/b1mZHAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 09:50:07 +0000
Date: Tue, 3 Sep 2024 11:49:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240903094958.GA740314@pevik>
References: <20240902024017.6404-1-wegao@suse.com>
 <20240903081916.27033-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240903081916.27033-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: D10ED1FCF6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mpls01.sh: Add --allow-unsupported for modprobe
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

This is needed in other mpls tests (mpls0[2-4].sh, it needs to be in mpls_lib.sh
to be reused.

Kind regards,
Petr

> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/mpls/mpls01.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
> index 196b5b2f9..892b5bd85 100755
> --- a/testcases/network/mpls/mpls01.sh
> +++ b/testcases/network/mpls/mpls01.sh
> @@ -21,7 +21,11 @@ cleanup()

>  setup()
>  {
> -	ROD modprobe mpls_router
> +	if grep -q 'sl-micro' /etc/os-release; then
> +		ROD modprobe --allow-unsupported mpls_router
> +	else
> +		ROD modprobe mpls_router
> +	fi
>  }

>  test1()

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
