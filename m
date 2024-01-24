Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88F1C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 12:02:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 332DB3CEE67
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 13:02:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 778FC3C4DB9
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:02:26 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 948866008E5
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 13:02:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4407D222F5;
 Wed, 24 Jan 2024 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706097744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sR1x+A1qtDNxQWk2Agg2JJXI+udxEx2TOYoOjdjERwA=;
 b=JE5ku7LhfdQKMMmczpCppKC/XIW4Ek2XFlrdOesbjRcW6htrr3393ytUV6A7EMrv+EjbB3
 qZjcmfH6MgrshYQqL33ZKEtptbErnCDXxy2aQxUqQAJsMPvZZJXpTpcy3LVktdY/b1BC2c
 Dyv9/FSI0G5m0V+Br8XQ5Xu3uYUdXlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706097744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sR1x+A1qtDNxQWk2Agg2JJXI+udxEx2TOYoOjdjERwA=;
 b=CfTeIt8xYsKpCapq3GMJWKp4sXpXq949LOH3GIXYONYeGJ+WB7iDd6QYIx99msn8L49UZ7
 d5xaKVCwWPWGS2Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706097742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sR1x+A1qtDNxQWk2Agg2JJXI+udxEx2TOYoOjdjERwA=;
 b=0eVWZmQorI9JoS4JPF97JTHtKL30Q17KMv3d4eOyaeic4/P3re3j5KB3xQQkn1yS+1oqxO
 2wwAslMFTy9t/nA5EEveSlc9iyC/8LXMwPlXJEAvgG6nO5ZR6L/Ju6R3TuxY5AbICy06Do
 SGBVhC9eHjqSfJadxuVy7TfRX+UeiJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706097742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sR1x+A1qtDNxQWk2Agg2JJXI+udxEx2TOYoOjdjERwA=;
 b=A+nKJhty9i2WB7ixmIamT/9PpS7t7dDqNiEIxcCrx0dDG26t+G3u+mR14uNxBakLPFQ+kf
 F3FAZDB5FxZE+2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0596F1333E;
 Wed, 24 Jan 2024 12:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3jxUO038sGUXKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 12:02:21 +0000
Date: Wed, 24 Jan 2024 13:02:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240124120212.GA279463@pevik>
References: <20240123162647.210424-1-pvorel@suse.cz>
 <20240123162647.210424-4-pvorel@suse.cz> <ZbDrDZ7DWsLuyzDw@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbDrDZ7DWsLuyzDw@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[ima_tpm.sh:url]; REPLY(-4.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ima_tpm.sh:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[19.33%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] kernel: Fix tst_brk TFAIL
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

> Hi!
> > diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> > index 6bc305f2c..234bf06dd 100755
> > --- a/testcases/kernel/device-drivers/zram/zram01.sh
> > +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> > @@ -82,7 +82,8 @@ zram_makefs()
> >  		mkfs.$fs /dev/zram$i > err.log 2>&1
> >  		if [ $? -ne 0 ]; then
> >  			cat err.log
> > -			tst_brk TFAIL "failed to make $fs on /dev/zram$i"
> > +			tst_res TFAIL "failed to make $fs on /dev/zram$i"
> > +			return

> I do not think that this one is correct, unlike other tests the steps in
> zram depends on each other if this fails and we attempt to continue we
> will get failues from zram_mount and zram_fill_fs as well.

> The zram tests are unfortunatelly messy in a sense that a testcase is
> a setup for the next one so we really need to exit the whole test if one
> of the testcases fails. I guess the clearest solution would be TFAIL
> followed by a TBROK in this case. Something as:

> 	tst_res TFAIL "Failed to make $fs on /dev/zram$i"
> 	tst_brk TBROK "Can't continue with mounting the FS"

You're right! I'll just slightly modify
	tst_brk TBROK "Can't continue with mounting $fs"


> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > index b675a20a1..2a28562e6 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> > @@ -159,7 +159,8 @@ get_pcr10_aggregate()
> >  		$cmd > hash.txt 2>&1
> >  		ret=$?
> >  	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" = 1 ]; then
> > -		tst_brk TFAIL "evmctl failed $msg"
> > +		tst_res TFAIL "evmctl failed $msg"
> > +		return
> >  	fi

> Again here, I'm not sure if it's safe to continue with the rest of the
> test.

Yes, this is safe, because the output of get_pcr10_aggregate() is later checked:

	get_pcr10_aggregate > tmp.txt
	pcr_aggregate="$(cat tmp.txt)"
	if [ -z "$pcr_aggregate" ]; then
		return
	fi

I made ima_tpm.sh quite hard to understand. I guess soon I should drop support
for older evmctl to make test easier to understand.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
