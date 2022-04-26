Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACDBC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 10:53:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6449F3CA15B
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 12:53:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3D263C0CEA
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 12:53:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8ED7B2002D2
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 12:53:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 692C4210F4;
 Tue, 26 Apr 2022 10:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650970411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQTgo9vsptWbXUMauKRjZ+MuwUA6Xmlb/DubDkgddCw=;
 b=fCqQK6z10j30hvFOrjb0LyMBYhL6cq1ZTRuYSZ8QyfcrpZfMXQajTEU7ZdJ+ifBxFCmGqk
 ulEhLlsuN9Rp8ZDuwX/NBTQQ+WofIs4UyKh6C0GIaSJ5zAR7ju37hwj21IHvqRCsuVpAGp
 sU9aty9ftaLdtjSUuDUYkGgIEHz5wkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650970411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQTgo9vsptWbXUMauKRjZ+MuwUA6Xmlb/DubDkgddCw=;
 b=g/EhWk6ZTSpo4XQ3ZujrI5JgKbAqZ6JobkQ32Yv1M1A7rKqXIasRJEwXXekbbYQjALoF0L
 LPz97j/Su6k1pyBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4721213AD5;
 Tue, 26 Apr 2022 10:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5JNGECvPZ2JXYQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 26 Apr 2022 10:53:31 +0000
Message-ID: <d448fbda-cbfb-e954-f5de-f1aa02b5bfd0@suse.cz>
Date: Tue, 26 Apr 2022 12:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220422144141.16848-1-pvorel@suse.cz>
 <20220422144141.16848-2-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220422144141.16848-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] shell: Use conditional expansion for
 library setup/cleanup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
there are a few files where the only change is in the copyright comment.
I'll leave it up to you whether you want to keep those changes or drop
them. I've also added a suggestion for another improvement in a separate
patchset below.

