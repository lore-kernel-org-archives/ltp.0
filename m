Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B63E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 11:02:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F08A3C0748
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 12:02:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC74D3C068A
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 12:02:07 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81D23103AAFE
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 12:02:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 143D71F397;
 Fri,  3 Jan 2025 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735902122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnJ8GiSh/H/P0Hn8X0TQBc9uNCFgxKDCwTnCc3yepfk=;
 b=laXq6apg+u/vEql7bNbvJntPXxVWOfWC/qfmLHzu1JylwJ2nFmiSSf40/gTlp5qDTZ+O7Z
 wFFdPeGUS8rwfAkPlmL/t9a6YxnG615M5YfNR7iW2lz9a6rUFVMKmxBhUZrwCQYBaSP2/m
 HQ5BFlYgJX2zkOXqtQRSWPXBF5kNmpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735902122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnJ8GiSh/H/P0Hn8X0TQBc9uNCFgxKDCwTnCc3yepfk=;
 b=SCJWvmLmj2R5lipB9WGCL3Ym7IdfeXZ99whLaOyJeEAh6vJQvxrjDhnRoK6/kQZsBgM7rA
 /b+v3JdM07w0FeDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=laXq6apg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SCJWvmLm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735902122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnJ8GiSh/H/P0Hn8X0TQBc9uNCFgxKDCwTnCc3yepfk=;
 b=laXq6apg+u/vEql7bNbvJntPXxVWOfWC/qfmLHzu1JylwJ2nFmiSSf40/gTlp5qDTZ+O7Z
 wFFdPeGUS8rwfAkPlmL/t9a6YxnG615M5YfNR7iW2lz9a6rUFVMKmxBhUZrwCQYBaSP2/m
 HQ5BFlYgJX2zkOXqtQRSWPXBF5kNmpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735902122;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnJ8GiSh/H/P0Hn8X0TQBc9uNCFgxKDCwTnCc3yepfk=;
 b=SCJWvmLmj2R5lipB9WGCL3Ym7IdfeXZ99whLaOyJeEAh6vJQvxrjDhnRoK6/kQZsBgM7rA
 /b+v3JdM07w0FeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D407F13418;
 Fri,  3 Jan 2025 11:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AA2EManDd2d2JwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 11:02:01 +0000
Date: Fri, 3 Jan 2025 12:01:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250103110156.GA199182@pevik>
References: <20241113-setresgid_refactoring-v1-0-b6d07400e374@suse.com>
 <20241113-setresgid_refactoring-v1-1-b6d07400e374@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241113-setresgid_refactoring-v1-1-b6d07400e374@suse.com>
X-Rspamd-Queue-Id: 143D71F397
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Refactor setresgit01 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Simplify general structure, using struct passwd only when it's strictly
> needed and use new LTP API.

Rewrite LGTM, but there is a problem with 16-bit version.

Old version when compiled for 64bit it quits with TCONF:

# ./setresgid01_16
...
TCONF  :  utils/compat_16.h:146: 16-bit version of setresgid() is not supported on your platform
TCONF  :  utils/compat_16.h:146: Remaining cases not appropriate for configuration

But when running your patchset it runs the test:
# ./setresgid01_16
...
setresgid01.c:67: TPASS: *tc->exp_rgid == cur_rgid (0)

This was caused by using SAFE_SETRESGID(...) instead of original SETRESGID(),
which is needed to employ the check for 16-bit support.

Therefore I merged with this change:

-       SAFE_SETRESGID(*tc->rgid, *tc->egid, *tc->sgid);
+       TST_EXP_PASS(SETRESGID(*tc->rgid, *tc->egid, *tc->sgid));
+       if (!TST_PASS)
+               return;

Besides using SAFE_SETRESGID() would in failure resulted in TBROK instead of
TFAIL (usually subject of testing should result in TFAIL, not TBROK).

Thanks for your work!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
