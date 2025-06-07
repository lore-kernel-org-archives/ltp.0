Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A2EC5B543
	for <ltp@archiver.kernel.org>; Sat,  7 Jun 2025 06:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749278585; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eeEteqZa1wrPh3lfZz5St1Hw56bwbWqpLZRK6yHcdm4=;
 b=Xzojx6d4zoBcmCumWNNAYSPUEGB6NTc1mD7rAM7ZjxEtqWkg3Q3B/wTuv9nW3H5D/NBNw
 EEB+Yw5gFYDd2zqdRhB868hFg5gRibha9b/RmfDJcznE/s56pps0xYrQM8yNSegsC02ABSB
 2Dhon7WXkyOMaqvBB+PbSdKv5+sQ3pI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E71A13CA69D
	for <ltp@archiver.kernel.org>; Sat,  7 Jun 2025 08:43:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E89C3C67EF
 for <ltp@lists.linux.it>; Sat,  7 Jun 2025 08:42:43 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 649542000D2
 for <ltp@lists.linux.it>; Sat,  7 Jun 2025 08:42:42 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1419293f8f.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749278562; x=1749883362; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mrUXViwDkqJhoI4YedUPeKtoVXSUs9aUlsZd2VKVLQk=;
 b=OFAT6FV/7kLn2wjuO6Ix2xns+DQHF2PjWxTBV84iXpj8w07BL2JLoGdCqpUQj79XFO
 ny7zqShaYEqOimqz7FO4EIUdEvSnUArJJrNGBkF3jQCLjL58nBPQWs0waGMFXFL2mGPs
 lmBWy31sICX/rxCQiskavIvVRpzB9c8TrsxbSYlb07kz0l6XQhJ2+glFEaaB2kFK+0qP
 lxxKCnEvZqigLmW2IJp0IEoc+/8GnNfTUeyEDK7O+AUz+rF29zXwWHLH5Nwf8acfrcuJ
 KjrDcmwe//5/CdifXRwonHxA5GTkhjttEFf13YQAVTovrbMdAfWe1/0bZhjcAh6vHgFP
 LS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749278562; x=1749883362;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrUXViwDkqJhoI4YedUPeKtoVXSUs9aUlsZd2VKVLQk=;
 b=H34SZY82xRZXrNUMvCKbTfs0zzGRp+2+4BzfGOmCKj/uvv7gTZTC7w8uZ6e8/N/8Oq
 EySpT7RwkMibdzT+tKhq0EzIL+ztn//fDvtmxEIDWh3BYQtVyE4aDkjFIB5wXVLZpzMx
 YGjHAAeli72744G3z1s7OpG2Syl2egT4l8t6e/cwXooqDSnixuS9WuNBZ9d3TYkA5W2g
 qb1tu1umXoFEfaAIqGAmSua4+ogm3EMOiB8Yi+Y0q3Hq6pToXZuLmzalkscYwId2sYcC
 n6NyA2YWh7XDXaWVV2HhjBQWT57ylElzczflfg55QiG55qNq/a1MxOGog2hHBlw20n6J
 ICMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlVQA3STpTuZi00ydiDRstUBxXicLZmxd/3YaesIyUgQaccLjKpuTRqEXPDT9FTkuXb84=@lists.linux.it
X-Gm-Message-State: AOJu0YxzyGgpmjR6kJ29lR4WC7wc56oWa8bmk9gRjxIp1qMVGdAxUkB8
 W18EFQsrnQIezLSPKZzOftA4i6SyDQHIylR8HmLgRKnfP7eRKaNSamRMSmdmBcPSXA==
X-Gm-Gg: ASbGncvBC8xsaSAMV3eQH74WEXkZgfHVVgCglpe9tAxpMCUkVMQlIXE5acgCWMOL4Ha
 nTXcZ4QPxRXCUMaOUvOpvojIpnB+OTEGFCaYXHN8vYo4kE7OMas1sF3XPrvKAGz3o+YsrzExCic
 PZdmHzLvprt+hUePVpHVQSzxjkHSJ/CCCh+gkcdd5nHCpNZ1DWxIj4mY9upFKAJIzp60AQlogvb
 y7ESwXbwwABqQWeGfHWgBkVHyL/lI2kvzrKSgfZM0kUKYmygv20zpxJVec54RJWQmatRfR3vC1x
 oB4RBdD7SSc55YEgx/kYaMK6X236vRfJ7IyVU2A3yR9bv58q3vvf6RHHZiWU8Q==
X-Google-Smtp-Source: AGHT+IEQpXVKIqGfsJsoMkweH+85T0leIdWCXGXZFYX0Iygo8VSgKAgnvV96Ffv+VcOEWsJk83bygQ==
X-Received: by 2002:a05:6000:2304:b0:3a4:d3ff:cef2 with SMTP id
 ffacd0b85a97d-3a53188dea2mr5422014f8f.27.1749278561634; 
 Fri, 06 Jun 2025 23:42:41 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603092f38sm21889275ad.79.2025.06.06.23.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 23:42:41 -0700 (PDT)
Date: Sat, 7 Jun 2025 14:42:22 -0400
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Message-ID: <aESIDuS42cY_sLBe@MiWiFi-CR6608-srv>
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
 <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
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
Cc: ltp@lists.linux.it, cgroups@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 05, 2025 at 05:56:11PM +0200, Michal Koutn=FD wrote:
> On Thu, Jun 05, 2025 at 11:40:19AM +0200, Petr Vorel <pvorel@suse.cz> wro=
te:
> > @Michal @Li WDYT?
> =

> RT_GROUP scheduling is v1 feature as of now.
> =

> Testing cgroup v2 makes only sense with =

> CONFIG_RT_GROUP_SCHED=3Dy and CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED=3Dy
> (this combination is equivalent to CONFIG_RT_GROUP_SCHED=3Dn on v2).

@Michal Koutn=FD  So we should skip test cgroupv2 with CONFIG_RT_GROUP_SCHE=
D=3Dyes, correct? Like following change?

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_i=
nterval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_=
interval01.c
index 55516ec89..b12bd7857 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval=
01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval=
01.c
@@ -43,10 +43,9 @@ static void setup(void)

        tp.type =3D tv->ts_type;

+       static const char * const kconf[] =3D {"CONFIG_RT_GROUP_SCHED=3Dy",=
 NULL};
+       if ((access("/sys/fs/cgroup/cgroup.controllers", F_OK) =3D=3D 0) &&=
 !tst_kconfig_check(kconf_strict)) {
+               tst_brk(TCONF, "CONFIG_RT_GROUP_SCHED not support on cgroup=
v2");
+       }

> =

> HTH,
> Michal



-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
