Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1F8CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 16:27:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FD923CF0A8
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 17:27:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BE523CECB1
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 17:27:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D89FD600F3F
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 17:27:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6324E211EC;
 Fri,  7 Nov 2025 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762532849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yvur5PG9Pt7PKRK5Umm61FWKGYJF++Gxju7FiYQU0ZY=;
 b=uPzRUaqOd0sNYPZaeIJFAbwek18BfCz8AuunPcBi5KPDGsCI5QzJl87QUNiQzYgGFxbrNn
 0xU/IXyfdGF7g6SPtfBO6ZxNIkieLlMQ67JMioxdEzzPrw9+JJMallKjskBZktbzj2s7C6
 S3O/pd/gDW1XpAJS3GCOUB4kkb/oG2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762532849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yvur5PG9Pt7PKRK5Umm61FWKGYJF++Gxju7FiYQU0ZY=;
 b=5Uw8s7lXy4dhHU1j3WeiPvEjV+Gq5uXlAJhSPox5CpVOXvse7F2woslrbyqLpIQPnTpHaA
 j8GrXT24Lk32/HBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1762532848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yvur5PG9Pt7PKRK5Umm61FWKGYJF++Gxju7FiYQU0ZY=;
 b=gpAbDPi9El6uMlnd+IDrzCkS2AsQP945Q/Hb2AHpV3ExVhEP4povJyWPIaAqssCQqepiA4
 C/uobzV7ScfsWz8xlqJEF22BYTLDVzRpnQys8Xb1mnL9sQEMQwh7q2wI6ElveBYuVzougZ
 QUeIOlxhy6pK8k5LXv3xu+1/AuxuX5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1762532848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yvur5PG9Pt7PKRK5Umm61FWKGYJF++Gxju7FiYQU0ZY=;
 b=UhZWe5GSzkgoUSu3/Wm2Rgp6UU+eCkjxJAN0kqTzdmu0bWt69u6FKVUVtBSEjYh58bir6I
 CCo+CmqOOwB8PJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3E531395F;
 Fri,  7 Nov 2025 16:27:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gmVLL+8dDmmNJgAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 07 Nov 2025 16:27:27 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Petr Vorel <pvorel@suse.cz>
Date: Fri, 07 Nov 2025 17:27:27 +0100
Message-ID: <12777454.O9o76ZdvQC@thinkpad>
In-Reply-To: <20251106163500.1063704-6-pvorel@suse.cz>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-6-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 CTE_CASE(0.50)[]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.cz:email]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] swapon03: Remove grep dependency
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thursday, November 6, 2025 5:35:00 PM CET Petr Vorel wrote:
> Instead of relying on 'grep' run via system() parse output with C
> implementation (faster, no dependency).
> 
> Also rename swap file to make sure it's more obvious that it was created
> by LTP.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Hi Petr,

Reviewed-by: Avinesh Kumar <akumar@suse.de>

for all patches in the series.


Thanks,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
