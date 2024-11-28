Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82463D69112
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 14:26:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEBFB3DBD16
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 15:26:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAA223DBCDE
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 15:26:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6EDAC63354B
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 15:25:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DA8A1F44F;
 Thu, 28 Nov 2024 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732803958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEYkMAm+UaiCC1dfgIVpxHnLfWsUiAF1wN4xUfvlRQI=;
 b=BsSq5p2Uyj5CA5eoZnNN94hnA2TlVeezlQReMfY21u02DZqhEgIj7bhKxxQsAxMi1MqkJ4
 M3jHSUhJdFS78O8IK/jC01QAovJEwck1nt8m2H1inUooCBK/n5ZPIt8LTqGCDqJ8GVBnW1
 DIqT/bqUf66KDPVn2OZIb2B6sIIcQCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732803958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEYkMAm+UaiCC1dfgIVpxHnLfWsUiAF1wN4xUfvlRQI=;
 b=xszB7KDU5DqBoBw5yOmVuXAb9DN3QiLhTpBsHNW8sI3Y5LVvUehV9A19ujC099mvTdp0Km
 qVPfK7iYtfN2taDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732803958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEYkMAm+UaiCC1dfgIVpxHnLfWsUiAF1wN4xUfvlRQI=;
 b=BsSq5p2Uyj5CA5eoZnNN94hnA2TlVeezlQReMfY21u02DZqhEgIj7bhKxxQsAxMi1MqkJ4
 M3jHSUhJdFS78O8IK/jC01QAovJEwck1nt8m2H1inUooCBK/n5ZPIt8LTqGCDqJ8GVBnW1
 DIqT/bqUf66KDPVn2OZIb2B6sIIcQCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732803958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEYkMAm+UaiCC1dfgIVpxHnLfWsUiAF1wN4xUfvlRQI=;
 b=xszB7KDU5DqBoBw5yOmVuXAb9DN3QiLhTpBsHNW8sI3Y5LVvUehV9A19ujC099mvTdp0Km
 qVPfK7iYtfN2taDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6351613974;
 Thu, 28 Nov 2024 14:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rktVF3Z9SGe7EgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 28 Nov 2024 14:25:58 +0000
Date: Thu, 28 Nov 2024 15:26:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <Z0h9evdYZKxXGIXs@yuki.lan>
References: <20241118-convert_mmap01-v3-1-b275c90035f5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241118-convert_mmap01-v3-1-b275c90035f5@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mmap01: Convert to new API
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
> +	if (system(cmd_buffer) != 0) {
> +		tst_res(TPASS, "Functionality of mmap() successful");
> +	} else {
> +		tst_res(TFAIL, "Specified pattern found in file");
> +		return;
> +	}

Can we please get rid of this ugly hack as well?

We can easily fork a child that would read the file and look for the
pattern instead. Also we do not even have to look for the patern, just
occurence of one these letters would be a failure. So we can write even
easier loop that would just read the file and check that it contains
only valid data.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
