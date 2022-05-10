Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F2C433F5
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 13:07:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8D583CA981
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 15:07:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F36EF3C9C87
 for <ltp@lists.linux.it>; Tue, 10 May 2022 15:07:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E4AE1400BD1
 for <ltp@lists.linux.it>; Tue, 10 May 2022 15:06:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFDC51F8BA;
 Tue, 10 May 2022 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652188018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZwMYpZk4Sr6nbDMG2YML92BwJGlvyOugCkEe4Ikfmc=;
 b=WwlX3g6WyIyaXHm9hS+VHw3QoDFKs62qCsnR08xtWaupEKwEDCT0okz5No7tnX6CFmysTG
 fTRqzMxhsQvzxVWV0cp8lZEWrtKntU9YbmVntBrbACBinBMdLuL8uMn1UkHJ6eRDvsd0vZ
 8I8rcK0O/L9gU55GIYHc1zeWKI3TqdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652188018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZwMYpZk4Sr6nbDMG2YML92BwJGlvyOugCkEe4Ikfmc=;
 b=X0CQQ0qPvrlea0EUGTQuvTK11WC2ETTP5SlwCcDD2uLOyQsYPvgCaPvGrczSfFRs1QS6Bv
 TyVygmQBM7kKNhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ABBF13AC1;
 Tue, 10 May 2022 13:06:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3kiwH3JjemI9HgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 13:06:58 +0000
Date: Tue, 10 May 2022 15:06:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnpjcH4i33YxyeFJ@pevik>
References: <20220510065104.1199-1-pvorel@suse.cz>
 <20220510065104.1199-2-pvorel@suse.cz> <YnpXGnJyjjZhxuRN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnpXGnJyjjZhxuRN@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] tst_net.sh: Fix for disabled IPv6
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
> > +# detect IPv6 support on lhost for tests which don't use test links
> > +tst_net_detect_ipv6
> > +
> >  [ -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0

> >  # Management Link
> > @@ -970,8 +1007,13 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> >  if [ -z "$_tst_net_parse_variables" ]; then
> >  	eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
> >  	eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")
> > -	eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> > -	eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> > +
> > +	tst_net_detect_ipv6 rhost
> > +
> > +	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
> > +		eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")
> > +		eval $(tst_net_ip_prefix -r $IPV6_RHOST || echo "exit $?")
> > +	fi

> If I'm looking right at this piece of code we do run the
> tst_net_detect_ipv6 twice once for lhost and once for rhost when the
> script is sourced and we only set the TST_NET_IPV6_ENABLED when the
> check succeeds, right?

Yes.

FYI 2 tests run only first run for lhost - these which use
TST_NET_SKIP_VARIABLE_INIT=1:
* lib/newlib_tests/shell/net/tst_ipaddr_un.sh (which does not need this feature
  as test runs for both IPv4 and IPv6 and does not need IPv6 functionality)
* and with this patchset also for testcases/kernel/containers/netns/netns_lib.sh
  netns tests require IPv6 only for lhost, thus that's enough for
  TST_NET_SKIP_VARIABLE_INIT=1

> Shouldn't we also unset it when the check fails because otherwise the
> check for rhost is basically no-op as long as the lhost supports ipv6?

Hm, that's right. Patch below would will fix it.
Anyway I'm not much happy with tst_net_detect_ipv6 setting global variable
$TST_NET_IPV6_ENABLED. But I wanted to stay compatible with the rest of
tst_net.sh, which becomes more an more messy (rewriting/deleting old tests
will allow cleanup code for TST_USE_LEGACY_API=1). Anyway, feel free to suggest
something better.

Kind regards,
Petr

diff --git testcases/lib/tst_net.sh testcases/lib/tst_net.sh
index 29d80df89..48dd6e8eb 100644
--- testcases/lib/tst_net.sh
+++ testcases/lib/tst_net.sh
@@ -1008,7 +1008,7 @@ if [ -z "$_tst_net_parse_variables" ]; then
        eval $(tst_net_ip_prefix $IPV4_LHOST || echo "exit $?")
        eval $(tst_net_ip_prefix -r $IPV4_RHOST || echo "exit $?")

-       tst_net_detect_ipv6 rhost
+       [ "$TST_NET_IPV6_ENABLED" = 1 ] && tst_net_detect_ipv6 rhost

        if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
                eval $(tst_net_ip_prefix $IPV6_LHOST || echo "exit $?")



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
