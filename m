Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89036C3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 22:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF26E3D1D7D
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 00:36:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 075E03D1BF9
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 00:36:06 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 84CC860075A
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 00:36:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 822A61FBEE;
 Mon, 29 Jul 2024 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722292564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMwl36MrSz7W4gOHJY23CGWqS/dh86C4c5T1ji/xGK8=;
 b=BRcyfyFuUJFIKCEfcYw5kZ0qeYCSFJREmc3lsSDgzflEJfKXzn/M+onnLMjTWlvh23TXuu
 JweVQc3K0AM/Zi9ikzg/asgELIKWV7P9gi5Q59UMhyYv+zixqVDTOB8va+oz/hyK1Bj5/I
 rbOj1w2Q9GI5NtVLAozNQ4uBfFr8V3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722292564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMwl36MrSz7W4gOHJY23CGWqS/dh86C4c5T1ji/xGK8=;
 b=XkhpIU9Yk+GjHR0ImeP8jsJ6wU/KkVrD8AdvuLjiYaVfmIOMHabAuSYm+/km9rSLk3FeQL
 dZTFwAMzZF/RMhCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BRcyfyFu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XkhpIU9Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722292564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMwl36MrSz7W4gOHJY23CGWqS/dh86C4c5T1ji/xGK8=;
 b=BRcyfyFuUJFIKCEfcYw5kZ0qeYCSFJREmc3lsSDgzflEJfKXzn/M+onnLMjTWlvh23TXuu
 JweVQc3K0AM/Zi9ikzg/asgELIKWV7P9gi5Q59UMhyYv+zixqVDTOB8va+oz/hyK1Bj5/I
 rbOj1w2Q9GI5NtVLAozNQ4uBfFr8V3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722292564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMwl36MrSz7W4gOHJY23CGWqS/dh86C4c5T1ji/xGK8=;
 b=XkhpIU9Yk+GjHR0ImeP8jsJ6wU/KkVrD8AdvuLjiYaVfmIOMHabAuSYm+/km9rSLk3FeQL
 dZTFwAMzZF/RMhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68E9C138A7;
 Mon, 29 Jul 2024 22:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mF15GFQZqGZdaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 22:36:04 +0000
Date: Tue, 30 Jul 2024 00:36:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240729223603.GA1307422@pevik>
References: <20240729223431.1307306-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240729223431.1307306-1-pvorel@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 822A61FBEE
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] cachestat01: Reduce required space on 64kb
 page size
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> First I thought we should use tst_fs_has_free() in each
> test_cached_pages() run, but test uses .all_filesystems, thus it's
> always 300 MB. Should we, just in case, use .dev_min_size = 300,
> to make sure it runs correctly even we change the DEV_SIZE_MB value?

Or for people who use custom block device passed via $LTP_DEV.

Kind regards,
Petr

> Or, should we really calculate required space with tst_fs_has_free(),
> based on page size num_pages and * 1.1 (reserved space for metadata)?

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
