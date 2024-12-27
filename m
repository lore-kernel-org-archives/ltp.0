Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58669E7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 07:39:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82633E4DA5
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 08:39:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDAEE3E2683
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 08:39:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 106DF1001267
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 08:39:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F9A333748;
 Fri, 27 Dec 2024 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735285167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6YEPGr82KCgvvMrI/lTng1DrNmmsGU2StR33QH5c+yw=;
 b=MsC2cmBG0k6TMZCGIgphtT52S/fVmIc4TyGpm26sB4QlRLZDg4Qz/3Jq3uq5AS0OP2vFkl
 RaCPl33L36QFzqNNgGOYlFzVHmBbcKV+3157ONxQSjQWAwaiTvdqu9lbWW8csjGQKv2jbs
 1x/UWzDq9iQEm9cwK0v7y8V0mnpIYlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735285167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6YEPGr82KCgvvMrI/lTng1DrNmmsGU2StR33QH5c+yw=;
 b=DKPS7TLdOE13Ge17OalV8kjkuZ0Pn0XUVtn9U4solaXA/T5C5/foLwX+ngvwlubsry7YEE
 xWZ0HMXBtpwQeZDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735285167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6YEPGr82KCgvvMrI/lTng1DrNmmsGU2StR33QH5c+yw=;
 b=MsC2cmBG0k6TMZCGIgphtT52S/fVmIc4TyGpm26sB4QlRLZDg4Qz/3Jq3uq5AS0OP2vFkl
 RaCPl33L36QFzqNNgGOYlFzVHmBbcKV+3157ONxQSjQWAwaiTvdqu9lbWW8csjGQKv2jbs
 1x/UWzDq9iQEm9cwK0v7y8V0mnpIYlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735285167;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=6YEPGr82KCgvvMrI/lTng1DrNmmsGU2StR33QH5c+yw=;
 b=DKPS7TLdOE13Ge17OalV8kjkuZ0Pn0XUVtn9U4solaXA/T5C5/foLwX+ngvwlubsry7YEE
 xWZ0HMXBtpwQeZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1793313985;
 Fri, 27 Dec 2024 07:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id guvbAq9ZbmekLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Dec 2024 07:39:27 +0000
Date: Fri, 27 Dec 2024 08:39:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>, Li Wang <liwang@redhat.com>
Message-ID: <20241227073921.GB290415@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Convert test catalog (docparse) from asciidoc to
 readthedocs.io (sphinx)
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

Hi

I suggest to convert test catalog ("docparse") generated by docparse/testinfo.pl
and asciidoc/asciidoctor to sphinx generator (readthedocs.io).
asciidoc/asciidoctor was a good choice at the time, but now it looks to me
better to use sphinx for everything.

I volunteer to do the work, but I would like to have a general agreement before
I do it.

Pros:

* We already have attempt to show tested syscalls [1]. Printing test catalog would
have more info.
* No need to install dependencies.
* Automatic. If we add also doc for stable releases, it would replace the need
to install dependencies and upload file to LTP release on GitHub [2]. Then only
link to page to test coverage on linux-test-project.readthedocs.io of particular
release (or link to whole doc on particular release) would be added in release
mail announcement (or we might keep adding generated pdf/epub/zipped html also
to LTP releases [2]).
* Unified look and feel.

Work needed:

* Convert docparse/testinfo.pl to doc/conf.py, obviously change from asciidoc
to spinx.
* Adding stable releases (not sure if it can be created automatically for all
tags).
* Adding offline formats [3] so that users can download the docs (that would be
useful anyway).

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/stats.html
[2] https://github.com/linux-test-project/ltp/releases
[3] https://docs.readthedocs.io/en/stable/downloadable-documentation.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
