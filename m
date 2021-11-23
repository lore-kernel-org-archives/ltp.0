Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB607C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 09:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6C693C8DCF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 10:49:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89513C24E3
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 10:49:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 222AC201036
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 10:49:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C0CC2171F;
 Tue, 23 Nov 2021 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637660959;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRnD2Q5lezmjEBQ4oXEAejxTxt3u2qXapMVh0IOWrx8=;
 b=YopuYlCgH7X5xQp4qqP577qaxSU0PIgXNdapnrTabmwPiNhlfVRb6juydUoH99tntmw3vZ
 2fa2ML1xDNXbr1v1TEpithoGiR2dPyrBYJaiznwLsD3O1Zg08F3/CVKwMNMwZVxxC3OwCB
 AO9rXv2b44oZE2pl7jq2FJQMTZlOBvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637660959;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRnD2Q5lezmjEBQ4oXEAejxTxt3u2qXapMVh0IOWrx8=;
 b=I8aVW9jfEfTl3cXd/6435WApTyT7XpR3A19EoqqyggvqczcQYxeKouUkVMkFVa30l+1Jg6
 kwvQVASbzWhVMDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05F3B13D8E;
 Tue, 23 Nov 2021 09:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CF52Oh65nGG6IAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Nov 2021 09:49:18 +0000
Date: Tue, 23 Nov 2021 10:49:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YZy5HNteJmoicTtJ@pevik>
References: <20211118172313.20159-1-mdoucha@suse.cz>
 <20211118172313.20159-3-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211118172313.20159-3-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] Add test for NFS directory listing regression
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

Cc: Alexey
...
> +++ b/testcases/network/nfs/nfs_stress/Makefile
> @@ -15,6 +15,7 @@ INSTALL_TARGETS		:= nfs_lib.sh \
>  			   nfs03 \
>  			   nfs04 \
>  			   nfs05 \
> -			   nfs06
> +			   nfs06 \
> +			   nfs07.sh
+ 1 for .sh name, we should later add it to the rest of NFS shell scripts.

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/nfs/nfs_stress/nfs07.sh b/testcases/network/nfs/nfs_stress/nfs07.sh
> new file mode 100755
> index 000000000..d8e482751
> --- /dev/null
> +++ b/testcases/network/nfs/nfs_stress/nfs07.sh
> @@ -0,0 +1,56 @@
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
nit: nfs07.sh -h does not list this, would you care to add TST_USAGE?

> +}
> +
> +. nfs_lib.sh
> +
> +do_setup()
> +{
> +	nfs_setup
> +
> +	local rpath=$(nfs_get_remote_path)
> +	tst_rhost_run -s -c "touch $rpath/file{1..$FILE_COUNT}"
> +	tst_rhost_run -s -c "mkdir $rpath/dir{1..$FILE_COUNT}"
Unfortunately {1..$FILE_COUNT} is bashism (not work at least on dash).
Could you please rewrite it to using for cycle and seq?
It might be reasonably slower on bash, but working everywhere.

The rest LGTM, good idea to add this test.

Kind regards,
Petr

> +}
> +
> +do_test()
> +{
> +	local count
> +
> +	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
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
> +}
> +
> +tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
