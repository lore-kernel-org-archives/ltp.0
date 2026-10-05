Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FFDCA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791214689; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type : sender : from;
 bh=TlUJ8tM81czwkeyGhz1Hqbc5BfmfQ3YNmxSUXw+pRWg=;
 b=pkp7GEVxYx9otvVDoKeNb1xYEttF/PySmwERJkO4EMRKk/Ta7uBxA1j/IYA5H2QNTlLBs
 mvLMsCnS1eeh9mHP8wZSIr+l+bi2D7ADv1jmV2U8+r/qVA2PQt+raBH20ZDmj/wIRVLSIcV
 l7Pi+l6n6WNdcXwpUe77N4IXnbRqWis=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2CB53E9D2C
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 17:38:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF6833E11F4
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:37:49 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2335F1A00900
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:37:49 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so12367485e9.2
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791214668; x=1791819468; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R6qVtlQrVnx6s2DGfppSzqmyXCkU45yfJA/OE+iptjU=;
 b=M4pZj02S/G1C03HlS2fDF/GYUd3nvqoc6OPCWzB6BULPlmAvBdYLp/QJSs+LYxFi5X
 BMXxDN6hRB0zj4l+N3kDr32nJe2Qde+jevV9fumYBOawbLSbAv+/Lby1goaibl07UFvX
 gqAqapM4AK9ysXBnroCL3lHXVuUsDIk4wIxMWh8HuGH0WiRmeDavQ4138Ed0pWuEjH5p
 dMBkt1SE0sLaVRR/+d5Ub5lgqaUgyw9nGSxEasgMFJOf/+yeEvALbPo2ZsKZgXc9sVrk
 LASJJW8rw9yHhy62NafusG1HsxGA0kTKUBrKN8WFgv3sgiMwhqNiDp7F3GumZZV+Miuq
 h5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791214668; x=1791819468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R6qVtlQrVnx6s2DGfppSzqmyXCkU45yfJA/OE+iptjU=;
 b=EncHTMpC/EOfHbRNqHla91gV5FcmnGP22YPdnCXpE1CG2CfT0lL9ZcywVCSvYaC8Lg
 zmkFNt4rRu+OtvTE8bM0pkV+7OlO9y9dkHJMRi0CaQzFaKIprdWxGJlyjXPMfO+mgWCd
 qZap84DuV98QagUDCfUIS1sgjyinn//PIzACk/2VPR8OE0B8uVsG4/SsaqOdpKPaxyQj
 g2sR1aTHiVDINx6xJvYn0BvmfkyRDlGkBy7aLqlraWO24MPbZu4jaE+jA8FaFUInU9Bm
 sMLihTfVq6XG+t9fgZi7ZypUhgP26NRjkS5+o62Faxr45eF/KxFR/Qmw/u8Xv0sOcDSR
 D02g==
X-Gm-Message-State: AFuF++kEqMa9k36VgQUSmdPEVvm9JYw3KhWFvKf0iqIRNIz/NQas5JSI
 R4Vjbd0nTNxm3xj/tAOGz9gUetdLrqvCXwLExCVXecCXBwFDIKTjeTtT7kc4v/MuUyk=
X-Gm-Gg: AYBFou3DL4hniDf3kA86UqJ2VquCLBmXTtr3a3p4ZAdBlB85Cf1aIn+6jFXMkLcc0bi
 1Zxyv65E2M4dIcoHopZJWZqJzJtnPKBuNES5cIIhxMi+ozZ0w9fra7mg3jMyoZPJxat+cVlndns
 FW4vMOAwWpiWuwYJjjdkminXYWH1x8ofNyFMrWURvTtw9XwcuZyrBReAm6xBq8EZL/pC9dcINpu
 XhO15roVAsoiBMwz1/d0ouvoDv7tjuHZa53ofNcgJqxTnSq0IOBzExS2AsWSyNcQAaapw7zA71A
 nVXu5Tk+jn5MgKV2t8VXh4Mo7y07v4DtiuPcd2I8QNWSh9EkDfFuVJtCempWs6krSYH2YNF4YtB
 RiWIjDcOMmsShncbJL/xSt8u6lHKmi9LKG3gA3Uo0H5h8NcgNzpT/WF2hL6rnuUkJ0KzmC6UdtP
 ab29VoqGwFK0cppMzM0X5HA77RFh7Y6FVbe7gSvuv9cx1AB1oTzGQTwwMw6DzrY3UioKetXSvaO
 TCPiJqDxuU=
X-Received: by 2002:a05:600d:82e7:b0:4a1:70f0:ac2 with SMTP id
 5b1f17b1804b1-4a170f00b34mr78540535e9.24.1791214668492; 
 Mon, 05 Oct 2026 08:37:48 -0700 (PDT)
Received: from blackbook2 (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1787e8b2asm519755e9.6.2026.10.05.08.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:37:48 -0700 (PDT)
Date: Mon, 5 Oct 2026 17:37:46 +0200
To: Wei Gao <wegao@suse.com>
Message-ID: <asPB9JgbOowPDAgX@blackbook2>
References: <20261004143332.25978-1-wegao@suse.com>
 <20261004143332.25978-3-wegao@suse.com>
MIME-Version: 1.0
In-Reply-To: <20261004143332.25978-3-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 2/2] memcontrol03,
 memcontrol04: Set protection on parent cgroups to prevent kswapd
 over-reclaim
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1748061619=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============1748061619==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uhhm57oyntxollre"
Content-Disposition: inline


--uhhm57oyntxollre
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] memcontrol03, memcontrol04: Set protection on
 parent cgroups to prevent kswapd over-reclaim
MIME-Version: 1.0

Hello Wei.

On Sun, Oct 04, 2026 at 02:33:27PM +0000, Wei Gao <wegao@suse.com> wrote:
> On NUMA systems (observed on PowerPC), allocating memory can trigger
> node-level memory pressure, waking up kswapd when free pages fall below
> the low watermark on a node.
>=20
> In cgroup v2, both hard protection (memory.min) and best-effort protection
> (memory.low) are hierarchical and calculated top-down: effective
> protection of descendant cgroups is bounded by their ancestors' protection
> values. When LTP runs inside an existing cgroup hierarchy, ancestor cgrou=
ps
> above the test root have memory.min and memory.low set to 0.

Note that this is expected behavior of protection and the test is meant
to work "relatively" with its own pressure source and target [1].


> As a result, when kswapd performs node-level background reclaim from the
> root cgroup downwards, ancestor cgroups without protection provide no
> protection boundary. kswapd reclaims pages from descendant leaf cgroups
> regardless of their local memory.min / memory.low settings, causing
> memcontrol03 and memcontrol04 to fail with over-reclaim:

Generally, this is not specific to this test -- it is because it the
whole host is overcommitted (edit: as I see the NUMA info below it could
be perhaps that only individual nodes are too small).

So I wonder could this be ensured at higher level -- something that sets
up the environment of the individual runners (e.g. reduce parallelism,
partition the system with memory limits or as a variant configure
generic memory protection)?

WDYT?
Michal


[1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#recla=
im-protection

--uhhm57oyntxollre--

--===============1748061619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1748061619==--
