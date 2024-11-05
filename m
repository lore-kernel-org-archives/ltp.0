Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA24FD2B924
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:16:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18B673D2238
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 14:16:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17C373D2211
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 14:15:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A41CB101C584
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 14:15:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB13121D67;
 Tue,  5 Nov 2024 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730812547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJNeZpuGJ71k5Y5T/YRUN5OA2g3LCoJKmggRtECXez4=;
 b=WlMfOD7Dtzbn3FjbtTYYoaLRblP6Y8mOFoRdn0t85o+HefW0Lz7yoLhKAimJIYv7iQTBsB
 vOND9Rx5nj7iOfNHT230SWUnEUm32e8jo0ODojsiFNVfoc9sfLdr0TafpK+xOZlX95xW76
 di0M0VsG1SMIzQ7KZqEwt88Cekz79/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730812547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJNeZpuGJ71k5Y5T/YRUN5OA2g3LCoJKmggRtECXez4=;
 b=O+rzGQhtqYuF9XNixXspxK51XzIsBKZNGxX/wQGE/4e+Ix6PwE/jE1fJrA9W/OB3Y5/7Cx
 PRA2K3SMQb2wyJCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730812546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJNeZpuGJ71k5Y5T/YRUN5OA2g3LCoJKmggRtECXez4=;
 b=l/YHMEKE40kVLiwaF+bphxbFQ18tpjrxPV+8BZ/gkArG/74JtEg2wUjXFWVKnBmYMA9EfA
 n4fIqUDfU2bjkPHG53umS3fqmifexIK5u/rAnRgfZmynUFmUXUP87VrBQVUXYmhj1wZlkf
 dwbVO95GlEQZzbZUSWjdvZJzBHuRd0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730812546;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJNeZpuGJ71k5Y5T/YRUN5OA2g3LCoJKmggRtECXez4=;
 b=f0JZY+3i/ebn2Ai1sf4FCZn71bWcPOs4IcXHRWZQ0LWT8HAmWJMPGtEFsYO0qMTmqYF8++
 ukR7anskE+nvf5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF1231394A;
 Tue,  5 Nov 2024 13:15:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9l6SLYIaKmebCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Nov 2024 13:15:46 +0000
Date: Tue, 5 Nov 2024 14:15:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zyoah1Av6lmabsw0@yuki.lan>
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
 <CAEemH2fCcYOzMhFHhQKL_=sPK1Q_RZp6H+jWW-BGuJEc7Xv1Yg@mail.gmail.com>
 <CAEemH2fTYRM_OC8szbFtByrdB_u9yGTKzMLhMKT077mmML00qg@mail.gmail.com>
 <a5e05496-76c0-432c-8779-84ab573a8b7d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5e05496-76c0-432c-8779-84ab573a8b7d@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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
> In this way it could work, but we loose guarded buffers which are passed 
> to the syscall and might be useful during debugging. In this case we 
> should use tst_buffers_alloc(). @Cyril what do you think?

That woudln't work either, since we cannot allocate "half a structure"
can we?

Unfortunatelly I think that having a per API version structures is the
cleanest solution. Because:

- our tests should run everywhere they can, that means that we have to
  use the minimal ABI that is required for the test

- important part of the backward compatibilty testing is that there are
  no accesses past the declared ruleset size, which can be easily done
  by the guarded buffers provided that we allocate exactly the size
  needed

And backward compatibility also means that we have to properly handle
the case when we need newer ABI than currently supported, so the
verify_landlock_enabled() needs a size parameter so that we can check
that the ABI is >= than the minimal ABI the test needs...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
