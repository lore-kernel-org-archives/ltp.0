Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B360EC8302B
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 15:01:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13AD13C6234
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 17:01:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80E513C25D8
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 17:01:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C68AA1A0093A
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 17:01:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E44221163;
 Mon, 30 Jun 2025 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751295683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpeuu1i0hG6oz1BNmpoZIAeZoDIey7eiOSvcRJPDZto=;
 b=2JEWzckhOdE1E3DVEm7MgC4QW6i4kzm8VlEA+w8b4VmYmNzT31BtawG+P93N1axrpsXagg
 RSS1iN4r8cJ04Pex0hf6H1wngkkHF+IPhK/qESnldh40o97eLKHj8acQ20EUPnwBJUtc1s
 Z3inV+QuRJGdXPnv971GplCZrpGNG4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751295683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpeuu1i0hG6oz1BNmpoZIAeZoDIey7eiOSvcRJPDZto=;
 b=BTgyH0lbjFWi7HqieokLXz1hngVadUfk/FqaNbi6dgHfvWVWIVY+6JU5r+PbiTFVgt/v4f
 hMrtq1WwmhtBw7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751295678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpeuu1i0hG6oz1BNmpoZIAeZoDIey7eiOSvcRJPDZto=;
 b=3MgA6T8/GfISsm3Fs4Fc73fdrBxRmYFwVVbOMuCrklZHKP1Yz1ru4QastxupzOiBadJ0io
 ilyyCpsZ9sLCLbZmH7tv96Vvma/G1MPm12XLfUnOiyNzjtIe3+jzwNLm12fkeCKhEp9gR4
 8brg9iBo4qq7Z+s1gvhVp4Rr4zwISZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751295678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpeuu1i0hG6oz1BNmpoZIAeZoDIey7eiOSvcRJPDZto=;
 b=otx37kRpvYYcRv7MyRq50OcVIT1KXjCRBIaNJAqaRWDOVWXZCpmA9oEa2Buy+UKWsOOlye
 ixbH87IU589WBBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13C3D1399F;
 Mon, 30 Jun 2025 15:01:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oq12Ar6mYmhNewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Jun 2025 15:01:18 +0000
Date: Mon, 30 Jun 2025 17:01:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aGKm59Zih2G8R6r9@yuki.lan>
References: <20250624-crash02_rewrite-v2-1-c4eaeee8598f@suse.com>
 <39406791-8bbd-4447-bbcd-0b25710a55e8@suse.cz>
 <aGKiB73K8c3S4Tiu@yuki.lan>
 <602a151d-4579-4975-86f5-168fb6f49884@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <602a151d-4579-4975-86f5-168fb6f49884@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RSPAMD_EMAILBL_FAIL(0.00)[chrubis.suse.cz:query timed out];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] misc: rewrite crash02 test
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
> Either one is good, but you still need to update runtime according to 
> command line arguments.

Only if you want to keep ntries parameter, I would just make the test
completely runtime controlled instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
