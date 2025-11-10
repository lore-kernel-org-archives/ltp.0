Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD7CCCF9E3
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 10:31:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 769743CF581
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 11:31:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFEBE3CF55A
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:30:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1442E140099D
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 11:30:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D980D1F397;
 Mon, 10 Nov 2025 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762770651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo17ROzag00kiyHTHgB3ueSHvPYANNyZ9eSMteQaLkU=;
 b=h3wXo84WWfiBP1xthavCNtBTO3YKglIjROEWNr/tOhmtpMPecyPE8q+tjfvLvrki019S/k
 I1vCUvGBClEY7tNPd9CS6eGm4NXXFifBNLb9wjzQxnkzoBz6hx2i/EmVJVx2RzG9ZFDC6P
 z5a9XUlTESSYXduLmbNJFkhi+weG9bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762770651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo17ROzag00kiyHTHgB3ueSHvPYANNyZ9eSMteQaLkU=;
 b=PweIq3iprwO8UiG3MDaxeRbq4UGZTRF9jdoIFmcVTiHQSbrhyeWq910y9mW9liHwi6esns
 dNxsyKl9xLwU9sAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PIxwDxlC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K5zAwyyL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762770650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo17ROzag00kiyHTHgB3ueSHvPYANNyZ9eSMteQaLkU=;
 b=PIxwDxlCleLY1Gdg5IbC4K9UdOVHN1UBwkE61M5Ygx6WHdo8VuBJYlsQWSM7Whu//xJfOw
 z+L/wLLajfgx1bIM0TtR6bPjwxpR1eLIs+JHcSRf2ni/eLfLB1hmLSkNCujLPbEAJFNsuw
 71py9bmOgAbxeUdVWveBW7DQLKp/rik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762770650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo17ROzag00kiyHTHgB3ueSHvPYANNyZ9eSMteQaLkU=;
 b=K5zAwyyLbJ8pu7B8U+w/hX2IHE8o3c5ktEULmKXCWRuvI+pxDL/IxflRyKTMg7h8t9EGhr
 gawXDxS+DGdkTNBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE85E14346;
 Mon, 10 Nov 2025 10:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4xuqLdq+EWnoJQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Nov 2025 10:30:50 +0000
Date: Mon, 10 Nov 2025 11:31:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <aRG_Cv1_AbZivQs0@yuki.lan>
References: <20251106114337.550054-1-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251106114337.550054-1-piotr.kubaj@intel.com>
X-Rspamd-Queue-Id: D980D1F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, ozlabs.org:url,
 yuki.lan:mid]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
FYI I've just send a patch with a basic documentation for the shell test
library, feel free to comment if there is anything unclear there:

https://patchwork.ozlabs.org/project/ltp/patch/20251110102407.15308-1-chrubis@suse.cz/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
