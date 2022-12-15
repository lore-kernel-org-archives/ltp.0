Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93310C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 18:39:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19A7F3CBCDF
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 19:39:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 901113C1BCA
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 19:39:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E328A200A17
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 19:39:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0D8F5C0D8;
 Thu, 15 Dec 2022 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671129560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0I/Zz3QjA9RZx6YY6LwIHtASLAHOCkyKMno3qblyy8E=;
 b=2ZxHJ7VnxCF/F7trBwxoE3Kk06W+QOk5Uw+NnPneXmi0cLhdsTm5f7o7j01JY0vILnM10q
 6q+X6ZDL4FsqKPRpCsrvqdmCLn5YyEyRMITLoEYr1fbe2XPtX5vaGCwhL6+STWg54GycEH
 OpfSb4d75tOFkUYYvcQS4W1PNJtiD6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671129560;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0I/Zz3QjA9RZx6YY6LwIHtASLAHOCkyKMno3qblyy8E=;
 b=I2JhaysrWwNYqT2/pYXbqj+weVSddEJMs6NVfDJDXsfJQ/Lh8kZLC5+0y4214YzHvDSMpx
 yt4OGoRzM34Y8UCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D8B8138E5;
 Thu, 15 Dec 2022 18:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +9mdI9hpm2MQWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 15 Dec 2022 18:39:20 +0000
Date: Thu, 15 Dec 2022 19:39:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Y5tp0K5QIZ74bnw7@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
 <Yz9CW5vXCuztOTOl@pevik>
 <42eb7aef99a50e09d28f0b9c16ad64cb2caabe91.camel@linux.ibm.com>
 <Yz+4xepB6HlyFSNJ@pevik>
 <9aee3c94e8816196b9449981f3559e1c149d1c49.camel@linux.ibm.com>
 <Y0QFSiMTx3XlvAHJ@pevik>
 <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a7b9b60182d13d92d6e0c5d2c588644027c72b41.camel@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

I'm sorry, it took me long time to look into the issue.

> Only the ima_conditionals.sh and ima_policy.sh tests define policy
> rules based on fsuuid.  The other tests are still based on the builtin
> "ima_policy=tcb" rules.
Yes.

> Without seeing the output of "cat /sys/kernel/security/ima/policy" it's
> hard to understand what's causing these errors.

1) In current master content of /sys/kernel/security/ima/policy when booted with
ima_policy=tcb, which is required by ima_policy.sh:
dont_measure fsmagic=0x9fa0 
dont_measure fsmagic=0x62656572 
dont_measure fsmagic=0x64626720 
dont_measure fsmagic=0x1021994 
dont_measure fsmagic=0x1cd1 
dont_measure fsmagic=0x42494e4d 
dont_measure fsmagic=0x73636673 
dont_measure fsmagic=0xf97cff8c 
dont_measure fsmagic=0x43415d53 
dont_measure fsmagic=0x27e0eb 
dont_measure fsmagic=0x63677270 
dont_measure fsmagic=0x6e736673 
dont_measure fsmagic=0xde5e81e4 
measure func=MMAP_CHECK mask=MAY_EXEC 
measure func=BPRM_CHECK mask=MAY_EXEC 
measure func=FILE_CHECK mask=^MAY_READ euid=0 
measure func=FILE_CHECK mask=^MAY_READ uid=0 
measure func=MODULE_CHECK 
measure func=FIRMWARE_CHECK 
measure func=POLICY_CHECK 

2) if I run ima_violations.sh now (in runtest/ima is run after ima_policy.sh.),
policy does not change as test does not touch it and test pass.

3) Then run ima_policy.sh, the policy changed:
dont_measure fsmagic=0x9fa0 
dont_measure fsmagic=0x62656572 
dont_measure fsmagic=0x64626720 
dont_measure fsmagic=0x1021994 
dont_measure fsmagic=0x73636673 
measure func=MMAP_CHECK mask=MAY_EXEC 
measure func=BPRM_CHECK mask=MAY_EXEC 
measure func=FILE_CHECK mask=MAY_READ uid=0 

4) Obviously the policy file is the same after repeated run of ima_policy.sh.

