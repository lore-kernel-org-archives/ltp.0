Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F5AE77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 14:53:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10163E712F
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 15:53:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E5133E6FA7
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 15:52:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B0C9643EAB
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 15:52:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68279210EE;
 Fri,  6 Dec 2024 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733496763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqXPYs88YBThdDdWjWSBH1FF2g83h+4StfjWzMAFVoY=;
 b=zhIBiUlagSYypcKBOtECo2sDgfdO/DaLPDsqHnXnZcZ6bpfqGnGSylttAHJcqhtb/2vgy3
 2gmJ+hr9UiR2js5YXSOHEftZlNWKqXaBulFH3izpl8BvCcA8q761NoRlW6onAJPTPSeBvO
 kdNI0XnvQC8DNqiCVhIZD6ToijwSmEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733496763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqXPYs88YBThdDdWjWSBH1FF2g83h+4StfjWzMAFVoY=;
 b=bkwMv2vzBzdeJlTGoObjfS1mz53kOp0hY7TnRUc4CD0pn+dkAeZOwUQyrRKSFE6KdyoRsc
 qiUddN85qQzL8+Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733496763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqXPYs88YBThdDdWjWSBH1FF2g83h+4StfjWzMAFVoY=;
 b=zhIBiUlagSYypcKBOtECo2sDgfdO/DaLPDsqHnXnZcZ6bpfqGnGSylttAHJcqhtb/2vgy3
 2gmJ+hr9UiR2js5YXSOHEftZlNWKqXaBulFH3izpl8BvCcA8q761NoRlW6onAJPTPSeBvO
 kdNI0XnvQC8DNqiCVhIZD6ToijwSmEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733496763;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqXPYs88YBThdDdWjWSBH1FF2g83h+4StfjWzMAFVoY=;
 b=bkwMv2vzBzdeJlTGoObjfS1mz53kOp0hY7TnRUc4CD0pn+dkAeZOwUQyrRKSFE6KdyoRsc
 qiUddN85qQzL8+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 508F0138A7;
 Fri,  6 Dec 2024 14:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r++YErsPU2fRcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Dec 2024 14:52:43 +0000
Date: Fri, 6 Dec 2024 15:52:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241206145237.GA126598@pevik>
References: <20241204172312.34099-1-mdoucha@suse.cz>
 <20241204172312.34099-2-mdoucha@suse.cz>
 <20241205111014.GB28204@pevik>
 <ffe3ddb9-834c-46e1-80ed-169b32c1f977@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ffe3ddb9-834c-46e1-80ed-169b32c1f977@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add test for data integrity over NFS
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

> > > +	bsize=$(( $bsize < 1024 ? 1024 : $bsize ))

> > nit: this would work if stat is not installed (minimal systems) or fails for
> > some reason:

> > if [ -z "$bsize" ] || [ "$bsize" -lt 1024 ]; then
> > 	bsize=1024
> > fi

> > If you agree, I can change it during merge.
> > Otherwise LGTM.

> Please do, thank you.

The remaining two patches merged with agreed change. Thanks!
I suppose you send a patch to modify vectorize_buffer() fsplough.c.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
