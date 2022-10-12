Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F45EC4332F
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 14:40:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F29673CAED0
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 16:40:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E21B3C9590
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:39:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A4EA16007A0
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 16:39:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 647BE1F381;
 Wed, 12 Oct 2022 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665585595;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaXA1E5gyUSNrpQx061u9ZHcc97a/nhAb0ij4k26yRs=;
 b=aHIOFFNR7DajDcBHWnBVZ+PyP0KIkK9gHEUpPwlvROgdPyB55HvTmQq5Ji3nB6EzChQXL9
 GQcSd08sZ3DHIz6IwYwXNFxZDDbp6/VQEPUBWpzqfukjvdgllaCcqpl92SEFaA3T9J8m7k
 KzdHUrjVhXzoHQmUt40FofGJI/tJMU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665585595;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VaXA1E5gyUSNrpQx061u9ZHcc97a/nhAb0ij4k26yRs=;
 b=zwXRPVG0Hw0Xan41lBYrp4X11dhxJw24LGZttwk1kmF90lkojcd25h726YKBMXb8FbowL1
 7mIPiRn4TbwBHXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32C6913A5C;
 Wed, 12 Oct 2022 14:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xadECrvRRmPgJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Oct 2022 14:39:55 +0000
Date: Wed, 12 Oct 2022 16:39:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Y0bRucMo4gV7B5lw@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
 <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
 <Y0aq/Oar7Swmqzhj@pevik>
 <39e9f8468b43b7d7a916e2b3e643aa233d161a81.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39e9f8468b43b7d7a916e2b3e643aa233d161a81.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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

Hi Mimi,

> Hi Petr,

> On Wed, 2022-10-12 at 13:54 +0200, Petr Vorel wrote:

> > For some reason ima_violations.sh works, when run as the first test after boot
> > (at least with only "ima_policy=tcb" setup), but not when whole ima runtest file
> > is run (as there are tests run before it).  I'm still trying to figure out
> > what's wrong.

> Sounds like initially the tests are run with the builtin "tcb" policy. 
Yes, since LTP does not support reboot and IMA ima_measurements.sh requires
ima_policy=tcb, I configured VM to run all tests with ima_policy=tcb.

> Loading any IMA policy rules replaces the existing builtin policy with
> the new custom policy.

Yes, done in ima_policy.sh, which is the second test (valid policy: measure.policy).
Thus only ima_measurements.sh and ima_policy.sh are run with ima_policy=tcb.
I haven't had a time to look into ascii_runtime_measurements, but this changed
with fsuuid= (previously was working, now vails in ima_violations.sh).
I'll have look soon (I'm wasting your time if I ask before proper debugging).

As I wrote before, it'd be great if 1) running whole runtest/ima worked (either
TPASS or TCONF detect missing something in kernel or in kernel params, ...).
2) running any single tests also TPASS or TCONF.

Testers then could run tests with a different setup (builtin policies, custom
policies, ...).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