Now with your patchset.
The policy file after 1) and 2) is obviously the same.

3) Now ima_policy.sh with your patchset:
ima_policy 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_policy 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_policy.c0pGs7haPF/mntpoint 
ima_policy 1 TINFO: timeout per run is 0h 5m 0s
ima_policy 1 TINFO: IMA kernel config:
ima_policy 1 TINFO: CONFIG_IMA=y
ima_policy 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_policy 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_policy 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_policy 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_policy 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_policy 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_policy 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_policy 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_policy 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_policy 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_policy 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_policy 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_policy 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_policy 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
ima_policy 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.0.7-1-default root=UUID=6de93d21-b5ed-4aa4-a9e4-00a7ab77c6d9 splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/570474ff-969e-41e6-883e-ecff2fd15015 mitigations=auto ignore_loglevel lsm=integrity ima_policy=tcb
ima_policy 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_policy 1 TINFO: LTP IMA policy rules based on fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f
ima_policy 1 TINFO: verify that invalid policy isn't loaded
ima_policy 1 TPASS: didn't load invalid policy
ima_policy 2 TINFO: verify that policy file is not opened concurrently and able to loaded multiple times
ima_policy 2 TPASS: policy was loaded just by one process and able to loaded multiple times

The default ima_policy=tcb is changed by fsuuid in ima_policy.sh:
dont_measure fsmagic=0x9fa0 fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
dont_measure fsmagic=0x62656572 fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
dont_measure fsmagic=0x64626720 fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
dont_measure fsmagic=0x1021994 fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
dont_measure fsmagic=0x73636673 fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
measure func=MMAP_CHECK mask=MAY_EXEC fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
measure func=BPRM_CHECK mask=MAY_EXEC fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f 
measure func=FILE_CHECK mask=MAY_READ fsuuid=7e3ca343-13c0-4464-8375-489cd3a57c0f uid=0 

4) running ima_violations.sh after ima_policy.sh no longer works, because
there is nothing new in /var/log/audit/audit.log. I don't know why, but
ima_violations.sh requires either the default ima_policy=tcb policy or policy
created by ima_policy.sh *without* fsuuid.

FYI below is content of /var/log/audit/audit.log.

Also looking at things twice, fsuuid does not help testing much.
Because main blocker for testing is not the scope of the policy, but write once
policy - CONFIG_IMA_WRITE_POLICY not being set on distro kernels thus repeated
write of the policy will need reboot.

Rebooting actually might be possible sooner or later with new runltp-ng from
Andrea [1] (the feature is not here yet, but will be sooner or later). runltp-ng
is close to upstream, there was first attempt [2].

Other option would be to prepare policy which would be suitable for all tests,
with help of fsuuid. But that has drawback:
Currently we use LTP API to mount directories on loop device after test has started.
These devices are temporary, e.g.
/tmp/LTP_ima_violations.pEvyfJO7Af/mntpoint/test.txt will be unmounted and
deleted after each test run. But for fsuuid we'd need to first permanently
mount the devices to get their UUID. Therefore there would have to be some
special setup script needed to be run for all tests. This has proven to be
problematic in the past. I'd have to extend the API to create something permanent.

Other question is whether IMA is tested by anybody with different build configuration.

I also looked to kselftest, but the only tests I found are some bpf related
(bpf_ima_*_hash tests: bpf/ima_setup.sh, used by bpf/prog_tests/test_ima.c,
bpf/progs/ima.c, which require also CONFIG_IMA_WRITE_POLICY, thus not usable on
distro kernels). There are tests in ima-evm-utils, but I thought they target to test evmctl,
although that's actually some testing of whole kernel and userspace IMA.

Kind regards,
Petr

[1] https://github.com/acerv/runltp-ng
[2] https://lore.kernel.org/ltp/20221202103011.12206-1-andrea.cervesato@suse.com/

