Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB09C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 08:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F42E3C8FB4
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 09:16:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F238B3C239D
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:16:28 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B35F1428092
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:16:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 385581F385;
 Fri, 21 Feb 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CE6713888;
 Fri, 21 Feb 2025 08:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xUmWAVk2uGewDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 08:16:25 +0000
Date: Fri, 21 Feb 2025 09:16:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250221081623.GA2739743@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
 <20250220191342.GA2716312@pevik>
 <c625586b0dbc4302dfb7adf4acb0c891b74cf8bc.camel@linux.ibm.com>
 <2637152a2715b8e84e966b12bc9c9cb1c27592c2.camel@linux.ibm.com>
 <20250220214333.GA2726725@pevik>
 <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd07d8052fbfa0cde426b4b07fde0c70e6aa046f.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 385581F385
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 3/3] ima: additional ToMToU violation tests
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, 2025-02-20 at 22:43 +0100, Petr Vorel wrote:
> > > On Thu, 2025-02-20 at 15:22 -0500, Mimi Zohar wrote:
> > > > On Thu, 2025-02-20 at 20:13 +0100, Petr Vorel wrote:
> > > > > > On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > > > > > > Hi Mimi,

> > > > > > > > Kernel patch "ima: limit the number of ToMToU integrity vio=
lations"
> > > > > > > > prevents superfluous ToMToU violations.=A0 Add correspondin=
g LTP tests.

> > > > > > > > Link:
> > > > > > > > https://lore.kernel.org/linux-integrity/20250219162131.4167=
19-3-zohar@linux.ibm.com/
> > > > > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> > > > > > > Unfortunately tests fail on both mainline kernel and kernel w=
ith your patches.

> > > > > > The new LTP IMA violations patches should fail without the asso=
ciated kernel
> > > > > > patches.

> > > > > > > Any hint what could be wrong?

> > > > > > Of course it's dependent on the IMA policy.=A0 The tests assume=
 being booted with
> > > > > > the
> > > > > > IMA
> > > > > > TCB measurement policy or similar policy being loaded.=A0 Can y=
ou share the IMA
> > > > > > policy?
> > > > > > e.g. cat /sys/kernel/security/ima/policy

> > > > > > thanks,

> > > > > > Mimi

> > > > > Now testing on kernel *with* your patches. First run always fails=
, regardless
> > > > > whether using ima_policy=3Dtcb or
> > > > > /opt/ltp/testcases/data/ima_violations/violations.policy).

> > > > > Kind regards,
> > > > > Petr

> > > > I'm not seeing that on my test machine.=A0 Could there be other thi=
ngs running on your
> > > > system causing violations.=A0 In anycase, your original test was le=
ss exacting.=A0=A0
> > > > Similarly,
> > > > instead of "-eq", try using "-qe" in the following test and removin=
g the subsequent
> > > > new
> > > > "gt" test.

> > > -> "-ge"

> > Sure, changing to -ge fixes the problem:
> > if [ $(($num_violations_new - $num_violations)) -ge $expected_violation=
s ]; then

> > I guess we need "-ge" for older kernels (unless "fix" for stable).=A0 S=
hould we
> > accept "$expected_violations || $expected_violations + 1" for new kerne=
ls to
> > avoid problems like the one on my system.

> The problem is that we don't control what else is running on the system. =
 So there could
> be other violations independent of these tests.  I'll have to think about=
 it some more and
> get back to you.  (There's no rush to do anything with these LTP IMA viol=
ation tests.)

OK, thank you. The worse scenario would be to use less precise variant "-ge=
".

> > I wonder if the problem was somehow caused by the fact that I built ker=
nel. OTOH
> > it's build by OBS (official openSUSE build service).

> As long as you weren't building the kernel and running the tests at the s=
ame, I doubt it
> would be the problem.

Understand, just something on openSUSE Tumbleweed system.

Kind regards,
Petr

> > I don't expect you'd have time to look into it, in case you're interest=
ed and
> > have time sending a links to rpm binary and src package.

> Ok.

> > https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-=
writers-ToMToU/standard/x86_64/kernel-default-6.14~rc3-1.1.gb6b4102.x86_64.=
rpm
> > https://download.opensuse.org/repositories/home:/pevik:/ima-limit-open-=
writers-ToMToU/standard/src/kernel-source-6.14~rc3-1.1.gb6b4102.src.rpm


> thanks,

> Mimi

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
