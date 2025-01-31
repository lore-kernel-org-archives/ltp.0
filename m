Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04096C0218F
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 09:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC33B3C7B07
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 10:16:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37D213C718E
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 10:15:47 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C4A7A10136A0
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 10:15:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94DD41F391;
 Fri, 31 Jan 2025 09:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738314945;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2H+8C9ExguzHsezCrUSQaLu1AZ/CjVeAnXnlh0Z6vv8=;
 b=Swa+kyRwoB95s7OgFV+Jn7nIsOHbPEtqMeuA+QRQL4VRNI6EOwguP92Svs75F+2Z8FuHnX
 vyDsPh0tKotu6+s07SkspFQPFYoccPHjZY9aez9UjbO667hRfjLo4BfHitn2VEjT2RbEuy
 0OHhOk8cs+2lNY4L8PkYghjNLH/bWyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738314945;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2H+8C9ExguzHsezCrUSQaLu1AZ/CjVeAnXnlh0Z6vv8=;
 b=SNyo7tmXon074ECg8tu9JVtvEVIywfAG5EeBXJ3jyHvIe5rXm4Pw+4Ek0XC/xtXcqie9Ss
 qrgvzwBoT4DejqDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Swa+kyRw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SNyo7tmX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738314945;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2H+8C9ExguzHsezCrUSQaLu1AZ/CjVeAnXnlh0Z6vv8=;
 b=Swa+kyRwoB95s7OgFV+Jn7nIsOHbPEtqMeuA+QRQL4VRNI6EOwguP92Svs75F+2Z8FuHnX
 vyDsPh0tKotu6+s07SkspFQPFYoccPHjZY9aez9UjbO667hRfjLo4BfHitn2VEjT2RbEuy
 0OHhOk8cs+2lNY4L8PkYghjNLH/bWyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738314945;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2H+8C9ExguzHsezCrUSQaLu1AZ/CjVeAnXnlh0Z6vv8=;
 b=SNyo7tmXon074ECg8tu9JVtvEVIywfAG5EeBXJ3jyHvIe5rXm4Pw+4Ek0XC/xtXcqie9Ss
 qrgvzwBoT4DejqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A1EB1364B;
 Fri, 31 Jan 2025 09:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WltdCcGUnGduGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 09:15:45 +0000
Date: Fri, 31 Jan 2025 10:15:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250131091535.GB1090737@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Queue-Id: 94DD41F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Remove [Description] subtitle from docparse
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Can we remove [Description] part from docparse documentation in tests?
This is transformed into "Description" subtitle in resulted html/pdf.

1) It's not really needed (it's obvious that it's a description of the test)
2) Sometimes it's missing (inconsistency).

I would keep other subtitles (e.g. [Algorithm]), just remove the first one.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