=== current master ===
# PATH="/opt/ltp/testcases/bin:$PATH" ./ima_violations.sh
type=INTEGRITY_PCR msg=audit(1670857707.178:126): pid=1438 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857707.186:127): pid=1374 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="ima_violations." name="/tmp/LTP_ima_violations.pEvyfJO7Af/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857707.190:128): pid=1441 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857707.202:129): pid=1445 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857707.206:130): pid=1374 uid=0 auid=0 ses=3 op=invalid_pcr cause=ToMToU comm="ima_violations." name="/tmp/LTP_ima_violations.pEvyfJO7Af/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857707.210:131): pid=1448 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857707.218:132): pid=1452 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857708.230:133): pid=1374 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="ima_violations." name="/tmp/LTP_ima_violations.pEvyfJO7Af/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857708.246:134): pid=1458 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
=> test passes

# PATH="/opt/ltp/testcases/bin:$PATH" ./ima_policy.sh
type=INTEGRITY_STATUS msg=audit(1670857735.235:139): pid=1476 uid=0 auid=0 ses=3 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_STATUS msg=audit(1670857735.243:140): pid=1476 uid=0 auid=0 ses=3 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.247:141): action=dont_measure fsmagic=0x9fa0 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.247:142): action=dont_measure fsmagic=0x62656572 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.247:143): action=dont_measure fsmagic=0x64626720 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.247:144): action=dont_measure fsmagic=0x01021994 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.247:145): UNKNOWN=dnt_measure res=0
type=INTEGRITY_STATUS msg=audit(1670857735.247:146): pid=1519 uid=0 auid=0 ses=3 op=update_policy cause=invalid-policy comm="cat" res=0 errno=0
type=INTEGRITY_STATUS msg=audit(1670857735.251:147): pid=1518 uid=0 auid=0 ses=3 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_STATUS msg=audit(1670857735.259:148): pid=1476 uid=0 auid=0 ses=3 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:149): action=dont_measure fsmagic=0x9fa0 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:150): action=dont_measure fsmagic=0x62656572 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:151): action=dont_measure fsmagic=0x64626720 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:152): action=dont_measure fsmagic=0x01021994 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:153): action=dont_measure fsmagic=0x73636673 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:154): action=measure func=FILE_MMAP mask=MAY_EXEC res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:155): action=measure func=BPRM_CHECK mask=MAY_EXEC res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857735.263:156): action=measure func=FILE_CHECK mask=MAY_READ uid=0 res=1
type=INTEGRITY_STATUS msg=audit(1670857735.267:157): pid=1523 uid=0 auid=0 ses=3 op=policy_update cause=completed comm="ima_policy.sh" res=1 errno=0

# PATH="/opt/ltp/testcases/bin:$PATH" ./ima_violations.sh
type=INTEGRITY_PCR msg=audit(1670857748.427:158): pid=1581 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857748.435:159): pid=1539 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="ima_violations." name="/tmp/LTP_ima_violations.F0oDEcjtAh/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857748.439:160): pid=1584 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857748.451:161): pid=1588 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857748.451:162): pid=1539 uid=0 auid=0 ses=3 op=invalid_pcr cause=ToMToU comm="ima_violations." name="/tmp/LTP_ima_violations.F0oDEcjtAh/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857748.455:163): pid=1591 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857748.467:164): pid=1595 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857749.475:165): pid=1539 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="ima_violations." name="/tmp/LTP_ima_violations.F0oDEcjtAh/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857749.487:166): pid=1601 uid=0 auid=0 ses=3 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
=> again, test passes, logs produced by ima_violations.sh are the same as were on previous run

=== your v1 patchset ===
# PATH="/opt/ltp/testcases/bin:$PATH" ./ima_violations.sh
type=INTEGRITY_PCR msg=audit(1670857298.171:130): pid=1504 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857298.179:131): pid=1434 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="ima_violations." name="/tmp/LTP_ima_violations.gLp6AVWCuS/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857298.183:132): pid=1507 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857298.191:133): pid=1511 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857298.195:134): pid=1434 uid=0 auid=0 ses=1 op=invalid_pcr cause=ToMToU comm="ima_violations." name="/tmp/LTP_ima_violations.gLp6AVWCuS/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857298.199:135): pid=1514 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857298.211:136): pid=1518 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857299.223:137): pid=1434 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="ima_violations." name="/tmp/LTP_ima_violations.gLp6AVWCuS/mntpoint/test.txt" dev="loop0" ino=6073 res=1 errno=0
type=INTEGRITY_PCR msg=audit(1670857299.235:138): pid=1524 uid=0 auid=0 ses=1 op=invalid_pcr cause=open_writers comm="grep" name="/var/log/audit/audit.log" dev="vda2" ino=8182 res=1 errno=0
=> so far so good

