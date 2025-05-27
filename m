Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FC4C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:56:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9B873C58EE
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:56:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 331083C023C
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:56:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41F3360025A
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:56:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 800E71F7E5;
 Tue, 27 May 2025 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748346976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OREHqNVwAfn76Bb7yM/vxVU6LoN2ExD6ZkW1aYHRNmQ=;
 b=vzh7wuULZGPdeYIRskvVFyVKQ3TTVLNzK1oIPWEZ/O3k8Bl+TLOIStq/1YaPbVhbqR5gAp
 hx6LfNIxZR0lthnizLXbADKpHhFDz4KnoIpaPOKEDYkLyG2bT1s1F++OE+GaNBnhxwgBbW
 5M7C/tkFigaUaB2pK08E1hBxt8a1qlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748346976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OREHqNVwAfn76Bb7yM/vxVU6LoN2ExD6ZkW1aYHRNmQ=;
 b=bB7lwoMaWtzgYqPU98+h3S8WmNAx02WlLneVQPuH7Ti5U7/cyofFN1kID9M03BO9CbSWiK
 k7YIdlQ4lrx4X9Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748346976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OREHqNVwAfn76Bb7yM/vxVU6LoN2ExD6ZkW1aYHRNmQ=;
 b=vzh7wuULZGPdeYIRskvVFyVKQ3TTVLNzK1oIPWEZ/O3k8Bl+TLOIStq/1YaPbVhbqR5gAp
 hx6LfNIxZR0lthnizLXbADKpHhFDz4KnoIpaPOKEDYkLyG2bT1s1F++OE+GaNBnhxwgBbW
 5M7C/tkFigaUaB2pK08E1hBxt8a1qlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748346976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OREHqNVwAfn76Bb7yM/vxVU6LoN2ExD6ZkW1aYHRNmQ=;
 b=bB7lwoMaWtzgYqPU98+h3S8WmNAx02WlLneVQPuH7Ti5U7/cyofFN1kID9M03BO9CbSWiK
 k7YIdlQ4lrx4X9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63268136E0;
 Tue, 27 May 2025 11:56:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id usfvF2CoNWhaDQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 27 May 2025 11:56:16 +0000
Date: Tue, 27 May 2025 13:56:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aDWoeDQ_2xVmkS2F@yuki.lan>
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <aDWfrkuuohllNO27@yuki.lan>
 <3f1d0ecb-2d7a-4879-a009-2ad078b22802@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f1d0ecb-2d7a-4879-a009-2ad078b22802@suse.com>
X-Spamd-Result: default: False [-6.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; SUBJECT_ENDS_QUESTION(1.00)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This is exactly the reason why I want to have queries on metadata
> > available in kirk, e.g. "filter out all tests that have runtime >
> > $some_constant".
> It's already there and it's called "max_runtime". We only miss to =

> convert all old tests into new LTP API:
> =

> $ ./kirk --framework=3Dhelp
> --framework option supports the following syntax:
> =

> <name>:<param1>=3D<value1>:<param2>=3D<value2>:..
> =

> Supported plugins: | ltp |
> =

> ltp configuration:
>  =A0=A0=A0 root: LTP install folder
>  =A0=A0=A0 max_runtime: filter out all tests above this time value

It's much less than a general query language over the metadata I
envisioned, but at least this is a common usecase that is now covered...

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
