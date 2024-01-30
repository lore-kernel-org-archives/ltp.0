Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E33C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:19:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24CCC3CF982
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 14:19:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 363D03CE104
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 14:19:22 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D0A71400335
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 14:19:21 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83614222D9;
 Tue, 30 Jan 2024 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706620760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6Dt9N8zZzDKaESMO3/Qj/kHANDeJAFDZiAZL8U0dkk=;
 b=RaSYus1cuBO61KTBkRyiomvURVQBWsysWdtCh3K6YLYtA+5fmt5OIC+wPvXOG4fbFLUNaH
 Nu8fVUmuS49FdhHrfN0MmNgAsWDiRZf92+arikCSuZeSIY/lcrLs0zKZpoOmm88yPhF9lY
 /VCrTN9Ph9L9WO0EPKNUU8U/gKBzUnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706620760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6Dt9N8zZzDKaESMO3/Qj/kHANDeJAFDZiAZL8U0dkk=;
 b=R7HXbuqlbKiFuhb1Rig6sFM6qkpxQCdQYn74AYYPhAS6qdk0jRFS94+zkMqV9DeRhklpiX
 Oyn5k9wP9BwGehBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706620760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6Dt9N8zZzDKaESMO3/Qj/kHANDeJAFDZiAZL8U0dkk=;
 b=RaSYus1cuBO61KTBkRyiomvURVQBWsysWdtCh3K6YLYtA+5fmt5OIC+wPvXOG4fbFLUNaH
 Nu8fVUmuS49FdhHrfN0MmNgAsWDiRZf92+arikCSuZeSIY/lcrLs0zKZpoOmm88yPhF9lY
 /VCrTN9Ph9L9WO0EPKNUU8U/gKBzUnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706620760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h6Dt9N8zZzDKaESMO3/Qj/kHANDeJAFDZiAZL8U0dkk=;
 b=R7HXbuqlbKiFuhb1Rig6sFM6qkpxQCdQYn74AYYPhAS6qdk0jRFS94+zkMqV9DeRhklpiX
 Oyn5k9wP9BwGehBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 670B713212;
 Tue, 30 Jan 2024 13:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6EWnFlj3uGUwKQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 13:19:20 +0000
Date: Tue, 30 Jan 2024 14:19:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130131919.GB786076@pevik>
References: <20231031160918.17845-1-pvorel@suse.cz>
 <20231031160918.17845-2-pvorel@suse.cz>
 <179d3e55-0d75-4bcd-852b-7046c143b193@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <179d3e55-0d75-4bcd-852b-7046c143b193@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[11.74%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] runtest/net.nfs: Rename test names
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

Hi Martin,

> Hi,
> I agree with the general idea but I think this version is a bit too verbose.
> How about something like this?

> nfs01_v30_ip4u nfs01.sh -v 3 -t udp
> nfs01_v30_ip4t nfs01.sh -v 3 -t tcp
> nfs01_v40_ip4t nfs01.sh -v 4 -t tcp
> nfs01_v41_ip4t nfs01.sh -v 4.1 -t tcp
> nfs01_v42_ip4t nfs01.sh -v 4.2 -t tcp
> nfs01_v30_ip6u nfs01.sh -6 -v 3 -t udp
> nfs01_v30_ip6t nfs01.sh -6 -v 3 -t tcp
> nfs01_v40_ip6t nfs01.sh -6 -v 4 -t tcp
> nfs01_v41_ip6t nfs01.sh -6 -v 4.1 -t tcp
> nfs01_v42_ip6t nfs01.sh -6 -v 4.2 -t tcp

> nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> nfs06_vall_ip4t nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t
> "tcp,tcp,tcp,tcp,tcp,tcp"
> nfs06_v4x_ip6t nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t
> "tcp,tcp,tcp,tcp,tcp,tcp"

Very good point, thank you!

We again get inconsistent with the rest of network runtest files, but I can live
with that).

I'll Cc you with next version.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
