Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE33C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 15:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23F7C3CF2B4
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 17:48:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDACE3CF2B4
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 17:48:01 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32DD51A003D4
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 17:48:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B82E1F8B8;
 Fri, 26 Jul 2024 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722008880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZEEv886Dog5RNhsyCRAyrsqYGgNQYChjmcUu93zIjw=;
 b=gXSB+13cjfsOx+QjyZSwTucWGInBtvWI7idF40NGKn8aj7DAHVlaORPUzLIr12zCtb46VF
 jodYqcWp1PIghezYI6m4DV9Ye44TSeNsBFoCVT3yRUTSxokbkWJVzjweS1Cr5EXYlukPJE
 ik98+lg0Hdb6IsbQVO09fscVodLze1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722008880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZEEv886Dog5RNhsyCRAyrsqYGgNQYChjmcUu93zIjw=;
 b=Tcm+4Rr0ThLKFttjuA+GE4fo1U9HssMSqlZMCOdMMXKfMp76aA/1vTWpWUJ5jjtQHuvXGK
 yOC6tVCaCoc6LdAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gXSB+13c;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Tcm+4Rr0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722008880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZEEv886Dog5RNhsyCRAyrsqYGgNQYChjmcUu93zIjw=;
 b=gXSB+13cjfsOx+QjyZSwTucWGInBtvWI7idF40NGKn8aj7DAHVlaORPUzLIr12zCtb46VF
 jodYqcWp1PIghezYI6m4DV9Ye44TSeNsBFoCVT3yRUTSxokbkWJVzjweS1Cr5EXYlukPJE
 ik98+lg0Hdb6IsbQVO09fscVodLze1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722008880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZEEv886Dog5RNhsyCRAyrsqYGgNQYChjmcUu93zIjw=;
 b=Tcm+4Rr0ThLKFttjuA+GE4fo1U9HssMSqlZMCOdMMXKfMp76aA/1vTWpWUJ5jjtQHuvXGK
 yOC6tVCaCoc6LdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E5631396E;
 Fri, 26 Jul 2024 15:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id abQ5AzDFo2ZtNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jul 2024 15:48:00 +0000
Date: Fri, 26 Jul 2024 17:47:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqPFF7BovWnpZu8T@yuki>
References: <20240119092909.22806-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240119092909.22806-1-andrea.cervesato@suse.de>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 2B82E1F8B8
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewritten symlink01 test
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
> This test has been split and rewritten. Now it verifies the following
> symlink() syscall features:
> 
> - symbolic link is created from a non-existing folder
> - symbolic link is created from existing folder
> - syscall raises EEXIST when symbolic link already exists
> - syscall raises ENAMETOOLONG when path name is PATH_MAX long (or above)

I had a quick look at the status of this and it seems that there are
still a few missing parts, namely:

$ git grep symlink01 runtest/

runtest/syscalls:chdir01A symlink01 -T chdir01
runtest/syscalls:chmod01A symlink01 -T chmod01
runtest/syscalls:link01 symlink01 -T link01
runtest/syscalls:readlink01A symlink01 -T readlink01
runtest/syscalls:rename01A symlink01 -T rename01
runtest/syscalls:rmdir03A symlink01 -T rmdir03
runtest/syscalls:symlink01 symlink01
runtest/syscalls:unlink01 symlink01 -T unlink01

And the only patch apart from symlink01 conversion on patchwork seems to
be rename15:

https://patchwork.ozlabs.org/project/ltp/patch/20240424092357.11207-1-andrea.cervesato@suse.de/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
