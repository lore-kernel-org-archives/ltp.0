Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEE5D73EA8
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 23:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C2683CBEC3
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 00:25:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B88C3CB260
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 00:24:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BC4671400326
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 00:24:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 914245BCF3;
 Thu, 29 Jan 2026 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769729096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6KwyVqDaWoi+Th+sPeBul3eq3yI9Cd797Kr7H2LaNA=;
 b=xdh7FlNN7BjoC6tQSOb4M4I0ly83KKg2fYVZAQgtAfdeKaJWrhUgS4ElBUcb9FBHaTX3QE
 to4M5sul78GhwkbJwavi8UhUIfvDkC6aXFr+TqUEIPjoeCS0VO9zxCb5PTfCwjnHFKaalc
 57owSMsk1MAyKpNc2uAojpxUZScjU5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769729096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6KwyVqDaWoi+Th+sPeBul3eq3yI9Cd797Kr7H2LaNA=;
 b=Gj+f/YlJ3lJUgzwm16ad88I0qMTkRDY7YOrSrlxXqgLM4/s9ektwAk7AllOQra5nvlL0/n
 UEGitxT52RkNoGAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769729096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6KwyVqDaWoi+Th+sPeBul3eq3yI9Cd797Kr7H2LaNA=;
 b=xdh7FlNN7BjoC6tQSOb4M4I0ly83KKg2fYVZAQgtAfdeKaJWrhUgS4ElBUcb9FBHaTX3QE
 to4M5sul78GhwkbJwavi8UhUIfvDkC6aXFr+TqUEIPjoeCS0VO9zxCb5PTfCwjnHFKaalc
 57owSMsk1MAyKpNc2uAojpxUZScjU5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769729096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6KwyVqDaWoi+Th+sPeBul3eq3yI9Cd797Kr7H2LaNA=;
 b=Gj+f/YlJ3lJUgzwm16ad88I0qMTkRDY7YOrSrlxXqgLM4/s9ektwAk7AllOQra5nvlL0/n
 UEGitxT52RkNoGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2BD83EA61;
 Thu, 29 Jan 2026 23:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NhnqNkfse2ksOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jan 2026 23:24:55 +0000
Date: Fri, 30 Jan 2026 00:24:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Message-ID: <20260129232454.GA110393@pevik>
References: <20260121134146.259161-2-piotr.kubaj@intel.com>
 <20260122140706.GA72518@pevik>
 <eefc58e780c7c80539d993b27b614c16cbae21c6.camel@intel.com>
 <20260123182822.GA367190@pevik>
 <79fc9cb3-ea1f-40ab-ba6f-e7a7dd4f23eb@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79fc9cb3-ea1f-40ab-ba6f-e7a7dd4f23eb@intel.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: "Dubel, Helena Anna" <helena.anna.dubel@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> On 1/23/2026 7:28 PM, Petr Vorel wrote:
> > Hi Piotr,

> > > > > Then it
> > > > > + * decreases the threshold for sending a thermal interrupt to just
> > > > > above
> > > > > + * the current temperature and runs a workload on the CPU.
> > > > First, why test needs to run for 30 sec and then sleep for 10 sec?
> > Maybe the most important of my questions / points.

> > > Here the point is to use a decreasing timeout. The test starts with 10s
> > > cooldown to make sure that even pre-production CPU's, which might have
> > > their thermal protections disabled, cool down properly. Once sleep time
> > > reaches 0, the conclusion is that either there was not enough workload
> > > or somehow interrupts are not triggered after all.
> > Why 30 sec and then sleep for 10 sec? Is it really needed to do it this way?

> Of course not.


> > Aren't these times depending on the tested machine? Some of them will fail due
> > time not running enough,

> That's unexpected with the numbers that are used, so something is amiss if
> it fails (and so it should fail).

I tested on very old (~15 years) Thinkpad, quite powerful 3 years old Thinkpad
and some random machine kind of between these two. All detect the threshold with
less than 10% of time (heating CPU runtime 1s and sleep time 1s).

You go with 30s to smaller values. Wouldn't be faster to go the opposite
(start with small values and increase)? The diff below runs successfully on all
3 machines. What am I missing?

> > other will waste time (if they get interrupt e.g. in 10 sec).

> That very well may happen, but is it a big deal?

We try to cut down the test runtime, because LTP test collection is huge
and runtime for it is many hours [1]. For example, we have many CVE tests which
detect race condition. Instead of running each test for "safe long time enough"
which could be e.g. several minutes for many of them we have way to shorten the
time (see include/tst_fuzzy_sync.h).

[1] https://linux-test-project.readthedocs.io/en/latest/developers/ground_rules.html#why-is-sleep-in-tests-bad-then

> > The usual approach would be to have the timeout safe enough for any type
> > of hardware but proactively check the temperature and stop testing once it's
> > done.

> We want to create conditions in which the temperature should rise and if it
> doesn't, then there is a problem.

Sure.

> That said, the temperature can of course be checked more proactively, at
> least in principle, like say run cpu_workload() for 1s, check the
> temperature, repeat that several times, then cool down etc.

Yeah, that's kind of my proposal above.

Also, all of my 3 machines have only 1x x86_pkg_temp type, but I suppose there
are devices with more (I was not able to figure that out from
drivers/thermal/intel/x86_pkg_temp_thermal.c but otherwise the test would not
try to test them all). But why it is important to test them all? Isn't it enough
just to test a single one?

Kind regards,
Petr

> BR, Rafael


+++ testcases/kernel/thermal/thermal_interrupt_events.c
@@ -117,8 +117,8 @@ static void *cpu_workload(double run_time)
 static void test_zone(int i)
 {
 			char path[NAME_MAX], temp_path[NAME_MAX];
-			int sleep_time = SLEEP, temp_high, temp;
-			double run_time = RUNTIME;
+			int sleep_time = 1, temp_high, temp;
+			double run_time = 1;
 
 			snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/", i);
 			strncpy(temp_path, path, NAME_MAX);
@@ -138,7 +138,7 @@ static void test_zone(int i)
 			SAFE_FILE_SCANF(trip_path, "%d", &trip);
 			SAFE_FILE_PRINTF(trip_path, "%d", temp_high);
 
-			while (sleep_time > 0) {
+			while (sleep_time < SLEEP) {
 				tst_res(TDEBUG, "Running for %f seconds, then sleeping for %d seconds", run_time, sleep_time);
 
 				for (int j = 0; j < nproc; j++) {
@@ -155,8 +155,8 @@ static void test_zone(int i)
 
 				if (temp > temp_high)
 					break;
-				sleep(sleep_time--);
-				run_time -= 3;
+				sleep(sleep_time++);
+				run_time += 3;
 			}
 
 			if (temp <= temp_high)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
