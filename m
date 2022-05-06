Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66330C433EF
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 14:42:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A0D33CA8BF
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 16:42:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 794833C0F84
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:42:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 420F5600D4B
 for <ltp@lists.linux.it>; Fri,  6 May 2022 16:42:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44DBF1F91D;
 Fri,  6 May 2022 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651848149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IHIXKOQLmR9GTxoknWlBkkxE9RwbsinKr0f4eEsJNc=;
 b=cxtjAexFYQJVlYks1vUOhZ9twj8I1dg2MSbGcjraJGZHWOSWLrf0EhIiOgE0tNfmZS9wQm
 052Cn+hnRpoUIziJyqUbsfGVI1spzp9u1wLkUDz5Ft/Cmj6qCtxk6+uVJllvk4gPtgaZ0o
 gM5iFo6GqKUcw3ADrmGbPVqFkmBXRTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651848149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IHIXKOQLmR9GTxoknWlBkkxE9RwbsinKr0f4eEsJNc=;
 b=C/I5AauUsZKo54hzpeh3lu8/l4zVCoqiWyBroGQnWPxJ12T0H+DurQDXO0ihphOKdibDP5
 sHLsB5EeO93/cVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D10F813A1B;
 Fri,  6 May 2022 14:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hNZJMtQzdWKldwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 06 May 2022 14:42:28 +0000
Date: Fri, 6 May 2022 16:44:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YnU0XII0YSf0CUnb@yuki>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220427125003.20815-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] tst_test.sh: Cleanup getopts usage
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
> index 1ce5d37ef..b7f255cb8 100755
> --- a/testcases/kernel/containers/netns/netns_breakns.sh
> +++ b/testcases/kernel/containers/netns/netns_breakns.sh
> @@ -29,11 +29,6 @@
>  TST_POS_ARGS=3
>  TST_SETUP=do_setup
>  TST_TESTFUNC=do_test
> -. netns_helper.sh
> -
> -PROG=$1
> -IP_VER=$2
> -COM_TYPE=$3
>  
>  do_setup()
>  {
> @@ -49,4 +44,10 @@ do_test()
>  	EXPECT_FAIL $NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK
>  }
>  
> +. netns_helper.sh
> +
> +PROG=$1
> +IP_VER=$2
> +COM_TYPE=$3

Can't we just keep these at the top along with the rest of the
variables? I do not see them redefined anywhere but maybe I miss
something.

>  tst_run
> diff --git a/testcases/kernel/containers/netns/netns_comm.sh b/testcases/kernel/containers/netns/netns_comm.sh
> index ccb8b47b1..bee944802 100755
> --- a/testcases/kernel/containers/netns/netns_comm.sh
> +++ b/testcases/kernel/containers/netns/netns_comm.sh
> @@ -32,11 +32,6 @@
>  TST_POS_ARGS=3
>  TST_SETUP=do_setup
>  TST_TESTFUNC=do_test
> -. netns_helper.sh
> -
> -PROG=$1
> -IP_VER=$2
> -COM_TYPE=$3
>  
>  do_setup()
>  {
> @@ -67,4 +62,10 @@ do_test()
>  	EXPECT_PASS $NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I lo $ip_lo 1>/dev/null
>  }
>  
> +. netns_helper.sh
> +
> +PROG=$1
> +IP_VER=$2
> +COM_TYPE=$3

Here as well.

>  tst_run

...

> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 891472c8a..dae0ceaf1 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
> -# Copyright (c) 2016-2021 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2016-2022 Petr Vorel <pvorel@suse.cz>
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  
>  [ -n "$TST_LIB_NET_LOADED" ] && return 0
> @@ -71,8 +71,6 @@ tst_net_setup()
>  	fi
>  }
>  
> -[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> -
>  if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
>  	tst_res TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
>  	unset TST_PARSE_ARGS_CALLER
> @@ -937,6 +935,7 @@ tst_default_max_pkt()
>  	echo "$((mtu + mtu / 10))"
>  }
>  
> +[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
>  [ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
            ^
	    This is no longer set in the tst_test.sh.

And we do not return from the tst_test.sh when -h was passed so I guess
that we can just delete this part of the check.

...

> diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
> index 855a74263..0183c1da2 100755
> --- a/testcases/network/dhcp/dnsmasq_tests.sh
> +++ b/testcases/network/dhcp/dnsmasq_tests.sh
> @@ -5,20 +5,6 @@
>  #
>  # Author: Alexey Kodanev alexey.kodanev@oracle.com
>  
> -dhcp_name="dnsmasq"
> -
> -. dhcp_lib.sh
> -
> -log="/var/log/dnsmasq.tst.log"
> -
> -lease_dir="/var/lib/misc"
> -tst_selinux_enforced && lease_dir="/var/lib/dnsmasq"
> -lease_file="$lease_dir/dnsmasq.tst.leases"
> -
> -common_opt="--no-hosts --no-resolv --dhcp-authoritative \
> -	--log-facility=$log --interface=$iface0 \
> -	--dhcp-leasefile=$lease_file --port=0 --conf-file= "
> -
>  start_dhcp()
>  {
>  	dnsmasq $common_opt \
> @@ -47,4 +33,18 @@ print_dhcp_version()
>  	dnsmasq --version | head -2
>  }
>  
> +. dhcp_lib.sh
> +
> +lease_dir="/var/lib/misc"
> +tst_selinux_enforced && lease_dir="/var/lib/dnsmasq"
> +
> +dhcp_name="dnsmasq"
> +log="/var/log/dnsmasq.tst.log"
> +
> +lease_file="$lease_dir/dnsmasq.tst.leases"
> +
> +common_opt="--no-hosts --no-resolv --dhcp-authoritative \
> +	--log-facility=$log --interface=$iface0 \
> +	--dhcp-leasefile=$lease_file --port=0 --conf-file= "

Here as well, it does not seem that these variables are redefined so can
we move the . dhcp_lib.sh just before the tst_run?

>  tst_run

...

> diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> index ec6643af6..805b1f5ab 100755
> --- a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> +++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> @@ -6,17 +6,17 @@
>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
>  
>  TST_TESTFUNC="do_test"
> -. tst_net.sh
>  
>  do_test()
>  {
> -	# not supported on IPv4
> -	TST_IPV6=6
> -	TST_IPVER=6
> -
>  	tst_res TINFO "Sending ICMPv6 with wrong next header for $NS_DURATION sec"
>  	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $NS_ICMPV6_SENDER_DATA_MAXSIZE" -n
>  	tst_ping
>  }
>  
> +. tst_net.sh
> +# not supported on IPv4
> +TST_IPV6=6
> +TST_IPVER=6

Here as well, are these actually changed if we set them before we source
the tst_net.sh?

>  tst_run

Other than these minor things this is rather nice cleanup that
simplifies the code a bit.

I guess that in the long term we can clean the shell tests so that there
is no need to have explicit call to the tst_run and instead the test
would be started automatically from the sourced tst_test.sh

Anyways I think that this patchset is good to go as long as we shuffle
the stuff that can be shuffled. With that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
