Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D8BD778AF
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 18:28:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B17A3CB907
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 19:28:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C58623C05FA
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 19:28:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21FD2200262
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 19:28:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 901A933852;
 Fri, 23 Jan 2026 18:28:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D19F1395E;
 Fri, 23 Jan 2026 18:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RHE9C8i9c2kTFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Jan 2026 18:28:24 +0000
Date: Fri, 23 Jan 2026 19:28:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Kubaj, Piotr" <piotr.kubaj@intel.com>
Message-ID: <20260123182822.GA367190@pevik>
References: <20260121134146.259161-2-piotr.kubaj@intel.com>
 <20260122140706.GA72518@pevik>
 <eefc58e780c7c80539d993b27b614c16cbae21c6.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eefc58e780c7c80539d993b27b614c16cbae21c6.camel@intel.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 901A933852
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] thermal: add new test group
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

> > > Then it
> > > + * decreases the threshold for sending a thermal interrupt to just
> > > above
> > > + * the current temperature and runs a workload on the CPU.

> > First, why test needs to run for 30 sec and then sleep for 10 sec?
Maybe the most important of my questions / points.

> Here the point is to use a decreasing timeout. The test starts with 10s
> cooldown to make sure that even pre-production CPU's, which might have
> their thermal protections disabled, cool down properly. Once sleep time
> reaches 0, the conclusion is that either there was not enough workload
> or somehow interrupts are not triggered after all.

Why 30 sec and then sleep for 10 sec? Is it really needed to do it this way?
Aren't these times depending on the tested machine? Some of them will fail due
time not running enough, other will waste time (if they get interrupt e.g. in 10
sec). The usual approach would be to have the timeout safe enough for any type
of hardware but proactively check the temperature and stop testing once it's
done.

...
> > > +			int temp;
> > > +
> > > +			snprintf(path, PATH_LEN,
> > > "/sys/class/thermal/thermal_zone%d/", i);
> > > +			strncpy(temp_path, path, PATH_LEN);
> > > +			strncat(temp_path, "temp", 4);
> > > +			tst_res(TDEBUG, "Testing %s", temp_path);
> > nit: I'd put this as TINFO to get at least some debug info without -
> > D.

> > > +			SAFE_FILE_SCANF(temp_path, "%d", &temp);
> > All SAFE_*() macros quit testing, therefore the following check is
> > not needed.
> It's necessary because if the temperature is below 0, there's most
> likely some kernel or sensor issue.

I'm sorry, I was wrong here. I mixed up vfscanf() return value from LTP
function, but you check the scanned value.

Kind regards,
Petr

> > > +			if (temp < 0) {
> > > +				tst_brk(TBROK, "Unexpected zone
> > > temperature value %d", temp);
> > > +				status = 0;
> > > +			}
> > > +			tst_res(TDEBUG, "Current temperature for
> > > %s: %d", path, temp);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
