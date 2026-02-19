Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C59E9A048
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 11:24:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A9973D073E
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 12:24:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48A4D3CA4ED
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:24:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6364F1A00813
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:24:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C96A53E6DB;
 Thu, 19 Feb 2026 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771500252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90cKF7e1qfba/anQ3fpXRkSTJRQE7PcKxgw/NdaCQCQ=;
 b=fFdwHkJWrFhgNbxPrSeurbGKUtD1tsu1MbiYSwLhnfu9CzSGLX0TYNpbc3JsOFOKdgHeOk
 XIazcqAlAyzJSFTt1ML49lfxKnaYleENaWJ99tBfm39Q9ZEvjGpWquYZyDPY3WtAdBn+9M
 zyDzM9RxEUbs8og/iqEA1cevArmnrMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771500252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90cKF7e1qfba/anQ3fpXRkSTJRQE7PcKxgw/NdaCQCQ=;
 b=HS6f9YMwtRD7GWNJLZ8FXQRJ5l3Kg0vbzonfy52cRhcSr0ryvs1GGnhNe+XqNynW2vHSzZ
 y1d+FTwUNm0BDDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771500252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90cKF7e1qfba/anQ3fpXRkSTJRQE7PcKxgw/NdaCQCQ=;
 b=fFdwHkJWrFhgNbxPrSeurbGKUtD1tsu1MbiYSwLhnfu9CzSGLX0TYNpbc3JsOFOKdgHeOk
 XIazcqAlAyzJSFTt1ML49lfxKnaYleENaWJ99tBfm39Q9ZEvjGpWquYZyDPY3WtAdBn+9M
 zyDzM9RxEUbs8og/iqEA1cevArmnrMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771500252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90cKF7e1qfba/anQ3fpXRkSTJRQE7PcKxgw/NdaCQCQ=;
 b=HS6f9YMwtRD7GWNJLZ8FXQRJ5l3Kg0vbzonfy52cRhcSr0ryvs1GGnhNe+XqNynW2vHSzZ
 y1d+FTwUNm0BDDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A53B73EA65;
 Thu, 19 Feb 2026 11:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GtYnJ9zylmlMKgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Feb 2026 11:24:12 +0000
Date: Thu, 19 Feb 2026 12:24:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aZby3eA2UvAnpWzd@yuki.lan>
References: <20260218135026.159676-1-rbranco@suse.de>
 <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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
> > +	SAFE_PTHREAD_JOIN(thr, NULL);
> > +	reset_pages();
> 
> This should also go into a cleanup(), otherwise if other syscalls will
> fail (ioctl for instance), memory will be lost.

Technically all memory is released when last reference to it is removed,
which happens on process exit. So no mmaped() memory is not going to
leak.

> > +	if (poison_fault_seen && sigbus_seen) {
> > +		tst_res(TPASS, "POISON successfully triggered SIGBUS");
> > +	} else if (poison_fault_seen && !sigbus_seen) {
> > +		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
> > +	} else if (!poison_fault_seen && sigbus_seen) {
> > +		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
> > +	} else {
> > +		tst_res(TFAIL, "No poison fault or SIGBUS observed");
> > +	}
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.min_kver = "6.6",
> 
> This is not needed, we should use UFFDIO_API instead, in order to verify
> that UFFD_FEATURE_POISON is present and eventually TCONF.
> 
> 
> Also, if I run checkpatch.pl on the code I get:
> 
> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> #25: FILE: userfaultfd06.c:25:
> +static volatile int poison_fault_seen;

For variables changed from a different thread atomic operation are
better than volatile, i.e. tst_atomic_load() and tst_atomic_store().

> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> #26: FILE: userfaultfd06.c:26:
> +static volatile int sigbus_seen;

This one is wrong, volatile is correct for variables changed for syscall
handlers.

> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
> #88: FILE: userfaultfd06.c:88:
> +       volatile char dummy;

I do not think that volatile is needed here.

> WARNING: braces {} are not necessary for any arm of this statement
> #120: FILE: userfaultfd06.c:120:
> +       if (poison_fault_seen && sigbus_seen) {
> [...]
> +       } else if (poison_fault_seen && !sigbus_seen) {
> [...]
> +       } else if (!poison_fault_seen && sigbus_seen) {
> [...]
> +       } else {
> [...]
> 
> total: 0 errors, 4 warnings, 134 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> userfaultfd06.c has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> If you have `b4`, please run `b4 prep --check` before sending the patch.
> 
> -- 
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
