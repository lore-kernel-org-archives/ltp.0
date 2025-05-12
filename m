Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B02C3ABCC
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 08:08:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70CE43CC28E
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:08:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222183CA59F
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:08:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BEB74600186
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:08:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBB8E1F38C;
 Mon, 12 May 2025 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747037309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QA2qTven0GZfTiDzuqxkucJkIHjyUqQHdcW6Yi2qKPw=;
 b=jzh+RSdBqNYbUUwVCR62Py7zTc/P3tw4c42rEvAZvTMnK0pfGoEFvIO8h0iRCa4RwY50iq
 48D6peLMo3GAZvbft9rBpX1VSboA9RmGdKR3Wea20xsSNHIchhNAhx/kT0tVmtv8qvMAzV
 QFr8cidkGMnpGV2Rypvv6ErV9zmLKXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747037309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QA2qTven0GZfTiDzuqxkucJkIHjyUqQHdcW6Yi2qKPw=;
 b=+kD7wGL16sPegY/XhcQz0VHMWMR6g/LAsxllgz41r/av4Arp5gGlHdj1W/HwMY+ruuNPYq
 mEdssNtN48MzxECQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747037309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QA2qTven0GZfTiDzuqxkucJkIHjyUqQHdcW6Yi2qKPw=;
 b=jzh+RSdBqNYbUUwVCR62Py7zTc/P3tw4c42rEvAZvTMnK0pfGoEFvIO8h0iRCa4RwY50iq
 48D6peLMo3GAZvbft9rBpX1VSboA9RmGdKR3Wea20xsSNHIchhNAhx/kT0tVmtv8qvMAzV
 QFr8cidkGMnpGV2Rypvv6ErV9zmLKXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747037309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QA2qTven0GZfTiDzuqxkucJkIHjyUqQHdcW6Yi2qKPw=;
 b=+kD7wGL16sPegY/XhcQz0VHMWMR6g/LAsxllgz41r/av4Arp5gGlHdj1W/HwMY+ruuNPYq
 mEdssNtN48MzxECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD00F1397F;
 Mon, 12 May 2025 08:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iHM7LX2sIWjsGAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 12 May 2025 08:08:29 +0000
Date: Mon, 12 May 2025 10:09:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <aCGsnw96BqwQTGW6@yuki.lan>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz>
 <aBh9Z4QA2YcdOFq1@rei.lan> <20250506080520.GA64990@pevik>
 <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
 <aBt8PJNmiJNuSEB5@yuki.lan>
 <adfcd1e3f129c97c2132a138e70599642566886a.camel@klomp.org>
 <MW5PR13MB5632B007B46225B5D7036A2EFD8AA@MW5PR13MB5632.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MW5PR13MB5632B007B46225B5D7036A2EFD8AA@MW5PR13MB5632.namprd13.prod.outlook.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,ozlabs.org:url,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
Cc: Mark Wielaard <mark@klomp.org>, Martin Cermak <mcermak@redhat.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Don't you want to keep the status or result (TINFO and TPASS)?
> 
> This shouldn't change from run-to-run unless the test is flaky.

Already addressed in v2 patch:

http://patchwork.ozlabs.org/project/ltp/patch/20250509092813.12860-1-chrubis@suse.cz/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
