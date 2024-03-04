Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E60C5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 14:48:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3C7C3CEB98
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:48:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C86F73C9968
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 15:48:30 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE81D1A01105
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 15:48:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E17876483;
 Mon,  4 Mar 2024 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709563708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9Hb3ULTmh/rQRl8+86ctYY8yCTAnggxDmtiZmWxx4E=;
 b=cGdImWbxAF9qHq9PnaNdwYI0eOy+AEv5AwPCRxIcMMVSulzFFs2t9c+oGaib0qIS9EtBEv
 MgjZqDRz85LeHI3Fv/8cdh0TzljMQHLiR+LBJ9WFJuHMxXV5eabs8Y/FC6DzFj3vf4etwr
 PjQKZAJOCwucGrA9NWmbt8NTKzQuasA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709563708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9Hb3ULTmh/rQRl8+86ctYY8yCTAnggxDmtiZmWxx4E=;
 b=UhnvDFWQ7OdI2MrLpDWteDjEMWnFjWvZa1I/7hOFqsw3T8S1c+/gClbBdDFcDJnyhWGYyF
 8tUHAHV1cBd+eDDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709563708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9Hb3ULTmh/rQRl8+86ctYY8yCTAnggxDmtiZmWxx4E=;
 b=cGdImWbxAF9qHq9PnaNdwYI0eOy+AEv5AwPCRxIcMMVSulzFFs2t9c+oGaib0qIS9EtBEv
 MgjZqDRz85LeHI3Fv/8cdh0TzljMQHLiR+LBJ9WFJuHMxXV5eabs8Y/FC6DzFj3vf4etwr
 PjQKZAJOCwucGrA9NWmbt8NTKzQuasA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709563708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9Hb3ULTmh/rQRl8+86ctYY8yCTAnggxDmtiZmWxx4E=;
 b=UhnvDFWQ7OdI2MrLpDWteDjEMWnFjWvZa1I/7hOFqsw3T8S1c+/gClbBdDFcDJnyhWGYyF
 8tUHAHV1cBd+eDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DF7213A5B;
 Mon,  4 Mar 2024 14:48:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q0IpAzzf5WU7XgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 Mar 2024 14:48:28 +0000
Date: Mon, 4 Mar 2024 15:47:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZeXe_WJcPDfea8eC@yuki>
References: <20240226153754.24998-1-andrea.cervesato@suse.de>
 <20240226153754.24998-2-andrea.cervesato@suse.de>
 <20240304143512.GB3115761@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240304143512.GB3115761@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cGdImWbx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UhnvDFWQ
X-Spamd-Result: default: False [0.18 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[49.16%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1E17876483
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add SAFE_MPROTECT() macro
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
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  include/tst_safe_macros.h |  5 +++++
> >  lib/safe_macros.c         | 18 ++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> 
> Although Cyril acked this I wonder why we are adding it into the old API.
> Shouldn't it be added only into tst_safe_macros.c?

To be honest I do not care that much as long as we do not expose the
functions into the headers for old API. We will have to convert the
safe_macros.c with coccinelle once all tests are converted and one more
function in there does not really matter that much.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
