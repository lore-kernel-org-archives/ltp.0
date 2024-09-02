Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96528CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 11:03:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F3243C4ADC
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 13:03:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B1C63C090A
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 13:03:06 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 19AB7140163A
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 13:03:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EB5721B44;
 Mon,  2 Sep 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E744713A7C;
 Mon,  2 Sep 2024 11:03:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6/A7N2eb1WaOcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 11:03:03 +0000
Date: Mon, 2 Sep 2024 13:02:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240902110246.GA375290@pevik>
References: <20240830095758.20018-1-wegao@suse.com>
 <20240902024017.6404-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240902024017.6404-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3EB5721B44
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mpls01.sh: Add --allow-unsupported for modprobe
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


> In sle-micro we encounter following error when do modprobe:
> root# modprobe mpls_router
> modprobe: ERROR: module 'mpls_router' is unsupported
> modprobe: ERROR: Use --allow-unsupported or set allow_unsupported_modules 1 in
> modprobe: ERROR: /etc/modprobe.d/10-unsupported-modules.conf
> modprobe: ERROR: could not insert 'mpls_router': Operation not permitted

> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/mpls/mpls01.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
> index 196b5b2f9..957f9d153 100755
> --- a/testcases/network/mpls/mpls01.sh
> +++ b/testcases/network/mpls/mpls01.sh
> @@ -21,7 +21,11 @@ cleanup()

>  setup()
>  {
> -	ROD modprobe mpls_router
> +	if grep -q suse /etc/os-release; then

Cyril asked for more specific grep in v1
https://lore.kernel.org/ltp/ZtWV0R_oDb7BQdKm@yuki.lan/

My suggestion to change before merge:
https://lore.kernel.org/ltp/20240902110037.GD279460@pevik/

-       if grep -q suse /etc/os-release; then
+       if grep -q 'sl-micro' /etc/os-release; then

Kind regards,
Petr

> +		ROD modprobe --allow-unsupported mpls_router
> +	else
> +		ROD modprobe mpls_router
> +	fi
>  }

>  test1()

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
