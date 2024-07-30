Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EA6C3DA61
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 08:56:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88ED43D1D8D
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 10:56:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14EC3CE640
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 10:55:44 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DF18D600ACB
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 10:55:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5EEC1F7F6;
 Tue, 30 Jul 2024 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722329743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybLiWskjZwzvUh8tsyeMu/uP2JiXw3raa8jM2awMDEU=;
 b=qMhLccnimefTTpzNm2mFZgiILq4MOCOnUM6fru0cgeZ42sMYhxqe+MeWkMwBRxBq9nRrL3
 hlTwVqq/Bzvu43kKf5v6OzoMd3vZkhqkhSImAltHYbbYUdEzuOU9O8jbLg8YZ4UbtG6il2
 gtwL7JkAS724ET5u3Nl5SFXUMfzHM6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722329743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybLiWskjZwzvUh8tsyeMu/uP2JiXw3raa8jM2awMDEU=;
 b=tM564ktYMCOaQ4I97J/FjbB92OjXDNpwnmHeR+S3gj63299e4wDCGQetQKOud9jbQC6CBK
 sZmIBP3fRRpGSADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722329742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybLiWskjZwzvUh8tsyeMu/uP2JiXw3raa8jM2awMDEU=;
 b=YTpXyJZ/7BVs7IBKAVptw9I52E/kiPqYlXe3MPDYeN51czAs5S8f9EwF489lgsbDI7WY/e
 elQzoxRVJd9KuCui63yYnMU7t8APZ3mwbHzgmxr0M5qUIMW8uzZFLsbFMUqM+aNclS49WD
 bZLNnszZ1XL00ExgX68wS7hN/j5aON0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722329742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ybLiWskjZwzvUh8tsyeMu/uP2JiXw3raa8jM2awMDEU=;
 b=3tuFo/RI0H9Pz0pi8AJkL2uVtz1ZHcK899UQqdvZRNHUL2riDSq8jN29CT/D25DkQop+qm
 NSvzlKkGU2SFY8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C881A13983;
 Tue, 30 Jul 2024 08:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +PetMI6qqGYzCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 30 Jul 2024 08:55:42 +0000
Date: Tue, 30 Jul 2024 10:55:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zqiqbi4Fs6807vEQ@yuki>
References: <20240722145443.19104-1-chrubis@suse.cz>
 <20240729205112.GA1287954@pevik> <ZqiRaf0bPloFV3LI@yuki>
 <20240730084924.GC1327610@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240730084924.GC1327610@pevik>
X-Spamd-Result: default: False [-7.60 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched: starvation: Autocallibrate the timeout
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
Cc: joe.liu@mediatek.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> OK, now testing with your patchset :)
> https://github.com/pevik/ltp/commit/0392e5142c5e8cb1d38dec9916a9f0118cf27afe
> 
> All tests are on KVM.

Thanks for the testing, it looks like the estimation is between 2x and
10x of the actual runtime, which is perfectly within the expected range.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
