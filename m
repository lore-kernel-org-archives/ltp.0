Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C0C04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 12:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60DF03C22F0
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 14:14:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D4003C0282
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 14:13:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD7291000A1D
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 14:13:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A9203386B1;
 Wed, 27 Jul 2022 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658924029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYosmgddA5Imdukn9WPIzFAedm4hGKqb24j7vIdlnCs=;
 b=Wat0udtC7YcHujnyooMmduXvBHsHeFWOcKU/ltd/sBry8ICiPWW1VwHoJtIruH18uaOcFm
 BtghsrhxY34ri+IO4QHIIb3C1XOTYPeC6PdhVDGWh3PtTfeulQkPSjKDP8pwmL8nGPRAkt
 BhXqpCHpX7S4oc/y4Txilon21mC3hd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658924029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYosmgddA5Imdukn9WPIzFAedm4hGKqb24j7vIdlnCs=;
 b=0f78xY3fEC5MqoH0H8jkG8oLX1IzEmG1Vh+pksDA/t7CIy12I62sD0uuipDinz3c3f10xL
 DLAv9Z/aWwQEB0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73DA313A8E;
 Wed, 27 Jul 2022 12:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XEbvGf0r4WL5FwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Jul 2022 12:13:49 +0000
Date: Wed, 27 Jul 2022 14:13:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YuEr+w4u8xqZZARz@pevik>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2fG_zv2gPhzXUnC45sWr+N87-Kzjyd3Xbx-J2qMR4PdKA@mail.gmail.com>
 <YuEQIx6sfjHiU4L3@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YuEQIx6sfjHiU4L3@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 00/10] Expand cgroup_lib shell library
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

patchset merged.
Luke, thanks a lot for amazing work, others for review!

FYI with these fixes there are only 6 tests failing on openSUSE Tumbleweed setup:

* memcg_stress: timeout after 15 min
* memcontrol04
memcontrol04.c:214: TFAIL: Expect: (F low events=379) == 0

* controllers
TEST 1: CPU CONTROLLER TESTING
RUNNING SETUP.....
ERROR: Could not mount cgroup filesystem on /dev/cpuctl..Exiting test
Cleanup called
cat: /dev/cpuctl/group_def/tasks: No such file or directory
...
Cleanup done for latency test 2

mount: /dev/cpuctl: cpuctl already mounted or mount point busy.
cpuctl_test_fj    1  TFAIL  :  ltpapicmd.c:188: failed to mount cpu subsystem... Exiting
cpuctl_test_fj    1  TFAIL  :  ltpapicmd.c:188: case1    FAIL

* cpuset_inherit
cpuset_inherit 1 TFAIL: Could not mount cgroup filesystem with  cpuset on /dev/cpuset..Exiting test

* cpuset_hotplug
cpuset_hotplug 1 TFAIL: Could not mount cgroup filesystem with  cpuset on /dev/cpuset..Exiting test

* cpuset_regression_test
cpuset_regression_test 1 TBROK: Both cpuset.cpu_exclusive and cpu_exclusive do not exist

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
