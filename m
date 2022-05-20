Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4044AC433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 10:56:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 984ED3CAAF3
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:56:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFD883C21CE
 for <ltp@lists.linux.it>; Fri, 20 May 2022 12:56:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B3A9C1A00923
 for <ltp@lists.linux.it>; Fri, 20 May 2022 12:56:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1EB61F9A2;
 Fri, 20 May 2022 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653044192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TUPau5HIusSeyB2QLZ6EE/+RpRt46edM+rVWlThj8fc=;
 b=jvPui4WWtOJ2+KAaaQt8Dq2V0lMwiBNdiT9a7jQZDgwFf5svONdw2SWtrUZtVEFDR+kkUx
 mdY8UlpoMhE3u1mQg8RBKS6BJY5WTT0VSnNFS2WZqldAp/Mp7dfK9ihHajfenj4MxQ62hM
 2N3BUCAo7mc+8hOoYPkp0VIOGlVBbeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653044192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TUPau5HIusSeyB2QLZ6EE/+RpRt46edM+rVWlThj8fc=;
 b=psMTU8A7D5uJARdUCbETQ23KLpFQho7OdD3OM24bp+zo7W9GeBzPFG0U6WuTKbCF1/jlSh
 jVltYssWZUOLUOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6B7813A5F;
 Fri, 20 May 2022 10:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ed8OL+Bzh2L6GgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 20 May 2022 10:56:32 +0000
Date: Fri, 20 May 2022 12:58:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: samir mulani <samirmulani93@gmail.com>
Message-ID: <Yod0ZMHdBbBIECVz@yuki>
References: <CADqa+6x0pWEC3LSZiCqBqJ1pTDfU_nPjAGCwPHjC-K=jS+gbpw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADqa+6x0pWEC3LSZiCqBqJ1pTDfU_nPjAGCwPHjC-K=jS+gbpw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP build failure with 5.14 on ppc64le
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> make -C /lib/modules/5.14.21-150400.19-default/build
> M=/Workspace/ltp-master/testcases/kernel/device-drivers/acpi
>   CC [M]  /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:
> In function 'get_sysfs_path':
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:132:11:
> error: implicit declaration of function 'acpi_bus_get_device'; did you
> mean 'acpi_get_gpe_device'? [-Werror=implicit-function-declaration]
>   status = acpi_bus_get_device(handle, &device);
>            ^~~~~~~~~~~~~~~~~~~
>            acpi_get_gpe_device
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:134:40:
> error: dereferencing pointer to incomplete type 'struct acpi_device'
>    sysfs_path = kobject_get_path(&device->dev.kobj, GFP_KERNEL);
>                                         ^~
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:
> In function 'acpi_test_bus':
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:407:11:
> error: implicit declaration of function 'acpi_bus_update_power'; did
> you mean 'acpi_os_trace_point'?
> [-Werror=implicit-function-declaration]
>   status = acpi_bus_update_power(device->handle, &state);
>            ^~~~~~~~~~~~~~~~~~~~~
>            acpi_os_trace_point
> cc1: some warnings being treated as errors
> make[7]: *** [/usr/src/linux-5.14.21-150400.19/scripts/Makefile.build:272:
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o]
> Error 1
> make[6]: *** [/usr/src/linux-5.14.21-150400.19/Makefile:1882:
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi] Error 2
> make[5]: *** [../../../linux-5.14.21-150400.19/Makefile:220: __sub-make] Error 2
> make[4]: [../../../../include/mk/module.mk:62: .dep_modules] Error 2 (ignored)
> rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
> CC testcases/kernel/device-drivers/block/block_dev_user/block_dev

That's just a LTP kernel module build failure, the modules we have in
LTP does not support all kernel versions and may fail to build. This is
not treated as an error by the build system and when the module fails to
build the test is skipped when tests are executed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
