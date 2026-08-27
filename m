Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D261C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:00:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 060E63DAE58
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 15:00:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6798B3D0F88
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:59:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 775CA200927
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 14:59:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E57A9211E0;
 Thu, 27 Aug 2026 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787835590;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W2bUKO+S2RMUXBTAOEgPKg4umH73+1yWKK6rswEbe58=;
 b=cCQ69gfFoqrJh8calrI8gtlLVLDzV+jUlHR02g+fAGEELIWtwpRXVUy//GGbqiXb+wVmsK
 X4BULP1roEwElaPasUiiKCFCN65954Wva0qhDK+/MdumQ+ZXdqlwRcxp7PA12cnVVmyGU/
 e52pnOxhLjIyf+i/cFiUst0mq6DoD8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787835590;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W2bUKO+S2RMUXBTAOEgPKg4umH73+1yWKK6rswEbe58=;
 b=ZuzS6nWzhkRWcIVAotT9AfMYqDVC+/Nma6UDObFIuqyua+GQwaT9KSM1yInr8q/PuqCAdD
 jZzIYBTlv6VyXTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787835585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W2bUKO+S2RMUXBTAOEgPKg4umH73+1yWKK6rswEbe58=;
 b=ifHGDAWsWuq7/WOsgF7vtajQxwee7HwrWg+Ttt/kfmyiFEqODjGq37ruaytPFKrwTZcEZd
 BDydfxM39f71575/rp8DfA+4oQCs/h6Ain/NZqdYPxIGS4FfBqF+SAcNn8dzVVufo3T7gU
 uqIWqRmO4X99OxCWqIhK1gUvuv31YsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787835585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W2bUKO+S2RMUXBTAOEgPKg4umH73+1yWKK6rswEbe58=;
 b=DN5SeQ43wTRsP59YKxTRRXso3NuEqGYTHQl4ilhyE6v9VP/Gx/iQyYVc/F4Z5eBp7jvVJv
 QTnHLkkYyEJC36Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBE3A13354;
 Thu, 27 Aug 2026 12:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sLZkIsA0kGroTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Aug 2026 12:59:44 +0000
Date: Thu, 27 Aug 2026 14:59:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 linuxtestproject.agent@gmail.com, Mimi Zohar <zohar@linux.ibm.com>,
 ltp@lists.linux.it
Message-ID: <20260827125937.GA471019@pevik>
References: <20260827030518.4078-1-linuxtestproject.agent@gmail.com>
 <6a8fdf90.52a3ce3c.38dd62.6301@mx.google.com>
 <20260827102252.GA442795@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827102252.GA442795@pevik>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 FREEMAIL_TO(0.00)[suse.com,gmail.com,linux.ibm.com,lists.linux.it];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,opensuse.org:url]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

...
> @Mimi FYI v1 patch triggers failure - it just calculate a different
> aggregate PCR-10. Although the commit subject is "properly detect failure" ..
> I'm not sure if this is a false negative or the current code on master just did
> not find error (false positive). As I said, I'll rerun v2 and let you know if
> it's the same.

> Testing on openSUSE Tumbleweed x86_64 VM with kernel: 7.1.8-1, virtualized TPM
> 2.0, evmctl 1.6.2. Working master [1], broken with your patch [2].

FYI tested on BIOS (legacy).

> FYI TPM 2.0 used:

> swtpm socket --tpmstate dir=/tmp/mytpm25 --ctrl \
> type=unixio,path=/tmp/mytpm25/swtpm-sock --log level=20 -d --tpm2

> Whole QEMU command:

