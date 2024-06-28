Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778A8C41513
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 08:12:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13FD63D4370
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 10:12:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 556603D04D2
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 10:12:34 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7662C1415330
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 10:12:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0288B21B93;
 Fri, 28 Jun 2024 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719562351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pz5+VONWvcUr7QyYUANyFHsbpIOdkauiffmCp6w2mW8=;
 b=eJ80FZ4g+9LsXN8FVSCoHXNEINhUA5+cLOMZT/OU7fN7vpmn1bBpe4FJds77eV4s6EWJbC
 74SO0vU8lz+kIXry6B5hLQr92JRzc1LxVxO5XdH3rPsFHkSIv44ksryD5yWqZkT5UP14/J
 GhB9NLVcyr3BSKsGvfOp9c7U25DkKhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719562351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pz5+VONWvcUr7QyYUANyFHsbpIOdkauiffmCp6w2mW8=;
 b=DEgR2/KXv0w9x0LhkYLW1uQzW/zTp33WMTtGvHWMiKE2cyTJjwt6fPT+z0fXb7NRu0idGE
 b8+MrTfoHim2hWDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eJ80FZ4g;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DEgR2/KX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719562351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pz5+VONWvcUr7QyYUANyFHsbpIOdkauiffmCp6w2mW8=;
 b=eJ80FZ4g+9LsXN8FVSCoHXNEINhUA5+cLOMZT/OU7fN7vpmn1bBpe4FJds77eV4s6EWJbC
 74SO0vU8lz+kIXry6B5hLQr92JRzc1LxVxO5XdH3rPsFHkSIv44ksryD5yWqZkT5UP14/J
 GhB9NLVcyr3BSKsGvfOp9c7U25DkKhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719562351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pz5+VONWvcUr7QyYUANyFHsbpIOdkauiffmCp6w2mW8=;
 b=DEgR2/KXv0w9x0LhkYLW1uQzW/zTp33WMTtGvHWMiKE2cyTJjwt6fPT+z0fXb7NRu0idGE
 b8+MrTfoHim2hWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4C7B1373E;
 Fri, 28 Jun 2024 08:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VfHRNm5wfmaWHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jun 2024 08:12:30 +0000
Date: Fri, 28 Jun 2024 10:12:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: John Stultz <jstultz@google.com>
Message-ID: <Zn5wZIM7pKLRgT_Z@yuki>
References: <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
 <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
 <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
 <CANDhNCpYjncxr-fn8o5vDDYScf4zvVmH_w_Ms1Jhg9tsn-UgDQ@mail.gmail.com>
 <CAEemH2eQwPSQrHKY3AxT03Nf9Y7NoKpY3y+XE8donjLhHYbP2Q@mail.gmail.com>
 <CANDhNCqWvQ9DCwXtdMW81OoZ0qULk8-6PCYwVeF_Ep+b4Kkg2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANDhNCqWvQ9DCwXtdMW81OoZ0qULk8-6PCYwVeF_Ep+b4Kkg2A@mail.gmail.com>
X-Rspamd-Queue-Id: 0288B21B93
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
Cc: kernel-team@android.com, Darren Hart <darren@os.amperecomputing.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Ok, but even after doing that as you suggested, building with the
> following fails for me:
> 
> make autotools
> ./configure -C testcases/realtime/
> make -j
> ...
> make[3]: *** No rule to make target 'Makefile.am', needed by
> 'Makefile.in'.  Stop.
> make[2]: *** [../../include/mk/generic_trunk_target.inc:108: all] Error 2
> make[1]: *** [../include/mk/generic_trunk_target.inc:108: all] Error 2
> make: *** [Makefile:85: testcases-all] Error 2
> 
> So it does *seem* like something is broken. :)

I can't reproduce that and it didn't show up on our CI that builds LTP
on 16 different distributions.

And the error message you get does not make much sense either. The
Makefile.am file is only referenced in the automake target. It shouldn't
be referenced from the testcases-all target at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
