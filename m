Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B86DC7114C
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 23:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3E783D27B3
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 01:02:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE37B3D0099
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 01:02:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 982961A00929
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 01:02:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CBCC21B6F;
 Wed, 28 Aug 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 158711398F;
 Wed, 28 Aug 2024 23:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5rESBHCsz2aDTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Aug 2024 23:02:08 +0000
Date: Thu, 29 Aug 2024 01:02:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240828230206.GA1811258@pevik>
References: <20240828052500.2395-1-wegao@suse.com>
 <20240828134551.6344-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240828134551.6344-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2CBCC21B6F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] isofs.sh: Create group and user before check
 mount option
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

> Case will failed if default system has no group named "bin", such
> as suse sle-micro, so this patch will create specific group for test
> instead of fixed "bin" group.

I wonder if we should not add this group to SUT, there are more tests which
needs some group (IDcheck.sh has bin, daemon, nobody, ...), e.g. hugeshmat03.c,
cgroup_core0[12].c, access01.c use nobody. Maybe that is more common than bin
(and presented on the SUT).

FYI we even have a ticket, although I don't expect you would have time to
to work on something generic...
https://github.com/linux-test-project/ltp/issues/468

...
>  MAX_DEPTH=3
>  MAX_DIRS=4

> +test_group="abc"

... thus I'm not opposite to workaround like this. But it'd be better to name
the new user ltp_isofs or something really unique.

> +
> +setup()
> +{
> +	if ! getent group $test_group > /dev/null; then
> +		useradd -U $test_group
> +	fi
> +}
> +
> +cleanup()
> +{
> +	userdel -f $test_group
> +	groupdel -f $test_group

+1 for using userdel which is everywhere.
But maybe prefix it with ROD?
or use TST_NEEDS_CMDS to make sure both binaries are on SUT?

Kind regards,
Petr
> +}
> +
>  gen_fs_tree()
>  {
>  	local cur_path="$1"
> @@ -92,8 +109,8 @@ do_test()
>  			"loop,block=512,unhide" \
>  			"loop,block=1024,cruft" \
>  			"loop,block=2048,nocompress" \
> -			"loop,check=strict,map=off,gid=bin,uid=bin" \
> -			"loop,check=strict,map=acorn,gid=bin,uid=bin" \
> +			"loop,block=2048,nocompress" \ "loop,check=strict,map=off,gid=$test_group,uid=$test_group" \
> +			"loop,check=strict,map=acorn,gid=$test_group,uid=$test_group" \
>  			"loop,check=relaxed,map=normal" \
>  			"loop,block=512,unhide,session=2"
>  		do

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