> /usr/bin/qemu-system-x86_64 -device VGA,edid=on,xres=1024,yres=768 \
> -only-migratable -chardev ringbuf,id=serial0,logfile=serial0,logappend=on \
> -serial chardev:serial0 -audiodev none,id=snd0 -device intel-hda -device \
> hda-output,audiodev=snd0 -global isa-fdc.fdtypeA=none -m 1536 -cpu host -netdev \
> user,id=qanet0 -device virtio-net,netdev=qanet0,mac=52:54:00:12:34:56 -object \
> rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 \
> -chardev socket,id=chrtpm,path=/tmp/mytpm25/swtpm-sock -tpmdev \
> emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0 -boot order=c \
> -device qemu-xhci -device usb-tablet -smp 1 -enable-kvm -no-shutdown -vnc \
> :115,share=force-shared -device virtio-serial -chardev \
> pipe,id=virtio_console,path=virtio_console,logfile=virtio_console.log,logappend=on \
> -device \
> virtconsole,chardev=virtio_console,name=org.openqa.console.virtio_console \
> -chardev \
> pipe,id=virtio_console_user,path=virtio_console_user,logfile=virtio_console_user.log,logappend=on \
> -device \
> virtconsole,chardev=virtio_console_user,name=org.openqa.console.virtio_console_user \
> -chardev \
> socket,path=qmp_socket,server=on,wait=off,id=qmp_socket,logfile=qmp_socket.log,logappend=on \
> -qmp chardev:qmp_socket -S -device virtio-scsi-pci,id=scsi0 -blockdev \
> driver=file,node-name=hd0-overlay0-file,filename=/var/lib/openqa/pool/25/raid/hd0-overlay0,cache.no-flush=on \
> -blockdev \
> driver=qcow2,node-name=hd0-overlay0,file=hd0-overlay0-file,cache.no-flush=on,discard=unmap \
> -device virtio-blk,id=hd0-device,drive=hd0-overlay0,bootindex=0,serial=hd0 \
> -blockdev \
> driver=file,node-name=cd0-overlay0-file,filename=/var/lib/openqa/pool/25/raid/cd0-overlay0,cache.no-flush=on \
> -blockdev \
> driver=qcow2,node-name=cd0-overlay0,file=cd0-overlay0-file,cache.no-flush=on,discard=unmap \
> -device scsi-cd,id=cd0-device,drive=cd0-overlay0,serial=cd0

> Kind regards,
> Petr

> [1] https://openqa.opensuse.org/tests/6185158#step/ima_tpm/4
> [2] https://openqa.opensuse.org/tests/6185106#step/ima_tpm/4
Maybe the wrapped version is easier to read
https://openqa.opensuse.org/tests/6187473#step/ima_tpm/6

> [3] https://openqa.opensuse.org/tests/6185106/file/autoinst-log.txt
https://openqa.opensuse.org/tests/6187580#step/ima_tpm/6

BTW tested on other VM locally (outside of openQA testing framework)
with emulated TPM 2.0 I have even 2 tests failing.

$ cat /sys/class/tpm/tpm*/tpm_version_major
2

$ evmctl ima_boot_aggregate -v; echo $?
Failed to read TPM 1.2 PCRs (errno: No such file or directory)
Using tss2-rc-decode to read PCRs.
ERROR:tcti:src/tss2-tcti/tctildr-dl.c:263:tctildr_get_default() No standard TCTI could be loaded 
ERROR:tcti:src/tss2-tcti/tctildr.c:477:tctildr_init_context_data() Failed to instantiate TCTI 
ERROR:esys:src/tss2-esys/esys_context.c:71:Esys_Initialize() Initialize default tcti. ErrorCode (0x000a000a) 
read_tpm_banks:2208 Failed to read sha1 PCRs: (esys initialize failed: tcti:IO failure)
ERROR:tcti:src/tss2-tcti/tctildr-dl.c:263:tctildr_get_default() No standard TCTI could be loaded 
ERROR:tcti:src/tss2-tcti/tctildr.c:477:tctildr_init_context_data() Failed to instantiate TCTI 
ERROR:esys:src/tss2-esys/esys_context.c:71:Esys_Initialize() Initialize default tcti. ErrorCode (0x000a000a) 
read_tpm_banks:2208 Failed to read sha256 PCRs: (esys initialize failed: tcti:IO failure)
Failed to read any TPM PCRs
errno: No such file or directory (2)
125

I need to use also --hwtpm:
$ evmctl ima_boot_aggregate -v --hwtpm; echo $?
Failed to read TPM 1.2 PCRs (errno: No such file or directory)
Trying to read TPM 2.0 PCRs via sysfs
Failed to read TPM 2.0 PCRs via sysfs (errno: No such file or directory)
sha256:e911229581efb7ceb82826940c7e939d05dbc33b38862730651767ab5bd7c446
0

This is on VM BIOS (legacy) running on UEFI QEMU host.

The same behaves when running this on the machine itself (in UEFI QEMU host,
outside of the VM).

Other, unrelated problem is that evmctl blocks on UEFI VM on UEFI QEMU host
(w/a --hwtpm) without any TPM on tss2-rc, but that might be caused just by old
VM, I'll retest and report if it persists.

OT: it'd be nice to describe exit values in evmctl man page.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
