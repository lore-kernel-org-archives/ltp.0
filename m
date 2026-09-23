Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7A6C982EA
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 11:17:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01AA03E6C15
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 13:17:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAAD73C9A7C
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 13:17:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 42BE9600D6D
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 13:17:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D61E721B67;
 Wed, 23 Sep 2026 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790162247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/868FOwB8oK3J5z1wfCxt5Qk0Z6gQsWKM5SU3xDJBE=;
 b=IdaUUWZkdUJhxwjYqSRglrQpKEuW3EyXep8F2gys39y/ryEssdQ+kSSDCvXEZYgbW4ci9g
 KbM6MpkieECBYP4SWRyZK5UBEMi4yby0rsh8CiYImPY2khuvloYNtmuXrUYqq2zvNwqCRc
 H15ytwabMlzW1HMJKxKf5QkH3WnvgqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790162247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/868FOwB8oK3J5z1wfCxt5Qk0Z6gQsWKM5SU3xDJBE=;
 b=KPB9lAv9hRXOOEeSfX7hwQyy8l58vXilffsm8hl8giJP0KBrDpBMUmoeO+zPY9k05FDIUh
 u3K4Qh/2hZoRcuCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mLDSXSzj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=crDugoHp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790162242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/868FOwB8oK3J5z1wfCxt5Qk0Z6gQsWKM5SU3xDJBE=;
 b=mLDSXSzjbfSbVPho3JE1LVkuMIhDgrqZGkSq5CP+MJjfeqV7ULwPOWkJpo/jIMkKppJDxx
 HBwZnEmgUypwh6XIGBcYc8nLaiSqI8i4cpwE7Fowc6v97K/LgP0ih/NBX+R1p0hNxpNZKt
 YosL0x1VWu2R/xnb6GLNIjkcTA+b2H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790162242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/868FOwB8oK3J5z1wfCxt5Qk0Z6gQsWKM5SU3xDJBE=;
 b=crDugoHp8sx2urJwupRHh2rw+CIF7xUpQgVUwhl/OzeyVj/NXgJk83P5lFwb8uDPW0m9Dx
 A9rBsMcZzjv4wDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80D5213432;
 Wed, 23 Sep 2026 11:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pJ0+FkK1s2rzEQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 23 Sep 2026 11:17:22 +0000
Date: Wed, 23 Sep 2026 13:17:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <arO1T65e7xn5j4_U@yuki.lan>
References: <20260903095255.4925-2-wegao@suse.com>
 <6a9a867b.de81f790.219d91.7092@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a9a867b.de81f790.219d91.7092@mx.google.com>
X-Rspamd-Queue-Id: D61E721B67
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 1/2] lib: Extend tst_assert_ulong() with enum
 flags
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
> > +
> > +	if (flags & TST_ASSERT_SATURATED_INT) {
> > +		if (sys_val_64 > (unsigned long long)INT_MAX)
> > +			expected_val = (unsigned long)INT_MAX;
> > +		else
> > +			expected_val = (unsigned long)sys_val_64;
> > +	} else if (flags & TST_ASSERT_TRUNC_32BIT) {
> 
> In 32bit compat mode `unsigned long` becomes 32bit, so we can simply do:
> 
> void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
> {
> 	unsigned long long sys_val;
> 
> 	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);
> 
> 	if (val == (unsigned long)sys_val) {
> 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
> 		return;
> 	}
> 
> 	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> 		path, val, (unsigned long)sys_val);
> }
> 
> And then, inside the test:
> 
> 	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> 		tst_res(TPASS, "shmmax clamped to INT_MAX in compat mode");

As I commented on the patch from pvorel, I do not like the blind TPASS
here. Either we put the saturated logic into the test library, or we
need to open-code it here.

> 	else
> 		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> 
> 	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> 	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