I've also run new tests on this patchset and everything seems to work.
Overall:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 22. 04. 22 16:41, Petr Vorel wrote:
> To avoid surprises when test specific setup/cleanup function is
> redefined by shell library.
> 
> Although there is not an optimal general solution because usually test
> which have specific setup/cleanup also needs to call library setup/cleanup,
> but it's better not to require TST_{SETUP,CLEANUP} to be on specific place.
> 
> Added to all shell libraries, regardless it's required or not.
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> * New in v2
> 
>  testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 4 ++--
>  testcases/kernel/device-drivers/zram/zram01.sh             | 4 ++--
>  testcases/kernel/device-drivers/zram/zram_lib.sh           | 6 +++---
>  testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh         | 4 ++--
>  testcases/kernel/fs/fs_bind/fs_bind_lib.sh                 | 4 ++--
>  testcases/network/busy_poll/busy_poll_lib.sh               | 5 +++--
>  testcases/network/dhcp/dhcp_lib.sh                         | 6 +++---
>  testcases/network/iptables/iptables_lib.sh                 | 1 +
>  testcases/network/nfs/nfs_stress/nfs_lib.sh                | 1 +
>  testcases/network/stress/interface/if-lib.sh               | 7 +++++--
>  testcases/network/stress/ipsec/ipsec_lib.sh                | 2 +-
>  testcases/network/virt/macsec_lib.sh                       | 6 +++---
>  testcases/network/virt/virt_lib.sh                         | 2 +-
>  testcases/network/virt/wireguard_lib.sh                    | 1 +
>  14 files changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index 1b76b65974..db010acc76 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -10,8 +10,8 @@ TST_NEEDS_CHECKPOINTS=1
>  TST_NEEDS_ROOT=1
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_CMDS="killall find kill"
> -TST_CLEANUP=memcg_cleanup
> -TST_SETUP=memcg_setup
> +TST_SETUP="${TST_SETUP:-memcg_setup}"
> +TST_CLEANUP="${TST_CLEANUP:-memcg_cleanup}"
>  TST_TESTFUNC=memcg_testfunc
>  
>  MEMCG_SHMMAX=${MEMCG_SHMMAX:-0}
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index 5b4c05434d..a80fbe7fa7 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
> -# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
>  # Test creates several zram devices with different filesystems on them.
> @@ -9,8 +9,8 @@
>  TST_CNT=7
>  TST_TESTFUNC="do_test"
>  TST_NEEDS_CMDS="awk bc dd"
> -. zram_lib.sh
>  TST_SETUP="setup"
> +. zram_lib.sh
>  
>  check_space_for_btrfs()
>  {
> diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
> index a420fb672b..803fd98259 100755
> --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
> -# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
>  dev_makeswap=-1
> @@ -12,8 +12,8 @@ sys_control=-1
>  
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> -TST_SETUP="zram_load"
> -TST_CLEANUP="zram_cleanup"
> +TST_SETUP="${TST_SETUP:-zram_load}"
> +TST_CLEANUP="${TST_CLEANUP:-zram_cleanup}"
>  TST_NEEDS_DRIVERS="zram"
>  . tst_test.sh
>  
> diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
> index 4976825311..ff862db438 100755
> --- a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
> +++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
> @@ -4,8 +4,8 @@
>  # Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>  # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>  
> -TST_SETUP=binfmt_misc_setup
> -TST_CLEANUP=binfmt_misc_cleanup
> +TST_SETUP="${TST_SETUP:-binfmt_misc_setup}"
> +TST_CLEANUP="${TST_CLEANUP:-binfmt_misc_cleanup}"
>  TST_NEEDS_DRIVERS="binfmt_misc"
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
> index a5356fa360..6676d1021a 100644
> --- a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
> +++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
> @@ -7,8 +7,8 @@
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
>  TST_MIN_KVER=2.6.15
> -TST_SETUP=fs_bind_setup
> -TST_CLEANUP=fs_bind_cleanup
> +TST_SETUP="${TST_SETUP:-fs_bind_setup}"
> +TST_CLEANUP="${TST_CLEANUP:-fs_bind_cleanup}"
>  TST_TESTFUNC=fs_bind_test
>  TST_NEEDS_CMDS="mount umount awk sed"
>  
> diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
> index d17504466c..91995e703f 100755
> --- a/testcases/network/busy_poll/busy_poll_lib.sh
> +++ b/testcases/network/busy_poll/busy_poll_lib.sh
> @@ -1,10 +1,11 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
> +# Copyright (c) Linux Test Project, 2016-2022
>  
> -TST_SETUP="setup"
>  TST_TESTFUNC="test"
> -TST_CLEANUP="cleanup"
> +TST_SETUP="${TST_SETUP:-setup}"
> +TST_CLEANUP="${TST_CLEANUP:-cleanup}"

The setup() and cleanup() functions here should get a prefix, otherwise
we're asking for duplicate definitions. But that can be added in a
separate patchset.

>  TST_MIN_KVER="3.11"
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
> index 5537112c8d..ebee0c2e9c 100755
> --- a/testcases/network/dhcp/dhcp_lib.sh
> +++ b/testcases/network/dhcp/dhcp_lib.sh
> @@ -1,11 +1,11 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2014-2018 Oracle and/or its affiliates. All Rights Reserved.
> -# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
>  # Author:       Alexey Kodanev alexey.kodanev@oracle.com
>  
> -TST_SETUP="dhcp_lib_setup"
> -TST_CLEANUP="dhcp_lib_cleanup"
> +TST_SETUP="${TST_SETUP:-dhcp_lib_setup}"
> +TST_CLEANUP="${TST_CLEANUP:-dhcp_lib_cleanup}"
>  TST_TESTFUNC="test01"
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> diff --git a/testcases/network/iptables/iptables_lib.sh b/testcases/network/iptables/iptables_lib.sh
> index ad2a894b6e..2d13b79ca8 100755
> --- a/testcases/network/iptables/iptables_lib.sh
> +++ b/testcases/network/iptables/iptables_lib.sh
> @@ -2,6 +2,7 @@
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2018-2019 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001
> +# Copyright (c) Linux Test Project, 2019-2022
>  #
>  #  Author:	Jan 20 2004 Hubert Lin <linux02NOSPAAAM@tw.ibm.com>
>  #				       <hubertNOSPAAAM@symbio.com.tw>
> diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> index 55ce1e11a4..8f90da5cca 100644
> --- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
> +++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
> @@ -1,5 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) Linux Test Project, 2016-2022
>  # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
>  # Copyright (c) International Business Machines  Corp., 2001
>  
> diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
> index b398be1ad0..2b1db6e007 100644
> --- a/testcases/network/stress/interface/if-lib.sh
> +++ b/testcases/network/stress/interface/if-lib.sh
> @@ -5,7 +5,11 @@
>  
>  CMD="${CMD:-ip}"
>  
> -TST_SETUP="${TST_SETUP:-if_setup}"
> +if [ -z "$TST_SETUP" ]; then
> +	TST_SETUP="if_setup"
> +	TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
> +fi
> +
>  TST_TESTFUNC="test_body"
>  TST_PARSE_ARGS="if_parse_args"
>  TST_USAGE="if_usage"
> @@ -32,7 +36,6 @@ if_setup()
>  
>  	tst_require_cmds "$CMD"
>  	netstress_setup
> -	TST_CLEANUP="${TST_CLEANUP:-netstress_cleanup}"
>  }
>  
>  if_cleanup_restore()
> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> index 99fed08088..4201eac11a 100644
> --- a/testcases/network/stress/ipsec/ipsec_lib.sh
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
>  # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
>  # Author: Hangbin Liu <haliu@redhat.com>
> diff --git a/testcases/network/virt/macsec_lib.sh b/testcases/network/virt/macsec_lib.sh
> index c2573c5720..ac77f09768 100755
> --- a/testcases/network/virt/macsec_lib.sh
> +++ b/testcases/network/virt/macsec_lib.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
> @@ -10,8 +10,8 @@ IPSEC_MODE="transport"
>  
>  TST_NEEDS_TMPDIR=1
>  TST_TESTFUNC=virt_netperf_msg_sizes
> -TST_SETUP=macsec_lib_setup
> -TST_CLEANUP=macsec_lib_cleanup
> +TST_SETUP="${TST_SETUP:-macsec_lib_setup}"
> +TST_CLEANUP="${TST_CLEANUP:-macsec_lib_cleanup}"
>  TST_NEEDS_DRIVERS="macsec"
>  . ipsec_lib.sh
>  . virt_lib.sh
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index e9cdab595f..fd3f4af0d4 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
>  # Copyright (c) 2014-2021 Oracle and/or its affiliates. All Rights Reserved.
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
> diff --git a/testcases/network/virt/wireguard_lib.sh b/testcases/network/virt/wireguard_lib.sh
> index 2e36bce309..836d09b7f4 100755
> --- a/testcases/network/virt/wireguard_lib.sh
> +++ b/testcases/network/virt/wireguard_lib.sh
> @@ -1,5 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) Linux Test Project, 2022
>  # Copyright (c) 2020 Oracle and/or its affiliates. All Rights Reserved.
>  
>  TST_NEEDS_TMPDIR=1


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
