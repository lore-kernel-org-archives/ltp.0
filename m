Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2890CA0EEB
	for <ltp@archiver.kernel.org>; Tue, 19 Aug 2025 17:10:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00E933CC9BF
	for <ltp@archiver.kernel.org>; Tue, 19 Aug 2025 19:09:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4ADD3CB92D
 for <ltp@lists.linux.it>; Tue, 19 Aug 2025 19:09:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99667200B37
 for <ltp@lists.linux.it>; Tue, 19 Aug 2025 19:09:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 06C3C1F8C0;
 Tue, 19 Aug 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E09C113686;
 Tue, 19 Aug 2025 17:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lvOxNNOvpGgDeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 19 Aug 2025 17:09:39 +0000
Date: Tue, 19 Aug 2025 19:09:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250819170930.GA230380@pevik>
References: <20250819154957.79325-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250819154957.79325-1-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 06C3C1F8C0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Makefile: Fix module dirs search
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

Hi Martin,

[ Cc Andrea to merge v2 fix ]

> Module dirs search runs relative to current working directory instead
> of the source directory. In an out-of-tree build, the search for makefiles
> will come up empty and grep will try to read from standard input, blocking
> indefinitely. Search for makefiles relative to the source directory to fix
> the issue.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/Makefile b/Makefile
> index 77270bc7c..7f0ba5e86 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -213,7 +213,7 @@ test-metadata: metadata-all
>  	$(MAKE) -C $(abs_srcdir)/metadata test

>  MODULE_DIRS :=  $(shell \
> -	dirname $$(grep -l 'include.*module\.mk' $$(find testcases/ -type f -name 'Makefile')))
> +	dirname $$(grep -l 'include.*module\.mk' $$(find $(abs_srcdir)/testcases/ -type f -name 'Makefile')))

Just having a quick look: v2 will be needed as path is added twice. :(

Build /home/foo/ltp/testcases/commands/insmod
make[1]: Entering directory '/home/pevik/install/src/ltp.git'
make[1]: *** /home/foo/ltp//home/foo/ltp/testcases/commands/insmod: No such file or directory.  Stop.
make[1]: Leaving directory '/home/pevik/install/src/ltp.git'
make: *** [Makefile:221: modules] Error 2

I guess removing "$(abs_srcdir)/" will be needed when you add it to find.

+ please add:
Fixes: e3e1fa0e78 ("Makefile: Add kernel modules related make targets")

With the change above you may add my RBT
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

diff --git Makefile Makefile
index 7f0ba5e869..d47b2528e9 100644
--- Makefile
+++ Makefile
@@ -220,17 +220,17 @@ MODULE_DIRS :=  $(shell \
 modules:
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
-		$(MAKE) -C $(abs_srcdir)/$(dir) || exit $$?; \
+		$(MAKE) -C $(dir) || exit $$?; \
 )
 modules-clean:
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
-		$(MAKE) -C $(abs_srcdir)/$(dir) clean || exit $$?; \
+		$(MAKE) -C $(dir) clean || exit $$?; \
 )
 modules-install: modules
 	@$(foreach dir,$(MODULE_DIRS),\
 		echo "Build $(dir)";\
-		$(MAKE) -C $(abs_srcdir)/$(dir) install || exit $$?; \
+		$(MAKE) -C $(dir) install || exit $$?; \
 )
 
 ## Help

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
