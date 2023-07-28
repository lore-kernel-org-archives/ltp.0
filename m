Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA02C0015E
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 07:53:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97C263CE664
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 09:53:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A865A3C8AC4
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 09:53:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D84CF1000EB0
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 09:53:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4ABF1F45B;
 Fri, 28 Jul 2023 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690530784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7CXcV80KjdtWFd3RY3hN2CwU7SMwmiyc9SX/iy13S8=;
 b=lnKZqResJFWHed3pDPuBoHHoIEdWlyYq3YjaOaJJU45ive36Dp4lBa6ynRnGoeAgrVsca9
 XeSNqyT9sG/1TlEqNFMeYNInmvNdLI+Vom/pMTTX4PZ1aJi0pZ93UerYw57RXg/kEN91eX
 CP9X0+E45FY5VKbGIsUZZV0oGTaUo3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690530784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7CXcV80KjdtWFd3RY3hN2CwU7SMwmiyc9SX/iy13S8=;
 b=VgNf283so1byfhP5XpMkcyjQSKteVHKkpbQG8mRfMEqzp76xMXB6hzbn8lXEd/P4c3WFrr
 fYyQFHyAbBIQJiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF88A13276;
 Fri, 28 Jul 2023 07:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QnuaLeBzw2TPVQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jul 2023 07:53:04 +0000
Date: Fri, 28 Jul 2023 09:53:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZMN0FtFduNJgY1cc@yuki>
References: <20230727150013.31835-1-mdoucha@suse.cz>
 <20230727150013.31835-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230727150013.31835-2-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/lib/tst_netdevice.c
> +++ b/lib/tst_netdevice.c
> @@ -7,6 +7,7 @@
>  #include <linux/veth.h>
>  #include <sys/socket.h>
>  #include <net/if.h>
> +#include <linux/pkt_sched.h>
>  #include "lapi/rtnetlink.h"
>  
>  #define TST_NO_DEFAULT_MAIN
> @@ -518,3 +519,116 @@ int tst_netdev_remove_route_inet(const char *file, const int lineno,
>  	return modify_route_inet(file, lineno, RTM_DELROUTE, 0, ifname,
>  		srcaddr, srcprefix, dstaddr, dstprefix, gateway);
>  }
> +
> +static int modify_qdisc(const char *file, const int lineno, const char *object,
> +	unsigned int action, unsigned int nl_flags, const char *ifname,
> +	unsigned int family, unsigned int parent, unsigned int handle,
> +	unsigned int info, const char *qd_kind,
> +	const struct tst_rtnl_attr_list *config)
> +{
> +	struct tst_rtnl_context *ctx;
> +	int ret;
> +	struct tcmsg msg = {
> +		.tcm_family = family,
> +		.tcm_handle = handle,
> +		.tcm_parent = parent,
> +		.tcm_info = info
> +	};
> +
> +	if (!qd_kind) {
> +		tst_brk_(file, lineno, TBROK,
> +			"Queueing discipline name required");
> +		return 0;
> +	}
> +
> +	if (ifname) {
> +		msg.tcm_ifindex = tst_netdev_index_by_name(file, lineno,
> +			ifname);
> +
> +		if (msg.tcm_ifindex < 0) {
> +			tst_brk_(file, lineno, TBROK, "Interface %s not found",
> +				ifname);
> +			return 0;
> +		}
> +	}
> +
> +	ctx = create_request(file, lineno, action, nl_flags, &msg, sizeof(msg));
> +
> +	if (!ctx)
> +		return 0;
> +
> +	if (!tst_rtnl_add_attr_string(file, lineno, ctx, TCA_KIND, qd_kind)) {
> +		tst_rtnl_destroy_context(file, lineno, ctx);
> +		return 0;
> +	}
> +
> +	if (config && !tst_rtnl_add_attr_list(file, lineno, ctx, config)) {
> +		tst_rtnl_destroy_context(file, lineno, ctx);
> +		return 0;
> +	}


Here as well, shouldn't we tst_brk_() consistently if we fail to prepare
the context?

> +	ret = tst_rtnl_send_validate(file, lineno, ctx);
> +	tst_rtnl_destroy_context(file, lineno, ctx);
> +
> +	if (!ret) {
> +		tst_brk_(file, lineno, TBROK,
> +			"Failed to modify %s: %s", object,
> +			tst_strerrno(tst_rtnl_errno));
> +	}
> +
> +	return ret;
> +}
> +
> +int tst_netdev_add_qdisc(const char *file, const int lineno,
> +	const char *ifname, unsigned int family, unsigned int parent,
> +	unsigned int handle, const char *qd_kind,
> +	const struct tst_rtnl_attr_list *config)
> +{
> +	return modify_qdisc(file, lineno, "queueing discipline", RTM_NEWQDISC,
> +		NLM_F_CREATE | NLM_F_EXCL, ifname, family, parent, handle, 0,
> +		qd_kind, config);
> +}
> +
> +int tst_netdev_remove_qdisc(const char *file, const int lineno,
> +	const char *ifname, unsigned int family, unsigned int parent,
> +	unsigned int handle, const char *qd_kind)
> +{
> +	return modify_qdisc(file, lineno, "queueing discipline", RTM_DELQDISC,
> +		0, ifname, family, parent, handle, 0, qd_kind, NULL);
> +}
> +
> +int tst_netdev_add_traffic_class(const char *file, const int lineno,
> +	const char *ifname, unsigned int parent, unsigned int handle,
> +	const char *qd_kind, const struct tst_rtnl_attr_list *config)
> +{
> +	return modify_qdisc(file, lineno, "traffic class", RTM_NEWTCLASS,
> +		NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC, parent, handle,
> +		0, qd_kind, config);
> +}
> +
> +int tst_netdev_remove_traffic_class(const char *file, const int lineno,
> +	const char *ifname, unsigned int parent, unsigned int handle,
> +	const char *qd_kind)
> +{
> +	return modify_qdisc(file, lineno, "traffic class", RTM_DELTCLASS, 0,
> +		ifname, AF_UNSPEC, parent, handle, 0, qd_kind, NULL);
> +}
> +
> +int tst_netdev_add_traffic_filter(const char *file, const int lineno,
> +	const char *ifname, unsigned int parent, unsigned int handle,
> +	unsigned int protocol, unsigned int priority, const char *f_kind,
> +	const struct tst_rtnl_attr_list *config)
> +{
> +	return modify_qdisc(file, lineno, "traffic filter", RTM_NEWTFILTER,
> +		NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC, parent, handle,
> +		TC_H_MAKE(priority << 16, htons(protocol)), f_kind, config);
> +}
> +
> +int tst_netdev_remove_traffic_filter(const char *file, const int lineno,
> +	const char *ifname, unsigned int parent, unsigned int handle,
> +	unsigned int protocol, unsigned int priority, const char *f_kind)
> +{
> +	return modify_qdisc(file, lineno, "traffic filter", RTM_DELTFILTER,
> +		0, ifname, AF_UNSPEC, parent, handle,
> +		TC_H_MAKE(priority << 16, htons(protocol)), f_kind, NULL);
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
