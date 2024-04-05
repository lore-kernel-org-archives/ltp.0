Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D769CD11C2
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 14:22:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55C893CEF2E
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 16:22:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE4F3CC8A5
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:22:23 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A42051BC1C02
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 16:22:22 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 809821F7D7;
 Fri,  5 Apr 2024 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712326941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wjOjBr+FtGDvW0yLcrvx74vXWXG3wBlNMlVobfWFVtc=;
 b=hAxELR+V1MR1BqqUWh9h5h42MGiIOtreuNal/pzzp/yFnVZ7f6wYKnplPZVVs0lbxhm5NL
 YpevQglqd94K+kDfiFs9WkuqiWuUgLVWT4fq6E14+SPgu/wNeMGsrgtZf3yoS0zGyxnrte
 pAC6TJeQFdLABhECDhSfWIthrryERKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712326941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wjOjBr+FtGDvW0yLcrvx74vXWXG3wBlNMlVobfWFVtc=;
 b=O3En1L+GbVrR/e3Yg6AsqHgr0moOcekfcQiJ8HB2n2xkgk7jorNh2Ym/iijDIlmy4qTEj8
 MhH3UrM1Fx+PXFAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712326941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wjOjBr+FtGDvW0yLcrvx74vXWXG3wBlNMlVobfWFVtc=;
 b=hAxELR+V1MR1BqqUWh9h5h42MGiIOtreuNal/pzzp/yFnVZ7f6wYKnplPZVVs0lbxhm5NL
 YpevQglqd94K+kDfiFs9WkuqiWuUgLVWT4fq6E14+SPgu/wNeMGsrgtZf3yoS0zGyxnrte
 pAC6TJeQFdLABhECDhSfWIthrryERKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712326941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=wjOjBr+FtGDvW0yLcrvx74vXWXG3wBlNMlVobfWFVtc=;
 b=O3En1L+GbVrR/e3Yg6AsqHgr0moOcekfcQiJ8HB2n2xkgk7jorNh2Ym/iijDIlmy4qTEj8
 MhH3UrM1Fx+PXFAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3277C139E8;
 Fri,  5 Apr 2024 14:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id /pJSCx0JEGanQgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 05 Apr 2024 14:22:21 +0000
Date: Fri, 5 Apr 2024 16:22:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>,
 Li Wang <liwang@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>,
 Yang Xu <xuyang2018.jy@fujitsu.com>, Mike Frysinger <vapier@gentoo.org>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Enji Cooper <yaneurabeya@gmail.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Wei Gao <wegao@suse.com>, Avinesh Kumar <akumar@suse.de>
Message-ID: <20240405142219.GA637941@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-2.71 / 50.00]; BAYES_HAM(-2.21)[96.25%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[suse.cz,redhat.com,fujitsu.com,gentoo.org,bell-sw.com,gmail.com,suse.de,suse.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[15];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] New LTP documentation
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
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

today I merged Andrea's and Cyril's work migrating our GitHub based docs to
readthedocs.org. Andrea, Cyril, thank you for this work, we're now using for
docs the same approach as the Linux kernel.

Our new documentation is now on https://linux-test-project.readthedocs.io/en/latest/.

I configured the hook on readthedocs.org, thus any docs update should trigger
readthedocs.org rebuild.

I also disabled our wiki on GitHub [2], it redirects to our homepage. It would
be good to be able to redirect it to our new readthedocs.org docs [1].

I also remove (with Cyril's ack) the content of our github.io page [3] to our
new readthedocs.org docs [1].

The docs is mostly done, but some bits are missing (e.g. C Test Network API [4],
KVM Test API [5], shell API [6]), thus we kept them in doc/old folder. This
folder will be removed once we finish the migration.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/
[2] https://github.com/linux-test-project/ltp/wiki/
[3] https://linux-test-project.github.io/
[4] https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-Network-API.asciidoc
[5] https://github.com/linux-test-project/ltp/blob/master/doc/old/KVM-Test-API.asciidoc
[6] https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
