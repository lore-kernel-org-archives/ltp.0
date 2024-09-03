Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CBECD342F
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 07:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 706023C4EAB
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 09:31:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3C213C0265
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:31:24 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9660260065D
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:31:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9AC71FCF3;
 Tue,  3 Sep 2024 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725348681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
 b=OzbTX+kiYnX1kJMkKsazkuoPXxoWZpnLQbDm29vi639bmdMFLhfQTo0G+4Q5t7b40E3Ib2
 L3cNWrYJsCf0ZHfe0QY8jzS9/a96/bDic8nHNuzI/OLZs8+n0cxWJvF3HuInMJmQSBKiaP
 SQC4c1cZYnXkcGtdvNH0vp2m8IqhJ6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725348681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
 b=a90nMhHLvoi+r09tX+x6N35gtkchjQ+VRm5ue/kaEJlHzdZJWaEgWxS4Zkx4edeRbT+npn
 OmsHtQL+lVVcyuDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SE0xcmyo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/HtWBsRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725348680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
 b=SE0xcmyofO2HBQXKkxV01N+wnsM99hl9PZxYGfqS8P5E/qxpDmDEycI9i8TCZZcqN4jdPF
 7zO9eVys/BDN4d//ZQbZlDpRkhLg2fG39YIEf2Xkm1jDJR6MRF0Y/JQz0Hsgf7/JNVv/B5
 bZ0mnbnDuO9ylq+wgyzfYLzNAYPsx8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725348680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
 b=/HtWBsRp9YsYyRiaMF0Afeo+loFRfaACnkefZlq9OAYCsboQkrKU6cKpwMIabk5VqHLDyU
 6TLMJEWksILt+DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C90813A52;
 Tue,  3 Sep 2024 07:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8AyXHEi71mb2TwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 07:31:20 +0000
Date: Tue, 3 Sep 2024 09:31:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: cel@kernel.org
Message-ID: <20240903073115.GA726144@pevik>
References: <20240831160900.173809-1-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240831160900.173809-1-cel@kernel.org>
X-Rspamd-Queue-Id: B9AC71FCF3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,vger.kernel.org,oracle.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH RFC] syscalls/fanotify09: Note backport of commit
 e730558adffb
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
Cc: Chuck Lever <chuck.lever@oracle.com>, stable@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chuck,

thanks for your patch, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
