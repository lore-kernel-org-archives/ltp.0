Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECF3C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:23:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14F0C3D1C07
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 12:23:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0850C3C8484
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 12:23:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 55CFC600839
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 12:23:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A8231F86B;
 Thu, 27 Aug 2026 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787826186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NB1YXotfksaoS7aBOxa6DMEEHL2SiVBmnYBq09qovIM=;
 b=qH74BuTz2QOQosyzLpRH9OEA5xefmXfHw9T4CZ5um+4p3Ci9gnbkpsf2OO4ThxBmNvxPpc
 AYhgdxOFPlgDQCZCPb93AMeew9fS7EBMvmlr3GkemRlW+5m54H0ka3P+rLUWEAeiy+0B8M
 GAGzc0FkbTqi5OmZ9z2sImVFWfKTT6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787826186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NB1YXotfksaoS7aBOxa6DMEEHL2SiVBmnYBq09qovIM=;
 b=Jkcwl8Z8bjpuEZXH6r6ELHcwJjH5p08rZsYxN2O675MhFydpzzQXiD01zNURG+osuJZbQ7
 WNAkTx7DcKFMe4BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787826182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NB1YXotfksaoS7aBOxa6DMEEHL2SiVBmnYBq09qovIM=;
 b=0YHePXbuIAcV4lQhIU63/RdEYOBWG7Iu583w1VSR1xsYD2xQ45RSOIUwTURgqf3lv90UHX
 mHjiIUgw+ePfrLZgK/DIc71SoLMyfW3N2HZcd3vhF+NDurNa2GcBaxguZshHJrvSdoT8MS
 /anE8hDaY12MKGtXwprx9HDhwQDjdHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787826182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NB1YXotfksaoS7aBOxa6DMEEHL2SiVBmnYBq09qovIM=;
 b=RSPwS4pugaa7ajBbe1WoyMUpJHwAomC6xgElttVaVanqVrc/uZYe38tIXvPvKvU78M5xJd
 D8Mpxd8c191+bIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27EA013354;
 Thu, 27 Aug 2026 10:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oVlqCAYQkGrjLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Aug 2026 10:23:02 +0000
Date: Thu, 27 Aug 2026 12:22:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260827102252.GA442795@pevik>
References: <20260827030518.4078-1-linuxtestproject.agent@gmail.com>
 <6a8fdf90.52a3ce3c.38dd62.6301@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8fdf90.52a3ce3c.38dd62.6301@mx.google.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,opensuse.org:url]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_tpm.sh: properly detect failure to verify the IMA
 measurement list
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, Andrea,

> Hi Mimi,

> > > +	pcr_aggregate="$(cat tmp.txt | awk '{print $1}')"

> > The cat here is redundant, awk can read the file directly:


> This is valid.

+1, agent did a good job here :). We could even avoid using tail (awk has this
feature), but let's ignore that.

As it is trivial, I can change it before merge (see diff below).

> > > +		lineno="$(cat tmp.txt | awk '{print $2}')"

> > Same here:

> > 	lineno="$(awk '{print $2}' tmp.txt)"

> [..]


> > > +		tst_res TPASS "aggregate PCR value matched real PCR value (line: $lineno/$total_measurements)"

> > This line is about 100 columns wide. LTP shell style asks for lines
> > under 80 characters; perhaps wrap it or shorten the message.

> we can ignore this one.

We should teach agent that splitting quotes string does more harm than slightly
longer line.

> @Petr can you please take a look?

Sure :). FYI I already did have a brief look yesterday, and I also triggered CI
jobs for v1 and wait them to finish. Of course I'll rerun them for v2.

@Mimi FYI v1 patch triggers failure - it just calculate a different
aggregate PCR-10. Although the commit subject is "properly detect failure" ..
I'm not sure if this is a false negative or the current code on master just did
not find error (false positive). As I said, I'll rerun v2 and let you know if
it's the same.

