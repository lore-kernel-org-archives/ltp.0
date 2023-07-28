Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF07AC001DE
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 08:21:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0466C3CDBC9
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 10:21:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852F43C8AC3
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:21:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CFCAD1401196
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 10:21:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F5771F8A3;
 Fri, 28 Jul 2023 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690532482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMHPD2s9tOI+OiUB3yQdiydzB+UJPmadko2XlGDKjEg=;
 b=ZS6yfJPSluYZ7MjJxmGPEgxRqFHBH8ZM1hua9cZl3OArjPv3B0UM+Biu24Ui9Bm+FkB+QY
 9gIh801QUAXB+DjKtBRlACZR12ozboYew+g+MOWClfyqe4dyqFSrZc2dWFmpedIR3CN2Q7
 /aTVtxSGFcyqGIfM9pzEA64NQKeKnsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690532482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMHPD2s9tOI+OiUB3yQdiydzB+UJPmadko2XlGDKjEg=;
 b=pVqDF1M2i2YXiB31HnFCv3t/n4+m2ohnR69CkECLVNdroUoQ3DphHjJ7Tl2nfO6M1cOe2A
 stD3VcOCsUb894Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0D6B133F7;
 Fri, 28 Jul 2023 08:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H57xOYF6w2TbZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 28 Jul 2023 08:21:21 +0000
Message-ID: <504b699c-5b06-0e0d-99a7-c8c7e5cec500@suse.cz>
Date: Fri, 28 Jul 2023 10:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230727150013.31835-1-mdoucha@suse.cz>
 <20230727150013.31835-2-mdoucha@suse.cz> <ZMN0FtFduNJgY1cc@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <ZMN0FtFduNJgY1cc@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] tst_netdevice: Add helper functions for qdisc
 and filter management
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 28. 07. 23 9:53, Cyril Hrubis wrote:
> Hi!
>> --- a/lib/tst_netdevice.c
>> +++ b/lib/tst_netdevice.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/veth.h>
>>   #include <sys/socket.h>
>>   #include <net/if.h>
>> +#include <linux/pkt_sched.h>
>>   #include "lapi/rtnetlink.h"
>>   
>>   #define TST_NO_DEFAULT_MAIN
>> @@ -518,3 +519,116 @@ int tst_netdev_remove_route_inet(const char *file, const int lineno,
>>   	return modify_route_inet(file, lineno, RTM_DELROUTE, 0, ifname,
>>   		srcaddr, srcprefix, dstaddr, dstprefix, gateway);
>>   }
>> +
>> +static int modify_qdisc(const char *file, const int lineno, const char *object,
>> +	unsigned int action, unsigned int nl_flags, const char *ifname,
>> +	unsigned int family, unsigned int parent, unsigned int handle,
>> +	unsigned int info, const char *qd_kind,
>> +	const struct tst_rtnl_attr_list *config)
>> +{
>> +	struct tst_rtnl_context *ctx;
>> +	int ret;
>> +	struct tcmsg msg = {
>> +		.tcm_family = family,
>> +		.tcm_handle = handle,
>> +		.tcm_parent = parent,
>> +		.tcm_info = info
>> +	};
>> +
>> +	if (!qd_kind) {
>> +		tst_brk_(file, lineno, TBROK,
>> +			"Queueing discipline name required");
>> +		return 0;
>> +	}
>> +
>> +	if (ifname) {
>> +		msg.tcm_ifindex = tst_netdev_index_by_name(file, lineno,
>> +			ifname);
>> +
>> +		if (msg.tcm_ifindex < 0) {
>> +			tst_brk_(file, lineno, TBROK, "Interface %s not found",
>> +				ifname);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	ctx = create_request(file, lineno, action, nl_flags, &msg, sizeof(msg));
>> +
>> +	if (!ctx)
>> +		return 0;
>> +
>> +	if (!tst_rtnl_add_attr_string(file, lineno, ctx, TCA_KIND, qd_kind)) {
>> +		tst_rtnl_destroy_context(file, lineno, ctx);
>> +		return 0;
>> +	}
>> +
>> +	if (config && !tst_rtnl_add_attr_list(file, lineno, ctx, config)) {
>> +		tst_rtnl_destroy_context(file, lineno, ctx);
>> +		return 0;
>> +	}
> 
> 
> Here as well, shouldn't we tst_brk_() consistently if we fail to prepare
> the context?

Same as in the previous patch. If we get into the failure branch here, 
tst_brk_() was already called somewhere in create_request() or 
tst_rtnl_add_attr_*() and it didn't terminate the process because we're 
in the cleanup phase.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
