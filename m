Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8119BC4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 13:44:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7F593CFB98
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 15:44:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4F123CFB8E
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 15:43:44 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 874D320A6AD
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 15:43:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95DBF33D0D;
 Wed, 17 Apr 2024 13:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713361422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2btqVKWoaz2+/7v5rUk7elj/8ELg2/ND/hPo5z8joo=;
 b=s/1HK2anCCQHqN5rONuZ0sInuIyxH7p6NL65A4I7jine4B5SGHj+GziX3DtsgdGw5RX82s
 w1kNpvPQpmTKFXgouxqFcFuv4cW4uMtsA3wCvDBW/qrP9Sf6dcvIzFxI+i+6GFawo1EB2y
 KJWfQO1XV1lj6XxlVpQVfffLePQ8FJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713361422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2btqVKWoaz2+/7v5rUk7elj/8ELg2/ND/hPo5z8joo=;
 b=YRD3H67fmTOVqw2S/0vOZW+Ik55sH1B5aDVKzY8FIOGeF5VRK/v9HFmGbNvmaL+Ag4ZVh6
 wJckRQWqw0qvrZAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713361422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2btqVKWoaz2+/7v5rUk7elj/8ELg2/ND/hPo5z8joo=;
 b=s/1HK2anCCQHqN5rONuZ0sInuIyxH7p6NL65A4I7jine4B5SGHj+GziX3DtsgdGw5RX82s
 w1kNpvPQpmTKFXgouxqFcFuv4cW4uMtsA3wCvDBW/qrP9Sf6dcvIzFxI+i+6GFawo1EB2y
 KJWfQO1XV1lj6XxlVpQVfffLePQ8FJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713361422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2btqVKWoaz2+/7v5rUk7elj/8ELg2/ND/hPo5z8joo=;
 b=YRD3H67fmTOVqw2S/0vOZW+Ik55sH1B5aDVKzY8FIOGeF5VRK/v9HFmGbNvmaL+Ag4ZVh6
 wJckRQWqw0qvrZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 866F813957;
 Wed, 17 Apr 2024 13:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n36KHw7SH2bFOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Apr 2024 13:43:42 +0000
Date: Wed, 17 Apr 2024 15:42:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zh_R31-342b-1Alm@yuki>
References: <20240417090222.707302-1-pvorel@suse.cz> <Zh-eIg51K9UtdQuj@yuki>
 <20240417100611.GA713385@pevik> <Zh-lGL4tU5Z2dSLi@yuki>
 <20240417122418.GB727397@pevik> <20240417133749.GA4484@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240417133749.GA4484@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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
> Changing it to {SAFE_,}MAKE_SWAPFILE_SIZE() on all places would mean we don't need
> {SAFE_,}MAKE_SWAPFILE_BLKS() at all. Therefore I think this check should be
> suppressed to TINFO. Other option is to use high enough value (more blocks)
> (not sure if using really small swap file makes sense anyway).

I do not think that we should use too small swap file even for the case
where we try to detect if swapfiles are supported. Currently it seems
that kernel accepts swapfiles smaller than page size, but it may also
start rejecting them with EINVAL in the future.

So I would keep the warning and rather tried to fix all the parts where
we attempt to create a swapfile smaller than page size.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
