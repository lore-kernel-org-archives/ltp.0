Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6092DC46CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 09:10:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12A233C9C17
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 10:10:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DB1D3C865E
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 10:10:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6AC001400049
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 10:10:44 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E84681FC0B;
 Wed, 27 Dec 2023 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703668242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6EESbuQ1ZCbij00+wuGKVmtkZ8Klpz8tg/opE+jj8o=;
 b=ATslONvzojQrZP/eQ3k6De7UbsMfVfstqJ0UoRce1dwMGYNYJage6W7kxUd3ylkLhYtRgd
 mcFW/ZjbmrdOsia4QcrEr7Tk/EZM2rSn1aJeOTx5b6jA8qXIyDTSl+Ng5802KapRBtnh7u
 foQUKs7SS+FJmhPlZlMYEsX2BLiBUN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703668242;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6EESbuQ1ZCbij00+wuGKVmtkZ8Klpz8tg/opE+jj8o=;
 b=xX0nuVmJ80CXXejf1rRFZZKVYWIyryNQOUi8TB6BYpRRcbf/p51x4Db1YSOmb0FvtDnWn5
 JcwqCWO1q/SniUDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703668241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6EESbuQ1ZCbij00+wuGKVmtkZ8Klpz8tg/opE+jj8o=;
 b=jmy1BbKHtYXz26xM30/chgKZormiYTJfiaj2VlgGBQ2Z4J30j92RvKWaxul/YCoLYTKxVp
 s2jftnKw5g+VkHpqjKETBGsyVjQ2VEW2UGVQRuFh1veEUk7mo07zjC2BDhXS3AehHZ895v
 KbmGj1scGfb3uilMQpAC1y5rieWQIQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703668241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6EESbuQ1ZCbij00+wuGKVmtkZ8Klpz8tg/opE+jj8o=;
 b=beDu8CA+fWeYJ0DgPHvwyWX62Twf9lP/c5Z+QzZxkNxqeLixwJUeLWIF33SkrrceDkJ+yZ
 /aRUcb8D2VrGjZDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 98FD313902;
 Wed, 27 Dec 2023 09:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id XoRfIBHqi2UxLAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 27 Dec 2023 09:10:41 +0000
Date: Wed, 27 Dec 2023 10:10:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shizhao Chen <shichen@redhat.com>
Message-ID: <20231227091039.GA727588@pevik>
References: <20231227065118.209595-1-shichen@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231227065118.209595-1-shichen@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.21%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tools: Fix syntax error caused by "; ;
 " in create_dmesg_entry awk script
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

Hi Shizhao,

> When running runltp with both -S and -K provided, tests that are supposed to be
> "skipped" and report TCONF results were failing due to an unexpected semicolon
> at the end of the constructed command.

> `-S` replace the test command with `exit 32;`
> `-K` appends another semicolon to the command then we get `exit 32;;`

> For example:

>   >>> 780:madvise06__with_dmesg_entry BROK <<<

>        1	<<<test_start>>>
>        2	tag=madvise06__with_dmesg_entry stime=1703556061
>        3	cmdline="dmesg -c 1>/dev/null 2>&1; exit 32;; dmesg > /mnt/testarea/ltp/output/DMESG_DIR_RHELKT1LITE.FILTERED-dmesg-output-53127-08:48:23PM/madvise06.dmesg.log"
>        4	contacts=""
>        5	analysis=exit
>        6	<<<test_output>>>
>        7	sh: -c: line 1: syntax error near unexpected token `;;'
>        8	sh: -c: line 1: `dmesg -c 1>/dev/null 2>&1; exit 32;; dmesg > /mnt/testarea/ltp/output/DMESG_DIR_RHELKT1LITE.FILTERED-dmesg-output-53127-08:48:23PM/madvise06.dmesg.log'
>        9	<<<execution_status>>>
>       10	initiation_status="ok"
>       11	duration=0 termination_type=exited termination_id=2 corefile=no
>       12	cutime=0 cstime=1
>       13	<<<test_end>>>

> Signed-off-by: Shizhao Chen <shichen@redhat.com>
> ---
>  tools/create_dmesg_entries_for_each_test.awk | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/tools/create_dmesg_entries_for_each_test.awk b/tools/create_dmesg_entries_for_each_test.awk
> index 25d750a55..7a22bb4a6 100644
> --- a/tools/create_dmesg_entries_for_each_test.awk
> +++ b/tools/create_dmesg_entries_for_each_test.awk
> @@ -27,6 +27,7 @@ NF && ! /^#/ {
>  	for (i = 2; i <= NF; i++) {
>  		s = s " " $i
>  	}
> +	sub(/;$/, "", s)

From the above context are you sure that there will not be missing semicolon?
(e.g. between dmesg and exit)

Wouldn't it be safe to make sure there is only only single semicolon at the end?

sub(/[;]+$/, ";")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI: runltp has been deprecated, we suggest to use python based kirk.
https://github.com/linux-test-project/kirk

Kind regards,
Petr

>  	s = s "; dmesg > " DMESG_DIR "/" $1 ".dmesg.log"
>  	print s
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
