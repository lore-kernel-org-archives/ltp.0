Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A203CCCA47C
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 11:14:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61FDE3C955B
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 13:14:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FC9B3C0F84
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 13:13:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 92E8A600136
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 13:13:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D04121F8B4;
 Thu, 23 Jun 2022 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655982833;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1wOnHCxyNA5NAORtr3TI9s9iFqG47VVepaVyEHfQ8SI=;
 b=hr/p2ijOGvqmcSvfOtMY3kAkrVcyrVagHYR8hA1qSoPuuHZBK06vvfrRI3WML5sTwSUrT8
 MOrkmbHP8sc5+SRzTsQSC90aQJAFF0uXKWoZFURRtAazFhGNDpfdPmx1qyoQ5jpwJUJGsd
 /Q5kocXAu0iC3DQBmrxyhM1c69SvyF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655982833;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1wOnHCxyNA5NAORtr3TI9s9iFqG47VVepaVyEHfQ8SI=;
 b=WBEsoh5Z2EuEBXeK2EkpDtVZdLvMSP8WGiPXychu5uw3fXDv1McebBBm7B7NaTuDVrMzLC
 BkW2DgYxd082akCA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 735612C142;
 Thu, 23 Jun 2022 11:13:53 +0000 (UTC)
References: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
 <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
 <CAASaF6wyH7YJtNaGfR9n-yhnHv9Pc7BvCMYe1EWvwnCMtNhfDQ@mail.gmail.com>
 <60876a29-d589-1de9-b4fd-a9000b8e7d68@jv-coder.de>
 <871qvi5r97.fsf@suse.de>
 <CAEemH2c=xxHrGiqtaRjM89S==JfsODnJ=D9b+mzaF68sjGRVJw@mail.gmail.com>
 <87wnda43ge.fsf@suse.de>
 <05f07b62-9751-a900-130b-b7ecc10ccacb@jv-coder.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 23 Jun 2022 11:51:26 +0100
In-reply-to: <05f07b62-9751-a900-130b-b7ecc10ccacb@jv-coder.de>
Message-ID: <87sfnv4opb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 6763a36
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Joerg,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>
> Am 6/21/2022 um 1:38 PM schrieb Richard Palethorpe:
>> Hello Li,
>> 
>> Li Wang <liwang@redhat.com> writes:
>> 
>>> On Tue, Jun 21, 2022 at 4:56 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
>>>
>>>  Hello,
>>>
>>>  Joerg Vehlow <lkml@jv-coder.de> writes:
>>>
>>>  > Hi Jan,
>>>  >
>>>  > Am 6/21/2022 um 9:22 AM schrieb Jan Stancek:
>>>  >> On Tue, Jun 21, 2022 at 9:15 AM Joerg Vehlow <lkml@jv-coder.de> wrote:
>>>  >>>
>>>  >>> Hi,
>>>  >>>
>>>  >>> Am 6/17/2022 um 3:17 AM schrieb lkft@linaro.org:
>>>  >>>> * qemu_i386, ltp-fs-tests
>>>  >>>>   - read_all_proc
>>>  >>> I've seen this test fail a lot, has anyone ever tried to analyze it? I
>>>  >>> was unable to reproduce the problem when running the test in isolation.
>>>  >> 
>>>  >> I see it hit timeouts too (read_all_sys as well). I think it needs
>>>  >> runtime restored to 5minutes as well, atm. it has 30s.
>>>  > Didn't think about that, but at least for the failures I've seen, this
>>>  > is not the reason. The message printed by the test is "Test timeout 5
>>>  > minutes exceeded."
>>>  >
>>>  > Joerg
>>>
>>>  The main issue with read_all is that it also acts as a stress
>>>  test. Reading some files in proc and sys is very resource intensive
>>>  (e.g. due to lock contention) and varies depending on what state the
>>>  system is in. On some systems this test will take a long time. Also
>>>  there are some files which have to be filtered from the test. This
>>>  varies by system as well.
>>>
>>> Does it make sense to have a lite version of read_all_sys?
>>> which may only go through files sequentially or under slight stress.
>> 
>> IIRC the reason I started doing it in parallel is because sequential
>> opens and reads are even slower and unreliable. Some level of parallism
>> is required, but too much and it causes issues.
>> 
>> Thinking about it now, on a single or two core system only one worker
>> process will be spawned. Which could get blocked for a long time on some
>> reads because of the way some sys/proc files are implemented.
>> 
>> The worker count can be overridden with -w if someone wants to try
>> increasing it to see if that actually helps on systems with <3
>> cpus. Also the number of reads is set to 3 in the runtest file, that can
>> be reduced to 1 with -r.
>> 
>>>
>>> With regard to this stressful read_all, I guess we can put into a dedicated
>>> set and run separately in stress testing.
>> 
>> I don't think I'd want to run that. IMO just doing enough to test
>> parallel accesses is whats required. More than that we will run into
>> diminishing returns . However I'm not against creating another runtest
>> file/entry for that.
>> 
>> On bigger systems I think the test is already quite limited even though
>> it does 3 reads. It only spwans a max of 15 workers which should prevent
>> it from causing huge lock contention on machines with >16 CPUs. At least
>> I've not seen problems with that.
>> 
>> It looks like the log from lkft is for a smaller machine?
> I just used this regression report as an anchor point, because I am
> seeing the same intermittent error on a 4 and an 8 core aarch64 system.
> The system state at the time of the test execution is very reproducible
> and sometimes the 5 minutes are exceeded, while it only takes ~3s, when
> it is successful. Maybe there is a very time sensitive kernel bug here?
> I am still not sure how to debug this, because I was never able to
> reproduce it without executing all ltp tests, that run before in out
> setup.

Very interesting. Well, running tests can cause files to appear in proc
and sys. Including ones which remain after testing has finished. The
most obvious example being when a module is loaded and it creates some
sys files.

Also it could be some reasources are added which are probed by existing
files. Which could be time sensitive if they are cleaned up
asynchronously.

Anyway it should be possible to profile the open and read syscalls with
ftrace or similar. Or you can just set '-v' and inspect the log. We
should also have a per read timeout. I just haven't got around to
implementing it. Probably it requires monitoring, killing and restarting
stuck workers due to how read is implemented on some files.

>
> Joerg


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
