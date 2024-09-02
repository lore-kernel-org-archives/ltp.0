Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6217CA0ED3
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 11:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43C153C4ADC
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 13:01:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 897953C090A
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 13:00:56 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5304814010EB
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 13:00:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8D4221B51;
 Mon,  2 Sep 2024 11:00:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 920D713A7C;
 Mon,  2 Sep 2024 11:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qCp/IuWa1Wb1cQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 11:00:53 +0000
Date: Mon, 2 Sep 2024 13:00:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240902110037.GD279460@pevik>
References: <20240830095758.20018-1-wegao@suse.com>
 <20240830103835.GA42409@pevik> <ZtWV0R_oDb7BQdKm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtWV0R_oDb7BQdKm@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B8D4221B51
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mpls01.sh: Add --allow-unsupported for modprobe
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

Hi Cyril, Wei,

> Hi!

> > 	if grep -q suse /etc/os-release; then

> There are a couple of english words that contain "suse" as a substring
> if one of these ends up in the os-release it would match, e.g. the
> os-release may contain VERSION="24 (Disused Miracle)".  And yes both
> Fedora and Ubuntu seems to include the the code names in the file.

> So I would be stricter here and checked for ID=suse.

Very good point.

FYI SLES (removed non-related lines)

NAME="SLES"
VERSION="15-SP6"
PRETTY_NAME="SUSE Linux Enterprise Server 15 SP6"
ID="sles"
ID_LIKE="suse"

SLE Micro (removed non-related lines):

NAME="SL-Micro"
PRETTY_NAME="SUSE Linux Micro 6.0"
ID="sl-micro"
ID_LIKE="suse"

Debian:
NAME="Debian GNU/Linux"
ID=debian

=> SUSE quite all variables, but at least Debian not (ID=debian).
Therefore for more complex scenarios I would source the file
(. /etc/os-release). But in this case grep sl-micro could be enough
(unique enough).

Will you ack this change (RBT/ABT) in v2 [1] (newer version than this, I would
change before merge)?

-       if grep -q suse /etc/os-release; then
+       if grep -q 'sl-micro' /etc/os-release; then

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20240902024017.6404-1-wegao@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
