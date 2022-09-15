Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4BEECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 10:07:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07A243CAC0F
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 12:07:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AE663C9111
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 12:07:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76E226023CE
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 12:07:11 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B34343388D;
 Thu, 15 Sep 2022 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663236430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1pYkcbJRUax48pNODVGhs92HFzkixMPe0j8llRVAbI=;
 b=p+CagastRYWyg8J9NMd45RcfEjuIHCPGF9WeexT5Z9lJfEemiFNg2/DPDWAF6EziJoWE3V
 NUN6EGu+xZFqpS0YH6ARh7nvdo+23iEPJsbUsyV4oxPgV4shFH5+2E3kwedPimoRi00yer
 COsAww6bbM3DyQub2Ju6fKPAhzdAYZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663236430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1pYkcbJRUax48pNODVGhs92HFzkixMPe0j8llRVAbI=;
 b=SnMN1hv16+74X26+DOelaEm7IkmHl2kKes7+/u9Bzd7Id6xGu25tJFCro/UgYHBFoLy2HW
 HI9Z0uJUo0JslnCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A137F132BD;
 Thu, 15 Sep 2022 10:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id B8P8JU75ImNKMAAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 10:07:10 +0000
Date: Thu, 15 Sep 2022 12:09:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dylan Jhong <dylan@andestech.com>
Message-ID: <YyL5w+DzuI7U06Td@yuki>
References: <20220914131950.1783054-1-dylan@andestech.com>
 <YyLpUMPMlGoXjwls@yuki> <YyL4cqTctXZ4TMmt@atcsi01>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyL4cqTctXZ4TMmt@atcsi01>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/uevent: Adjust the number of uevents
 dynamically in uevent02
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
Cc: "Mina Hui-Min Chou\(\(\(\(\(\(\(\)" <minachou@andestech.com>,
 "x5710999x@gmail.com" <x5710999x@gmail.com>,
 "Charles Ci-Jyun Wu\(\(\(\(\(\(\(\)" <dminus@andestech.com>,
 "Alan Quey-Liang Kao\(\(\(\(\(\(\(\)" <alankao@andestech.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > >  #include "uevent.h"
> > >  
> > >  #define TUN_PATH "/dev/net/tun"
> > >  
> > > +#define MAX_UEVENT 7
> > > +
> > > +struct uevent_desc add = {
> > > +	.msg = "add@/devices/virtual/net/ltp-tun0",
> > > +	.value_cnt = 4,
> > > +	.values = (const char*[]) {
> > > +		"ACTION=add",
> > > +		"DEVPATH=/devices/virtual/net/ltp-tun0",
> > > +		"SUBSYSTEM=net",
> > > +		"INTERFACE=ltp-tun0",
> > > +	}
> > > +};
> > > +struct uevent_desc add_rx = {
> > > +	.msg = "add@/devices/virtual/net/ltp-tun0/queues/rx-0",
> > > +	.value_cnt = 3,
> > > +	.values = (const char*[]) {
> > > +		"ACTION=add",
> > > +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> > > +		"SUBSYSTEM=queues",
> > > +	}
> > > +};
> > > +struct uevent_desc add_tx = {
> > > +	.msg = "add@/devices/virtual/net/ltp-tun0/queues/tx-0",
> > > +	.value_cnt = 3,
> > > +	.values = (const char*[]) {
> > > +		"ACTION=add",
> > > +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> > > +		"SUBSYSTEM=queues",
> > > +	}
> > > +};
> > > +struct uevent_desc rem_rx = {
> > > +	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/rx-0",
> > > +	.value_cnt = 3,
> > > +	.values = (const char*[]) {
> > > +		"ACTION=remove",
> > > +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/rx-0",
> > > +		"SUBSYSTEM=queues",
> > > +	}
> > > +};
> > > +struct uevent_desc rem_tx = {
> > > +	.msg = "remove@/devices/virtual/net/ltp-tun0/queues/tx-0",
> > > +	.value_cnt = 3,
> > > +	.values = (const char*[]) {
> > > +		"ACTION=remove",
> > > +		"DEVPATH=/devices/virtual/net/ltp-tun0/queues/tx-0",
> > > +		"SUBSYSTEM=queues",
> > > +	}
> > > +};
> > > +struct uevent_desc rem = {
> > > +	.msg = "remove@/devices/virtual/net/ltp-tun0",
> > > +	.value_cnt = 4,
> > > +	.values = (const char*[]) {
> > > +		"ACTION=remove",
> > > +		"DEVPATH=/devices/virtual/net/ltp-tun0",
> > > +		"SUBSYSTEM=net",
> > > +		"INTERFACE=ltp-tun0",
> > > +	}
> > > +};
> > 
> > Why do we have to move these outside of the function? I do not see a
> > single reason to do so.
> > 
> 
> I think separating the declaration of uevents and dynamic adding uevents 
> will make the program easier to read.
> This part is open to discussion, I'm just giving my thoughts.
> if everyone think it's a bad idea, I'll change it back in v2 patch.
> 
> declaration
> ----------------------------
> struct uevent_desc rem_tx = {}
> struct uevent_desc add_rx = {}
> struct uevent_desc add_tx = {}
> .....
> 
> dynamically adding uevent:
> --------------------------
> uevents[i++] = &add;
> if (has_RPS)
>         uevents[i++] = &add_rx;
> uevents[i++] = &add_tx;
> if (has_RPS)
>         uevents[i++] = &rem_rx;
> uevents[i++] = &rem_tx;
> uevents[i++] = &rem;
> uevents[i++] = NULL;
> 
> > > +	const struct uevent_desc *uevents[MAX_UEVENT];
> > > +	int pid, fd, i = 0;
> > > +	int has_RPS = tst_kconfig_get("CONFIG_RPS");
> > 
> > Getting the flag should be done once in the test setup, otherwise kernel
> > config will be parsed in each iteration of the test.
> > 
> 
> If we parse the kernel configuration during test setup, we will block all 
> images without CONFIG_RPS from executing this testcase. This is not my 
> intention, in this patch I designed to continue executing uevent02 even 
> without CONFIG_RPS. Just adjusting uevents can pass this test. So I think 
> parsing the kernel config in test_all() should be the correct way.

I do not think that we understand each other here. What I proposed is to
call the function that parses kernel config in the test setup and
initialize the has_RPS flag there so that it's not called on each
interation of the run() function (e.g. when test is passed -i 100 on
command line).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
