Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05049C61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787660190; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fj2L40ESNV0OCl7wvBGS25aH4JvkLJ1GeMxaf2y3rb4=;
 b=VEsIN21O7+uT0wi7qLFSaWraB+S+yqfwZltjz7sIlEUYsl75mS9U7f6K+7WmJg88Sm9vq
 blCq+c3eX7x5/K7ZSrTYqVj2FiV7R8orR5B6APb9UQcfLgDjQX58+KT86Bh1W1q5MsVWHHA
 sRmiMTEsn/ROQ2Eg32GHVuALPhTz21w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 667173C5E50
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:16:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 979DD3C1E1C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 14:16:11 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D40871400BD9
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 14:16:10 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c214e625259so707931466b.2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787660170; x=1788264970; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bjdOKXLgLg9TBPGc0FlRQ4pP8uo3o0hm8UrThhuckaw=;
 b=BxKrZrgl1IUqWsUevM9dnFq0feMr4AGu6blIRyT4LCVj0cLvC5H4WeupZeRL7OedUS
 FnDQ1S+NuCjFWMh8Cn2GNrdjYww0Wq8+830K62eulSZ8fk3EobmklzbCamWHNQjjfbg7
 jZLLIhJYqFh2pb67JBoFc1tV8KFWu6hDvQPe1sXO0MJzaT6AElhB1s6CxCkSOc8tWoSB
 44yHfAvQydeSoQwsa1qZj9CUv5iIdn3apeQeVu0OLgRuovYkaFZkUJb6BCRovr0ZN4Qn
 H2mwxQwmIHliYBmmiMnmJqAtIPXLQ428bw3NtnrGl2WxKrrHgZ4tBEfMea9coAVKMPQ1
 jVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660170; x=1788264970;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bjdOKXLgLg9TBPGc0FlRQ4pP8uo3o0hm8UrThhuckaw=;
 b=VD+fggCkAmTHxaNHQ20Ui7E7iPxZSGgu1YecMn7LQRwKyxCoywBNa7k1z/Psj01Phr
 jL/79EmA84Yyn+GqXPdDgIwap2sxWKKqNBXAl/U6J1s9SxQk5ODq1V9cjX2bxY/k7edf
 dZbJwK+LMwSy4j3JfgqvQnGblIySA624bNSgNVqbwVI57+NxDAHwG17KZp6sfex0kTix
 msUL3onQWw1fm5rOvovH2whHXgB+rVnasI2CSL8jDT5JkU4siqmpacT1X7d3CNy3oRFO
 FtUb+jGFfqU0Jd0FQmoqdVmK8jM6FGWiV9RursJ+Zl8GYcax5wmq1jJ2kLRh4OpxAqWP
 CQpA==
X-Gm-Message-State: AFuF++l2f2ty47+h10KiEBegjtJgSF3xdqviCMtBH+Sg1m1walBgkLCM
 Z3GuMZTcNf3a/svlgq6WYQTPweHewFhPGowWPHrGv1/P7IetT8+knVMDXX0YHGpRppw=
X-Gm-Gg: AR+sD11sd/JVQJbIbDrqN1FTCFEDeaMfyG69OljAsYRX+6Kc1gWzdCkcO7PckvxQRJv
 D9E3lo5csdz86HAeojYde0qTFpsqObVpT5oCTnGAId1cNvsB/owRrUePXx6DJqo5LDkH7L3GRcL
 5lTtLt5QJUXnFr3eYn2qsGt7ixnpLBnTCq6K9WvHGCIiuEgu8gBBx3kiEg3lFdxPG258t5OWz6s
 +S4YDmKApYraW/nDfT6gWML3JeRreGY4FhyFKD3TZyrbqhq9GyPVN6CWo7WnKuB5Tz/m9Hq4a2i
 D7P6oXs8QOfqFtR85SlPryrp+INQ19xQramAwkjobr4bAjwxAioyT8wa2cP29Amp493ZLfXkQV6
 4ZzKkjwt6/yuIBNepExOY9mKaO2uD62k4SIlMzvYVEMguO4tFiAs/VwLFrxsacIw3yuSIa7fiOT
 IuWAAqu4sinxhHSMacCEWowyEaBkoI58pX2Wvjndq3gTemkIy1CbSIqHpkKkHFL7GnfovwA9fi4
 uFgWbIKmASNypjs+c5RIR9ysSykrpLTPc/b
X-Received: by 2002:a17:907:5c5:b0:c20:f6d9:d8c7 with SMTP id
 a640c23a62f3a-c24e5c0d2d7mr639814566b.24.1787660169832; 
 Tue, 25 Aug 2026 05:16:09 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25054440c4sm54234166b.53.2026.08.25.05.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:16:09 -0700 (PDT)
Message-ID: <6a8d8789.e23a4405.3c1b2a.58c7@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260825022926.9649-1-wegao@suse.com>
Date: Tue, 25 Aug 2026 12:16:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Reduce the throttling interval from 2 MB to 64 KB (usleep for 200us
> every 64 KB) in the page-dirtying loop. This smooths out allocation
> spikes and gives asynchronous swap writeback time to catch up under
> slower VM storage environments, avoiding unexpected MemCG OOM-kills.

Unfortunately this is not a solution but a workaround, we need to make
sure that we are able to see any change to the swap memory while
allocating dirty pages close to the memory.max. This is probably a
fix for a specific target rather than complete fix.

We need to find an another way to ensure that OOM killer won't kick in.
That is caused by the time between releasing swap and storing swapped
data inside the hard disk. If that is not gonna happen for a certain
amount of times, the OOM killer kicks. By reducing the throttling
interval, we simply pause more time over 256MB of memory, but an even
slower machine won't fit into these intervals of 64KB.

There's not a "clean" solution, but we can use the v2 cgroup support
for `memory.reclaim` and request enough data while we are swapping it.

On v1 we can either disable the cgroup OOM killer via memory.oom_control
so the child blocks instead of being killed, or keep the loop unthrottled
(the kernel already blocks faults in direct reclaim at memory.max) and
report an OOM kill as TBROK via the child's exit status.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
