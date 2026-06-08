Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD85CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:19:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98E123E4E86
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:19:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A43C3C0039
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:18:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 423B36001E7
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:18:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 689077591C;
 Mon,  8 Jun 2026 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780910337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bfPfhua5wnuDSJ6XfpJDZweO+zqkqYomBNgG4IvnCU=;
 b=LrzQGF/xjJiyGNs1GAnZd2aQ6eZguY+Q9VbhnaxnlNsVkqwlVIy6gKiWxqoM5XQ46Oy1PF
 dRcvlf/gVVEbUp0V13VnJZfbi064OvWFw/5GAKzX5TQMlx4l6jPmlc3k5+mndUoml6SzDI
 GdHOpbkqeeivq5Zgi22+xGZR4cJMzjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780910337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bfPfhua5wnuDSJ6XfpJDZweO+zqkqYomBNgG4IvnCU=;
 b=UL44d8Xxwh5wkoouUVzYtI/H8cbOP+eyTlEewGsh5bSwLq+5m8KVHZBNIOCOJsQBjBcev8
 j3i+1xfwzuu/TlBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1gTJGVIR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LXx9obit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780910333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bfPfhua5wnuDSJ6XfpJDZweO+zqkqYomBNgG4IvnCU=;
 b=1gTJGVIRAqhhVlTs2JVjF4r4JFfkXaOr6xh98bOFJA1jzTjnFN/zmVCCQmm+ZvJaThoerU
 lKc94yJSqiUPZA0zRtWS0cIMVNQE7rJ7W/5zsAz8lnUPxwp3S2ayZCawkc4K7LjvG/TIC9
 vjeT6L7GDgfx3FBQYAisz2AvRLxgliY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780910333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bfPfhua5wnuDSJ6XfpJDZweO+zqkqYomBNgG4IvnCU=;
 b=LXx9obitESRJLMR+1bKYXXxi3cxbMrpJQYEHY9SmVDA3MtONMjPc1HCmXSLKNGNTbr9LPQ
 pcpXO6EUQ7H4x3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58491779AA;
 Mon,  8 Jun 2026 09:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UeZXFP2IJmruewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jun 2026 09:18:53 +0000
Date: Mon, 8 Jun 2026 11:18:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aiaI90UCa6OTP3dN@yuki.lan>
References: <20260608074419.1276-1-wegao@suse.com>
 <20260608085931.3981-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260608085931.3981-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 689077591C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email, suse.cz:dkim,
 yuki.lan:mid, linux.dev:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ksm: Fix sysfs path concatenation in ksm_test.h
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
> On Mon, 8 Jun 2026 07:44:15 +0000, Wei Gao wrote:
> > ksm: Fix sysfs path concatenation in ksm_test.h
> 
> > Fixes: 40a366b53adc ("lib: Introduce tst_path_defs.h to consolidate system paths")
> 
> This commit hash does not exist in the LTP repository. Could the
> reference be verified and corrected?
> 
> Verdict: Needs revision


@Andrea the bot still misses existing patches:

$ git log 40a366b53adc

commit 40a366b53adc477d950cc73f071b0cd4ebe25f85
Author: Li Wang <li.wang@linux.dev>
Date:   Thu Jun 4 17:41:59 2026 +0800

    lib: Introduce tst_path_defs.h to consolidate system paths

    We have a lot of hardcoded strings and duplicated macros for /proc
    and /sys paths scattered throughout the testcases.

    This patch introduces a new common header, tst_path_defs.h, to centralize
    and standardize these path definitions. By unifying these macros, we
    reduce code duplication, improve maintainability, and ensure consistent
    path usage across the entire LTP codebase.

    Signed-off-by: Li Wang <li.wang@linux.dev>
    Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
    Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
