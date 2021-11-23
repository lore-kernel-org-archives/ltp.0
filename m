Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28E0C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 19:40:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7076D3C8F07
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 20:40:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4033C053E
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 20:40:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 812311000A6C
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 20:40:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE7851FD5A;
 Tue, 23 Nov 2021 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637696420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9yVs2USXA7nPU2UywKSEFsP6d9qf8H9S1dJrVHX9iE=;
 b=G/fC74hsjxQDOh6LUg8o79hqGQ46WV3hQjqgjjehO8OMVpLm5xXgWZyCZ2bP0HyrwuiZMv
 HilF8zmUdJnCGDI/F2a2ZnPOAVk7C77E6cuX3M1XqR9MmetZ4Z+DICqCkT66tmg8AXiX28
 WK0ZQSnCj2iZdZwBjFX/NMNyFTF9m80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637696420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9yVs2USXA7nPU2UywKSEFsP6d9qf8H9S1dJrVHX9iE=;
 b=Qol6CDXExcIiaz6Dyrsr7mBP1RrO7Wl6q58G7hteDTUqb4SHBmBeSK7f9HUYB4XOCVWnGe
 8KS/G6YaJMBReEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4FD713E5B;
 Tue, 23 Nov 2021 19:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jiPiBaJDnWEVLwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Nov 2021 19:40:18 +0000
Date: Tue, 23 Nov 2021 20:40:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YZ1Dmbh+m6blfLzZ@pevik>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211123151537.14913-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add test for NFS directory listing
 regression
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

Hi Martin,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Changes since v1:
> - Replace Bash-style brace expansion with $(seq ...)
> - Document command line parameter in usage info

>  runtest/net.nfs                           | 11 ++++
>  testcases/network/nfs/nfs_stress/Makefile |  3 +-
>  testcases/network/nfs/nfs_stress/nfs07.sh | 67 +++++++++++++++++++++++
>  3 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100755 testcases/network/nfs/nfs_stress/nfs07.sh

> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 3df35809a..042c14ce4 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -61,6 +61,17 @@ nfs01_06  nfs06 -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
>  nfs02_06 nfs06 -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
>  nfs03_ipv6_06 nfs06 -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"

> +nfs3_07 nfs07.sh -v 3 -t udp
> +nfs3t_07 nfs07.sh -v 3 -t tcp
> +nfs4_07 nfs07.sh -v 4 -t tcp
> +nfs41_07 nfs07.sh -v 4.1 -t tcp
> +nfs42_07 nfs07.sh -v 4.2 -t tcp
> +nfs3_ipv6_07 nfs07.sh -6 -v 3 -t udp
> +nfs3t_ipv6_07 nfs07.sh -6 -v 3 -t tcp
> +nfs4_ipv6_07 nfs07.sh -6 -v 4 -t tcp
> +nfs41_ipv6_07 nfs07.sh -6 -v 4.1 -t tcp
> +nfs42_ipv6_07 nfs07.sh -6 -v 4.2 -t tcp
> +
>  nfslock3_01 nfslock01 -v 3 -t udp
>  nfslock3t_01 nfslock01 -v 3 -t tcp
>  nfslock4_01 nfslock01 -v 4 -t tcp
> diff --git a/testcases/network/nfs/nfs_stress/Makefile b/testcases/network/nfs/nfs_stress/Makefile
> index 856008ce2..0b7408e29 100644
> --- a/testcases/network/nfs/nfs_stress/Makefile
> +++ b/testcases/network/nfs/nfs_stress/Makefile
> @@ -15,6 +15,7 @@ INSTALL_TARGETS		:= nfs_lib.sh \
>  			   nfs03 \
>  			   nfs04 \
>  			   nfs05 \
> -			   nfs06
> +			   nfs06 \
> +			   nfs07.sh

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/nfs/nfs_stress/nfs07.sh b/testcases/network/nfs/nfs_stress/nfs07.sh
> new file mode 100755
> index 000000000..2c04746fa
> --- /dev/null
> +++ b/testcases/network/nfs/nfs_stress/nfs07.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
> +#
> +#  DESCRIPTION: Create a large number of files and directories on NFS volume.
> +#  Then check whether they can be listed via NFS.
> +
> +FILE_COUNT=5000
> +
> +TST_OPTS="n:"
> +TST_PARSE_ARGS=do_parse_args
> +TST_TESTFUNC="do_test"
> +TST_SETUP="do_setup"
> +
> +do_parse_args()
> +{
> +	case "$1" in
> +	n) FILE_COUNT="$2";;
> +	esac
> +}
> +
> +. nfs_lib.sh
> +
> +TST_USAGE="show_usage"
> +
> +show_usage()
> +{
> +	nfs_usage
> +	echo "-n x    Create x files and x directories, default is 5000"
I'd use $FILE_COUNT (safe to use as help is run before setup, thus -n is not
processed).

> +}
> +
> +do_setup()
> +{
> +	nfs_setup
> +
> +	local rpath=$(nfs_get_remote_path | sed -e 's/%/%%/g')
> +	local file_fmt="$rpath/file%1.0f"
> +	local dir_fmt="$rpath/dir%1.0f"
> +
> +	tst_rhost_run -s -c "touch \$(seq -f \"$file_fmt\" -s ' ' $FILE_COUNT)"
> +	tst_rhost_run -s -c "mkdir \$(seq -f \"$dir_fmt\" -s ' ' $FILE_COUNT)"
+1, very nice

> +}
> +
> +do_test()
> +{
> +	local count
> +
> +	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
typo: s/fitler/filter/

> +	# out potential duplicate filenames returned by buggy NFS
> +	count=`ls | grep '^file' | sort -u | wc -l`
> +
> +	if [ $count -ne $FILE_COUNT ]; then
> +		tst_res TFAIL "Listing files failed: $count != $FILE_COUNT"
> +		return
> +	fi
> +
> +	count=`ls | grep '^dir' | sort -u | wc -l`
> +
> +	if [ $count -ne $FILE_COUNT ]; then
> +		tst_res TFAIL "Listing dirs failed: $count != $FILE_COUNT"
> +		return
> +	fi
> +
> +	tst_res TPASS "All files and directories were correctly listed"
maybe mention $FILE_COUNT?
> +}
> +
> +tst_run

Reviewed-by: Petr Vorel <pvorel@suse.cz>

If you agree, I suggest to merge it with these changes:

diff --git testcases/network/nfs/nfs_stress/nfs07.sh testcases/network/nfs/nfs_stress/nfs07.sh
index 2c04746fa..e44573405 100755
--- testcases/network/nfs/nfs_stress/nfs07.sh
+++ testcases/network/nfs/nfs_stress/nfs07.sh
@@ -26,7 +26,7 @@ TST_USAGE="show_usage"
 show_usage()
 {
 	nfs_usage
-	echo "-n x    Create x files and x directories, default is 5000"
+	echo "-n x    Create x files and x directories, default is $FILE_COUNT"
 }
 
 do_setup()
@@ -45,7 +45,7 @@ do_test()
 {
 	local count
 
-	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
+	# Pass the list of files through `sort -u` in case `ls` doesn't filter
 	# out potential duplicate filenames returned by buggy NFS
 	count=`ls | grep '^file' | sort -u | wc -l`
 
@@ -61,7 +61,7 @@ do_test()
 		return
 	fi
 
-	tst_res TPASS "All files and directories were correctly listed"
+	tst_res TPASS "All $FILE_COUNT files and directories were correctly listed"
 }
 
 tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
