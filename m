Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485D3CCD199
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 17:05:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0E073CEEA0
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 19:05:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609FA3CEB80
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 19:05:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 80CCB1000D90
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 19:05:13 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so12175995e9.0
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 10:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760720713; x=1761325513; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11WXCmAr2J4Q1VKOSE4Feuiuoee/FnM9Wk5Ls9V39FY=;
 b=BcjAIU/FTyrjxrdk+EGpXKPNOuuuf85mVLGxNMyDtZC0fhUcPRsIhhWKoXZvKfd6GH
 Wb7wa3GD9+ZCjmP8uHv2dh6SVJ5l6rxWbPrwYhx4Nsv8HH7Af+8TzZqG3D49rsy3KmjL
 h2Fwp6nQ47AGHSMxI0moXfWx3cB1bDtwY3Da1WBjUULIu6zr5qAKly7cgaQIl4jcAGnJ
 gmbg3K6y+uxDHsV5lliVTZDV/2AKDdrBA7vo6n24jOUrfnBud5acL0jfoxz3YCzu/ec6
 RA9EBK4CcFQueH7iMfp54wFJliG5tLMkklq20VjUAQYEib3ZS4kftJeU2AgskT+cmf3H
 z/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760720713; x=1761325513;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11WXCmAr2J4Q1VKOSE4Feuiuoee/FnM9Wk5Ls9V39FY=;
 b=o8HSIfnNTDuoFLJeaRdV3qDXhtIQ8MrYaejq8dC+vHcUPMs/FLxJNx2C8eBuATUh0c
 7vuZDqQluxBMRi+qhZwKAOK1NLw1Oz/g+N1YHgTeh/MeSefMtRpHEyqq1csgb+mg9vM6
 d3afHaeeswhwl5ec3Px0go8+IK6VILRoGadgxANklslzZN84sdIuzonvJHKQRHZxmKMd
 IxWbXcx2icKotTCl/uiUdzvC/CJFOpkFMXKKgX8BWBuATsdX18O8fNscifOy9hmFQgEQ
 8SstxpHJtv61WJGdHRd/jQuWrEUNUfrF1BlPXyvrB55HZUDJCZnXs9XUwmDm6y+MfveS
 rIPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/8aipK2hWJePu3eQMoJY4/6J5DwP6wQraXNZr4hJ5vtql9bLsz6BUpTIKXsqwe1k6IEk=@lists.linux.it
X-Gm-Message-State: AOJu0YwPIjcmOJsjaamtMgwRkqeS7kzo/i1XoDEqklbHflREprV4Q8QO
 nMWqmjVnfms+YLo6zR7t+QEx8isAY/iJL7YqCI7DANCRv11VIscjsbfi
X-Gm-Gg: ASbGnctb1+JhGm2BVcOITk+det8OcdKvTntNcN19TVnVU4tCXKLRDkfBVSk2I7VEiQZ
 RRzgq5vginoo3V/Zj8C83Ts/1kqRogprg1wpYZgPzP4IIkBGPI/OQJWwIaV8ugHWSDSgH6admOf
 1J0yFh9cBhBD7ZjqtGEoAupShnWltRWCMNABQMVBxELI0/fMzW1pXWwFJ6rmrmtDZePKLuMOSiL
 lnrCooA1RXoWmc0UIjcpKpuJ+FgxB7IXpYF4cNtq41uC4fz7XYwYhzbFp5aUQg19cQi8nrL0arm
 PZi9CGOBzqEHI2bpe9Sh0vlO4085jpZZTqum3PV/qn3ukGZa3mDHHxKUePs4dxQPaThWN9GG/A7
 c3vmkb2YX9BkPjESYcDJZhL0FCMlzar8B3pL8ExjTUYXCbwS6ztyz2gjtsP5uzCN1RChJKnBgm0
 XEqyVV+PdLuJIgrow=
X-Google-Smtp-Source: AGHT+IGmY1UFJJXlxSAy1D+FcDBKqk5RvLkJlbVAX+ARs5FazO+BieJylSPAz9qCZ5mit8NuAkM7hA==
X-Received: by 2002:a05:600c:444d:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-471179202famr33603235e9.36.1760720712471; 
 Fri, 17 Oct 2025 10:05:12 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520dd65sm3782745e9.15.2025.10.17.10.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 10:05:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:05:09 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20251017170509.GB355538@pevik>
References: <20251013185934.GA114595@pevik>
 <59f5af6c290efef806b73ba905cbfc412c290109.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <59f5af6c290efef806b73ba905cbfc412c290109.camel@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ltp: upgrade 20250530 -> 20250930
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: Yi Zhao <yi.zhao@eng.windriver.com>, Khem Raj <raj.khem@gmail.com>,
 openembedded-core@lists.openembedded.org,
 Hui Min Mina Chou <minachou@andestech.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard, all,

