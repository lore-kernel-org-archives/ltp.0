Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A75D64084
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 07:09:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B05443D0398
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 08:08:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E9063D0395
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 08:08:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D07FE1A0089E
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 08:08:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B921336C4;
 Wed, 17 Dec 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 569DC3EA63;
 Wed, 17 Dec 2025 07:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f/TtDPVWQmnmZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Dec 2025 07:08:37 +0000
Date: Wed, 17 Dec 2025 08:08:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20251217070831.GA34230@pevik>
References: <20251216173053.29112-1-mdoucha@suse.cz>
 <20251216173053.29112-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251216173053.29112-2-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9B921336C4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cpuset_memory: Fix race in multinode subtests
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

> In two subtests, memory allocation races against a change of the allowed
> cpuset nodes list. This causes random failures. Add the missing sleep
> to ensure that memory allocation completes before the allowed nodes
> get changed.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> index 1f68d7444..d13c605e2 100755
> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
> @@ -354,7 +354,7 @@ talk2memory_test_for_case_12_13()
>  	sleep 1
>  	echo $1 > "$2/tasks"
>  	/bin/kill -s SIGUSR1 $1
> -
> +	sleep 1

Thanks for the fix, this patch merged!

I wonder if this very old test is in a long run worth to rewrite into C, as depending on
sleep is not a good idea and C API would hopefully help to avoid it. (Yeah, we
discuss sleep as a part of ground rules [1].)

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20251215124404.16395-2-chrubis@suse.cz/


>  	echo 0 > "$2/cpuset.mems" || return 1
>  	sleep 1
>  	/bin/kill -s SIGUSR1 $1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