# PATH="/opt/ltp/testcases/bin:$PATH" ./ima_policy.sh
type=INTEGRITY_STATUS msg=audit(1670857346.435:139): pid=1541 uid=0 auid=0 ses=1 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_STATUS msg=audit(1670857346.443:140): pid=1541 uid=0 auid=0 ses=1 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.447:141): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x9fa0 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.447:142): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x62656572 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.447:143): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x64626720 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.447:144): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x01021994 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.447:145): UNKNOWN=dnt_measure res=0
type=INTEGRITY_STATUS msg=audit(1670857346.447:146): pid=1594 uid=0 auid=0 ses=1 op=update_policy cause=invalid-policy comm="sed" res=0 errno=0
type=INTEGRITY_STATUS msg=audit(1670857346.451:147): pid=1593 uid=0 auid=0 ses=1 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_STATUS msg=audit(1670857346.455:148): pid=1541 uid=0 auid=0 ses=1 op=policy_update cause=failed comm="ima_policy.sh" res=0 errno=0
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:149): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x9fa0 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:150): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x62656572 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:151): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x64626720 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:152): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x01021994 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:153): action=dont_measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa fsmagic=0x73636673 res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:154): action=measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa func=FILE_MMAP mask=MAY_EXEC res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:155): action=measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa func=BPRM_CHECK mask=MAY_EXEC res=1
type=INTEGRITY_POLICY_RULE msg=audit(1670857346.463:156): action=measure fsuuid=23a85f4a-3f53-49e4-9079-2c7e5ba1c9fa func=FILE_CHECK mask=MAY_READ uid=0 res=1
type=INTEGRITY_STATUS msg=audit(1670857346.463:157): pid=1598 uid=0 auid=0 ses=1 op=policy_update cause=completed comm="ima_policy.sh" res=1 errno=0
=> obviously, there is fsuuid=... and comm="sed" instead of comm="cat"

# PATH="/opt/ltp/testcases/bin:$PATH" ./ima_violations.sh
tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
ima_violations 1 TINFO: Formatting ext3 with opts='/dev/loop0'
ima_violations 1 TINFO: Mounting device: mount -t ext3 /dev/loop0 /tmp/LTP_ima_violations.6QLCCXonjt/mntpoint 
ima_violations 1 TINFO: timeout per run is 0h 5m 0s
ima_violations 1 TINFO: IMA kernel config:
ima_violations 1 TINFO: CONFIG_IMA=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_violations 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_violations 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_violations 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_violations 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_violations 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-6.0.7-1-default root=UUID=6de93d21-b5ed-4aa4-a9e4-00a7ab77c6d9 splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty kernel.softlockup_panic=1 resume=/dev/disk/by-uuid/570474ff-969e-41e6-883e-ecff2fd15015 mitigations=auto ignore_loglevel lsm=integrity ima_policy=tcb
ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_violations 1 TINFO: LTP IMA policy rules based on fsuuid=b1314073-12d0-49c7-bbd0-19bcbaa37182
ima_violations 1 TINFO: using log /var/log/audit/audit.log
ima_violations 1 TINFO: verify open writers violation
ima_violations 1 TFAIL: open_writers violation not added
ima_violations 2 TINFO: verify ToMToU violation
ima_violations 2 TFAIL: ToMToU violation not added
ima_violations 3 TINFO: verify open_writers using mmapped files
tst_test.c:1558: TINFO: Timeout per run is 0h 00m 30s
ima_mmap.c:38: TINFO: sleep 3s
ima_violations 3 TFAIL: open_writers violation not added
ima_mmap.c:41: TPASS: test completed
=> There is no outpout in /var/log/audit/audit.log, thus test is correct that
it fails. On a previous (good) run, 2 new violations are added to
/sys/kernel/security/ima/violations, on the following (bad) run no new
violation is added (obviously).

> thanks,

> Mimi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
