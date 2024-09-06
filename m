Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AFCCE7AFD
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 09:54:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E89D73C2266
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 11:54:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70D843C0352
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 11:54:28 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B9ECF14098BC
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 11:54:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C3911F8AE;
 Fri,  6 Sep 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C27A136A8;
 Fri,  6 Sep 2024 09:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bqh4FVHR2mZhYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Sep 2024 09:54:25 +0000
Date: Fri, 6 Sep 2024 11:53:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZtrRCVxNKuu5ZdHN@yuki.lan>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6C3911F8AE
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> tst_test.c:1860: TINFO: LTP version: 20240524
> tst_test.c:1864: TINFO: Tested kernel: 6.8.0-1010-raspi #11-Ubuntu SMP
> PREEMPT_DYNAMIC Thu Aug  8 23:22:41 UTC 2024 aarch64
> tst_test.c:1703: TINFO: Timeout per run is 0h 00m 30s
> shell_test01.c:11: TINFO: C test exits now
> Usage: tst_res_ filename lineno [TPASS|TFAIL|TCONF|TINFO|TDEBUG] 'A short
> description'
> tst_test.c:1535: TBROK: Test haven't reported results!
> 
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> 
> 
> Here I got test failures on my RPi4 (bash-5.2.21) that the $LINEON can't
> be parsed correctly.

Are you sure that this is due to bash? My guess is that on RPi the
default shell is dash because it's debian based.

I will try to reproduce.

> The reason probably is some shells or specific versions might not handle
> $LINENO correctly within aliases, especially when the line number needs
> to be dynamically determined.
> 
> So I suggest using a function instead of the alias.
> 
> 
> --- a/testcases/lib/tst_env.sh
> +++ b/testcases/lib/tst_env.sh
> @@ -21,5 +21,12 @@ tst_brk_()
>         esac
>  }
> 
> -alias tst_res="tst_res_ $tst_script_name \$LINENO"
> -alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> +tst_res()
> +{
> +    tst_res_ "$tst_script_name" "$LINENO" "$@"
> +}
> +
> +tst_brk()
> +{
> +    tst_brk_ "$tst_script_name" "$LINENO" "$@"
> +}

That actually does not work because unlike the alias the $LINENO is
expanded in the wrong place and the line is incorrect.

The whole reason for this to be alias is that it's expanded on the
correct line in the test source.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
