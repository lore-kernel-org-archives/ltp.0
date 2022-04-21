Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B70AC433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 13:08:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A5003CA6E5
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 15:08:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D951E3C5649
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:46:10 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 167CA1A00CB0
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:46:09 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 454FD5C018F;
 Thu, 21 Apr 2022 08:46:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 21 Apr 2022 08:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650545168; x=
 1650631568; bh=EF79PcQ0MfsAEfNLabjI/AemFrjtcYYPaqHYxL/eq64=; b=W
 6c359dwSyENwETz81qLRTB+g80cgYrKhSQaRHYo/3BB++4gIKnm9UU1yEj8odT5b
 oVzQNvkoz3fRUip+EysuW/Y3dFeYVzC9S0BHUZDIhP2qDNfeS/LoqYzK0RjPu1vC
 UjRNn24wlNroHQkMXIR95BDm7ezMJHYFuAmLepV5ZTuOUHOOS4RPD0xyvnIefiQe
 VLUeigMYt9xV6wUuDvS2Ybjin6lncjywzKGu8eANiApJTx6qD/SK4JzoQPsTaIld
 LK5ZM71wO72Vd7ll/oR6lMnhqV24vCsCRcjFA7NPKOAsLEfLuHL4Y/3qfpMPqLrK
 CibUCG6MDpJ2h72MvgJgw==
X-ME-Sender: <xms:D1JhYlbYfP5dYypUDbjqNuixwx-YemR40IyjR-PJQgRJsaCJuogy-Q>
 <xme:D1JhYsZ8w9DWjFdxLm8Vv_OEkThiMD6WY3i4Z2Hr5I5VGUujrmW3gocFeT-hf0Ifv
 3o2bE_CrGUgt_c>
X-ME-Received: <xmr:D1JhYn9cPjc0S9Vd2Pxa1CY9-hBDv023GQmKWeUAul_A_WBx-hXJHcaTsKDcj_47GiXfCAf7lLIK7JBdVRggI181Lq5idA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddvgdehgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
 tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
 gvrhhnpeejkefgieehvdfgieeufedtleekkeevueetfeelffeuvdelkeelfeeuledvgeeu
 teenucffohhmrghinhepghhithhlrggsrdgtohhmpdhtuhigsghuihhlugdrtghomhdpkh
 gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:D1JhYjronjhA2r-aKcAKwYSmOqMPS_PWzqpWuK7g_a-Nrfdi3lMnAw>
 <xmx:D1JhYgrBCH5irM4hF0JFKQZ9_OH4KUYnGcUDYvPVpQK-Z-uLsGtdYQ>
 <xmx:D1JhYpTJR6klHoS_vxc4i798NsHbE5gjaMqJjxm_8Fo8JY71Qb3aYQ>
 <xmx:EFJhYtipqdrgSDpYgSi0qvmo6WObrQJW1ntKN2CxEMldFnNsjWVVYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 08:46:06 -0400 (EDT)
Date: Thu, 21 Apr 2022 15:46:02 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <YmFSCp2Bufy39GBD@shredder>
References: <CA+G9fYvO5OERA0k-r=Q8gbGdUKm0VppL2KPJ9e-R0NreBESo_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvO5OERA0k-r=Q8gbGdUKm0VppL2KPJ9e-R0NreBESo_g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 21 Apr 2022 15:08:19 +0200
Subject: Re: [LTP] [next] LTP: netns_breakns: Command \"add\" is unknown,
 try \"ip link help\".
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 "vadimp@nvidia.com" <vadimp@nvidia.com>, Netdev <netdev@vger.kernel.org>,
 jiri@nvidia.com, open list <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Raju.Lakkaraju@microchip.com, idosch@nvidia.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 21, 2022 at 06:12:54PM +0530, Naresh Kamboju wrote:
> Regressions found on all devices LTP containers test cases failed on
> Linux next-20220420. [1]
> 
>   - ltp-containers-tests/netns_comm_ns_exec_ipv6_ioctl
>   - ltp-containers-tests/netns_breakns_ns_exec_ipv6_netlink
>   - ltp-containers-tests/netns_breakns_ip_ipv6_netlink
>   - ltp-containers-tests/netns_breakns_ns_exec_ipv4_ioctl
>   - ltp-containers-tests/netns_breakns_ip_ipv4_netlink
>   - ltp-containers-tests/netns_comm_ip_ipv6_ioctl
>   - ltp-containers-tests/netns_comm_ip_ipv4_netlink
>   - ltp-containers-tests/netns_comm_ns_exec_ipv4_netlink
>   - ltp-containers-tests/netns_breakns_ns_exec_ipv6_ioctl
>   - ltp-containers-tests/netns_comm_ip_ipv6_netlink
>   - ltp-containers-tests/netns_comm_ns_exec_ipv4_ioctl
>   - ltp-containers-tests/netns_breakns_ns_exec_ipv4_netlink
>   - ltp-containers-tests/netns_breakns_ip_ipv4_ioctl
>   - ltp-containers-tests/netns_comm_ip_ipv4_ioctl
>   - ltp-containers-tests/netns_breakns_ip_ipv6_ioctl
>   - ltp-containers-tests/netns_comm_ns_exec_ipv6_netlink
> 
> 
> Test log:
> ---------
> netns_breakns 1 TINFO: timeout per run is 0h 15m 0s
> Command \"add\" is unknown, try \"ip link help\".
> netns_breakns 1 TBROK: unable to create veth pair devices
> Command \"delete\" is unknown, try \"ip link help\".
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: f1244c81da13009dbf61cb807f45881501c44789
>   git_describe: next-20220420
>   kernel_version: 5.18.0-rc3
>   kernel-config: https://builds.tuxbuild.com/283Ot2o4P4hh7rNSH56BnbPbNba/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/520334286
>   artifact-location: https://builds.tuxbuild.com/283Ot2o4P4hh7rNSH56BnbPbNba
> 
> I will bisect these failures.

Should be fixed by:

https://patchwork.kernel.org/project/netdevbpf/patch/20220419125151.15589-1-florent.fourcot@wifirst.fr/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
