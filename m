Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A539D778AE
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 19:48:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01E003CB9C2
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 20:48:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E167A3CB86F
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 20:48:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 60515100036D
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 20:48:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FFEB5BCC7;
 Fri, 23 Jan 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEAD1395E;
 Fri, 23 Jan 2026 19:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uzXwKZXQc2lmYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Jan 2026 19:48:37 +0000
Date: Fri, 23 Jan 2026 20:48:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260123194836.GA435072@pevik>
References: <20260120144626.231614-2-piotr.kubaj@intel.com>
 <20260120193851.GB65442@pevik>
 <4dd67d8bf040715bf5a6456bb4270f08dba3986b.camel@intel.com>
 <20260122142701.GA78350@pevik>
 <4366caa2f3055b446e421278d314265c1c3b32ad.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4366caa2f3055b446e421278d314265c1c3b32ad.camel@intel.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1FFEB5BCC7
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] thermal: add new test group
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

...
> Hi,

> I tried:
> SAFE_SSCANF(line, " TRM:%sThermal event interrupts", buffer);

I'm sorry, you wrote that, but I did not get that the line is based on number of
CPU core (I meant scanning into integer variables).

> But it's the same as before, only the first number ends up in the
> buffer. Still, even if I managed to put them all into buffer, I would
> still need to later divide them into individual elements of
> interrupt_array and strtok seems fit for that.

I'm usually trying to avoid using strtok(), but whatever.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
