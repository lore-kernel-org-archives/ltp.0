Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3606C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 19:35:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7C2A3CE28C
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 20:35:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A28E93CAF8E
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:35:35 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D8C6860006F
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:35:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F29F41FD40;
 Sun, 21 Jan 2024 19:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705865732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syEHoZftVfhgGw78U8o0995JGS09JTuynDN3NkDdn8s=;
 b=26rkh6NCpXjlMDXQu2/TtNpb26ovyMn0dwOszB0gxUytUYSKy/e7kc7B/CY6Xq9VOWpPB2
 d6X/wMCxcK5gB6yWUa5lcFwEsFelWAphRB+y3zZyFLSLe0FozZDEAVpl6GwoJvvg4PVBqM
 HbzVl9zyFGJCXCronhlNql7cfM64mRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705865732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syEHoZftVfhgGw78U8o0995JGS09JTuynDN3NkDdn8s=;
 b=oc7/UCDqM9s1yIzCvOduTFr6Ggw0/nESIAb6VEU4S17Sx601EYlFusdNNLJJ8EcLnwYgHH
 iVXgFdJx5gtBmHCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705865731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syEHoZftVfhgGw78U8o0995JGS09JTuynDN3NkDdn8s=;
 b=ImRULln2ATK1GEn1jAfo51WEIoRvMo1jwoFh1YUaLoOSNxpf5N3t1Od2k2HmwEzNRso1jK
 fndlvBxNmyZjdxZaoqMyXR18BUfE5bOCkNQA/LDs87J0qQykUlWSWW+iTgy8CYrUzt5rdB
 9fydKUPD411go7Gmzuk/TNsy0G1hwvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705865731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syEHoZftVfhgGw78U8o0995JGS09JTuynDN3NkDdn8s=;
 b=3+h+C3qb6uFhwWNTWIVn8+qaqQbyh93qILRHC6B8/FWTqE5ywKrFnrFO4Do+PSNmRdmigc
 ZTLxlqZlIJlkYDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C6D613995;
 Sun, 21 Jan 2024 19:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NQ/CIwJyrWXRKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 21 Jan 2024 19:35:30 +0000
Date: Sun, 21 Jan 2024 20:35:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20240121193528.GA51882@pevik>
References: <20240118191353.2815915-1-pvorel@suse.cz>
 <20240119153305.bzqn3ehrzgrgs3ud@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119153305.bzqn3ehrzgrgs3ud@quack3>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ImRULln2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3+h+C3qb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.78 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.07)[62.76%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: F29F41FD40
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] readahead01: Pass also on memfd secret
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> Yes, memfd secret is standard tmpfs file in principle so readahead(2)
> succeeds. Feel free to add:

Jan, thanks a lot for having a look!
Fix merged.

Kind regards,
Petr

> Reviewed-by: Jan Kara <jack@suse.cz>

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
