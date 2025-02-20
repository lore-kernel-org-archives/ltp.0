Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE0DC021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 19:14:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C26E13C7B85
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 20:14:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2A2A3C0430
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 20:13:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 045D71BDD08D
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 20:13:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 604B41F387;
 Thu, 20 Feb 2025 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740078829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
 b=cFKOxLHn1FMUwUmSUNg2I+gsPkGtdFAeRVKew+EljQfPRG9PTJiQbIoprhMc8XE1D6AbaZ
 AqULBPwhm8TPq5XIAqO98MMILW8h9VRJW4/oOYNPSzh6JeLWHiIsefHc8CJEMdQY7EVAo9
 K7tEtyIo+MGoPH8XPo5r2l5o7ZwKwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740078829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
 b=cnKlinJ6clYdZuhNWVmTTgfhR4mMWILShB7bxf4WnuGq7kv9aud2RqZ2XVxs0UUeihA0pq
 4nqRGZoxZ6kCbwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740078829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
 b=cFKOxLHn1FMUwUmSUNg2I+gsPkGtdFAeRVKew+EljQfPRG9PTJiQbIoprhMc8XE1D6AbaZ
 AqULBPwhm8TPq5XIAqO98MMILW8h9VRJW4/oOYNPSzh6JeLWHiIsefHc8CJEMdQY7EVAo9
 K7tEtyIo+MGoPH8XPo5r2l5o7ZwKwmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740078829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlzUcSTDSEkNHy8Fobz9oUsMdz91Ct8W7U/s9j/zWSI=;
 b=cnKlinJ6clYdZuhNWVmTTgfhR4mMWILShB7bxf4WnuGq7kv9aud2RqZ2XVxs0UUeihA0pq
 4nqRGZoxZ6kCbwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D99213301;
 Thu, 20 Feb 2025 19:13:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +prKIOx+t2e0NgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 19:13:48 +0000
Date: Thu, 20 Feb 2025 20:13:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250220191342.GA2716312@pevik>
References: <20250220160054.12149-1-zohar@linux.ibm.com>
 <20250220160054.12149-3-zohar@linux.ibm.com>
 <20250220181604.GA2709977@pevik>
 <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd10e47b4c8b6af0e8d37975cdf1e82133add8c3.camel@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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

> On Thu, 2025-02-20 at 19:16 +0100, Petr Vorel wrote:
> > Hi Mimi,

> > > Kernel patch "ima: limit the number of ToMToU integrity violations"
> > > prevents superfluous ToMToU violations.=A0 Add corresponding LTP test=
s.

> > > Link:
> > > https://lore.kernel.org/linux-integrity/20250219162131.416719-3-zohar=
@linux.ibm.com/
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

> > Unfortunately tests fail on both mainline kernel and kernel with your p=
atches.

> The new LTP IMA violations patches should fail without the associated ker=
nel patches.

> > Any hint what could be wrong?

> Of course it's dependent on the IMA policy.  The tests assume being boote=
d with the IMA
> TCB measurement policy or similar policy being loaded.  Can you share the=
 IMA policy?
> e.g. cat /sys/kernel/security/ima/policy

> thanks,

> Mimi

Now testing on kernel *with* your patches. First run always fails, regardle=
ss
whether using ima_policy=3Dtcb or
/opt/ltp/testcases/data/ima_violations/violations.policy).

Kind regards,
Petr

First run fails:

