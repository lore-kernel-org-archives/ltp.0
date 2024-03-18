Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B1C54E58
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 16:32:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A9473D14CD
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 17:32:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26AE03CC8BF
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:32:05 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81560600186
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 17:32:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB8AA5C759;
 Mon, 18 Mar 2024 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710779523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kE663VpWXfblrElNjtfAwZ9QcavPbRYdfjC/V5Vwhqw=;
 b=XTznmdfpr4Ma8djf1R++3HvASjlcT3wLk/GNtJtZRt/+96pHiFXwYmae/IcAS2pLIo8yBt
 2WkolgL5JcEKTqlEwDuYi/hF7CijhDmpkItKwPHKMKU7BpRcEZtwK3DPuCASZDU9ve9rZP
 Fc85+gnmtWxMKvQG70BYZVMIg5VZqj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710779523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kE663VpWXfblrElNjtfAwZ9QcavPbRYdfjC/V5Vwhqw=;
 b=44JnMKJ2Ko22zHncxNgnbwoPfJsr+EA4AGhCnkOTFQsyckRBBK8rOZ2qDv6SmdKpByNp6P
 VF2ZKnT3bPYX5gCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710779523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kE663VpWXfblrElNjtfAwZ9QcavPbRYdfjC/V5Vwhqw=;
 b=XTznmdfpr4Ma8djf1R++3HvASjlcT3wLk/GNtJtZRt/+96pHiFXwYmae/IcAS2pLIo8yBt
 2WkolgL5JcEKTqlEwDuYi/hF7CijhDmpkItKwPHKMKU7BpRcEZtwK3DPuCASZDU9ve9rZP
 Fc85+gnmtWxMKvQG70BYZVMIg5VZqj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710779523;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kE663VpWXfblrElNjtfAwZ9QcavPbRYdfjC/V5Vwhqw=;
 b=44JnMKJ2Ko22zHncxNgnbwoPfJsr+EA4AGhCnkOTFQsyckRBBK8rOZ2qDv6SmdKpByNp6P
 VF2ZKnT3bPYX5gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9202D136A5;
 Mon, 18 Mar 2024 16:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q1+eIoNs+GWAZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Mar 2024 16:32:03 +0000
Date: Mon, 18 Mar 2024 17:31:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240318163158.GB408613@pevik>
References: <20240104211935.1438103-1-petr.vorel@gmail.com>
 <20240104211935.1438103-3-petr.vorel@gmail.com>
 <Zfhkpt1CVcSv3h3t@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zfhkpt1CVcSv3h3t@yuki>
X-Spamd-Result: default: False [-2.47 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.97)[94.88%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] make: Delete gitignore.mk
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

Hi Cyril,

thanks, merged this one (with first commit).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
