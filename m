Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0703CCD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781789031; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Ud3TDnEQCBLJX+T4e9nfi8t/Z+X9wXAIgEB5gRxRL2M=;
 b=JuzZTxnIwmoPbxdsy2v8PvY2/SxtinO/eI8twgKTzDq9UM/xDun+kTocc6k3I7ja5mKib
 jt6CzYrIvtIuXFFQocdwoh96A1rpEwgmSk0CM1g7H7IYhHWR3GHpxB8dRag3PXoBwTtDHAU
 GdjFswxzMPzTFGFJbbNZvs+9Q7k+omA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E2203E5893
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 15:23:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5089D3E28F9
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 15:23:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 872451000929
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 15:23:30 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so6773375e9.3
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 06:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781789010; x=1782393810; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=et/v9WSAxefEWWFV/dumt5I9lqibT58M8Jr18jkHqhA=;
 b=JWH10mZY7nP1xqgLsVj9FvtYuzzqDDtkAnYHITY2x5fuk4yuL1QJgw/7ST9i0xQ2g9
 gAAbv0o/vgekrlSno0LNNWdvFPxOkcJ2ie0Vps4XmtdwX20FOF6csHbCBdlxdZGoMqzb
 b1WqPvTpIotigQSZv1xLy9ly6lVwAStDB/uhZj2j/OyHYvrls/OQ4Bp/89Iem9cbfcJN
 nGYi+Wdafu1p7se7129Yv20FPfYzYQ7eSDi3odrZxEzBM/oU73+VPhrGB1ArDdaIQRFL
 EZDt8Sjpl6GihEaA8H9zDyx3A7aavbOMQXBjWux6cxfta7T8mcTWV8iFH2X6Ggd09nte
 QTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789010; x=1782393810;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et/v9WSAxefEWWFV/dumt5I9lqibT58M8Jr18jkHqhA=;
 b=E0vJvO9DJBetSi4f9CZhKJeNisFklIikKCla5SAbKmEKqt/MixsvMEbzUdnVF4UdTE
 m2n4qOTSXGV68DVCEtnaF6KI3SyNIlhO16L9++k9zH1W9ZDVoSZJLY9PuHD0MD/SDTE4
 GKwgnifr/cFaU2p9fq+DCDLWaTT7C7M2bZbJnhT/BWeKJENGk72TYZ+kVsPgJfKpaHw+
 MfhwbndWL3BAv3xyxqm32qdaDoG154fgcSg59KwOxKYcweoqJ2enCZ7YuIT7S+qsKtu6
 ZrSI3W1ZFsExxd+tW8V1kG1PQ6F3Fr+58CoBbFhPujcdsw+82ABbAs9OXPg7i8bx0leg
 A0Hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MLHO0JhuzfCdKlCBF5BKG4zNKIIF6DKuLbhKGONwuNGGpAue8fSxoOPP2R43JVMC9e9E=@lists.linux.it
X-Gm-Message-State: AOJu0YyMIfKrC6sXmRqMv5Xf2yc4fh8aXWSC8X2TsyOt/54bBXvopdO+
 F3SJcz/FvYFlibKNFDaac4+7BdsWBChfg44k7U7HJ1cesx08HNUtZzW3xGCVdbpZjgE=
X-Gm-Gg: AfdE7cmdaCpN1cTNUtPj1rQVKfQd3DMZpl7pL47u1cbdqQ2LH2JK9VykeKxtO70Xy3f
 I5YD/Tuf32H1A8xWENKLCw7JoMCDYMdUBUkeASYkUW9jGFeKhb5VYECwIA0kh5yJ5uS00w3bX3S
 EntmUmZc0D++y8a5cQf9475vp8AI2mgjBRbxCw0ealaNACuiZpMoSNR13Dq8wmcDkxf7E9RBqcZ
 RMccWWdbgZlm8LILZ6V6EDYh0VPYiFAzlZ3mTKHwiqyT2mx4PAZF4DqhPuxIf3iozbsfsJLZZgf
 R31Z6ueLpqcNxPiXOsirpg28Tq09Dm1zWfVPSvjpBBqj/mEVjDrlVVhU6EQ1GV4iMiiJtP4zqZo
 bWY76w+f54P4+qMbOIhmGrXOLszhC4tU+JdoqE2Ve5WpAsTtwF8LSINQ6LhgMKiyLxixgHV3El5
 fwFOOb3DhoMdRnXyPtj5yKX2KRDhArzSjouC6o8s1kANmY+8lVy+LmN6T+ICK9BQ==
X-Received: by 2002:a05:600c:590d:b0:490:e1a6:45b6 with SMTP id
 5b1f17b1804b1-492382195e3mr52792965e9.20.1781789009802; 
 Thu, 18 Jun 2026 06:23:29 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a159d06sm56069185e9.0.2026.06.18.06.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:23:29 -0700 (PDT)