[ I realized that we went quite far to kirk topic, which would be interesting to
Cyril, Andrea and possible other people developers or users, therefore Cc them.
Replying to this thread:
https://lists.openembedded.org/g/openembedded-core/message/224816
+ links to replies from Richardo previously in LTP ML
https://lore.kernel.org/ltp/c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org/
https://lore.kernel.org/ltp/8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org/
NOTE: Cc requires subscription.
]

I added few final points below.

> On Mon, 2025-10-13 at 20:59 +0200, Petr Vorel wrote:

...
> > > I did send some questions and had some discussion on kirk a while ago.
> > > Quite simply, it isn't useful/interesting to Yocto Project.

> > I see your points [2] [3].

> > > What we want to test with is our images and our kernel, as we build it.
> > > kirk, as far as I understand it has gone a different route where there
> > > isn't really any userspace left and it simply tests against a kernel
> > > binary. We'd no longer be testing our build artefacts but some more
> > > artificial construct.

> > I don't understand "any userspace left and it simply tests against a kernel
> > binary". LTP tests are mostly focused on the kernel (+ it's modules). And you
> > can run individual tests by just executing them (+ handle environment variables)
> > or use runltp or use kirk. The executor does not matter that much. In the end we
> > at SUSE also test with LTP our built image :). (LTP is used by mainline folks
> > and by distro folks).

> Sorry, I'm not really being clear. The Yocto Project is in the middle
> of some huge changes and I'm struggling with those. Equally, I did want
> to at least given some response to your upgrade which is appreciated.

> I guess we're one of the few ltp users with a cross environment. We
> have a way to launch target images under emulation and our own methods
> for controlling them and transferring files. We do all this without
> special permissions or access other than ability to use kvm. As such we
> liked being able to just run runltp on the target in the environment we
> already have.

> kirk, at least as I understand it, wants to do much of this for itself.
> That means we end up with two ways of running the target emulation
> which may or may not match. We'd much prefer just having one so we
> either have issues there or we do not but our test environment is
> consistent across all tests.

> > FYI although kirk is meant to be run on the host, doing a different connections,
> > it can also be run on SUT. Sure, there is then python3 dependency on SUT
> > (heavier than shell + it's dependencies), but still kind of runltp replacement.


> > > We're trying to test what we build. You're trying to test the kernel
> > > for regressions. They're two different things.

> > > I totally understand why you've gone that direction with kirk but I
> > > also did spell out at the time that it wasn't something which really
> > > fits in with the way we run tests, or what we actually aim to test. I
> > > was told at the time that basically, nobody is interested in what we
> > > want/do.

> > ...
> > > > I see in meta/lib/oeqa/runtime/cases/ltp.py the deprecated
> > > > /opt/ltp/runltp is still being used. We want to remove it (not sure
> > > > when, but it will happen sooner or later). Any change somebody would
> > > > submit a patch to switch to kirk?

> > > It is more likely that when you drop runltp, we'll just have to drop
> > > ltp. Sorry :(. I did explain this at while ago :/.

> > It's a question if any of the users really need LTP. If yes, you could vendor
> > runltp.

> > Or, write a simple script which parses the content of the runtest files and
> > execute them. FYI for part of openSUSE testing we still use our custom openQA
> > runner which does exactly this. It would be very light: -d and -r can be
> > replaced by TMPDIR and LTPROOT, -I is supported by all tests. The only missing
> > thing will be generating of results (if you really need it, I'd recommend kirk
> > and it's JSON output).

> We'd appreciate and be able to use the json output, we already have
> json output for most of our other tests. Beyond that, as you say, we
> don't really need much beyond what runltp does though. kirk brings with
> it a number of things we definitely do not want (as mentioned above). I
> don't know if we can avoid those or not.

As I wrote previously, kirk is possible to be used as nearly drop-in runltp
replacement run on the SUT. It's not the intended use-case (we aim it to be run
on host), but still supported use case.

> > The reason we go to kirk + ltx is that in the future we plan to get rid of
> > runtests, replace them with metadata info (that will allow many things [4],
> > but you were Cc at the discussion [5]). Once this happen, runltp (or any custom
> > script / framework runner) will be broken. But this likely take long time.

> Right, using a vendored runltp would just buy us a small amount of time
> so likely isn't a long term viable solution sadly. I'd consider it if
> it were but it doesn't seem a good investment of time.

I would say adopting kirk in minimalistic way (or identify what you need and
it's still missing) would be sure safer in a long term.

Kind regards,
Petr

> Cheers,

> Richard

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
