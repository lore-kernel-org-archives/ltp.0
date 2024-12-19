Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20266E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:29:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3F233ED3FC
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:29:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CEC13ED3FC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:29:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E4644146A256
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:29:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A6BE1F44B;
 Thu, 19 Dec 2024 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifYV3VS55GtXN8UteTVAozgAypKfxqW8NVMw/nWP0x4=;
 b=CBvkjx70vnVEdEbYG8oqYkeVhDVfja77qgxqFkS/ge6pJY0JY20EMWeVrgzULvNzSw/tOy
 ZZadE/QR4STiItROAgHFy0MdM7DC8utc2wA0+Wr7dBkXYfA7MEFw5BE757RtIcRc4CN6B0
 Yjpo7zbDbAKIMZwd8jOwKfMnEa5Nc2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifYV3VS55GtXN8UteTVAozgAypKfxqW8NVMw/nWP0x4=;
 b=wI3TCzF5qIaIloxtbJHwi+MnpWGwnp1kBjCFozStWUD00P35l94TsevQXEscb/sDQ/7LKJ
 n6N0FQKVE5jDOTCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734614962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifYV3VS55GtXN8UteTVAozgAypKfxqW8NVMw/nWP0x4=;
 b=CBvkjx70vnVEdEbYG8oqYkeVhDVfja77qgxqFkS/ge6pJY0JY20EMWeVrgzULvNzSw/tOy
 ZZadE/QR4STiItROAgHFy0MdM7DC8utc2wA0+Wr7dBkXYfA7MEFw5BE757RtIcRc4CN6B0
 Yjpo7zbDbAKIMZwd8jOwKfMnEa5Nc2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734614962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ifYV3VS55GtXN8UteTVAozgAypKfxqW8NVMw/nWP0x4=;
 b=wI3TCzF5qIaIloxtbJHwi+MnpWGwnp1kBjCFozStWUD00P35l94TsevQXEscb/sDQ/7LKJ
 n6N0FQKVE5jDOTCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39E6613A32;
 Thu, 19 Dec 2024 13:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iYdEDbIfZGeqFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Dec 2024 13:29:22 +0000
Date: Thu, 19 Dec 2024 14:29:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z2Qfs0C6_TAre2-o@yuki.lan>
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <20241219130738.GA111004@pevik>
 <CAEemH2d_P7y+y+P91Lxxi8jBVN1mEjWtt4fh6CRQ07+Bv0yp9Q@mail.gmail.com>
 <20241219132800.GC111004@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241219132800.GC111004@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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
> > Sure, but I am wondering do you running the latest LTP branch in productive
> > env?
> 
> We mostly run LTP stable branch with some exceptions: openSUSE Tumbleweed and
> few products in development. Usually it would be more work to backport fixes
> to stable package than running master. But sometimes we get a punishment for
> this approach :).

It's also best CI for LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