# LTP_IMA_LOAD_POLICY=3D1 LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/b=
in:$PATH" ima_violations.sh
(policy is /opt/ltp/testcases/data/ima_violations/violations.policy)
ima_violations 1 TINFO: Running: ima_violations.sh =

ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-defau=
lt #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86=
_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.XR34KhtnDM as tmpdir =
(tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_=
ima_violations.XR34KhtnDM/mntpoint =

ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc=
3-1.gb6b4102-default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c spl=
ash=3Dsilent video=3D1024x768 plymouth.ignore-serial-consoles console=3Dtty=
S0 console=3Dtty kernel.softlockup_panic=3D1 resume=3D/dev/disk/by-uuid/c3b=
865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=3Dauto security=3Dapparmor ig=
nore_loglevel
ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
ima_violations 1 TINFO: test requires IMA policy:
measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
ima_violations 1 TINFO: WARNING: missing required policy content: 'measure =
func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0'
ima_violations 1 TINFO: trying to load '/opt/ltp/testcases/data/ima_violati=
ons/violations.policy' policy:
measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
ima_violations 1 TINFO: example policy successfully loaded
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added: 2 - 0
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP=
 PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected whi=
ch might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU vio=
lation
ima_violations 8 TPASS: 2 ToMToU violation(s) added
ima_violations 9 TINFO: WARNING: policy loaded via LTP_IMA_LOAD_POLICY=3D1,=
 reboot recommended

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0

Second run is ok:
# LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_violations=
.sh
ima_violations 1 TINFO: Running: ima_violations.sh =

ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-defau=
lt #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86=
_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /var/tmp/LTP_ima_violations.SWERFjvPTp as tmp=
dir (btrfs filesystem)
ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc=
3-1.gb6b4102-default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c spl=
ash=3Dsilent video=3D1024x768 plymouth.ignore-serial-consoles console=3Dtty=
S0 console=3Dtty kernel.softlockup_panic=3D1 resume=3D/dev/disk/by-uuid/c3b=
865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=3Dauto security=3Dapparmor ig=
nore_loglevel
ima_violations 1 TINFO: test requires IMA policy:
measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
ima_violations 1 TINFO: SUT has required policy content
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TPASS: 1 open_writers violation(s) added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP=
 PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected whi=
ch might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU vio=
lation
ima_violations 8 TPASS: 2 ToMToU violation(s) added

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0

Reboot and running with ima_policy=3Dtcb also fails on the first time:

# LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_violations=
.sh =

tmpfs is skipped
ima_violations 1 TINFO: Running: ima_violations.sh =

ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-defau=
lt #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86=
_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.FKQSfezAwR as tmpdir =
(tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_=
ima_violations.FKQSfezAwR/mntpoint =

ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc=
3-1.gb6b4102-default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c spl=
ash=3Dsilent video=3D1024x768 plymouth.ignore-serial-consoles console=3Dtty=
S0 console=3Dtty kernel.softlockup_panic=3D1 resume=3D/dev/disk/by-uuid/c3b=
865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=3Dauto security=3Dapparmor ig=
nore_loglevel ima_policy=3Dtcb
ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
ima_violations 1 TINFO: booted with IMA policy: tcb
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers too many violations added: 3 - 1
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP=
 PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected whi=
ch might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU vio=
lation
ima_violations 8 TPASS: 2 ToMToU violation(s) added

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0

Second and later run is again OK
# LTPROOT=3D"/opt/ltp" PATH=3D"/opt/ltp/testcases/bin:$PATH" ima_violations=
.sh =

tmpfs is skipped
ima_violations 1 TINFO: Running: ima_violations.sh =

ima_violations 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-defau=
lt #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86=
_64 x86_64 GNU/Linux
ima_violations 1 TINFO: Using /tmp/LTP_ima_violations.1Qf6qJuSoo as tmpdir =
(tmpfs filesystem)
tst_device.c:99: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts=3D'/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_=
ima_violations.1Qf6qJuSoo/mntpoint =

ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=3D10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=3Dy
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH=3D"sha256"
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=3Dy
ima_violations 1 TINFO: CONFIG_IMA_ARCH_POLICY=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=3Dy
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
ima_violations 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
ima_violations 1 TINFO: CONFIG_IMA_DISABLE_HTABLE=3Dy
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc=
3-1.gb6b4102-default root=3DUUID=3De36b2366-1af2-4408-903c-1fca82c60f4c spl=
ash=3Dsilent video=3D1024x768 plymouth.ignore-serial-consoles console=3Dtty=
S0 console=3Dtty kernel.softlockup_panic=3D1 resume=3D/dev/disk/by-uuid/c3b=
865f9-5d5b-410e-a6d1-9ebcf721584c mitigations=3Dauto security=3Dapparmor ig=
nore_loglevel ima_policy=3Dtcb
ima_violations 1 TINFO: $TMPDIR is on tmpfs =3D> run on loop device
ima_violations 1 TINFO: booted with IMA policy: tcb
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TPASS: 1 open_writers violation(s) added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TPASS: 1 ToMToU violation(s) added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1900: TINFO: LTP version: 20250130-22-gcd2215702f
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc3-1.gb6b4102-default #1 SMP=
 PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected whi=
ch might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 02m 00s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TPASS: 1 open_writers violation(s) added
ima_mmap.c:41: TPASS: test completed

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0
ima_violations 4 TINFO: verify limiting single open writer violation
ima_violations 4 TPASS: 1 open_writers violation(s) added
ima_violations 5 TINFO: verify limiting multiple open writers violations
ima_violations 5 TPASS: 1 open_writers violation(s) added
ima_violations 6 TINFO: verify new open writer causes additional violation
ima_violations 6 TPASS: 2 open_writers violation(s) added
ima_violations 7 TINFO: verify limiting single open reader ToMToU violations
ima_violations 7 TPASS: 1 ToMToU violation(s) added
ima_violations 8 TINFO: verify new open reader causes additional ToMToU vio=
lation
ima_violations 8 TPASS: 2 ToMToU violation(s) added

Summary:
passed   8
failed   0
broken   0
skipped  0
warnings 0

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
