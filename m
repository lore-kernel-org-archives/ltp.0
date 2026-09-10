Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92C2C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 14:45:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C515C3E836E
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 16:45:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 986963D03B0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 16:44:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1363602447
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 16:44:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B3031FDF1;
 Thu, 10 Sep 2026 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789051482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXu6mEPh0hMjeJXc9joaOb6oCqcWsiQDxPW6opAmeos=;
 b=Nsv1fbsP+k7LAQtOLrxODs/mymImMYb4u+33LR70UBSUA6LZBp+T33qeojASJe/rI1Wr+7
 CnitXmlVWQ+hpWRh/eEl2s7rOaM2AATqhYvMU4rJrRZoa2qWdbVYeTWqwQz3/cwi0aIjJz
 TqF0ioXFf4eWKRqI1jI9BYaZER2W2pU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789051482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXu6mEPh0hMjeJXc9joaOb6oCqcWsiQDxPW6opAmeos=;
 b=gbd6+Is6Wedoiwbvhaerx9kRUWtHMjdqAGuMil4MMeBF6cFt/v5HSYI+Ay6I2ROnGNhuIX
 wLukBvW7w5XfABCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789051478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXu6mEPh0hMjeJXc9joaOb6oCqcWsiQDxPW6opAmeos=;
 b=Hkuaye3gfKl5KygLmZeEGdmrgteWrMqfZyAD7gKmAyRaxIGBV+Mj7wCwhkeuRzYZGJWk/J
 tAg4MF8o5Kc7QsAadGgtTeHm23XSa/q3V2UQuCRafOflPmspx3Merol1nZlw564en8xyPM
 0nz6n7YsOUxQmQsvuEsBCnRSb03ocpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789051478;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BXu6mEPh0hMjeJXc9joaOb6oCqcWsiQDxPW6opAmeos=;
 b=Rk218ouZ0hvfDl9fprM5PpDpHnlgJUOXDYGUVzSP0j2ddReWfKqDLFnTs9zWtnohYUumnt
 lyMYk0p1OHx5w3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A58913180;
 Thu, 10 Sep 2026 14:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hvV/AlbComomYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Sep 2026 14:44:38 +0000
Date: Thu, 10 Sep 2026 16:44:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <aqLCW1fWNGxTX8mo@yuki.lan>
References: <20260904-min_kernel-v2-1-9991d3fb3c18@suse.com>
 <apqTA2QG3LdEVX5F@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <apqTA2QG3LdEVX5F@linux.dev>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Check minimal supported kernel version
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Define the minimal supported kernel version in tst_kvercmp.h so that
> > the documentation fetches it dynamically and the core library aborts
> > unsupported kernels with TCONF during test setup.
> 
> The description doesn't match the code.
> Other than that, it looks good to me.

Indeed. Feel free to add my reviewed by with this description adjusted.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
