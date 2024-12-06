Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C174E77173
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 11:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D08E13E6CC6
	for <ltp@archiver.kernel.org>; Fri,  6 Dec 2024 12:43:36 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 671F13E6CA2
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 12:43:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A418D1416734
 for <ltp@lists.linux.it>; Fri,  6 Dec 2024 12:43:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F61B21134;
 Fri,  6 Dec 2024 11:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733485399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D5D0Ubem88SoqI3SzQLlWn8sDBsaY8Y82SSigsCjbM=;
 b=RVO44OcbsvropwKmOhBDGpnOAfNGxcLAZHaPBbq1Zrwso3lByjhQCOcpRqdkjKanQikblN
 ld4YvXt2JZPxzBWBu3+eTA7RuiExmZrpl5qRjf2uKnsLa37/AC6hpDsYGOWBwkUzCFXef6
 9UZCV8JGebq29b5FrWNRuwg6OXuYtDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733485399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D5D0Ubem88SoqI3SzQLlWn8sDBsaY8Y82SSigsCjbM=;
 b=Whw90RIpvuBemFxv4vm7GfqK9dGQJAIBx0PZrdWSctQOUk1QgVJQqE9SGsrieYgmcw9lDz
 18gF8TDw+lah5gCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RVO44Ocb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Whw90RIp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733485399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D5D0Ubem88SoqI3SzQLlWn8sDBsaY8Y82SSigsCjbM=;
 b=RVO44OcbsvropwKmOhBDGpnOAfNGxcLAZHaPBbq1Zrwso3lByjhQCOcpRqdkjKanQikblN
 ld4YvXt2JZPxzBWBu3+eTA7RuiExmZrpl5qRjf2uKnsLa37/AC6hpDsYGOWBwkUzCFXef6
 9UZCV8JGebq29b5FrWNRuwg6OXuYtDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733485399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2D5D0Ubem88SoqI3SzQLlWn8sDBsaY8Y82SSigsCjbM=;
 b=Whw90RIpvuBemFxv4vm7GfqK9dGQJAIBx0PZrdWSctQOUk1QgVJQqE9SGsrieYgmcw9lDz
 18gF8TDw+lah5gCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E1F213647;
 Fri,  6 Dec 2024 11:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iiawAlfjUmfYNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Dec 2024 11:43:19 +0000
Date: Fri, 6 Dec 2024 12:43:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Z1LjZyO1CQmu-OE0@yuki.lan>
References: <20241129133421.24349-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241129133421.24349-1-mdoucha@suse.cz>
X-Rspamd-Queue-Id: 1F61B21134
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for data integrity over NFS
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
> Add NFS test which checks data integrity of random writes into a file,
> with both buffered and direct I/O.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1: Added TST_TIMEOUT
> 
> The lower loop count is necessary because NFS has very large block size,
> up to 256KB on x86_64. The new tests take ~50 minutes to complete in total
> on my laptop. With the default loop count, the TCP tests would all time out.
> 
> The subtest timeout is fully determined by NFS block size and hardcoded
> command line arguments. For TCP tests, it's exactly 8 minutes 32 seconds
> so the whole test script will take no more than 34 minutes 8 seconds.
> The TST_TIMEOUT value is rounded up to 40 minutes to add some margin
> for setup and cleanup.

This is only on a one particular setup though. I bet it would be a few
hours on a hardware with slower I/O.

What about we change the fsplough so that it loops over
tst_remaining_runtime() and pass a runtime instead of number of
iterations?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
