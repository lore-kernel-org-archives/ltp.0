Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA69CA9EC5
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791814456; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type : sender : from;
 bh=CHRcJuBYXwq4MaQFrecp4d90jD4UqBySmZ2iqfZvnP0=;
 b=MidgWvz/EbWUE8fCF4/yd90V/dS+7tlM0dG4HG0RzdlTvUSKrMLciWqy0uMxV8rmmYH9W
 rGOM6Q0xRA7fZ9yGQzUa7Q+F+f1txqBvSz2iYBtvu60nVhmySb63Cv857+Hdp4dMciYJ/f1
 ad9GeWNgLp1T0qrH8GWsEUIOAL0lJoA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9DF23EA8E8
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 16:14:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DC303E2F49
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 16:13:55 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C65E1A007B2
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 16:13:54 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so16824185e9.3
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791814434; x=1792419234; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2pJPhCOZe/IYPFLvtQxjCi2SVEfh19gBRMAcq4V1zlM=;
 b=N/XQUdM+OoBxq6AooGaYGZQRRrwTfPx+r9QnhRML5OfIB6vdxKd883e64GPoK9oBH9
 sDser2qd2kogBk5XnWECPiDxMxbigRNEKnvidFod1nMmp1/iV2GhxVS7Wd19iUrMDGhU
 3a7MtnTDuxHJNa4BheXdFbh7xm4QOEsf+Rt7gGyBVocuANAe0CeYbWh8mkgyg4+YmyoH
 u6xnghux5463yL6raj4HcqbmejLuWSJ+GXK05Sm/VBJC9XRW5fE57HDBirGa2gM2TCrW
 mUVxpbmBuyadHnIFY+4JIXoUakJsANf7qvLHCE/hLCv8Qh9n6TAWlbQD1cGozjtyiokm
 jK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814434; x=1792419234;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2pJPhCOZe/IYPFLvtQxjCi2SVEfh19gBRMAcq4V1zlM=;
 b=nh3tZPeqbilFQ9J4qpYfmZ2uQe3bnXJVMFKeuQHpkIad6u6HFG7ut3AXbtljvLXUHw
 /z47rFGmbOe04a9OV2s7Cv36PNUuERH7RJFyGJCq8yHAu/jovTsBBJZeAS7/j6V5KdpC
 StMrzNxhUKLTLCvvkgkLCDfvWcnIc62gu7FuxH1OyBDM84c2yE1WUHErTwD/sH1+LE8G
 sliOMHkaGlO/Of/aRlQEIj+i4VQi7qqhyeSzzqQCLtLJckEkskne6Tbr+XQrjwAJbo1C
 aYwb7j3/u/nf31SLO93/d584b2EJEueTMvnUwtD9cOlpdOS3p07as0JMUyvwoc7JrYdV
 duuQ==
X-Gm-Message-State: AFq9FYKH0HQ1ioVhWnJpofgCuKQgAQa/EvfBl9Rim+FSA/vJDLEcO0Sj
 1U+g4UPxxzJJ1qzdX1beqpFSsQHCTr3RHY+7E0HAKLtROWgjiecm+Agu9/Cm/UU2cSmkb71iahW
 WF9GOKy0=
X-Gm-Gg: AYBFou04Kew44XF54ELhhjiV9Ud/kCL8ZTMiOsv2I+eufKuKY0nZdycC3BS8iNnrGrC
 765S6HVgkG+XwqOXyVYzF7/VnfslaaHplOL21C54NZfxpD+kzehRBlZn2/jUO4va+Dif8ofYISW
 FsrkwwZTj9++N3+9KtYqysETH551qzkD/dLnIYekaQABud5kEGcqBvpdnp8u8DUVzBljF9RZhyP
 64KB833SiGw8NSETLk2PJ42khpkCS5bC7z2j7WI2q1pvzTAysg3ToZyQAuPcSxFPumA6aY/S0jp
 /em1ojCdDI8QSkIS2K/OzRSGZGj6sBE533oC836zRlGPxTrddOv4y9nhETTUArdQsN0LsybokgY
 fq+ZYPHthYNGdyyO14vO1CdGd2HfDpwXxug3ktcI3du9s/zwtx9OF2cRmd9QY/vPgn4jWpSnqLf
 tDPd6oomggqN519auNG+zzRFPOXNDs9YqqmEoZorXzB08TFA+yyqCu3TT0hJ/52Pw5QIcdjYHg9
 Q==
X-Received: by 2002:a05:600c:630f:b0:4a1:9f59:ee7 with SMTP id
 5b1f17b1804b1-4a19f5911f4mr57613725e9.0.1791814433678; 
 Mon, 12 Oct 2026 07:13:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be97d1esm465166545e9.8.2026.10.12.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:13:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:13:51 +0200
To: Wei Gao <wegao@suse.com>
Message-ID: <20261012-postbox-cultural-bdfeea18f89f@there>
References: <20261004143332.25978-1-wegao@suse.com>
 <20261004143332.25978-3-wegao@suse.com>
 <asPB9JgbOowPDAgX@blackbook2>
 <asb7iTU4FBh4b0UT@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
In-Reply-To: <asb7iTU4FBh4b0UT@autotest-wegao.qe.prg2.suse.org>
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
Content-Type: multipart/mixed; boundary="===============0799885386=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


--===============0799885386==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6tpu5kcakg6xzxui"
Content-Disposition: inline


--6tpu5kcakg6xzxui
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] memcontrol03, memcontrol04: Set protection on
 parent cgroups to prevent kswapd over-reclaim
MIME-Version: 1.0

On Thu, Oct 08, 2026 at 02:10:17AM +0000, Wei Gao <wegao@suse.com> wrote:
> Protecting this solely from the external runner is tricky since LTP builds
> a 3-level cgroup hierarchy:
> - /sys/fs/cgroup/ltp (Level 1)
> - tst_cg (/sys/fs/cgroup/ltp/ltp-testxxxx, Level 2 =E2=80=94 trunk_A's pa=
rent)
> - trunk_cg[A] (Level 3 =E2=80=94 trunk_B's parent)
> Every level in this chain needs memory.low =3D 50M. Even if an external r=
unner=20
> sets it at /sys/fs/cgroup/ltp, tst_cg or trunk_A will break the protectio=
n chain.

I see. (Note that this needn't be the same 50M as inside the test. The
value at this level would denote some protection sufficient for test's
stability.)

> Another option is make sure enough memory to the test environment so kswa=
pd=20
> doesn't get triggered at all. I guess we can do this to avoid issue?

That sounds even better (or limit amount of tests running in parallel
wrt available amounts), memory.low on the high level is best-effort in
the end.


Michal

--6tpu5kcakg6xzxui--

--===============0799885386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0799885386==--
