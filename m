Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75323D2FFE6
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 10:23:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9364C3C6878
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 12:23:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AF903C4F14
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 12:23:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7270D1BB9055
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 12:23:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73A5A1F385;
 Fri, 18 Oct 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729246997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MFwyEqI8CAjG3Nnb+srvWXGqZvHlKmTV5Gdq4A51AYM=;
 b=Z//5+eiX9iEAPRVdWUGvVlhhiKCs8M+gsJURQf000D5yUAlNjAd82m7jYxjpoQphfixfqW
 UJQRFiEdeWziGuGDis2SA7cRcdFfYeBteFuolwrtwtcMklykX9fPsqs1r+m5edte1AYZGJ
 hqtd5sfy3kAgorQpVS1UzUx6ZSW9yNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729246997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MFwyEqI8CAjG3Nnb+srvWXGqZvHlKmTV5Gdq4A51AYM=;
 b=1MgPzd3BCOSOJubVj2o32/GOQRhf+Vxl/WNs+P4pZa9Wap9iUQ5bw5RLoTQA7N1PYiqdK+
 3oz+cYt+de4KeeCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729246997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MFwyEqI8CAjG3Nnb+srvWXGqZvHlKmTV5Gdq4A51AYM=;
 b=Z//5+eiX9iEAPRVdWUGvVlhhiKCs8M+gsJURQf000D5yUAlNjAd82m7jYxjpoQphfixfqW
 UJQRFiEdeWziGuGDis2SA7cRcdFfYeBteFuolwrtwtcMklykX9fPsqs1r+m5edte1AYZGJ
 hqtd5sfy3kAgorQpVS1UzUx6ZSW9yNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729246997;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MFwyEqI8CAjG3Nnb+srvWXGqZvHlKmTV5Gdq4A51AYM=;
 b=1MgPzd3BCOSOJubVj2o32/GOQRhf+Vxl/WNs+P4pZa9Wap9iUQ5bw5RLoTQA7N1PYiqdK+
 3oz+cYt+de4KeeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4343A13433;
 Fri, 18 Oct 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vxpcDhU3EmcibAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Oct 2024 10:23:17 +0000
Date: Fri, 18 Oct 2024 12:23:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20241018102315.GA286253@pevik>
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
 <Zw5bCxNMuCz4aKWC@yuki.lan>
 <CAASaF6w0Smez5e=hn8UGU2DC3Fi2zrqYX2PwKKE4r23RQ0BM4Q@mail.gmail.com>
 <Zw5xhhvjNkvAwKU0@yuki.lan>
 <CAASaF6xTYOCooJ4FsyfScn1HJY-1SKugbM6yZJ3QdxfoJ=QWEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xTYOCooJ4FsyfScn1HJY-1SKugbM6yZJ3QdxfoJ=QWEQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer
 size" test
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

Hi Jan,

I dared to merge your patch. Thank for the fix!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
