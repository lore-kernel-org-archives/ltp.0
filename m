Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77C8C71150
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 22:49:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07FBC3D27BB
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 00:49:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49C353CF762
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 00:48:55 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A312601A6C
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 00:48:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 927EB21999;
 Wed, 28 Aug 2024 22:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724885332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMM3nbleKrouIadUNbcurEA9+rkEJEy0foulk5AmsIc=;
 b=GjLExMmIUbgAfaNYHTdaubpACkeTvMxAbO0xeChPk8B9iDykr98ulc6DiIWEraEtHXSkw+
 fSKlguRQtYAwkk431wWfu37JVmIC28JBXXm3tS1S4CJYa1lOkNd8lX7/djg30NPqrQyzfJ
 ORon9QAt3N1NrxXI00VjKkll9s07YZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724885332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMM3nbleKrouIadUNbcurEA9+rkEJEy0foulk5AmsIc=;
 b=vmG8yV5org/ZeO5e8OwLd0yzrJKqMg7E3MhH8g+rOPJxrcuYhA1OPiDFub7q5yu5CZbGHW
 2vaHGhzGBzMS3vAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724885331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMM3nbleKrouIadUNbcurEA9+rkEJEy0foulk5AmsIc=;
 b=NqDpDs3ANeuxeLz4nIRhEA/LOGZ70Zd2QOcW6KKu+c3S7uWDGmUAKw9xOZfkV4D//gVAx0
 lgwQfxtk09pT7Kym3djJ4JrPEhGiX+l13Ai6zsVdcH9chYIIQuy2NR4d33F61Vbnaa205l
 HkOc/aCDTv0GdaOEsDGZaakp9kDx2M0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724885331;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMM3nbleKrouIadUNbcurEA9+rkEJEy0foulk5AmsIc=;
 b=j7wo1lbyNN+wN9stwSRy0QrYNyh2rrV9lR2TGF6UcIgM/gnJXs2PuIUOpzfXY2nEnOUI6F
 r/13Q2PY+wLXfPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7902F1398F;
 Wed, 28 Aug 2024 22:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rXekHFOpz2ZJSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Aug 2024 22:48:51 +0000
Date: Thu, 29 Aug 2024 00:48:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever III <chuck.lever@oracle.com>
Message-ID: <20240828224850.GA1773775@pevik>
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUBJECT_ENDS_QUESTION(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp build broken on Fedora 40?
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chuck,

> Hi-

> I'm finding that ltp 20240524 does not build on Fedora 40 due
> to a missing header:

I guess you need to backport gcc-14 fix b0ae1ee239 ("rpc_svc_1: Fix incompatible
pointer type error") [1] (or build with older gcc).

> ltp/testcases/kernel/device-drivers/tbio/tbio_kernel/ltp_tbio.c:46:10: fatal error: linux/genhd.h: No such file or directory
>    46 | #include <linux/genhd.h>
>       |          ^~~~~~~~~~~~~~~
> compilation terminated.

Yes, <linux/genhd.h> was removed back then in v5.18-rc1 [2] (we should use
<linux/blkdev.h>). But that should not cause your build fail. But because we
don't maintain these kernel drivers (there was a plan to move them to kunit
anyway), the build error is ignored [3]:

	# Ignoring the exit status of commands is done to be forward compatible with
	# kernel internal API changes. The user-space test will return TCONF, if it
	# doesn't find the module (i.e. it wasn't built either due to kernel-devel
	# missing or module build failure).
	%.ko: %.c .dep_modules ;

With properly installed kernel headers (WITH_MODULES = yes in
include/mk/config.mk) I get:

$ cd testcases/kernel/device-drivers/acpi
$ make; echo $?
make -C "ltp/lib" -f "ltp/lib/Makefile" all
make[1]: Entering directory 'ltp/lib'
GEN ltp-version.h
make[2]: Nothing to be done for 'all'.
make[2]: Nothing to be done for 'all'.
make[1]: Leaving directory 'ltp/lib'
CC testcases/kernel/device-drivers/acpi/ltp_acpi
Building modules: ltp_acpi_cmds.c
make -C /lib/modules/6.10.6-amd64/build M=ltp/testcases/kernel/device-drivers/acpi
make[1]: Entering directory '/usr/src/linux-headers-6.10.6-amd64'
  CC [M]  ltp/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o
ltp/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:39:10: fatal error: linux/genhd.h: No such file or directory
   39 | #include <linux/genhd.h>
      |          ^~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [/usr/src/linux-headers-6.10.6-common/scripts/Makefile.build:249: ltp/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o] Error 1
make[2]: *** [/usr/src/linux-headers-6.10.6-common/Makefile:1943: ltp/testcases/kernel/device-drivers/acpi] Error 2
make[1]: *** [/usr/src/linux-headers-6.10.6-common/Makefile:252: __sub-make] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-6.10.6-amd64'
make: [../../../../include/mk/module.mk:62: .dep_modules] Error 2 (ignored)
=> note "ignored"
rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
0

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/b0ae1ee2392d0612cce7d61842b78640a04b26f0
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=322cbb50de711814c42fb088f6d31901502c711a
[3] https://github.com/linux-test-project/ltp/blob/master/include/mk/module.mk#L54-L58

> However the ltp build works on Fedora 39. I'm not sure why
> because I cannot find a linux/genhd.h on that system.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