Testing on openSUSE Tumbleweed x86_64 VM with kernel: 7.1.8-1, virtualized TPM
2.0, evmctl 1.6.2. Working master [1], broken with your patch [2].

FYI TPM 2.0 used:

swtpm socket --tpmstate dir=/tmp/mytpm25 --ctrl \
type=unixio,path=/tmp/mytpm25/swtpm-sock --log level=20 -d --tpm2

Whole QEMU command:

/usr/bin/qemu-system-x86_64 -device VGA,edid=on,xres=1024,yres=768 \
-only-migratable -chardev ringbuf,id=serial0,logfile=serial0,logappend=on \
-serial chardev:serial0 -audiodev none,id=snd0 -device intel-hda -device \
hda-output,audiodev=snd0 -global isa-fdc.fdtypeA=none -m 1536 -cpu host -netdev \
user,id=qanet0 -device virtio-net,netdev=qanet0,mac=52:54:00:12:34:56 -object \
rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 \
-chardev socket,id=chrtpm,path=/tmp/mytpm25/swtpm-sock -tpmdev \
emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0 -boot order=c \
-device qemu-xhci -device usb-tablet -smp 1 -enable-kvm -no-shutdown -vnc \
:115,share=force-shared -device virtio-serial -chardev \
pipe,id=virtio_console,path=virtio_console,logfile=virtio_console.log,logappend=on \
-device \
virtconsole,chardev=virtio_console,name=org.openqa.console.virtio_console \
-chardev \
pipe,id=virtio_console_user,path=virtio_console_user,logfile=virtio_console_user.log,logappend=on \
-device \
virtconsole,chardev=virtio_console_user,name=org.openqa.console.virtio_console_user \
-chardev \
socket,path=qmp_socket,server=on,wait=off,id=qmp_socket,logfile=qmp_socket.log,logappend=on \
-qmp chardev:qmp_socket -S -device virtio-scsi-pci,id=scsi0 -blockdev \
driver=file,node-name=hd0-overlay0-file,filename=/var/lib/openqa/pool/25/raid/hd0-overlay0,cache.no-flush=on \
-blockdev \
driver=qcow2,node-name=hd0-overlay0,file=hd0-overlay0-file,cache.no-flush=on,discard=unmap \
-device virtio-blk,id=hd0-device,drive=hd0-overlay0,bootindex=0,serial=hd0 \
-blockdev \
driver=file,node-name=cd0-overlay0-file,filename=/var/lib/openqa/pool/25/raid/cd0-overlay0,cache.no-flush=on \
-blockdev \
driver=qcow2,node-name=cd0-overlay0,file=cd0-overlay0-file,cache.no-flush=on,discard=unmap \
-device scsi-cd,id=cd0-device,drive=cd0-overlay0,serial=cd0

Kind regards,
Petr

[1] https://openqa.opensuse.org/tests/6185158#step/ima_tpm/4
[2] https://openqa.opensuse.org/tests/6185106#step/ima_tpm/4
[3] https://openqa.opensuse.org/tests/6185106/file/autoinst-log.txt

diff --git testcases/kernel/security/integrity/ima/tests/ima_tpm.sh testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 8bb86ea4ac..edf8699f83 100755
--- testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -295,7 +295,7 @@ test2()
 	get_pcr10_aggregate > tmp.txt
 	ret=$?
 
-	pcr_aggregate="$(cat tmp.txt | awk '{print $1}')"
+	pcr_aggregate="$(awk '{print $1}' tmp.txt)"
 	if [ -z "$pcr_aggregate" ]; then
 		return
 	fi
@@ -304,7 +304,7 @@ test2()
 	if [ "$hash" = "$pcr_aggregate" ]; then
 		tst_res TPASS "aggregate PCR value matches real PCR value"
 	elif [ $ret -eq 0 ]; then
-		lineno="$(cat tmp.txt | awk '{print $2}')"
+		lineno="$(awk '{print $2}' tmp.txt)"
 		if [ -z "$lineno" ]; then
 			return
 		fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
