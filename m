Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB5DC4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 12:09:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474843CFBC8
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:09:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 489C03CFB98
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 14:08:59 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 24D6A60103A
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 14:08:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E07F434EB7;
 Thu, 18 Apr 2024 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713442136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zoFkDQ7CHTOq+X8WyiAfazHTJVas9WIOHaG3lKoohE=;
 b=War2h/Iknc1WGKblBxEodsgaNBut5Xx8ba80H5CN81LsNepLSg8KhwV7Ue0GFgeJojOCN2
 b5GLpKHZDLTYZvWJ+uwQUlQ15rg/IYIbE9cxlWreRRIiDOwvZaMGF/yEfT6iAthQVGWSQF
 YjK2Dk8IMIs6qmci60I8qbHpwjC3xxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713442136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zoFkDQ7CHTOq+X8WyiAfazHTJVas9WIOHaG3lKoohE=;
 b=4GCR72vFtuQD2CivcEN6++ZoWJ/UmBzfmIue1bm1Ve2WRULL0evCGb5lAGcSyHeKvX7ZWh
 szxMigFCxXUVN4AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713442134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zoFkDQ7CHTOq+X8WyiAfazHTJVas9WIOHaG3lKoohE=;
 b=HYyBM7Pdivrq/svOtfWfvg5res4dJ/aDWbKyRd83kGS5YL9Ip7eJ5hUzLWlLrFKvPOTdg6
 /6kww3UD1j/daS85IcgH1zntPLGeHv5qINMv/TyDvKlnLd9GNQnZrTiTQtPrITjQKHKyk+
 EgQF71Ie8w9wGbZ/sp6Afb3iUHlxhoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713442134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0zoFkDQ7CHTOq+X8WyiAfazHTJVas9WIOHaG3lKoohE=;
 b=mHB5vlBYp7W3qO5j5bvkNrJ4JmWz8Tr0M6uML1/rf7RespnQMbWKtUcGG6DqXZ7HNPVS0J
 u0r6Z+S9CN/1d8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB6C013687;
 Thu, 18 Apr 2024 12:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IP/cMFYNIWZQcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Apr 2024 12:08:54 +0000
Date: Thu, 18 Apr 2024 14:08:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZiENKCoyPNerXCwJ@yuki>
References: <b5872e1e-723f-4444-ae9c-39fd8b9d39fd@suse.com>
 <20240418113204.GA70047@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240418113204.GA70047@pevik>
X-Spamd-Result: default: False [-6.98 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.18)[96.06%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 8th of May 09:00 UTC
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> 8th May is a public holiday in the Czech Republic. I guess some of us will not
> be available in the call (definitely not me). Could we postpone a week later?
> (although it would work for me, there might be people taking 2 days of vacation
> on following Thursday and Friday).

I will not be around at 8th May either.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
