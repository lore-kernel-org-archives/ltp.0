Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E0FCA5FAB
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790740536; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UznPBWtaC2g08Ydg6oGBsrvGXZXTCd1srI6tAgXsHJc=;
 b=QSZeMYWgAM78DV26S3d1BXC/fkRB527pGb71ZNT8PKgLhUFmGYR7Q7+r6twUkhU+l5gSj
 6UpdoaDjt3OKqntzGB2QQkF/d7FzHMjCUrJxg33FxOHjaNDqOXr9pT3Ch7LI9XX/gb0GMX1
 gmwQoq9zxpV7pqYJSI46RYFMH0o4Is8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17C0A3EAA89
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 05:55:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6A353C0857
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:55:14 +0200 (CEST)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81683200B3C
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 05:55:14 +0200 (CEST)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48aef5d66c1so958740f8f.3
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790740514; x=1791345314; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ECtTkJbv1BAvGfTba0uppxYr4b0KsEu+emYYAloO9o=;
 b=Dfmqs2jq04ZMHlK1PrM3MK1hoM3GvyUmlnHI7EE05NZmwKlUUZk7/PnMTfa8XlTjRg
 HCrStnqj3auKhXYAGswc37EMYU/CdMo6HFNDkd69gd3sOXu5hhSGg5mMjAvjbUf7WK/E
 P5yEE/PLypMCNduvxfq6MQG+jZQTdK5CUOJ6UZm5dBFXPhabMXUxhH5Lvf1fe8zLBN1c
 rqV1ndjNh/xN5gEjx+XAnuVBaE5hWY4+XQHRbVF3EK0SqmKWR6lTFgcPtZ3d4xiqNlxT
 P4mZ7uuVdEsa1GYdNzSwvi99d9Saz47kYomyArWFHKWX6uLjSI9w1hLbVhT6fcR8KKPC
 /GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790740514; x=1791345314;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8ECtTkJbv1BAvGfTba0uppxYr4b0KsEu+emYYAloO9o=;
 b=lcXF/IUnhj7LrJGyUZywJk0Dt/raPxdAf/NQGDSnrSCUr17FxuIJ1I/rXfukkyNq8P
 2SrRVtoV/VOUfYvnu0eMOKP1YXXw7lxyBJWKXOL8KwxWQL+G9M0SyIfXtlB3lQQ++x2z
 gODd8kgy43LiAcr5H+7dwtsgf9eucONAOtFCiLUVIHw6VUTcddvvWtYvGVqWFHOTnwO4
 yQeNwZ9ogsBZY+3uBBTNm+b1297nKi6u3jQqj9a/LQZ2toQIwYfNB/GwHwG11plGQEew
 VMtow27kzFz8LQUP9aYSPwOtMhVHWhcCjryH4eSlXXVnPhu45BL0WtDkaZrHCChl4x9D
 Tlvw==
X-Gm-Message-State: AFq9FYJ5cssd8vCVnfIMYpwoRzxkFXOJ5Vy6SjrUgCdD0ls57z54Zv+9
 t6wlAkdo7Fw+PXZ0f1KjM/vMw3BUta69BjkNNjgAO549f1FU2eaJwbAp5VA10QBJcg==
X-Gm-Gg: AYBFou0bEsxGTagZOWPCP8qzPSDRG5HEmqDcAZVrQSc9qZ+tsbbh9v+6UJT5Wsix2H6
 3yAIPLH5mi1+Ecd4vdPBSY7HA+BcQY3WC5ykczUjTdkQLSrkzN95JrN7wmR1uYxRHKLLglb/51S
 COp1ZDmLntP3N0JIsQJ4yhdSkShqP6WDyWBl1yyLxstYiUukAUB59kYgnJnrf31nGUvLoDs8gj5
 ZBuEWTW2y18S0o+Xc+7ON/HGuYQuKHA2bUfKTMlNFkS4qednz7nGVQ+b/xcriTnEd8oq7ngqc+M
 7eKNE1ervLcE//t4YtkgYeLs17nh5oKfPWQcVkQsbUEYPpSBs84ze4RUJ8S44oHn6Fpx1OcbaPG
 wWLkE6FhC3rAyrGlfPHe9gU3aW0KoG3CpY4lg0Yb7zZ+Em//grlbp14Nx7hzkQUHDP86HSSm1Dk
 hXykxXgcWyqVWTDkLQcLGIbox0jA2sFuODxnUYBQzY+vjNXDrfAA6OX4DsL3+/Oqz+zBDHUtFvN
 +KwEg/V1HBsfBQJkt/eidQ/tfvlSx4eV4CuyQ1dFb4J/rMc5xuYWgLdeCv1a9V2kM2zqt1n
X-Received: by 2002:a05:6000:4b0c:b0:488:640e:f6ca with SMTP id
 ffacd0b85a97d-48b02551adbmr209798f8f.55.1790740513938; 
 Tue, 29 Sep 2026 20:55:13 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029cb005sm78887f8f.14.2026.09.29.20.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 20:55:13 -0700 (PDT)
Date: Wed, 30 Sep 2026 03:55:12 +0000
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Message-ID: <aryIIJJViLtp6KQY@autotest-wegao.qe.prg2.suse.org>
References: <20260929022340.524-1-wegao@suse.com>
 <20260929-second-foyer-87225078267f@there>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929-second-foyer-87225078267f@there>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] memcontrol03: Bind to single CPU on systems
 with 64KB pagesize
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 29, 2026 at 06:58:26PM +0200, Michal Koutn=FD wrote:
> Hi.
> =

> On Tue, Sep 29, 2026 at 02:23:32AM +0000, Wei Gao <wegao@suse.com> wrote:
> > On multi-CPU systems with 64KB page size (e.g. ppc64le), memcontrol03
> > intermittently fails with over-reclaim of protected pagecache under
> > trunk_B:
> > =

> >   memcontrol03.c:104: TINFO: Child 142113 in trunk_G: Allocating anon: =
150994944
> >   memcontrol03.c:121: TPASS: Child 142113 exited
> >   memcontrol03.c:214: TPASS: Expect: (A/B memory.current=3D54394880) ~=
=3D 52428800
> >   ...
> >   memcontrol03.c:104: TINFO: Child 142114 in trunk_G: Allocating anon: =
174063616
> >   memcontrol03.c:116: TPASS: Child 142114 killed by OOM
> >   memcontrol03.c:230: TFAIL: Expect: (A/B memory.current=3D43319296) ~=
=3D 52428800
> > =

> > In the kernel, per-CPU charge batching (MEMCG_CHARGE_BATCH =3D 64 pages)
> > caches up to 64 * 64KB =3D 4MB per CPU in memcg_stock. On a multi-CPU
> > system, allocating memory across CPUs allows cached stock charges to
> > accumulate in ancestor trunk_A (up to 4MB * nr_cpus, e.g. 16MB on a
> > 4-CPU machine). Because trunk_A has memory.max =3D 200M, this extra sto=
ck
> > pressure forces the reclaimer to evict pagecache in trunk_B down to
> > ~35-43MB instead of the expected ~50MB. Simply enlarging the tolerance
> > rate further is not good idea.
> > =

> > Bind the test process to a single CPU in setup() when page size is
> > >=3D 64KB. This confines stock batching to a single CPU, preventing
> > multi-CPU stock inflation and ensuring reproducible reclaim behavior.
> =

> Should the goal be stability/repeatibility of the test.
> What about pinning to the single CPU regardless of page size?
Thanks for quick feedback, v2 sent.
> =

> Thanks,
> Michal



-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
