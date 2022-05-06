Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCF8C433F5
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 16:30:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D10F3CA8C7
	for <ltp@archiver.kernel.org>; Fri,  6 May 2022 18:30:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8033C053F
 for <ltp@lists.linux.it>; Fri,  6 May 2022 18:30:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3BBC4140110C
 for <ltp@lists.linux.it>; Fri,  6 May 2022 18:30:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 576E121A8D;
 Fri,  6 May 2022 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651854638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+V6kWHQIDAd80Tye1zLT7MaNAVbZDYl8+rKFjFMx+0=;
 b=nOwPPkDWtGjvcoSggTp/mKZCIQYN0vl+Ri4kZ4g52lMgwI1ZT3WXDEgR/2Z9eCp/zrmhGK
 LKzEu0uW+YolMwXy8zBGSz6g7QnxC7h3o7Ky3NgssmYWB8cu0Cr1g4fV1hzsKvuEgRxCRO
 IE7TCkwoSkZLARGu6ak4aetdW52lO6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651854638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+V6kWHQIDAd80Tye1zLT7MaNAVbZDYl8+rKFjFMx+0=;
 b=CoVVxhFVuZEQ2pRA9ms8fpWVVo6dHWeYqjMULkMRTEKgv0uzrMGIUjuSw3eiuZkmspXjpB
 EYR3tQZebNDXiFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4C113A1B;
 Fri,  6 May 2022 16:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t9HQBC5NdWI7KgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 06 May 2022 16:30:38 +0000
Date: Fri, 6 May 2022 18:30:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnVNLD+nyBtoydyz@pevik>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-5-pvorel@suse.cz> <YnU0XII0YSf0CUnb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnU0XII0YSf0CUnb@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
...
> > +[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> >  [ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
>             ^
> 	    This is no longer set in the tst_test.sh.
Good point, thanks!

> And we do not return from the tst_test.sh when -h was passed so I guess
> that we can just delete this part of the check.
No, this is needed for lib/newlib_tests/shell/net/tst_ipaddr_un.sh, which really
does not want to initialize netns.

...
> > diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
...
> > +. dhcp_lib.sh
> > +
> > +lease_dir="/var/lib/misc"
> > +tst_selinux_enforced && lease_dir="/var/lib/dnsmasq"
> > +
> > +dhcp_name="dnsmasq"
> > +log="/var/log/dnsmasq.tst.log"
> > +
> > +lease_file="$lease_dir/dnsmasq.tst.leases"
> > +
> > +common_opt="--no-hosts --no-resolv --dhcp-authoritative \
> > +	--log-facility=$log --interface=$iface0 \
> > +	--dhcp-leasefile=$lease_file --port=0 --conf-file= "

> Here as well, it does not seem that these variables are redefined so can
> we move the . dhcp_lib.sh just before the tst_run?

Again, needed, because tst_selinux_enforced can be called after loading
tst_test.sh (here after dhcp_lib.sh), because till then it's not visible.

I noted it after v1:
https://lore.kernel.org/ltp/Ykd9CAXfi9FZ+iHB@pevik/

I note it in the commit message.

> >  tst_run

> ...

> > diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> > index ec6643af6..805b1f5ab 100755
> > --- a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> > +++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
> > @@ -6,17 +6,17 @@
> >  # Author: Mitsuru Chinen <mitch@jp.ibm.com>

> >  TST_TESTFUNC="do_test"
> > -. tst_net.sh

> >  do_test()
> >  {
> > -	# not supported on IPv4
> > -	TST_IPV6=6
> > -	TST_IPVER=6
> > -
> >  	tst_res TINFO "Sending ICMPv6 with wrong next header for $NS_DURATION sec"
> >  	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $NS_ICMPV6_SENDER_DATA_MAXSIZE" -n
> >  	tst_ping
> >  }

> > +. tst_net.sh
> > +# not supported on IPv4
> > +TST_IPV6=6
> > +TST_IPVER=6

> Here as well, are these actually changed if we set them before we source
> the tst_net.sh?
Well, they are changed *after* loading tst_net.sh.

> >  tst_run

> Other than these minor things this is rather nice cleanup that
> simplifies the code a bit.

> I guess that in the long term we can clean the shell tests so that there
> is no need to have explicit call to the tst_run and instead the test
> would be started automatically from the sourced tst_test.sh
+1 (although it was nice to search for tst_run to see what is the actual test,
because there are several shell libraries to search).

> Anyways I think that this patchset is good to go as long as we shuffle
> the stuff that can be shuffled. With that:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks!

As Martin replied to netns_breakns.sh args, I'm going to merge it,
because I have 3 patchsets which are waiting for this to be merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
