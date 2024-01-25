Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47EAC47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 08:26:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F12113CE1D5
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 09:25:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8054F3CAC7B
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 09:25:45 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D8C7F6005CD
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 09:25:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E92B62218E;
 Thu, 25 Jan 2024 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706171143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+Fa6jHmH3FKj+PHL0ZBcNjKeypGTNA1sKWEzgv/YRQ=;
 b=eNol/9CkKGVMcJ50XjSSkdpoZdFPo7Cp2nhcbbWdR3iqNE+ffv/EY14a3jBveVub0lCUq/
 P956HlxLHvFetmhMAL9PBDdDx/0WwyDEU0z1bynnE/coy6ddUeNC6jhm3a1dcKwEPdh5wW
 QIEe0A/dP+dYaXxflyanuk/kXUwqxgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706171143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+Fa6jHmH3FKj+PHL0ZBcNjKeypGTNA1sKWEzgv/YRQ=;
 b=RuBYWrvxjKinBtVvCQ0wSYgtNz+HgOel/BRg5PQbFi9zJ2Wsco0ubBwyVSoQY7vUJGVmdj
 YBrsDQbOhgcCeECQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706171143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+Fa6jHmH3FKj+PHL0ZBcNjKeypGTNA1sKWEzgv/YRQ=;
 b=eNol/9CkKGVMcJ50XjSSkdpoZdFPo7Cp2nhcbbWdR3iqNE+ffv/EY14a3jBveVub0lCUq/
 P956HlxLHvFetmhMAL9PBDdDx/0WwyDEU0z1bynnE/coy6ddUeNC6jhm3a1dcKwEPdh5wW
 QIEe0A/dP+dYaXxflyanuk/kXUwqxgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706171143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+Fa6jHmH3FKj+PHL0ZBcNjKeypGTNA1sKWEzgv/YRQ=;
 b=RuBYWrvxjKinBtVvCQ0wSYgtNz+HgOel/BRg5PQbFi9zJ2Wsco0ubBwyVSoQY7vUJGVmdj
 YBrsDQbOhgcCeECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA1C5134C3;
 Thu, 25 Jan 2024 08:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K0crLAcbsmUaJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jan 2024 08:25:43 +0000
Date: Thu, 25 Jan 2024 09:25:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240125082542.GA373351@pevik>
References: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
 <05c3fd69-cee6-4575-8c93-eaeec24af1b6@suse.cz>
 <20240124170547.GA324363@pevik> <2729940.mvXUDI8C0e@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2729940.mvXUDI8C0e@localhost>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.08 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.78)[93.69%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap04.c: Avoid vma merging
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

Hi Avinesh, Martin,

> > Shouldn't there be also second munmap()?
> > SAFE_MUNMAP(addr2, pagesize);
> No, we are unmapping both the mappings ( 2 pages ) together.

Ah, thanks!
Merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