Message-ID: <6a33f151.34ecd23a.148835.82ec@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajKzKA_ROAlfBDys@rei.lan>
Date: Thu, 18 Jun 2026 13:23:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] metadata: add tests grouping support
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > 1. Source file path - the two nearest parent directories (immediate
> >    parent first), skipping 'kernel' as too generic. For example:
> >    - testcases/kernel/syscalls/clone/clone01.c -> clone, syscalls
> >    - testcases/kernel/kvm/kvm_pagefault01.c -> kvm
> >    - testcases/cve/cve-2017-16939.c -> cve
> > 
> > 2. @group tags in the doc comment block, e.g.:
> >    /*    * Test description.
> >     *
> >     * @group stress
> 
> Maybe call it groups and allow white-space separated list?
> 
> I'm not really sure about the syntax, but I guess that @groups foo bar
> will do.

I was thinking that having `@group foo` is cleaner. When we start to have
multiple groups it can be really to handle multiple groups: for instance,
we might end up having one line over 80 chars in the description.

@groups foo1 bar1 foo2 bar2 foo3 bar3 ..

Instead, we might have

@group foo1
@group bar1
@group foo2
@group bar2
@group foo3
@group bar3

These strings are short, but if we have long names it can be weird
to read having all of them on a single line.

> 
> >     */
> > 
> > Add test case for @group tag parsing.
> > 
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  metadata/metaparse.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++
> >  metadata/tests/groups.c      | 11 ++++++
> >  metadata/tests/groups.c.json | 13 +++++++
> >  3 files changed, 112 insertions(+)
> > 
> > diff --git a/metadata/metaparse.c b/metadata/metaparse.c
> > index 561cbb9d2d54689988c9aa49d591628696bcf847..6bc4b7af60c7449d4b60a1252fa58fed77e03066 100644
> > --- a/metadata/metaparse.c
> > +++ b/metadata/metaparse.c
> > @@ -1168,6 +1168,92 @@ static void print_help(const char *prgname)
> >  	exit(0);
> >  }
> >  
> > +/*
> > + * Add groups derived from the source file path.
> > + *
> > + * Groups are the two nearest parent directories (immediate parent
> > + * first), skipping 'kernel' as it's too generic:
> > + *
> > + *   testcases/kernel/syscalls/clone/clone01.c  -> clone, syscalls
> > + *   testcases/kernel/kvm/kvm_pagefault01.c     -> kvm
> > + *   testcases/cve/cve-2017-16939.c             -> cve
> > + */
> > +static void add_path_groups(struct data_node *groups, const char *fname)
> > +{
> > +	char buf[256];
> > +	int offsets[8];
> > +	int ndirs = 0;
> > +	int ngroups = 0;
> > +	char *p;
> > +
> > +	if (strncmp(fname, "testcases/", 10))
> > +		return;
> > +
> > +	snprintf(buf, sizeof(buf), "%s", fname + 10);
> 
> Maybe avoid static buffers here with:
> 
> 	buf = strdup(fname + 10);
> 

we can eventually just loop on file name and using offsets, but a
small static buffer makes things clear. I will try to handle it
differently.

> > +	p = strtok(buf, "/");
> > +	while (p && ndirs < 8) {
> > +		offsets[ndirs++] = p - buf;
> 
> Why do we store offset rather than the pointer to the string?
> 
> 		dirs[ndirs++] = p;

Leftover of experiments I guess..

> 
> > +		p = strtok(NULL, "/");
> > +	}
> > +
> > +	/* Last element is the filename, skip it */
> > +	ndirs--;
> > +
> > +	for (int j = ndirs - 1; j >= 0 && ngroups < 2; j--) {
> > +		if (!strcmp(buf + offsets[j], "kernel"))
> > +			continue;
> > +
> > +		data_node_array_add(groups, data_node_string(buf + offsets[j]));
> > +		ngroups++;
> > +	}
> 
> We can avoid the complex loop by adding a function to add the group with
> the "kernel" filter and just calling it twice here:
> 
> 	add_group(groups, dirs[ndirs-1]);
> 	add_group(groups, dirs[ndirs-2]);

This makes sense yes, we are not gonna add any folder after kernel anyway.

> 
> > +}
> > +
> > +/*
> > + * Add groups from @group tags in the doc comment block.
> > + */
> > +static void add_doc_groups(struct data_node *groups, struct data_node *doc)
> > +{
> > +	if (!doc || doc->type != DATA_ARRAY)
> > +		return;
> > +
> > +	for (unsigned int i = 0; i < data_node_array_len(doc); i++) {
> > +		struct data_node *line = doc->array.array[i];
> > +		const char *s;
> > +
> > +		if (line->type != DATA_STRING)
> > +			continue;
> > +
> > +		s = line->string.val;
> > +
> > +		while (*s && (*s == ' ' || *s == '\t'))
> > +			s++;
> > +
> > +		if (strncmp(s, "@group ", 7))
> > +			continue;
> > +
> > +		s += 7;
> > +		while (*s && (*s == ' ' || *s == '\t'))
> > +			s++;
> > +
> > +		if (*s)
> > +			data_node_array_add(groups, data_node_string(s));
> > +	}
> 
> If we hook up into the multiline_comment() function we can consume the
> line as well so that it does not appear in the parsed doc string. We
> would have to pass the groups node from the main all the way to
> multiline_comment() something as (uncomplete):

Will take a look into it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
