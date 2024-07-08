Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A72EC3DA42
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 09:27:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E34303D3A14
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 11:27:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BEFB3CBA12
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 11:27:05 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D4AB14044C9
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 11:27:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E7B0219D7;
 Mon,  8 Jul 2024 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720430822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lZ4TPQ7un8pkq8AhMfc3iI/MWbAhzcjN0qI443aw2Y=;
 b=EJyF6SqEec5fijA+5Al77F9/cchQCsX8n1UmTTvFCYHylaR7kE9mdKmKHHansk+S47Tzpp
 dg35U4khrXKThrW6G/UuF8l+xWQMaqrYcDS+wxlUOChm5IQvNbYSNyaE2F1ZEujVrWr0PR
 XTNDfoGGyDiKhLrdOiVtOfj/D5A70dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720430822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lZ4TPQ7un8pkq8AhMfc3iI/MWbAhzcjN0qI443aw2Y=;
 b=Vf11r5nnzV42v/jcvPboqL+FDPONRc1k2g6uofF37adlkaUUUv+4jCPRLjT21pXoj24Obe
 epC/ljH7b8PolJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720430822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lZ4TPQ7un8pkq8AhMfc3iI/MWbAhzcjN0qI443aw2Y=;
 b=EJyF6SqEec5fijA+5Al77F9/cchQCsX8n1UmTTvFCYHylaR7kE9mdKmKHHansk+S47Tzpp
 dg35U4khrXKThrW6G/UuF8l+xWQMaqrYcDS+wxlUOChm5IQvNbYSNyaE2F1ZEujVrWr0PR
 XTNDfoGGyDiKhLrdOiVtOfj/D5A70dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720430822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lZ4TPQ7un8pkq8AhMfc3iI/MWbAhzcjN0qI443aw2Y=;
 b=Vf11r5nnzV42v/jcvPboqL+FDPONRc1k2g6uofF37adlkaUUUv+4jCPRLjT21pXoj24Obe
 epC/ljH7b8PolJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4501213A7F;
 Mon,  8 Jul 2024 09:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ECr5D+awi2YrNgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jul 2024 09:27:02 +0000
Date: Mon, 8 Jul 2024 11:26:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240708092656.GA124018@pevik>
References: <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
 <ZmM25L0EmJufsS-f@yuki>
 <ee1e4c128c12200d6f55f2afe34a44cd110c33e2.camel@linuxfoundation.org>
 <ZmNEW_Q20Cf7hnUr@yuki>
 <SA3PR13MB637235EB7D225D1D68AA2CCEFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <17D79A236EC1FFC3.15678@lists.yoctoproject.org>
 <ZmlT9Dgcx3FkZLVr@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZmlT9Dgcx3FkZLVr@rei>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Andrea,

> Hi!
> > I did a talk at SUSE Labs conference when I tried to explain when we are
> > heading and it was recorded, unfortunately it wasn't uploaded to youtube
> > yet, I will post the link here once it's there.

> And it's finally uploaded:

> https://www.youtube.com/watch?v=T1ImuNr9Oxo

Great. As I wrote It'd be great to summarize kirk + ltx architecture in LTP docs.
For the start it could be just a very short article + link to this video.

FYI there are some Debian users who would appreciate have kirk published via
pypi, see Anders's effort:

https://github.com/linux-test-project/kirk/pull/20
(Probably better to move related discussion to the ticket.)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
