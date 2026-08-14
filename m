Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086B7C5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 06:01:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36F3F3C72E2
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 08:01:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EEAD3C5E18
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 08:01:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 577DC200058
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 08:01:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D5BB82D69;
 Fri, 14 Aug 2026 06:01:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1AB578211;
 Fri, 14 Aug 2026 06:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E/z5OSevfmqKJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Aug 2026 06:01:11 +0000
Date: Fri, 14 Aug 2026 08:01:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20260814060102.GC261864@pevik>
References: <20260813112524.1849695-1-pvorel@suse.cz>
 <b901f8d94a9d6e3faf26a5e359ad8ec7e306c931.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b901f8d94a9d6e3faf26a5e359ad8ec7e306c931.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1D5BB82D69
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ima_setup.sh: Use tst_umount()
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

> Hi Petr,

> On Thu, 2026-08-13 at 13:25 +0200, Petr Vorel wrote:
> > Use standard test mechanism to detect problems during umount() caused by
> > GNOME's gvfsd-trash daemon. Although it will not solve the problem it at
> > least warn tester.

> > Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> With this patch applied and after removing everything other than ima_violations
> from /opt/ltp/runtest/ima, I'm still seeing:

> ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_violations 1 TINFO: booted with IMA policy: tcb
> ima_violations 1 TINFO: using log /var/log/audit/audit.log
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TPASS: 1 open_writers violation(s) added
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TPASS: 1 ToMToU violation(s) added
> ima_violations 3 TINFO: verify open_writers using mmapped files
> tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.1.5-
> 101.fc43.x86_64/build/.config'
> ima_violations 3 TBROK: tst_checkpoint wait 10000 0 failed
> umount: /tmp/LTP_ima_violations.1OEcI81NHB/mntpoint: target is busy.
> ima_violations 3 TINFO: umount(/tmp/LTP_ima_violations.1OEcI81NHB/mntpoint)
> failed, try 1 ...
> ima_violations 3 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it
> to speed up tests.
> umount: /tmp/LTP_ima_violations.1OEcI81NHB/mntpoint: target is busy.
> ima_violations 3 TINFO: umount(/tmp/LTP_ima_violations.1OEcI81NHB/mntpoint)
> failed, try 2 ...

I wonder if the process on your machine is gvfsd-trash or something else.
Unfortunately what we can do is probably just an advice to user, killing any
userspace process is probably too aggressive. So the current isn't really a
workaround just kind of a hint.

> The message keeps repeating ...

Yeah, I wonder if trying 50x makes even sense, IMHO 5x would be enough.

FYI the current code in tst_test.sh:

tst_umount()
{
	local mntpoint="${1:-$TST_MNTPOINT}"
	local i=0

	[ -z "$mntpoint" ] && return

	if ! echo "$mntpoint" | grep -q ^/; then
		tst_brk TCONF "The '$mntpoint' is not an absolute path"
	fi

	if ! grep -q "${mntpoint%/}" /proc/mounts; then
		tst_res TINFO "The '$mntpoint' is not mounted, skipping umount"
		return
	fi

	while [ "$i" -lt 50 ]; do
		if umount "$mntpoint" > /dev/null; then
			return
		fi

		i=$((i+1))

		tst_res TINFO "umount($mntpoint) failed, try $i ..."
		tst_res TINFO "Likely gvfsd-trash is probing newly mounted "\
		              "fs, kill it to speed up tests."

		tst_sleep 100ms
	done

	tst_res TWARN "Failed to umount($mntpoint) after 50 retries"
}

Kind regards,
Petr

> Mimi


> > ---
> >  testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > index 19f00532b1..054ab28611 100644
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -313,7 +313,7 @@ ima_cleanup()
> >  	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER

> >  	for dir in $UMOUNT; do
> > -		umount $dir
> > +		tst_umount $dir
> >  	done

> >  	if [ "$IMA_POLICY_LOADED" = 1 ]; then

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
