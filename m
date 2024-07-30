Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB5C3DA61
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:50:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F223D1D8A
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 11:50:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 866253CEB69
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 11:50:20 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F2E311401207
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 11:50:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B804A1F7EC;
 Tue, 30 Jul 2024 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722333018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BG4dIZdJYOtb/bUUkxJo+cYty81sjM97YWQDTsCdcr0=;
 b=O+jGnItchJmPcaL/g0vHIW23VlGNXZV4RDLk2XOSAQ6BJW8A96fOz3b39jJ0NxOInxRQ0U
 JyRp6EL1wL0x9coc/aP/EBX7IAlgbck1RYyH4iTxRM+WyKKq0gukv73FG/7EHlG/czQw4M
 cNFqSzuwAkadru89YOp4YlZqS7ybsYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722333018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BG4dIZdJYOtb/bUUkxJo+cYty81sjM97YWQDTsCdcr0=;
 b=P69uBSGqRTiW8l4LC4xcQAU3SX8VdUwvgnQvlPqIGXyokTQ6KXxY2MZ/9C8Y3vqnoid0Wj
 bgKxhFsHSByzhmDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ghuNUSA5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dh2jlg7z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722333017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BG4dIZdJYOtb/bUUkxJo+cYty81sjM97YWQDTsCdcr0=;
 b=ghuNUSA50rlXn4vEkysED94H0MdbrmmPzXoWIqWDbNWfjGofM1sACsukm9u9IxaKbgiUNT
 Q8h1SBAj59Rk48mDPWDRWOBCfXeNMceNIUSX1ouFZxFYu2czAw0dXtYXK1zRBVdlJehSDE
 3Su3QKfSvsqi/glzUAhmqOQg59Lkz6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722333017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BG4dIZdJYOtb/bUUkxJo+cYty81sjM97YWQDTsCdcr0=;
 b=dh2jlg7zVBr/jwfOWR9uY7MLtgNFx+zONtvYvQTtvJlkpAQFbUuKubkMzjb5Gr4pykg2XZ
 JgJA9+GVF5P9yXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A895F13297;
 Tue, 30 Jul 2024 09:50:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i+vAJ1m3qGYPGwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jul 2024 09:50:17 +0000
Date: Tue, 30 Jul 2024 11:49:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Zqi3OWYrcAVGTNl0@yuki>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <7787ae84-8c5a-4f31-815b-afb12fce2575@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7787ae84-8c5a-4f31-815b-afb12fce2575@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B804A1F7EC
X-Spamd-Result: default: False [-3.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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
> $PWD is not the correct path. It should be set as follows:
> 
> testdir=$(dirname $0)
> export PATH=$PATH:$testdir:$testdir/tests/

This does not work for tests that have .needs_tmpdir because $(dirname
$0) is '.' I suppose that we need realpath as well:

testdir=$(realpath $(dirname $0))

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
