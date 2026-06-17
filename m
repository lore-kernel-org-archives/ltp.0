Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BE8CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 08:52:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DB4B3E5921
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 10:52:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5ACD3E1FC1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 10:52:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62B1F600905
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 10:52:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 889636A9F8;
 Wed, 17 Jun 2026 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781686341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f0BUfwIJF2qagUwvaG0t/8oMWYHUJOAMi5F0WkHL8E=;
 b=3dw1o9BJLPw3IAJ9PTHRqcekw0tetBZ8SR7eOC1cw6bKx8oSbGji0ZE8Uq5YVH+6O8N9sT
 d7K/AWqpLsDIbq/9ePQ51oIzeOGegGCH1AkyLE8sT8Sy03qbgwee8UjhYiMSDwFXrsuL+i
 QAIdqbMAZ1bkzNsv5WLQTxN0ipd1OSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781686341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f0BUfwIJF2qagUwvaG0t/8oMWYHUJOAMi5F0WkHL8E=;
 b=BmQx9gUAdgfl1NEIe7XocayRyyB++Ja2aCZbQkHGdndkyEAY4VsQoRRuB4CSe5sp38I3aV
 FjSHXwyboRTwQxAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781686341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f0BUfwIJF2qagUwvaG0t/8oMWYHUJOAMi5F0WkHL8E=;
 b=3dw1o9BJLPw3IAJ9PTHRqcekw0tetBZ8SR7eOC1cw6bKx8oSbGji0ZE8Uq5YVH+6O8N9sT
 d7K/AWqpLsDIbq/9ePQ51oIzeOGegGCH1AkyLE8sT8Sy03qbgwee8UjhYiMSDwFXrsuL+i
 QAIdqbMAZ1bkzNsv5WLQTxN0ipd1OSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781686341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1f0BUfwIJF2qagUwvaG0t/8oMWYHUJOAMi5F0WkHL8E=;
 b=BmQx9gUAdgfl1NEIe7XocayRyyB++Ja2aCZbQkHGdndkyEAY4VsQoRRuB4CSe5sp38I3aV
 FjSHXwyboRTwQxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75282779A8;
 Wed, 17 Jun 2026 08:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SaViGkVgMmr2RAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jun 2026 08:52:21 +0000
Date: Wed, 17 Jun 2026 10:52:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajJgQmumLAfPLWGk@yuki.lan>
References: <20260616114204.5636-2-piotr.kubaj@intel.com>
 <6a31618c.7f42fb59.24bb2.63c5@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a31618c.7f42fb59.24bb2.63c5@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rfim: add new test for verifying RFIM sysfs
 interface
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, daniel.niestepski@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static void check_read_only(const char *path)
> > +{
> > +	tst_res(TDEBUG, "Checking whether %s is read-only", path);
> > +
> > +	if (access(path, F_OK)) {
> > +		tst_res(TFAIL | TERRNO, "%s does not exist", path);
> > +		return;
> > +	}
> > +
> > +	int fd = open(path, O_RDONLY);
> > +
> > +	if (fd == -1) {
> > +		tst_res(TFAIL | TERRNO, "%s can't be read", path);
> > +		return;
> > +	}
> > +	close(fd);
> > +
> > +	fd = open(path, O_WRONLY);
> > +	if (fd != -1) {
> > +		close(fd);
> > +		tst_res(TFAIL, "%s is writable", path);
> > +		return;
> > +	}
> > +
> > +	tst_res(TPASS, "%s is read-only", path);
> > +}
> 
> This function can be easily replaced by access().
> 
> TST_EXP_PASS(access(path, R_OK));
> TST_EXP_FAIL(access(path, W_OK), ..);

This depends on where the error from kernel is supposed to be returned
from. For files that are generated by kernel such as /sys/ and /proc/
the permission bits can be all enabled but you may still get EPERM when
you actually open the file and kernel decides that this file shouldn't
be readable in the open() syscall handler for the particular file.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
