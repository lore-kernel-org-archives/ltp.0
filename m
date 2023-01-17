Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18FEC3DA78
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 08:26:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D06A63CC8D8
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 09:26:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA33E3CB4B0
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 09:26:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 18DB120090D
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 09:26:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7B2138129;
 Tue, 17 Jan 2023 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673943974;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SwKeDrDKdK2oO2nCSvnVqqs7/3SjHoXXv8mdOndvsc=;
 b=XJqaI0CGjxyfeMWe800XOq/FMIR4gLzky5nk/i1p4fHwOG3h81tm4VNlftPv7Um0g/jEFW
 ifnYc3iqOneEYG5K+sklObwzl/qHH21YH0H2cVjJ4NjvLq6gmlhaY3HLn31zXrFofVQERc
 2mPMeMv4A3e2gaMY/lOc2pQFuEZBUSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673943974;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SwKeDrDKdK2oO2nCSvnVqqs7/3SjHoXXv8mdOndvsc=;
 b=c0FI9XCU+7qjaKIxIX6boJA4UU4UxwI+TdlhpeqcOtchCUlpWsO3ZMHW/o6kAFJm0py+hD
 L5vnFDaHIlyKgVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C14AD1390C;
 Tue, 17 Jan 2023 08:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oVeYLaZbxmPLVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 17 Jan 2023 08:26:14 +0000
Date: Tue, 17 Jan 2023 09:26:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: WEI GAO <wegao@suse.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Message-ID: <Y8Zbpfq8xcDZ2uZI@pevik>
References: <20230106113126.5304-1-wegao@suse.com>
 <20230111195231.23596-1-wegao@suse.com> <Y8EnKACJtJJ80uw+@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8EnKACJtJJ80uw+@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add PATH to tst_rhost_run.sh
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

Hi Wei, all,

I at least once reproduced the problem:
# ./tst_rhost_run.sh
RTNETLINK answers: File exists
tst_rhost_run 1 TBROK: ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2 failed

I can't reproduce it now, let's skip it.

Unfortunately there is another problem, which can't be solved with adjusting
PATH for the test, because also remote end would need to have PATH adjusted
With this patch and with your another patch [1]:

# ./tst_rhost_run.sh
...
tst_rhost_run 1 TINFO: tst_rhost_run: cmd: tst_net_iface_prefix -r 10.0.0.1
tst_rhost_run 1 TINFO: NETNS: ns_exec 17258 net,mnt sh -c " tst_net_iface_prefix -r 10.0.0.1 || echo RTERR" 2>&1
./../../../..//testcases/lib/tst_net.sh: line 1027: sh:: command not found
tst_rhost_run 1 TINFO: tst_rhost_run: cmd: tst_net_iface_prefix -r fd00:1:1:1::1
tst_rhost_run 1 TINFO: NETNS: ns_exec 17258 net,mnt sh -c " tst_net_iface_prefix -r fd00:1:1:1::1 || echo RTERR" 2>&1
./../../../..//testcases/lib/tst_net.sh: line 1032: sh:: command not found
...
tst_rhost_run 1 TPASS: tst_rhost_run is working

=> test claims TPASS, but it actually does not work properly (false negative).

Therefore instead of adjusting PATH I want to fix it properly, i.e. moving
to testcases/kernel/containers/share/ (described previously).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20230117040132.5245-1-wegao@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
