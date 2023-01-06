Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8E4C5479D
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 10:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAB563CCCD4
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 11:53:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 078B73C19D9
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 11:53:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 777001400181
 for <ltp@lists.linux.it>; Fri,  6 Jan 2023 11:53:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 659CE24F2B;
 Fri,  6 Jan 2023 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673002420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c8oKc09iuAl8mzqdmTkIqpFGfC1j8MMhD0pu2gwVDPI=;
 b=t59c4c/SuqG+JnlaNhGQTX7n7U9oZjrTiiFq61Bw/QfvJkfBIXUUKl9LRrm31B/ExroJWr
 oLHXU9tbZJQUzqK/JTqs8QIFtibJDb4s/1RgQ/pTWpV8zGci6Xfi2r6AysycriCvmmhYcI
 uEvNZnqUhKAiTAWQmLtbsQJGdHCUqw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673002420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c8oKc09iuAl8mzqdmTkIqpFGfC1j8MMhD0pu2gwVDPI=;
 b=hO5QcDRXmiFAWJRIE0MZvOwyig8F/+AJKrmpXdcDXTaYkKnkfiAmyc8ectjEMp4LFpnNEY
 FwaKh3MwkB3geGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34B65139D5;
 Fri,  6 Jan 2023 10:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id n+1hC7T9t2MQEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jan 2023 10:53:40 +0000
Date: Fri, 6 Jan 2023 11:53:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <Y7f9snVrsp+JVbJi@pevik>
References: <20230105162929.16047-1-mdoucha@suse.cz> <Y7frMzCovq8I/oOE@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7frMzCovq8I/oOE@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ltp-aiodio.part4: Run DIT000 with only 1
 reader process
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

merged. Thanks a lot for your work.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
