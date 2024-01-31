Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681CEC47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:31:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5ED03CE0C3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:30:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FFD63CAE45
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:30:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1902D60A78B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:30:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D8C7B1FB6E;
 Wed, 31 Jan 2024 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706697043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwnkPwEz0HjCPIe1CA6eT6Z53fAJfuMzFV7gSEdTJl4=;
 b=L2+IQn3LBfXIba/N78bdwzQ4dNDXO1ujWOf+ydwEETv3rhJDZz7O+C3Qn/ZQ61X/++BU5X
 ewyAlu6JnQERVaB+UcxUgCqz29lQcW6I956yRn/RnLtLIjFNBRiXzT+WENuK98T+n/QYiJ
 10cOfH1qImSKaV+4q//QBHsHwHY+79Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706697043;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwnkPwEz0HjCPIe1CA6eT6Z53fAJfuMzFV7gSEdTJl4=;
 b=nTgPY39Jfy6B+aeiRVpep2oZ41ZT/d/89e/PZHLkQ1zHE9YkEkjon0K8rWTLe90uBIrw9n
 b5CCLBGdiKf8bBBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706697042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwnkPwEz0HjCPIe1CA6eT6Z53fAJfuMzFV7gSEdTJl4=;
 b=u4Fv1FK/EZA8kT1J9ssDnizVxTZy29nY/zsyPST/zoY+EdVKLUFvWEI/rcVd5oep3eVqxz
 sEsOqL+vPJPjn9tA0fB2wW4zAP+regfEO5GQ6ygna0kBIlCSNehJq8t/q5UY3B7/yfDpWN
 V5AbdrFGPHpzageerlcc1yhuQ0hwSww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706697042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fwnkPwEz0HjCPIe1CA6eT6Z53fAJfuMzFV7gSEdTJl4=;
 b=9IaTmsdKgDreEqACP9rik2gjOKkElaf3kdA3jrrOf9c6rk5JQvS3ga8yHNnzQXxq7gCxGY
 lUoMqpF4sawDqbCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C728D139B1;
 Wed, 31 Jan 2024 10:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xBlKMFIhumWfXgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 31 Jan 2024 10:30:42 +0000
Date: Wed, 31 Jan 2024 11:30:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZbohXx6wa4ny60G1@yuki>
References: <20240131100018.15767-1-andrea.cervesato@suse.de>
 <20240131100018.15767-3-andrea.cervesato@suse.de>
 <20240131102551.GC890138@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131102551.GC890138@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="u4Fv1FK/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9IaTmsdK
X-Spamd-Result: default: False [0.06 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.13)[67.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D8C7B1FB6E
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Increase default appends operations in
 dio_append
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
> I'm ok to keep this in single commit with increasing the number of operations,
> but it should have been at least mentioned in the commit message.

The commit changelog should mention the addition of the function to
check the available space, but otherwise it's ok.

> And, if I understand correctly, this was meant by Cyril in v1
> https://lore.kernel.org/ltp/ZbjpATp6cK9AkvBm@yuki/

I mostly object to having two unrelated chnages in a single commit,
functional fix shouldn't be cobbled togegher with a change that adjusts
default parameters.

Also the check for a free space should be ideally added into all I/O
tests eventually.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
