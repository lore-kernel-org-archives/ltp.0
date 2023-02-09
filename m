Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3672FC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 09:21:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4924B3CC0A3
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 10:21:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40CD03C039E
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 10:21:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 496F31400E47
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 10:21:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F61935170;
 Thu,  9 Feb 2023 09:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675934464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26X9aWzxtOTvcUMymBloY1OCRiPoQATCFe/2DiQhQkc=;
 b=klsmkL2HVItue/qCIrm4bPN+oJm9WrOGbrjRHFYJClLRXio4gc4VVOlec3XgHfqKfnSpRV
 r+ztAw6eU9Nom9WQBJ7YLbuTqv6hXZvBnNIL1xUUS4/9b38CUUj9uSp4zmkPLAEjIG2vWM
 zhSTgXyjR4uHeXyG9UMq4GN7CWIm+hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675934464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26X9aWzxtOTvcUMymBloY1OCRiPoQATCFe/2DiQhQkc=;
 b=Io+wTp/ICnaaROa8Bgxc24lvcAArCY/t351PyY1NDHIYkr90LPR4t5nRCO1F85r74A/p9D
 bKinfhKtuuoLR5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 029131339E;
 Thu,  9 Feb 2023 09:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QYggO/+65GO8KgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Feb 2023 09:21:03 +0000
Date: Thu, 9 Feb 2023 10:21:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+S6/qr2dpO9LMi+@pevik>
References: <20230208092327.28914-1-pvorel@suse.cz> <Y+NzkUcAyeupRwmP@pevik>
 <Y+Ox+H1awhu+h2j+@yuki> <20230208145833.GB1918@pevik>
 <Y+Sqt9NA9S4gxISX@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+Sqt9NA9S4gxISX@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] testscripts/network.sh: Don't load tst_net.sh
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

Hi Cyril,

> Hi!
> > Please read further info in my later reaction [1]
> > (TL;DR: not all include it, but these aren't in runtest files anyway).

> In that case:

> Acked-by: Cyril Hrubis <chrubis@suse.cz>

Merged as b45bb8924d, with updated description.

I need to spent time to resolve these old tests.
https://github.com/linux-test-project/ltp/issues/128
(updated this text below in the ticket description)

$ git grep -l LTP_RSH |grep -v -e README -e tst_net.sh -e /ns-tools/
testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01
testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
testcases/network/stress/tcp/multi-diffnic/tcp4-multi-diffnic01
testcases/network/stress/tcp/multi-diffport/tcp4-multi-diffport01
testcases/network/stress/tcp/multi-sameport/tcp4-multi-sameport01
testcases/network/stress/tcp/uni-basic/tcp4-uni-basic01
testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
testcases/network/stress/udp/multi-diffnic/udp4-multi-diffnic01
testcases/network/stress/udp/multi-diffport/udp4-multi-diffport01
testcases/network/stress/udp/uni-basic/udp4-uni-basic01

These tests using similar IPsec proto/mode params, which are in
runtest/net_stress.ipsec_{dccp,icmp,sctp,tcp,udp}. These new and well working
tests are using ipsec_lib.sh and are testing either with ping via tst_ping()
(ICMP tests) or with netstress.c via tst_netload() (the rest of the tests).

The old legacy tests are using various TCP/UDP client-server and ICMP sender
tools from testcases/network/stress/ns-tools/. To decide whether they can be
safely deleted or should be kept (and cleanup and possibly migrated to
ipsec_lib.sh) is whether their C tools they use test other kernel functionality
than netstress.c and ping.

There is also ns-igmp_querier.c, which is used in mcast-lib.sh, which should be
cleaned (probably not a candidate to put the code into netstress.c), but that's
another case.

Once this all is solved, several shell scripts in
testcases/network/stress/ns-tools/ can be deleted.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
