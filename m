Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DD1C47073
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 01:58:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C77A63D0502
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 02:58:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6B933C9787
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 02:58:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F17E7600A35
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 02:58:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 336BF1F45E;
 Wed,  3 Jan 2024 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704247082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upreQnQYv967QmQmgwzYfgDfBjQkatUg+yzlIcYWDv4=;
 b=Qgm3cLZgDEq9Bgk0BDIRTVhnTyMmZKplZ8Y40sCqMUpZr+xbpK4S+cMypZHL6eN//Ke5+z
 VxFEqIpPfo754zA+ailpD2khdwI4saJdFzrskf82jJeq6omMofLqzHPkPbCoDvQooBiMtK
 W1KaWIYZxnbi+uqjgoqb5I7leBx6STM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704247082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upreQnQYv967QmQmgwzYfgDfBjQkatUg+yzlIcYWDv4=;
 b=kolxd0Es+Ap5VR1ITOOxchPOHEmChX8Tf44jvjwepzlkDPL4C+p4gB/AF/CyReoXM/x82x
 DVEwyWghtirVnEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704247082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upreQnQYv967QmQmgwzYfgDfBjQkatUg+yzlIcYWDv4=;
 b=Qgm3cLZgDEq9Bgk0BDIRTVhnTyMmZKplZ8Y40sCqMUpZr+xbpK4S+cMypZHL6eN//Ke5+z
 VxFEqIpPfo754zA+ailpD2khdwI4saJdFzrskf82jJeq6omMofLqzHPkPbCoDvQooBiMtK
 W1KaWIYZxnbi+uqjgoqb5I7leBx6STM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704247082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upreQnQYv967QmQmgwzYfgDfBjQkatUg+yzlIcYWDv4=;
 b=kolxd0Es+Ap5VR1ITOOxchPOHEmChX8Tf44jvjwepzlkDPL4C+p4gB/AF/CyReoXM/x82x
 DVEwyWghtirVnEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1049E1340C;
 Wed,  3 Jan 2024 01:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z0WlAiq/lGUgCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 01:58:02 +0000
Date: Wed, 3 Jan 2024 02:57:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240103015756.GA1061240@pevik>
References: <ZZQHPkwg-W2R1ejJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZQHPkwg-W2R1ejJ@yuki>
X-Spamd-Result: default: False [-0.69 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.39)[90.84%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I would prefer also to merge before release "remove UCLINUX" patchset (unless
nobody complains).

https://lore.kernel.org/ltp/20240103015240.1065284-1-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
