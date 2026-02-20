Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6CC5518F
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 10:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F3833D0817
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 11:49:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 562B83C015A
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:49:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 984D81400C7C
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:49:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF603E6D5;
 Fri, 20 Feb 2026 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771584559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dep45DmwG6rU/Qk4V07RaJF4Afa1qpcli7KXsFnVslE=;
 b=v/t+Q6q7X+BC8EvixotQlo1++1Bc7AlIAj303lOXarlNmEVvUNHmGY/x4hHgIANnGmLqTZ
 f9x+w5gHHdz0cuQ/Jhri+CRoXCkTZabg+LgU25LUuxm99xzza1Q0mZhlEBeNOUVwTZ2bkI
 Twe0F/0BMNUCeM8tdCWVT0jt+It1qVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771584559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dep45DmwG6rU/Qk4V07RaJF4Afa1qpcli7KXsFnVslE=;
 b=rQoMoj4NEp8T1FFGpnpendPh2Ft0MwXiBOLVEsreah80qiXFY7DXRrH+wVfTjNV/FNUOaj
 9yODn4KLuayj0sCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771584559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dep45DmwG6rU/Qk4V07RaJF4Afa1qpcli7KXsFnVslE=;
 b=v/t+Q6q7X+BC8EvixotQlo1++1Bc7AlIAj303lOXarlNmEVvUNHmGY/x4hHgIANnGmLqTZ
 f9x+w5gHHdz0cuQ/Jhri+CRoXCkTZabg+LgU25LUuxm99xzza1Q0mZhlEBeNOUVwTZ2bkI
 Twe0F/0BMNUCeM8tdCWVT0jt+It1qVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771584559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dep45DmwG6rU/Qk4V07RaJF4Afa1qpcli7KXsFnVslE=;
 b=rQoMoj4NEp8T1FFGpnpendPh2Ft0MwXiBOLVEsreah80qiXFY7DXRrH+wVfTjNV/FNUOaj
 9yODn4KLuayj0sCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA223EA65;
 Fri, 20 Feb 2026 10:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N2/cNC48mGk0MgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Feb 2026 10:49:18 +0000
Date: Fri, 20 Feb 2026 11:49:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <aZg8NDoUFezK-WTE@yuki.lan>
References: <aZbmf5tEKC75gH7T@yuki.lan>
 <20260219145719.6660-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260219145719.6660-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open: fix directory verification and misleading
 test description
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
> How do you think about removing the O_DIRECTORY case from open01.c and
> creating a separate fstat test?

Yes please.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
