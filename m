Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2365DC4332F
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 12:51:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CD943CA5CA
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 14:51:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90A4D3CA581
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C6701A006E9
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 14:50:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DBD01F74F;
 Wed, 27 Apr 2022 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651063808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrycZzeyXmyYH7CFl+i+uePYf8MDQVe6tr1QpzUzvrA=;
 b=teIQS6kQ4rvrrYNOl+Y3KEDn13IdxVU31jSZd/5LEsY6rQkdWHKbPol2gC/VrSAy6F2/wY
 ekBm7sCRlI9Oqvc9LI29k6YJYYvOGUfB2rZn9kUUluoF06IjyNbOrZVt8RVY/6Omem49OP
 7EunlFpkCENqaWH5UwuQQSajQUubKp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651063808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrycZzeyXmyYH7CFl+i+uePYf8MDQVe6tr1QpzUzvrA=;
 b=+ZYf1y9hkxa+Pv+h6Yt0CDRi+ifoI629eM6r8z9WViUhZbe9iqi16eT8CKsD07H3nj8/MR
 Of2J+9aSqhygnwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D20A81323E;
 Wed, 27 Apr 2022 12:50:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SAZIMv87aWK5RgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 12:50:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Apr 2022 14:50:02 +0200
Message-Id: <20220427125003.20815-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427125003.20815-1-pvorel@suse.cz>
References: <20220427125003.20815-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/5] tst_test.sh: Cleanup getopts usage
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_test.sh used getopts twice, but the real parsing was on tst_run().
For tst_net.sh (or other libs) will be useful if there is only single
parsing at the end of tst_test.sh, i.e. before entering tst_run().

This requires to move loading tst_test.sh to the end of the script
(before calling tst_run()).

Changing loading tst_test.sh (or other shell libraries) in other shell
libraries is not necessary (unless shell library defines a cleanup
function), but move sourcing to the end of the file to follow the
convention.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* zram01.sh: remove duplicate load of zram_lib.sh
* don't change rup01.sh, rusers01.sh

 lib/newlib_tests/shell/net/tst_ipaddr_un.sh   |  2 +-
 lib/newlib_tests/shell/net/tst_rhost_run.sh   |  2 +-
 lib/newlib_tests/shell/timeout01.sh           |  2 +-
 lib/newlib_tests/shell/timeout02.sh           |  2 +-
 lib/newlib_tests/shell/timeout03.sh           |  2 +-
 lib/newlib_tests/shell/timeout04.sh           |  2 +-
 lib/newlib_tests/shell/tst_check_driver.sh    |  2 +-
 lib/newlib_tests/shell/tst_check_kconfig01.sh |  3 +-
 lib/newlib_tests/shell/tst_check_kconfig02.sh |  2 +-
 lib/newlib_tests/shell/tst_check_kconfig03.sh |  2 +-
 lib/newlib_tests/shell/tst_check_kconfig04.sh |  2 +-
 lib/newlib_tests/shell/tst_check_kconfig05.sh |  2 +-
 lib/newlib_tests/shell/tst_format_device.sh   |  2 +-
 testcases/commands/ar/ar01.sh                 |  3 +-
 testcases/commands/cp/cp_tests.sh             |  2 +-
 testcases/commands/cpio/cpio_tests.sh         |  3 +-
 testcases/commands/df/df01.sh                 |  2 +-
 testcases/commands/du/du01.sh                 |  2 +-
 testcases/commands/eject/eject-tests.sh       |  2 +-
 testcases/commands/file/file01.sh             |  3 +-
 testcases/commands/gdb/gdb01.sh               |  3 +-
 testcases/commands/gzip/gzip_tests.sh         |  2 +-
 testcases/commands/insmod/insmod01.sh         |  2 +-
 testcases/commands/keyctl/keyctl01.sh         |  2 +-
 testcases/commands/ld/ld01.sh                 |  2 +-
 testcases/commands/ldd/ldd01.sh               |  2 +-
 testcases/commands/ln/ln_tests.sh             |  2 +-
 testcases/commands/lsmod/lsmod01.sh           |  2 +-
 testcases/commands/mkdir/mkdir_tests.sh       |  2 +-
 testcases/commands/mkfs/mkfs01.sh             |  2 +-
 testcases/commands/mkswap/mkswap01.sh         |  2 +-
 testcases/commands/mv/mv_tests.sh             |  2 +-
 testcases/commands/nm/nm01.sh                 |  2 +-
 testcases/commands/shell/shell_pipe01.sh      |  3 +-
 testcases/commands/sysctl/sysctl01.sh         |  3 +-
 testcases/commands/sysctl/sysctl02.sh         |  4 +-
 testcases/commands/tar/tar_tests.sh           |  3 +-
 testcases/commands/unshare/unshare01.sh       |  2 +-
 testcases/commands/unzip/unzip01.sh           |  2 +-
 testcases/commands/vmcp/vmcp_m.sh             |  3 +-
 testcases/commands/wc/wc01.sh                 |  2 +-
 testcases/commands/which/which01.sh           |  2 +-
 testcases/kernel/connectors/pec/cn_pec.sh     |  3 +-
 .../kernel/containers/netns/netns_breakns.sh  | 11 ++--
 .../kernel/containers/netns/netns_comm.sh     | 11 ++--
 .../kernel/containers/netns/netns_helper.sh   |  3 +-
 .../kernel/containers/netns/netns_sysfs.sh    |  3 +-
 .../cgroup/cgroup_regression_test.sh          |  5 +-
 testcases/kernel/controllers/cgroup_lib.sh    |  6 +-
 .../kernel/controllers/cpuacct/cpuacct.sh     |  3 +-
 .../cpuset/cpuset_regression_test.sh          |  4 +-
 .../memcg/functional/memcg_failcnt.sh         |  2 +-
 .../memcg/functional/memcg_force_empty.sh     |  2 +-
 .../controllers/memcg/functional/memcg_lib.sh | 60 +++++++++----------
 .../memcg/functional/memcg_limit_in_bytes.sh  |  2 +-
 .../memcg_max_usage_in_bytes_test.sh          |  2 +-
 .../memcg_memsw_limit_in_bytes_test.sh        |  2 +-
 .../memcg_move_charge_at_immigrate_test.sh    |  2 +-
 .../memcg/functional/memcg_stat_rss.sh        |  2 +-
 .../memcg/functional/memcg_stat_test.sh       |  2 +-
 .../memcg/functional/memcg_subgroup_charge.sh |  2 +-
 .../functional/memcg_usage_in_bytes_test.sh   |  2 +-
 .../functional/memcg_use_hierarchy_test.sh    |  2 +-
 .../memcg/stress/memcg_stress_test.sh         |  5 +-
 testcases/kernel/controllers/pids/pids.sh     |  3 +-
 .../kernel/device-drivers/rcu/rcu_torture.sh  |  3 +-
 .../kernel/device-drivers/zram/zram01.sh      |  4 +-
 .../kernel/device-drivers/zram/zram02.sh      |  2 +-
 .../kernel/device-drivers/zram/zram_lib.sh    |  3 +-
 .../kernel/fs/binfmt_misc/binfmt_misc01.sh    |  2 +-
 .../kernel/fs/binfmt_misc/binfmt_misc02.sh    |  2 +-
 .../kernel/fs/binfmt_misc/binfmt_misc_lib.sh  |  4 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind01.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind02.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind03.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind04.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind05.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind06.sh |  2 +-
 .../kernel/fs/fs_bind/bind/fs_bind07-2.sh     |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind07.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind08.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind09.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind10.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind11.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind12.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind13.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind14.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind15.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind16.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind17.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind18.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind19.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind20.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind21.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind22.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind23.sh |  2 +-
 testcases/kernel/fs/fs_bind/bind/fs_bind24.sh |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh   |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh   |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh   |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh   |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh   |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh   |  2 +-
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh   |  2 +-
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh    |  7 +--
 .../kernel/fs/fs_bind/fs_bind_regression.sh   |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move01.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move02.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move03.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move04.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move05.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move06.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move07.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move08.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move09.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move10.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move11.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move12.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move13.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move14.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move15.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move16.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move17.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move18.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move19.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move20.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move21.sh  |  2 +-
 .../kernel/fs/fs_bind/move/fs_bind_move22.sh  |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind01.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind02.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind03.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind04.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind05.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind06.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind07-2.sh     |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind07.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind08.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind09.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind10.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind11.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind12.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind13.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind14.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind15.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind16.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind17.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind18.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind19.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind20.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind21.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind22.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind23.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind24.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind25.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind26.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind27.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind28.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind29.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind30.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind31.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind32.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind33.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind34.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind35.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind36.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind37.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind38.sh       |  2 +-
 .../fs/fs_bind/rbind/fs_bind_rbind39.sh       |  2 +-
 testcases/kernel/fs/iso9660/isofs.sh          |  3 +-
 testcases/kernel/fs/linktest/linktest.sh      |  3 +-
 .../fs/quota_remount/quota_remount_test01.sh  |  3 +-
 testcases/kernel/mem/vma/vma05.sh             |  3 +-
 testcases/kernel/numa/numa01.sh               |  3 +-
 .../integrity/ima/tests/evm_overlay.sh        |  2 +-
 .../integrity/ima/tests/ima_conditionals.sh   |  3 +-
 .../security/integrity/ima/tests/ima_kexec.sh |  3 +-
 .../security/integrity/ima/tests/ima_keys.sh  |  4 +-
 .../integrity/ima/tests/ima_measurements.sh   |  3 +-
 .../integrity/ima/tests/ima_policy.sh         |  3 +-
 .../integrity/ima/tests/ima_selinux.sh        |  3 +-
 .../security/integrity/ima/tests/ima_setup.sh |  4 +-
 .../security/integrity/ima/tests/ima_tpm.sh   |  3 +-
 .../integrity/ima/tests/ima_violations.sh     |  5 +-
 .../tracing/dynamic_debug/dynamic_debug01.sh  |  5 +-
 testcases/lib/tst_net.sh                      |  5 +-
 testcases/lib/tst_test.sh                     | 29 ++++-----
 testcases/misc/lvm/cleanup_lvm.sh             |  2 +-
 testcases/misc/lvm/generate_lvm_runfile.sh    |  2 +-
 testcases/misc/lvm/prepare_lvm.sh             |  2 +-
 testcases/network/busy_poll/busy_poll01.sh    |  3 +-
 testcases/network/busy_poll/busy_poll02.sh    |  3 +-
 testcases/network/busy_poll/busy_poll03.sh    |  3 +-
 testcases/network/busy_poll/busy_poll_lib.sh  |  4 +-
 testcases/network/dccp/dccp01.sh              |  2 +-
 testcases/network/dhcp/dhcp_lib.sh            |  6 +-
 testcases/network/dhcp/dhcpd_tests.sh         |  6 +-
 testcases/network/dhcp/dnsmasq_tests.sh       | 28 ++++-----
 testcases/network/iproute/ip_tests.sh         |  2 +-
 testcases/network/iptables/iptables01.sh      |  1 -
 testcases/network/iptables/iptables_lib.sh    |  5 +-
 testcases/network/iptables/nft01.sh           |  3 +-
 testcases/network/mpls/mpls01.sh              |  2 +-
 testcases/network/mpls/mpls02.sh              |  3 +-
 testcases/network/mpls/mpls03.sh              |  5 +-
 testcases/network/mpls/mpls04.sh              |  5 +-
 testcases/network/mpls/mpls_lib.sh            |  4 +-
 .../network/multicast/mc_cmds/mc_cmds.sh      |  6 +-
 .../network/multicast/mc_commo/mc_commo.sh    |  5 +-
 .../network/multicast/mc_member/mc_member.sh  |  6 +-
 testcases/network/nfs/fsx-linux/fsx.sh        |  3 +-
 testcases/network/nfs/nfs_stress/nfs01.sh     |  3 +-
 testcases/network/nfs/nfs_stress/nfs02.sh     |  3 +-
 testcases/network/nfs/nfs_stress/nfs03.sh     |  3 +-
 testcases/network/nfs/nfs_stress/nfs04.sh     |  2 +-
 testcases/network/nfs/nfs_stress/nfs05.sh     |  3 +-
 testcases/network/nfs/nfs_stress/nfs06.sh     |  2 +-
 testcases/network/nfs/nfs_stress/nfs07.sh     |  8 +--
 testcases/network/nfs/nfs_stress/nfs_lib.sh   |  5 +-
 testcases/network/nfs/nfslock01/nfslock01.sh  |  3 +-
 testcases/network/nfs/nfsstat01/nfsstat01.sh  |  3 +-
 .../network/rpc/basic_tests/rpc01/rpc01.sh    |  2 +-
 testcases/network/rpc/basic_tests/rpc_lib.sh  |  5 +-
 .../rpc/basic_tests/rpcinfo/rpcinfo01.sh      |  2 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh   |  2 +-
 testcases/network/sctp/sctp01.sh              |  2 +-
 testcases/network/sockets/bind_noport01.sh    |  2 +-
 .../stress/broken_ip/broken_ip-checksum.sh    |  2 +-
 .../stress/broken_ip/broken_ip-dstaddr.sh     |  2 +-
 .../stress/broken_ip/broken_ip-fragment.sh    |  2 +-
 .../network/stress/broken_ip/broken_ip-ihl.sh |  2 +-
 .../stress/broken_ip/broken_ip-nexthdr.sh     | 10 ++--
 .../stress/broken_ip/broken_ip-plen.sh        |  2 +-
 .../stress/broken_ip/broken_ip-protcol.sh     |  2 +-
 .../stress/broken_ip/broken_ip-version.sh     |  2 +-
 testcases/network/stress/dccp/dccp_ipsec.sh   |  4 +-
 .../network/stress/dccp/dccp_ipsec_vti.sh     |  4 +-
 testcases/network/stress/dns/dns-stress.sh    |  6 +-
 .../network/stress/ftp/ftp-download-stress.sh |  4 +-
 .../network/stress/ftp/ftp-upload-stress.sh   |  4 +-
 testcases/network/stress/http/http-stress.sh  |  4 +-
 .../network/stress/icmp/icmp-uni-basic.sh     |  4 +-
 testcases/network/stress/icmp/icmp-uni-vti.sh |  4 +-
 .../stress/interface/if-addr-adddel.sh        |  4 +-
 .../stress/interface/if-addr-addlarge.sh      |  4 +-
 testcases/network/stress/interface/if-lib.sh  |  5 +-
 .../network/stress/interface/if-mtu-change.sh |  4 +-
 .../stress/interface/if-route-adddel.sh       |  4 +-
 .../stress/interface/if-route-addlarge.sh     |  4 +-
 .../network/stress/interface/if-updown.sh     |  4 +-
 .../stress/interface/if4-addr-change.sh       |  2 +-
 testcases/network/stress/ipsec/ipsec_lib.sh   | 15 ++---
 .../mcast-group-multiple-socket.sh            |  2 +-
 .../grp-operation/mcast-group-same-group.sh   |  2 +-
 .../mcast-group-single-socket.sh              |  2 +-
 .../mcast-group-source-filter.sh              |  2 +-
 .../multicast/grp-operation/mcast-lib.sh      |  6 +-
 .../multicast/packet-flood/mcast-pktfld01.sh  |  2 +-
 .../multicast/packet-flood/mcast-pktfld02.sh  |  2 +-
 .../multicast/query-flood/mcast-queryfld01.sh |  2 +-
 .../multicast/query-flood/mcast-queryfld02.sh |  2 +-
 .../multicast/query-flood/mcast-queryfld03.sh |  2 +-
 .../multicast/query-flood/mcast-queryfld04.sh |  2 +-
 .../multicast/query-flood/mcast-queryfld05.sh |  2 +-
 .../multicast/query-flood/mcast-queryfld06.sh |  2 +-
 .../network/stress/ns-tools/tst_net_stress.sh |  4 +-
 .../network/stress/route/route-change-dst.sh  |  6 +-
 .../network/stress/route/route-change-gw.sh   |  6 +-
 .../network/stress/route/route-change-if.sh   |  6 +-
 .../stress/route/route-change-netlink-dst.sh  |  4 +-
 .../stress/route/route-change-netlink-gw.sh   |  4 +-
 .../stress/route/route-change-netlink-if.sh   |  4 +-
 testcases/network/stress/route/route-lib.sh   |  5 +-
 .../network/stress/route/route-redirect.sh    |  4 +-
 testcases/network/stress/sctp/sctp_ipsec.sh   |  4 +-
 .../network/stress/sctp/sctp_ipsec_vti.sh     |  4 +-
 testcases/network/stress/ssh/ssh-stress.sh    |  2 +-
 testcases/network/stress/tcp/tcp_ipsec.sh     |  4 +-
 testcases/network/stress/tcp/tcp_ipsec_vti.sh |  4 +-
 testcases/network/stress/udp/udp_ipsec.sh     |  4 +-
 testcases/network/stress/udp/udp_ipsec_vti.sh |  4 +-
 testcases/network/tcp_cc/bbr01.sh             |  3 +-
 testcases/network/tcp_cc/bbr02.sh             |  4 +-
 testcases/network/tcp_cc/dctcp01.sh           |  3 +-
 testcases/network/tcp_cc/tcp_cc_lib.sh        |  5 +-
 testcases/network/tcp_cmds/arping/arping01.sh |  2 +-
 .../network/tcp_cmds/clockdiff/clockdiff01.sh |  2 +-
 testcases/network/tcp_cmds/host/host01.sh     |  2 +-
 .../network/tcp_cmds/ipneigh/ipneigh01.sh     |  2 +-
 .../network/tcp_cmds/netstat/netstat01.sh     |  2 +-
 testcases/network/tcp_cmds/ping/ping01.sh     |  2 +-
 testcases/network/tcp_cmds/ping/ping02.sh     |  2 +-
 .../network/tcp_cmds/sendfile/sendfile01.sh   |  2 +-
 testcases/network/tcp_cmds/tc/tc01.sh         |  3 +-
 .../network/tcp_cmds/tcpdump/tcpdump01.sh     |  3 +-
 testcases/network/tcp_cmds/telnet/telnet01.sh |  3 +-
 .../network/tcp_cmds/tracepath/tracepath01.sh |  2 +-
 .../network/tcp_fastopen/tcp_fastopen_run.sh  |  2 +-
 testcases/network/traceroute/traceroute01.sh  |  2 +-
 testcases/network/virt/fou01.sh               |  2 +-
 testcases/network/virt/geneve01.sh            |  9 ++-
 testcases/network/virt/geneve02.sh            | 14 ++---
 testcases/network/virt/gre01.sh               |  2 +-
 testcases/network/virt/gre02.sh               |  2 +-
 testcases/network/virt/ipvlan01.sh            |  2 +-
 testcases/network/virt/macsec01.sh            |  1 -
 testcases/network/virt/macsec02.sh            |  1 -
 testcases/network/virt/macsec03.sh            |  3 +-
 testcases/network/virt/macsec_lib.sh          |  5 +-
 testcases/network/virt/macvlan01.sh           |  2 +-
 testcases/network/virt/macvtap01.sh           |  2 +-
 testcases/network/virt/sit01.sh               |  2 +-
 testcases/network/virt/virt_lib.sh            | 36 +++++------
 testcases/network/virt/vlan01.sh              |  2 +-
 testcases/network/virt/vlan02.sh              |  2 +-
 testcases/network/virt/vlan03.sh              |  2 +-
 testcases/network/virt/vxlan01.sh             |  9 ++-
 testcases/network/virt/vxlan02.sh             |  5 +-
 testcases/network/virt/vxlan03.sh             |  2 +-
 testcases/network/virt/vxlan04.sh             |  2 +-
 testcases/network/virt/wireguard01.sh         |  3 +-
 testcases/network/virt/wireguard02.sh         |  6 +-
 testcases/network/virt/wireguard_lib.sh       |  4 +-
 testcases/network/xinetd/xinetd_tests.sh      |  2 +-
 323 files changed, 500 insertions(+), 570 deletions(-)

diff --git a/lib/newlib_tests/shell/net/tst_ipaddr_un.sh b/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
index e7730b8d0..76875e2b5 100755
--- a/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
+++ b/lib/newlib_tests/shell/net/tst_ipaddr_un.sh
@@ -13,7 +13,6 @@ TST_NET_SKIP_VARIABLE_INIT=1
 IPV4_NET16_UNUSED="10.23"
 IPV6_NET32_UNUSED="fd00:23"
 
-. tst_net.sh
 
 IPV4_DATA="
 0 0|10.23.0.0
@@ -168,4 +167,5 @@ do_test()
 	esac
 }
 
+. tst_net.sh
 tst_run
diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
index 119247f8e..773b8dd33 100755
--- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
+++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
@@ -4,7 +4,6 @@
 
 TST_TESTFUNC=do_test
 PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
-. tst_net.sh
 
 export TST_NET_RHOST_RUN_DEBUG=1
 
@@ -24,4 +23,5 @@ do_test()
 	tst_res TPASS "tst_rhost_run is working"
 }
 
+. tst_net.sh
 tst_run
diff --git a/lib/newlib_tests/shell/timeout01.sh b/lib/newlib_tests/shell/timeout01.sh
index 8f0971ac2..6945f612e 100755
--- a/lib/newlib_tests/shell/timeout01.sh
+++ b/lib/newlib_tests/shell/timeout01.sh
@@ -5,11 +5,11 @@
 TST_TESTFUNC=do_test
 
 TST_TIMEOUT=-1
-. tst_test.sh
 
 do_test()
 {
 	tst_res TPASS "timeout $TST_TIMEOUT set"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/timeout02.sh b/lib/newlib_tests/shell/timeout02.sh
index 47e7a2d41..cc8cce5d9 100755
--- a/lib/newlib_tests/shell/timeout02.sh
+++ b/lib/newlib_tests/shell/timeout02.sh
@@ -5,11 +5,11 @@
 TST_TESTFUNC=do_test
 
 TST_TIMEOUT=2
-. tst_test.sh
 
 do_test()
 {
 	tst_res TPASS "timeout $TST_TIMEOUT set (LTP_TIMEOUT_MUL='$LTP_TIMEOUT_MUL')"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/timeout03.sh b/lib/newlib_tests/shell/timeout03.sh
index eec2d40bc..811ce7565 100755
--- a/lib/newlib_tests/shell/timeout03.sh
+++ b/lib/newlib_tests/shell/timeout03.sh
@@ -28,7 +28,6 @@ TST_TESTFUNC=do_test
 TST_CLEANUP=cleanup
 
 TST_TIMEOUT=1
-. tst_test.sh
 
 do_test()
 {
@@ -46,4 +45,5 @@ cleanup()
 	tst_res TFAIL "cleanup: running after TST_TIMEOUT"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/timeout04.sh b/lib/newlib_tests/shell/timeout04.sh
index c702905f3..eb41c2c4f 100755
--- a/lib/newlib_tests/shell/timeout04.sh
+++ b/lib/newlib_tests/shell/timeout04.sh
@@ -5,7 +5,6 @@
 TST_TESTFUNC=do_test
 
 TST_TIMEOUT=1
-. tst_test.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_cleanup()
     tst_res TINFO "cleanup"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_check_driver.sh b/lib/newlib_tests/shell/tst_check_driver.sh
index d188b6f77..c43ec3199 100755
--- a/lib/newlib_tests/shell/tst_check_driver.sh
+++ b/lib/newlib_tests/shell/tst_check_driver.sh
@@ -6,7 +6,6 @@ TST_TESTFUNC=test
 TST_SETUP=setup
 TST_CNT=3
 TST_NEEDS_CMDS="tst_check_drivers find grep head sed"
-. tst_test.sh
 
 MODULES_DIR="${MODULES_DIR:-/lib/modules/$(uname -r)}"
 
@@ -60,4 +59,5 @@ test3()
 	test_drivers $(grep -E '_[^/]+\.ko' $f | head -3)
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig01.sh b/lib/newlib_tests/shell/tst_check_kconfig01.sh
index 03f86266d..c80b8923a 100755
--- a/lib/newlib_tests/shell/tst_check_kconfig01.sh
+++ b/lib/newlib_tests/shell/tst_check_kconfig01.sh
@@ -5,11 +5,10 @@
 TST_TESTFUNC=do_test
 TST_NEEDS_KCONFIGS="CONFIG_EXT4"
 
-. tst_test.sh
-
 do_test()
 {
 	tst_res TFAIL "kernel .config doesn't have CONFIG_EXT4"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig02.sh b/lib/newlib_tests/shell/tst_check_kconfig02.sh
index 6a20cfc3d..5bdb98413 100755
--- a/lib/newlib_tests/shell/tst_check_kconfig02.sh
+++ b/lib/newlib_tests/shell/tst_check_kconfig02.sh
@@ -4,11 +4,11 @@
 
 TST_TESTFUNC=do_test
 TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
-. tst_test.sh
 
 do_test()
 {
 	tst_res TFAIL "invalid kconfig delimter"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig03.sh b/lib/newlib_tests/shell/tst_check_kconfig03.sh
index 361b6bf0b..1dcc14a81 100755
--- a/lib/newlib_tests/shell/tst_check_kconfig03.sh
+++ b/lib/newlib_tests/shell/tst_check_kconfig03.sh
@@ -5,11 +5,11 @@
 TST_TESTFUNC=do_test
 TST_NEEDS_KCONFIGS="CONFIG_EXT4_FS : CONFIG_XFS_FS"
 TST_NEEDS_KCONFIGS_IFS=":"
-. tst_test.sh
 
 do_test()
 {
 	tst_res TPASS "valid kconfig delimter"
 }
 
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig04.sh b/lib/newlib_tests/shell/tst_check_kconfig04.sh
index 21cd998dd..522b3a8dc 100755
--- a/lib/newlib_tests/shell/tst_check_kconfig04.sh
+++ b/lib/newlib_tests/shell/tst_check_kconfig04.sh
@@ -3,7 +3,6 @@
 # Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
 
 TST_TESTFUNC=do_test
-. tst_test.sh
 
 do_test()
 {
@@ -21,4 +20,5 @@ do_test()
 		tst_res TPASS "kernel .config doesn't have CONFIG_EXT4"
 	fi
 }
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_check_kconfig05.sh b/lib/newlib_tests/shell/tst_check_kconfig05.sh
index f118f27a5..045995c84 100755
--- a/lib/newlib_tests/shell/tst_check_kconfig05.sh
+++ b/lib/newlib_tests/shell/tst_check_kconfig05.sh
@@ -3,7 +3,6 @@
 # Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
 
 TST_TESTFUNC=do_test
-. tst_test.sh
 
 do_test()
 {
@@ -13,4 +12,5 @@ do_test()
 	tst_require_kconfigs "CONFIG_EXT4"
 	tst_res TFAIL "kernel .config has CONFIG_EXT4"
 }
+. tst_test.sh
 tst_run
diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
index 7bd6f17d7..3a527c92e 100755
--- a/lib/newlib_tests/shell/tst_format_device.sh
+++ b/lib/newlib_tests/shell/tst_format_device.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC=test
 TST_CNT=2
 TST_DEV_FS_OPTS="-b 1024 -O quota"
 TST_DEV_EXTRA_OPTS="5m"
-. tst_test.sh
 
 test1()
 {
@@ -20,4 +19,5 @@ test2()
 	EXPECT_PASS "df $TST_DEVICE | grep -q /dev"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/ar/ar01.sh b/testcases/commands/ar/ar01.sh
index b4af622af..943944d21 100644
--- a/testcases/commands/ar/ar01.sh
+++ b/testcases/commands/ar/ar01.sh
@@ -13,8 +13,6 @@ TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="$AR"
 
-. tst_test.sh
-
 setup()
 {
 	MOD=
@@ -348,4 +346,5 @@ test17()
 	ROD rm -f lib.a file2.in
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/cp/cp_tests.sh b/testcases/commands/cp/cp_tests.sh
index 9a6590e99..7ca457f52 100755
--- a/testcases/commands/cp/cp_tests.sh
+++ b/testcases/commands/cp/cp_tests.sh
@@ -10,7 +10,6 @@ TST_CNT=5
 TST_TESTFUNC=do_test
 TST_SETUP=setup
 TST_NEEDS_TMPDIR=1
-. tst_test.sh
 
 create_tree()
 {
@@ -91,4 +90,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/cpio/cpio_tests.sh b/testcases/commands/cpio/cpio_tests.sh
index a98b7eca7..458c21370 100755
--- a/testcases/commands/cpio/cpio_tests.sh
+++ b/testcases/commands/cpio/cpio_tests.sh
@@ -8,8 +8,6 @@ TST_TESTFUNC=cpio_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="cpio"
 TST_SETUP="setup"
-. tst_test.sh
-
 
 setup()
 {
@@ -47,4 +45,5 @@ cpio_test()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 86df94086..f74032c96 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -14,7 +14,6 @@ TST_USAGE=usage
 TST_PARSE_ARGS=parse_args
 TST_NEEDS_ROOT=1
 TST_FORMAT_DEVICE=1
-. tst_test.sh
 
 usage()
 {
@@ -192,4 +191,5 @@ test12()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 1f0df959f..274e32a4e 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -10,7 +10,6 @@ TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="dd du stat"
-. tst_test.sh
 
 setup()
 {
@@ -108,4 +107,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/eject/eject-tests.sh b/testcases/commands/eject/eject-tests.sh
index 299b9fa06..7b916cfb6 100755
--- a/testcases/commands/eject/eject-tests.sh
+++ b/testcases/commands/eject/eject-tests.sh
@@ -13,7 +13,6 @@ TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="eject"
-. tst_test.sh
 
 setup()
 {
@@ -144,4 +143,5 @@ test4()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
index ff1e0817c..df152b656 100755
--- a/testcases/commands/file/file01.sh
+++ b/testcases/commands/file/file01.sh
@@ -13,8 +13,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="readelf"
 
-. tst_test.sh
-
 setup()
 {
 	case $(readelf -h /bin/sh) in
@@ -90,4 +88,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/gdb/gdb01.sh b/testcases/commands/gdb/gdb01.sh
index 04259c511..24acb98f6 100755
--- a/testcases/commands/gdb/gdb01.sh
+++ b/testcases/commands/gdb/gdb01.sh
@@ -8,8 +8,6 @@
 TST_TESTFUNC=simple_test
 TST_NEEDS_CMDS="gdb /bin/cat"
 
-. tst_test.sh
-
 simple_test()
 {
 	gdb /bin/cat -ex "run /etc/passwd" -ex quit < /dev/null
@@ -21,4 +19,5 @@ simple_test()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index f4e336640..fdc933ea2 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -14,7 +14,6 @@ TST_CNT=2
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="gzip gunzip"
-. tst_test.sh
 
 creat_dirnfiles()
 {
@@ -149,4 +148,5 @@ test2()
 	ROD_SILENT rm -rf tst_gzip.tmp/
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
index e7c3d6fae..1881ba389 100755
--- a/testcases/commands/insmod/insmod01.sh
+++ b/testcases/commands/insmod/insmod01.sh
@@ -10,7 +10,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="rmmod insmod"
 TST_NEEDS_MODULE="ltp_insmod01.ko"
-. tst_test.sh
 
 inserted=0
 
@@ -46,4 +45,5 @@ do_test()
 	tst_res TPASS "insmod passed"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 0858b6867..7b357a71e 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -18,7 +18,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="keyctl"
-. tst_test.sh
 
 check_keyctl()
 {
@@ -109,4 +108,5 @@ do_test()
 	tst_res TPASS "Bug not reproduced"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/ld/ld01.sh b/testcases/commands/ld/ld01.sh
index 0a598ec3a..c8ba4fc1c 100755
--- a/testcases/commands/ld/ld01.sh
+++ b/testcases/commands/ld/ld01.sh
@@ -14,7 +14,6 @@ TST_TESTFUNC=test
 TST_SETUP=setup
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="$CC $LD"
-. tst_test.sh
 
 setup()
 {
@@ -78,4 +77,5 @@ test5()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/ldd/ldd01.sh b/testcases/commands/ldd/ldd01.sh
index 8d7965a5b..1f5a75741 100755
--- a/testcases/commands/ldd/ldd01.sh
+++ b/testcases/commands/ldd/ldd01.sh
@@ -8,7 +8,6 @@
 TST_CNT=2
 TST_SETUP=setup
 TST_TESTFUNC=test
-. tst_test.sh
 
 LDD=${LDD:=ldd}
 
@@ -39,4 +38,5 @@ test2()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/ln/ln_tests.sh b/testcases/commands/ln/ln_tests.sh
index ecf7bf5b7..5bcf827cd 100755
--- a/testcases/commands/ln/ln_tests.sh
+++ b/testcases/commands/ln/ln_tests.sh
@@ -10,7 +10,6 @@ TST_CNT=6
 TST_TESTFUNC=do_test
 TST_SETUP=setup
 TST_NEEDS_TMPDIR=1
-. tst_test.sh
 
 setup()
 {
@@ -78,4 +77,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 38182a657..8b7a0a794 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -11,7 +11,6 @@ TST_SETUP=setup
 TST_TESTFUNC=lsmod_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="lsmod"
-. tst_test.sh
 
 module_inserted=
 
@@ -82,4 +81,5 @@ lsmod_test()
 	tst_res TFAIL "'lsmod' doesn't match /proc/modules output"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/mkdir/mkdir_tests.sh b/testcases/commands/mkdir/mkdir_tests.sh
index 0e88a830a..c0a570e5c 100755
--- a/testcases/commands/mkdir/mkdir_tests.sh
+++ b/testcases/commands/mkdir/mkdir_tests.sh
@@ -9,7 +9,6 @@ TST_CNT=3
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
-. tst_test.sh
 
 setup()
 {
@@ -50,4 +49,5 @@ test3()
 	ROD rm -rf "$LONG_PATH"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index a3ff027a6..64f952dca 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -14,7 +14,6 @@ TST_PARSE_ARGS=parse_args
 TST_NEEDS_ROOT=1
 TST_NEEDS_DEVICE=1
 TST_NEEDS_CMDS="blkid df"
-. tst_test.sh
 
 usage()
 {
@@ -174,4 +173,5 @@ test5()
 	mkfs_test "-h"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index ed6efa43d..fe1695876 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -11,7 +11,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_DEVICE=1
 TST_NEEDS_CMDS="uuidgen blkid blockdev mkswap"
-. tst_test.sh
 
 setup()
 {
@@ -158,4 +157,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/mv/mv_tests.sh b/testcases/commands/mv/mv_tests.sh
index 253b273a8..91648dd8f 100755
--- a/testcases/commands/mv/mv_tests.sh
+++ b/testcases/commands/mv/mv_tests.sh
@@ -13,7 +13,6 @@ TST_CNT=2
 TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
-. tst_test.sh
 
 setup()
 {
@@ -149,4 +148,5 @@ test2()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/nm/nm01.sh b/testcases/commands/nm/nm01.sh
index 873126d20..c795d47ff 100755
--- a/testcases/commands/nm/nm01.sh
+++ b/testcases/commands/nm/nm01.sh
@@ -13,7 +13,6 @@ TST_TESTFUNC=test
 TST_SETUP=setup
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="$NM"
-. tst_test.sh
 
 setup()
 {
@@ -121,4 +120,5 @@ test7()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/shell/shell_pipe01.sh b/testcases/commands/shell/shell_pipe01.sh
index 3c8ef49fb..f384aa8a9 100755
--- a/testcases/commands/shell/shell_pipe01.sh
+++ b/testcases/commands/shell/shell_pipe01.sh
@@ -4,8 +4,6 @@
 
 TST_TESTFUNC=do_test
 
-. tst_test.sh
-
 do_test()
 {
 	tst_res TINFO "expecting SUCCESS string passed from stdin"
@@ -14,4 +12,5 @@ do_test()
 	EXPECT_PASS [ "$line" = "SUCCESS" ]
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
index d885cb1a4..d58688e0d 100755
--- a/testcases/commands/sysctl/sysctl01.sh
+++ b/testcases/commands/sysctl/sysctl01.sh
@@ -13,8 +13,6 @@ TST_TESTFUNC=sysctl_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl"
 
-. tst_test.sh
-
 sysctl_test()
 {
 	# With commit d00535d, sched_time_avg was renamed as sched_time_avg_ms
@@ -38,4 +36,5 @@ sysctl_test()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/sysctl/sysctl02.sh b/testcases/commands/sysctl/sysctl02.sh
index 367cd5743..806dd1fd8 100755
--- a/testcases/commands/sysctl/sysctl02.sh
+++ b/testcases/commands/sysctl/sysctl02.sh
@@ -21,11 +21,10 @@ TST_CNT=4
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl"
 TST_NEEDS_KCONFIGS="CONFIG_SYSCTL=y, CONFIG_PROC_FS=y"
+
 sys_name="fs.file-max"
 sys_file="/proc/sys/fs/file-max"
 
-. tst_test.sh
-
 setup()
 {
 	orig_value=$(cat "$sys_file")
@@ -77,4 +76,5 @@ cleanup()
 	[ -n "$orig_value" ] && sysctl -w -q $sys_name=$orig_value
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
index f90ff216c..60520188c 100755
--- a/testcases/commands/tar/tar_tests.sh
+++ b/testcases/commands/tar/tar_tests.sh
@@ -11,8 +11,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="gzip bzip2"
 
-. tst_test.sh
-
 TAR_FILES="file1 file2 file3"
 
 check_listing()
@@ -133,4 +131,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/unshare/unshare01.sh b/testcases/commands/unshare/unshare01.sh
index bf163a7f4..5c67d0eed 100755
--- a/testcases/commands/unshare/unshare01.sh
+++ b/testcases/commands/unshare/unshare01.sh
@@ -33,7 +33,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="unshare id mount umount"
-. tst_test.sh
 
 max_userns_path="/proc/sys/user/max_user_namespaces"
 max_mntns_path="/proc/sys/user/max_mnt_namespaces"
@@ -157,4 +156,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/unzip/unzip01.sh b/testcases/commands/unzip/unzip01.sh
index c3bb75730..2408942af 100755
--- a/testcases/commands/unzip/unzip01.sh
+++ b/testcases/commands/unzip/unzip01.sh
@@ -10,7 +10,6 @@ TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="unzip"
-. tst_test.sh
 
 EXTRACT_MATCH="extracting"
 
@@ -83,4 +82,5 @@ do_test()
 	ROD rm -rf "dir/"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
index 5dc7bf0d6..3924a6e11 100644
--- a/testcases/commands/vmcp/vmcp_m.sh
+++ b/testcases/commands/vmcp/vmcp_m.sh
@@ -14,7 +14,6 @@
 TST_CNT=2
 TST_TESTFUNC=vmcp_main
 TST_NEEDS_CMDS="vmcp"
-. tst_test.sh
 
 vmcp_run()
 {
@@ -45,5 +44,5 @@ vmcp_main2()
         vmcp_run 1 "vmcp dasddasddasd"
 }
 
-
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
index ee12e2b71..b37cb47c6 100755
--- a/testcases/commands/wc/wc01.sh
+++ b/testcases/commands/wc/wc01.sh
@@ -10,7 +10,6 @@ TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="wc"
-. tst_test.sh
 
 setup()
 {
@@ -67,4 +66,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
index dd6659ea0..6b1dfad37 100755
--- a/testcases/commands/which/which01.sh
+++ b/testcases/commands/which/which01.sh
@@ -10,7 +10,6 @@ TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="which"
-. tst_test.sh
 
 setup()
 {
@@ -104,4 +103,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/connectors/pec/cn_pec.sh b/testcases/kernel/connectors/pec/cn_pec.sh
index 74e94dc5e..082e30102 100755
--- a/testcases/kernel/connectors/pec/cn_pec.sh
+++ b/testcases/kernel/connectors/pec/cn_pec.sh
@@ -19,8 +19,6 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_CHECKPOINTS=1
 TST_TEST_DATA="fork exec exit uid gid"
 
-. tst_test.sh
-
 num_events=10
 
 LISTENER_ID=0
@@ -146,4 +144,5 @@ test()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/containers/netns/netns_breakns.sh b/testcases/kernel/containers/netns/netns_breakns.sh
index 1ce5d37ef..b7f255cb8 100755
--- a/testcases/kernel/containers/netns/netns_breakns.sh
+++ b/testcases/kernel/containers/netns/netns_breakns.sh
@@ -29,11 +29,6 @@
 TST_POS_ARGS=3
 TST_SETUP=do_setup
 TST_TESTFUNC=do_test
-. netns_helper.sh
-
-PROG=$1
-IP_VER=$2
-COM_TYPE=$3
 
 do_setup()
 {
@@ -49,4 +44,10 @@ do_test()
 	EXPECT_FAIL $NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK
 }
 
+. netns_helper.sh
+
+PROG=$1
+IP_VER=$2
+COM_TYPE=$3
+
 tst_run
diff --git a/testcases/kernel/containers/netns/netns_comm.sh b/testcases/kernel/containers/netns/netns_comm.sh
index ccb8b47b1..bee944802 100755
--- a/testcases/kernel/containers/netns/netns_comm.sh
+++ b/testcases/kernel/containers/netns/netns_comm.sh
@@ -32,11 +32,6 @@
 TST_POS_ARGS=3
 TST_SETUP=do_setup
 TST_TESTFUNC=do_test
-. netns_helper.sh
-
-PROG=$1
-IP_VER=$2
-COM_TYPE=$3
 
 do_setup()
 {
@@ -67,4 +62,10 @@ do_test()
 	EXPECT_PASS $NS_EXEC $NS_HANDLE0 $NS_TYPE $tping -q -c2 -I lo $ip_lo 1>/dev/null
 }
 
+. netns_helper.sh
+
+PROG=$1
+IP_VER=$2
+COM_TYPE=$3
+
 tst_run
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index d7d4d2c2d..a74d923d1 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -7,7 +7,6 @@ TST_CLEANUP=netns_ns_exec_cleanup
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="ip ping"
 TST_NEEDS_DRIVERS="veth"
-. tst_test.sh
 
 # Set to 1 only for test cases using ifconfig (ioctl).
 USE_IFCONFIG=0
@@ -276,3 +275,5 @@ netns_ip_cleanup()
 	ip netns del $NS_HANDLE0 2>/dev/null
 	ip netns del $NS_HANDLE1 2>/dev/null
 }
+
+. tst_test.sh
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index 8125e2490..9fc390eaf 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -11,7 +11,6 @@ TST_CLEANUP=do_cleanup
 TST_SETUP=do_setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
-. tst_test.sh
 
 do_setup()
 {
@@ -50,7 +49,6 @@ do_cleanup()
 	kill -9 $NS_HANDLE 2>/dev/null
 }
 
-
 do_test()
 {
 	EXPECT_PASS ns_exec $NS_HANDLE $NS_TYPE test -e /sys/class/net/$DUMMYDEV
@@ -58,4 +56,5 @@ do_test()
 	EXPECT_FAIL test -e /sys/class/net/$DUMMYDEV
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index 592a1d3b1..69b51773c 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2009 FUJITSU LIMITED
 # Author: Li Zefan <lizf@cn.fujitsu.com>
 
@@ -12,8 +12,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="awk dmesg find mountpoint rmdir"
 
-. cgroup_lib.sh
-
 do_setup()
 {
 	mkdir cgroup/
@@ -439,4 +437,5 @@ test9()
 	check_kernel_bug
 }
 
+. cgroup_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
index 7918b5636..56c9a7521 100644
--- a/testcases/kernel/controllers/cgroup_lib.sh
+++ b/testcases/kernel/controllers/cgroup_lib.sh
@@ -1,10 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
 
-. tst_test.sh
-
 # Find mountpoint to given subsystem
 # get_cgroup_mountpoint SUBSYSTEM
 # RETURN: 0 if mountpoint found, otherwise 1
@@ -37,3 +35,5 @@ is_cgroup_subsystem_available_and_enabled()
 
 	return 1
 }
+
+. tst_test.sh
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index ca881988f..97a395cd5 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -21,8 +21,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="awk"
 
-. tst_test.sh
-
 mounted=1
 max=$1
 nbprocess=$2
@@ -178,4 +176,5 @@ do_test()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index a6806b7b0..68fcf2eec 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2016-2022
 # Copyright (c) 2015 Fujitsu Ltd.
 # Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
 #
@@ -16,8 +17,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_MIN_KVER="3.18"
 
-. cgroup_lib.sh
-
 LOCAL_MOUNTPOINT="cpuset_test"
 BACKUP_DIRECTORY="cpuset_backup"
 
@@ -218,4 +217,5 @@ test()
 	tst_res TPASS "Bug is not reproducible"
 }
 
+. cgroup_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index 65ad82e0a..1fed01569 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -11,7 +11,6 @@
 MEMCG_TESTFUNC=test
 MEMCG_SHMMAX=1
 TST_TEST_DATA="--mmap-anon --mmap-file --shm"
-. memcg_lib.sh
 
 MEMORY_LIMIT=$PAGESIZE
 MEMORY_TO_ALLOCATE=$((MEMORY_LIMIT * 2))
@@ -36,4 +35,5 @@ test()
 	fi
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
index 92ac25938..23a4bd04d 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
@@ -11,7 +11,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=6
 
-. memcg_lib.sh
 
 # Test memory.force_empty
 test1()
@@ -54,4 +53,5 @@ test6()
 	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index db010acc7..96d26ef2d 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -1,7 +1,7 @@
 #! /bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2012 FUJITSU LIMITED
-# Copyright (c) 2014-2019 Linux Test Project
+# Copyright (c) 2014-2022 Linux Test Project
 # Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
 #
 # Author: Peng Haitao <penght@cn.fujitsu.com>
@@ -14,35 +14,6 @@ TST_SETUP="${TST_SETUP:-memcg_setup}"
 TST_CLEANUP="${TST_CLEANUP:-memcg_cleanup}"
 TST_TESTFUNC=memcg_testfunc
 
-MEMCG_SHMMAX=${MEMCG_SHMMAX:-0}
-MEMCG_TESTFUNC=${MEMCG_TESTFUNC:-memcg_no_testfunc}
-
-. cgroup_lib.sh
-
-PAGESIZE=$(tst_getconf PAGESIZE)
-if [ $? -ne 0 ]; then
-	tst_brk TBROK "tst_getconf PAGESIZE failed"
-fi
-
-# Post 4.16 kernel updates stat in batch (> 32 pages) every time
-PAGESIZES=$(($PAGESIZE * 33))
-
-# On recent Linux kernels (at least v5.4) updating stats happens in batches
-# (PAGESIZES) and also might depend on workload and number of CPUs.  The kernel
-# caches the data and does not prioritize stats precision.  This is especially
-# visible for max_usage_in_bytes where it usually exceeds
-# actual memory allocation.
-# When checking for usage_in_bytes and max_usage_in_bytes accept also higher values
-# from given range:
-MEM_USAGE_RANGE=$((PAGESIZES))
-
-HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
-[ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
-HUGEPAGESIZE=$(($HUGEPAGESIZE * 1024))
-
-orig_memory_use_hierarchy=
-orig_shmmax=
-
 memcg_require_memsw()
 {
 	if ! [ -e /dev/memcg/memory.limit_in_bytes ]; then
@@ -415,3 +386,32 @@ memcg_no_testfunc()
 {
 	tst_brk TBROK "No testfunc specified, set MEMCG_TESTFUNC"
 }
+
+. cgroup_lib.sh
+
+MEMCG_SHMMAX=${MEMCG_SHMMAX:-0}
+MEMCG_TESTFUNC=${MEMCG_TESTFUNC:-memcg_no_testfunc}
+
+PAGESIZE=$(tst_getconf PAGESIZE)
+if [ $? -ne 0 ]; then
+	tst_brk TBROK "tst_getconf PAGESIZE failed"
+fi
+
+# Post 4.16 kernel updates stat in batch (> 32 pages) every time
+PAGESIZES=$(($PAGESIZE * 33))
+
+# On recent Linux kernels (at least v5.4) updating stats happens in batches
+# (PAGESIZES) and also might depend on workload and number of CPUs.  The kernel
+# caches the data and does not prioritize stats precision.  This is especially
+# visible for max_usage_in_bytes where it usually exceeds
+# actual memory allocation.
+# When checking for usage_in_bytes and max_usage_in_bytes accept also higher values
+# from given range:
+MEM_USAGE_RANGE=$((PAGESIZES))
+
+HUGEPAGESIZE=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
+[ -z $HUGEPAGESIZE ] && HUGEPAGESIZE=0
+HUGEPAGESIZE=$(($HUGEPAGESIZE * 1024))
+
+orig_memory_use_hierarchy=
+orig_shmmax=
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
index 31892fd0e..77d293329 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
@@ -12,7 +12,6 @@ MEMCG_TESTFUNC=test
 MEMCG_SHMMAX=1
 TST_CNT=15
 
-. memcg_lib.sh
 TST_CLEANUP=cleanup
 
 cleanup()
@@ -111,4 +110,5 @@ test15()
 	EXPECT_FAIL echo xx \> memory.limit_in_bytes
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index 6a2607c43..d1ffbe053 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -9,7 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=4
 
-. memcg_lib.sh
 
 MEM_TO_ALLOC=$((PAGESIZE * 1024))
 MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
@@ -88,4 +87,5 @@ test4()
 	test_max_usage_in_bytes 1 1
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
index ab26cb3d1..96f5360a8 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
@@ -9,7 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=12
 
-. memcg_lib.sh
 
 test1()
 {
@@ -88,4 +87,5 @@ test12()
 	EXPECT_FAIL echo xx \> memory.memsw.limit_in_bytes
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
index 3c1b3394b..86a705f0c 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_move_charge_at_immigrate_test.sh
@@ -9,7 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=4
 
-. memcg_lib.sh
 
 
 # Run test cases which test memory.move_charge_at_immigrate
@@ -80,4 +79,5 @@ test4()
 		$((PAGESIZES * 2)) 3 $PAGESIZES $PAGESIZES 0 0
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
index d9b4ec287..63a425871 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh
@@ -13,7 +13,6 @@ MEMCG_TESTFUNC=test
 MEMCG_SHMMAX=1
 TST_CNT=10
 
-. memcg_lib.sh
 
 # Test the management and counting of memory
 test1()
@@ -68,4 +67,5 @@ test10()
 	test_mem_stat "--mmap-lock1" $PAGESIZES $PAGESIZES "rss" $PAGESIZES $PAGESIZES true
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
index 0308b40ba..28c1fcd9c 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_stat_test.sh
@@ -9,7 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=8
 
-. memcg_lib.sh
 
 test1()
 {
@@ -115,4 +114,5 @@ test8()
 	rmdir subgroup
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index cda624923..08b6697d4 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -12,7 +12,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=3
 
-. memcg_lib.sh
 
 # Allocate memory bigger than per-cpu kernel memory
 MEM_TO_ALLOC=$((PAGESIZES * 2))
@@ -67,4 +66,5 @@ test3()
 	test_subgroup 0
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
index 6c1b36505..6f932124e 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
@@ -9,7 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=2
 
-. memcg_lib.sh
 
 MEM_TO_ALLOC=$((PAGESIZE * 1024))
 MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
@@ -35,4 +34,5 @@ test2()
 		$MEM_EXPECTED_UPPER false
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
index e21982384..f17ba11c0 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_test.sh
@@ -9,7 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=3
 
-. memcg_lib.sh
 
 test1()
 {
@@ -53,4 +52,5 @@ test3()
 	rmdir subgroup
 }
 
+. memcg_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
index c43d72116..fa0df3196 100755
--- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
+++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 FUJITSU LIMITED
 # Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
-# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 #
 # Author: Li Zefan <lizf@cn.fujitsu.com>
 # Restructure for LTP: Shi Weihua <shiwh@cn.fujitsu.com>
@@ -19,8 +19,6 @@ TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir grep awk cut"
 # therefore the default 5 mins timeout is not enough.
 TST_TIMEOUT=2100
 
-. cgroup_lib.sh
-
 setup()
 {
 	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
@@ -111,4 +109,5 @@ test2()
 	run_stress 1 $(( $MEM - $THREAD_SPARE_MB)) 5 $RUN_TIME
 }
 
+. cgroup_lib.sh
 tst_run
diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index a3d644eff..e8bafc739 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -13,8 +13,6 @@ TST_USAGE=usage
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="killall"
 
-. tst_test.sh
-
 caseno=$1
 max=$2
 subcgroup_num=$3
@@ -393,4 +391,5 @@ do_test()
 	case$caseno
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/device-drivers/rcu/rcu_torture.sh b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
index bca1530bd..25a3e7e65 100755
--- a/testcases/kernel/device-drivers/rcu/rcu_torture.sh
+++ b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
@@ -19,8 +19,6 @@ TST_OPTS="t:w:"
 TST_USAGE=rcutorture_usage
 TST_PARSE_ARGS=rcutorture_parse_args
 
-. tst_test.sh
-
 # default options
 test_time=30
 num_writers=5
@@ -92,4 +90,5 @@ do_test()
 	esac
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index 5b4c05434..ad01291bf 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2019-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test creates several zram devices with different filesystems on them.
@@ -9,7 +9,6 @@
 TST_CNT=7
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk bc dd"
-. zram_lib.sh
 TST_SETUP="setup"
 
 check_space_for_btrfs()
@@ -151,4 +150,5 @@ do_test()
 	esac
 }
 
+. zram_lib.sh
 tst_run
diff --git a/testcases/kernel/device-drivers/zram/zram02.sh b/testcases/kernel/device-drivers/zram/zram02.sh
index c980fce76..bb6e9a5f0 100755
--- a/testcases/kernel/device-drivers/zram/zram02.sh
+++ b/testcases/kernel/device-drivers/zram/zram02.sh
@@ -7,7 +7,6 @@
 
 TST_CNT=6
 TST_TESTFUNC="do_test"
-. zram_lib.sh
 
 # List of parameters for zram devices.
 # For each number the test creates own zram device.
@@ -64,4 +63,5 @@ do_test()
 	esac
 }
 
+. zram_lib.sh
 tst_run
diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh b/testcases/kernel/device-drivers/zram/zram_lib.sh
index 803fd9825..e94d7db11 100755
--- a/testcases/kernel/device-drivers/zram/zram_lib.sh
+++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
@@ -15,7 +15,6 @@ TST_NEEDS_ROOT=1
 TST_SETUP="${TST_SETUP:-zram_load}"
 TST_CLEANUP="${TST_CLEANUP:-zram_cleanup}"
 TST_NEEDS_DRIVERS="zram"
-. tst_test.sh
 
 zram_cleanup()
 {
@@ -193,3 +192,5 @@ zram_set_memlimit()
 
 	tst_res TPASS "test succeeded"
 }
+
+. tst_test.sh
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
index 06106e863..beb803084 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
@@ -25,7 +25,6 @@ TST_CNT=9
 TST_TESTFUNC=do_test
 TST_NEEDS_CMDS="cat"
 
-. binfmt_misc_lib.sh
 
 verify_binfmt_misc()
 {
@@ -61,4 +60,5 @@ do_test()
 	esac
 }
 
+. binfmt_misc_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
index 7bf4a0a2b..37c9b9e0f 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
@@ -21,7 +21,6 @@ TST_CNT=6
 TST_TESTFUNC=do_test
 TST_NEEDS_CMDS="cat head"
 
-. binfmt_misc_lib.sh
 
 recognised_unrecognised()
 {
@@ -106,4 +105,5 @@ do_test()
 	esac
 }
 
+. binfmt_misc_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
index ff862db43..7fcf12388 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
@@ -11,8 +11,6 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="${TST_NEEDS_CMDS} modprobe mount umount mkdir rm"
 
-. tst_test.sh
-
 rmod_binfmt_misc=0
 umount_binfmt_misc=0
 binfmt_misc_mntpoint="ltp_binfmt_misc"
@@ -72,3 +70,5 @@ binfmt_misc_cleanup()
 		rmod_binfmt_misc=0
 	fi
 }
+
+. tst_test.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
index 70d7fe11b..0168851c2 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -45,4 +44,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
index a765a758b..3e7f36642 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -46,4 +45,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
index 3c73cdeee..562045170 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -57,4 +56,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
index a49145040..4c826fbcf 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -46,4 +45,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
index 3f6ff8a81..2572ec64f 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -54,4 +53,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
index 13bf8abd8..004314a6a 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -44,4 +43,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
index 92e71c976..94dc4b1dd 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -31,4 +30,5 @@ test()
 	EXPECT_PASS umount share2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
index bae87a5cd..08991a942 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -54,4 +53,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
index 4bb292b42..a1f1a9241 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -45,4 +44,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
index a10511c77..2dc3f0140 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -54,4 +53,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
index 4e60d8615..ca236221c 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -49,4 +48,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
index 07f87a612..5406cee14 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -60,4 +59,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
index 38942fc6f..321709272 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -49,4 +48,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
index 7090a2b6f..4ea429fe1 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -35,4 +34,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
index dd0c1345b..1678e3f72 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -31,4 +30,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
index 9a7c7f388..7deb6c0a3 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -40,4 +39,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
index 85bbd9f90..dee3860d2 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -32,4 +31,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
index e0e844120..bd7858ea7 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -45,4 +44,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
index 262d1cbe0..1ce6f1631 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -45,4 +44,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
index 25292d4c8..3d7c64584 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -49,4 +48,5 @@ test()
 	EXPECT_PASS umount share2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
index e19de1950..92927cfe9 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -45,4 +44,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
index d8abe99de..d7584219c 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -54,4 +53,5 @@ test()
 	EXPECT_PASS umount dir4
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
index d013f8c7d..e51d64b67 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -37,4 +36,5 @@ test()
 	EXPECT_PASS umount parent
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
index af7aaa095..b91fc75e4 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -37,4 +36,5 @@ test()
 	EXPECT_PASS umount tmp2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
index fe9a816e7..1ec32a87e 100755
--- a/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -32,4 +31,5 @@ test()
 	EXPECT_PASS umount dir1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
index 930e98547..a82eee6ed 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -35,4 +34,5 @@ test()
 	EXPECT_PASS umount dir1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
index b1ce9b2bd..ef6e8f62e 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -50,4 +49,5 @@ test()
 	EXPECT_PASS umount dir1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
index 2f716d028..e6e84a14d 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -24,4 +23,5 @@ test()
 	EXPECT_PASS umount dir1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
index 641ab40d1..7b8088ecb 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -28,4 +27,5 @@ test()
 	EXPECT_PASS umount dir1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
index dbcb5ba17..8c0dbcd23 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -52,4 +51,5 @@ test()
 	EXPECT_PASS umount parent
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
index 0e87cc464..7abd709d1 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -74,4 +73,5 @@ test()
 	EXPECT_PASS umount dir1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
index 074984b25..7f675b0cb 100755
--- a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -52,4 +51,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
index 6676d1021..2dd9ef08f 100644
--- a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
+++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
@@ -12,10 +12,6 @@ TST_CLEANUP="${TST_CLEANUP:-fs_bind_cleanup}"
 TST_TESTFUNC=fs_bind_test
 TST_NEEDS_CMDS="mount umount awk sed"
 
-. tst_test.sh
-
-[ -z "$FS_BIND_TESTFUNC" ] && tst_brk TBROK "Please set FS_BIND_TESTFUNC before sourcing fs_bind_lib.sh"
-
 # Test interface:
 #
 # FS_BIND_TESTFUNC is the real testfunction. Please do not use
@@ -245,3 +241,6 @@ fs_bind_test()
 
 	_fs_bind_cleanup_test
 }
+
+. tst_test.sh
+[ -z "$FS_BIND_TESTFUNC" ] && tst_brk TBROK "Please set FS_BIND_TESTFUNC before sourcing fs_bind_lib.sh"
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_regression.sh b/testcases/kernel/fs/fs_bind/fs_bind_regression.sh
index ce3e64ce4..e346b1e31 100755
--- a/testcases/kernel/fs/fs_bind/fs_bind_regression.sh
+++ b/testcases/kernel/fs/fs_bind/fs_bind_regression.sh
@@ -7,7 +7,6 @@
 TST_CNT=3
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test1()
 {
@@ -53,4 +52,5 @@ test3()
 	EXPECT_PASS umount dir2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
index 761cd2c7b..ab897fd16 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -41,4 +40,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
index 141a8da14..06e140d70 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -42,4 +41,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
index 1e33b8301..dad8930ab 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -44,4 +43,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
index 711ce5bd4..dc9268114 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -38,4 +37,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
index 57ca42366..222bbda4a 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -41,4 +40,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
index e0d027fc5..3898aeab6 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -37,4 +36,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
index c451406d1..7b26706fc 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -38,4 +37,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
index a3d7082c5..0767a6175 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -32,4 +31,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
index b4b9339ee..2067ca7e7 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -47,4 +46,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
index bd743f33d..be5432bff 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -43,4 +42,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
index 40a0484d4..35fb56a5e 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -44,4 +43,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
index f89ce424c..ccae31822 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -42,4 +41,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
index d46058a47..7d45ce06f 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -27,4 +26,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
index 78cb455cf..83e383ec2 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -29,4 +28,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
index e74fb713f..8519b04df 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -29,4 +28,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
index 7ab16afaa..f6047dec2 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -26,4 +25,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
index dbd2fa80a..daf28ddc6 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -24,4 +23,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
index 1a3c2be37..2652c5289 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -44,4 +43,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
index c19dc01ab..63c5cdbf6 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -44,4 +43,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
index a9012a5f1..2d131b6cd 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -28,4 +27,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
index d8fb89127..4b61be0d3 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -41,4 +40,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
index 61dbc712b..ced34ac2c 100755
--- a/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -34,4 +33,5 @@ test()
 	EXPECT_PASS umount tmp2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
index aee6f2bf5..d5a64301f 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -47,4 +46,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
index 0a2ce7949..09ef35178 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -47,4 +46,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
index 86a930735..7fb1a460d 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -58,4 +57,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
index 27c2d2148..3e55e2e28 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -49,4 +48,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
index 7c6bc3e00..3f60789b3 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -59,4 +58,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
index 32905196a..8f1384a4e 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -49,4 +48,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
index 11db71998..666920d65 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -34,4 +33,5 @@ test()
 	EXPECT_PASS umount share2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
index 79e16dec5..2fc9c945b 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -59,4 +58,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
index f7e403608..e609977f6 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -49,4 +48,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
index cc06aad8c..a8195d831 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -60,4 +59,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
index e74670e6a..d052ae5c0 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -55,4 +54,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
index b5e2213a1..3fadf3391 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -65,4 +64,5 @@ test()
 	EXPECT_PASS umount share2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
index 5e908e666..0c50bce8e 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -55,4 +54,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
index 5a6775e4f..443d71c47 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -36,4 +35,5 @@ test()
 	EXPECT_PASS umount share2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
index 164ded501..f1f21e63e 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -32,4 +31,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
index 086767f9c..c348a2a3b 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -42,4 +41,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
index 8cb193e21..bf8414c92 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -33,4 +32,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
index f5bff11a2..e4ca564a2 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -47,4 +46,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
index 94ffe947c..0314c08bc 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -47,4 +46,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
index 527f69ae8..9dd28c89c 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -50,4 +49,5 @@ test()
 	EXPECT_PASS umount share2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
index 4e35487f4..0603f9c63 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -47,4 +46,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
index a1cb90b46..34eb8b274 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -53,4 +52,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
index 7ed13787a..1755ba445 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -46,4 +45,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
index a36e47938..e4b41ee8f 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -46,4 +45,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
index 73cc9bada..29c326772 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -46,4 +45,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
index 717a9381e..25d721043 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -53,4 +52,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
index 9472f6926..2ec567196 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -48,4 +47,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
index 687230a26..d95f11506 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -53,4 +52,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
index 828c5b94c..29404471d 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -48,4 +47,5 @@ test()
 	EXPECT_PASS umount share1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
index 105ad353e..d84f9cab6 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -40,4 +39,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
index 09df7002c..9ee70ed30 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -35,4 +34,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
index e34952886..b3eff6e98 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -42,4 +41,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
index 3d68283c0..1f49d9d8e 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -35,4 +34,5 @@ test()
 	EXPECT_PASS umount parent1
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
index 964acce18..170f7c42b 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -56,4 +55,5 @@ test()
 	EXPECT_PASS umount dir4
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
index c421432b9..1d6b401c9 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -40,4 +39,5 @@ test()
 	EXPECT_PASS umount parent
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
index f14168d34..758e631f9 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -43,4 +42,5 @@ test()
 	EXPECT_PASS umount parent
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
index 8e90974b9..a1af464e7 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -38,4 +37,5 @@ test()
 	EXPECT_PASS umount parent
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
index 726fbf0eb..c0054de68 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -52,4 +51,5 @@ test()
 	EXPECT_PASS umount parent2/child2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
index 8861230b7..12ddaff68 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -51,4 +50,5 @@ test()
 	EXPECT_PASS umount parent2/child2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
index 697c7dd00..be98d179a 100755
--- a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
@@ -6,7 +6,6 @@
 
 FS_BIND_TESTFUNC=test
 
-. fs_bind_lib.sh
 
 test()
 {
@@ -28,4 +27,5 @@ test()
 	EXPECT_PASS umount parent2
 }
 
+. fs_bind_lib.sh
 tst_run
diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 1d2ebe03e..dfa4ac73d 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -14,8 +14,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP=setup
 TST_TESTFUNC=do_test
 
-. tst_test.sh
-
 MAX_DEPTH=3
 MAX_DIRS=4
 
@@ -97,4 +95,5 @@ do_test()
 	done
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/fs/linktest/linktest.sh b/testcases/kernel/fs/linktest/linktest.sh
index 3386a445b..e68ce10f4 100755
--- a/testcases/kernel/fs/linktest/linktest.sh
+++ b/testcases/kernel/fs/linktest/linktest.sh
@@ -11,8 +11,6 @@ TST_OPTS="a:s:"
 TST_PARSE_ARGS=parse_args
 TST_USAGE=usage
 
-. tst_test.sh
-
 hard_links=1000
 soft_links=1000
 
@@ -72,4 +70,5 @@ do_test()
 	rm -rf hlink.$$ slink.$$
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
index e1ea5925d..25d9f8fcc 100755
--- a/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
+++ b/testcases/kernel/fs/quota_remount/quota_remount_test01.sh
@@ -14,8 +14,6 @@ TST_CLEANUP=do_clean
 TST_TESTFUNC=do_test
 TST_MIN_KVER="2.6.26"
 
-. tst_test.sh
-
 do_setup()
 {
 	if [ ! -d /proc/sys/fs/quota ]; then
@@ -77,4 +75,5 @@ do_test()
 	do_clean
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index c94a4b96c..9ef6f0a23 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -23,8 +23,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="gdb"
 
-. tst_test.sh
-
 CORE_LIMIT=$(ulimit -c)
 CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
 
@@ -64,4 +62,5 @@ vma_report_check()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 892f22ee8..367813ce9 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -22,8 +22,6 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="awk bc numactl numastat"
 
-. tst_test.sh
-
 # Awk the field matching the node value for numastat
 # $1 - Pid number
 # $2 - Node number
@@ -383,4 +381,5 @@ test9()
 	tst_res TPASS "NUMA preferred node policy verified with THP enabled"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index dd601b84e..9851829f7 100755
--- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -10,7 +10,6 @@ TST_SETUP="setup"
 TST_CLEANUP="cleanup"
 TST_NEEDS_DEVICE=1
 TST_CNT=4
-. ima_setup.sh
 
 setup()
 {
@@ -91,4 +90,5 @@ cleanup()
 	TST_MNT_PARAMS="$params_backup"
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
index 095028e16..0d50db906 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
@@ -13,8 +13,6 @@ TST_NEEDS_CMDS="cat chgrp chown id sg sudo"
 TST_CNT=1
 TST_NEEDS_DEVICE=1
 
-. ima_setup.sh
-
 verify_measurement()
 {
 	local request="$1"
@@ -63,4 +61,5 @@ test1()
 	verify_measurement fgroup
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 30bbd066e..1c9d77ef2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -13,8 +13,6 @@ TST_CNT=3
 TST_NEEDS_DEVICE=1
 TST_SETUP="setup"
 
-. ima_setup.sh
-
 IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
 REQUIRED_POLICY='^measure.*func=KEXEC_CMDLINE'
 
@@ -117,4 +115,5 @@ test()
 	esac
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 995a55fed..571646049 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -12,8 +12,6 @@ TST_NEEDS_DEVICE=1
 TST_SETUP=setup
 TST_CLEANUP=cleanup
 
-. ima_setup.sh
-
 FUNC_KEYCHECK='func=KEY_CHECK'
 REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
 
@@ -28,7 +26,6 @@ cleanup()
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
-
 require_valid_policy_template()
 {
 	while read line; do
@@ -145,4 +142,5 @@ test2()
 	fi
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 6c184f396..db97beaeb 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -11,8 +11,6 @@ TST_SETUP="setup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
-. ima_setup.sh
-
 setup()
 {
 	require_ima_policy_cmdline "tcb"
@@ -93,4 +91,5 @@ test3()
 	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 8924549df..af1fb0028 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -9,8 +9,6 @@
 TST_SETUP="setup"
 TST_CNT=2
 
-. ima_setup.sh
-
 setup()
 {
 	require_policy_writable
@@ -75,4 +73,5 @@ test2()
 	fi
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index a4eb60b16..2e5b56afc 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -14,8 +14,6 @@ TST_CNT=2
 TST_NEEDS_DEVICE=1
 TST_SETUP="setup"
 
-. ima_setup.sh
-
 FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
 REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
 
@@ -168,4 +166,5 @@ test2()
 	validate_policy_capabilities $measured_data
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index af7f3a5f5..a626aae44 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -14,8 +14,6 @@ TST_NEEDS_ROOT=1
 # TST_NEEDS_DEVICE can be unset, therefore specify explicitly
 TST_NEEDS_TMPDIR=1
 
-. tst_test.sh
-
 SYSFS="/sys"
 UMOUNT=
 TST_FS_TYPE="ext3"
@@ -350,6 +348,8 @@ require_evmctl()
 	fi
 }
 
+. tst_test.sh
+
 # loop device is needed to use only for tmpfs
 TMPDIR="${TMPDIR:-/tmp}"
 if [ "$(df -T $TMPDIR | tail -1 | awk '{print $2}')" != "tmpfs" -a -n "$TST_NEEDS_DEVICE" ]; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 59df20cc1..b675a20a1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -10,8 +10,6 @@ TST_CNT=2
 TST_NEEDS_CMDS="awk cut tail"
 TST_SETUP="setup"
 
-. ima_setup.sh
-
 EVMCTL_REQUIRED='1.3.1'
 ERRMSG_EVMCTL="=> install evmctl >= $EVMCTL_REQUIRED"
 ERRMSG_TPM="TPM hardware support not enabled in kernel or no TPM chip found"
@@ -296,4 +294,5 @@ test2()
 	fi
 }
 
+. ima_setup.sh
 tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index b3151a149..24fa5c8e3 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -11,9 +11,6 @@ TST_CLEANUP="cleanup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
-. ima_setup.sh
-. daemonlib.sh
-
 setup()
 {
 	FILE="test.txt"
@@ -153,4 +150,6 @@ test3()
 	tst_sleep 2s
 }
 
+. ima_setup.sh
+. daemonlib.sh
 tst_run
diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index fd5ee06c8..4b159517b 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -17,9 +17,6 @@ TST_NEEDS_ROOT=1
 TST_SETUP=setup
 TST_CLEANUP=cleanup
 
-. tst_test.sh
-
-
 DEBUGFS_WAS_MOUNTED=0
 DEBUGFS_PATH=""
 DEBUGFS_CONTROL=""
@@ -27,7 +24,6 @@ DYNDEBUG_STATEMENTS="./debug_statements"
 EMPTY_FLAG="-"
 NEW_INTERFACE=0
 
-
 mount_debugfs()
 {
 	if grep -q debugfs /proc/mounts ; then
@@ -153,4 +149,5 @@ cleanup()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 891472c8a..dae0ceaf1 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2016-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2016-2022 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 [ -n "$TST_LIB_NET_LOADED" ] && return 0
@@ -71,8 +71,6 @@ tst_net_setup()
 	fi
 }
 
-[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
-
 if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
 	tst_res TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
 	unset TST_PARSE_ARGS_CALLER
@@ -937,6 +935,7 @@ tst_default_max_pkt()
 	echo "$((mtu + mtu / 10))"
 }
 
+[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 [ -n "$TST_PRINT_HELP" -o -n "$TST_NET_SKIP_VARIABLE_INIT" ] && return 0
 
 # Management Link
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index d97df9ab4..28b7d12ba 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2014-2021
+# Copyright (c) Linux Test Project, 2014-2022
 # Author: Cyril Hrubis <chrubis@suse.cz>
 #
 # LTP test library for shell.
@@ -642,17 +642,6 @@ tst_run()
 		done
 	fi
 
-	OPTIND=1
-
-	while getopts ":hi:$TST_OPTS" _tst_name $TST_ARGS; do
-		case $_tst_name in
-		'h') tst_usage; exit 0;;
-		'i') TST_ITERATIONS=$OPTARG;;
-		'?') tst_usage; exit 2;;
-		*) $TST_PARSE_ARGS "$_tst_name" "$OPTARG";;
-		esac
-	done
-
 	if ! tst_is_int "$TST_ITERATIONS"; then
 		tst_brk TBROK "Expected number (-i) not '$TST_ITERATIONS'"
 	fi
@@ -818,22 +807,26 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
 
 	TST_ARGS="$@"
 
-	while getopts ":hi:$TST_OPTS" tst_name; do
-		case $tst_name in
-		'h') TST_PRINT_HELP=1;;
-		*);;
+	OPTIND=1
+
+	while getopts ":hi:$TST_OPTS" _tst_name $TST_ARGS; do
+		case $_tst_name in
+		'h') tst_usage; exit 0;;
+		'i') TST_ITERATIONS=$OPTARG;;
+		'?') tst_usage; exit 2;;
+		*) $TST_PARSE_ARGS "$_tst_name" "$OPTARG";;
 		esac
 	done
 
 	shift $((OPTIND - 1))
 
 	if [ -n "$TST_POS_ARGS" ]; then
-		if [ -z "$TST_PRINT_HELP" -a $# -ne "$TST_POS_ARGS" ]; then
+		if [ $# -ne "$TST_POS_ARGS" ]; then
 			tst_brk TBROK "Invalid number of positional parameters:"\
 					  "have ($@) $#, expected ${TST_POS_ARGS}"
 		fi
 	else
-		if [ -z "$TST_PRINT_HELP" -a $# -ne 0 ]; then
+		if [ $# -ne 0 ]; then
 			tst_brk TBROK "Unexpected positional arguments '$@'"
 		fi
 	fi
diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
index b41b41319..f05289f00 100755
--- a/testcases/misc/lvm/cleanup_lvm.sh
+++ b/testcases/misc/lvm/cleanup_lvm.sh
@@ -7,7 +7,6 @@
 TST_TESTFUNC=cleanup_lvm
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="losetup umount vgremove"
-. tst_test.sh
 
 LVM_DIR="${LVM_DIR:-/tmp}"
 LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
@@ -32,4 +31,5 @@ cleanup_lvm()
 	tst_res TPASS "LVM configuration for LTP removed successfully."
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 02a797219..72b286a69 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -7,7 +7,6 @@
 TST_TESTFUNC=generate_runfile
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sed"
-. tst_test.sh
 
 LVM_DIR="${LVM_DIR:-/tmp}"
 LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
@@ -30,4 +29,5 @@ generate_runfile()
 	tst_res TPASS "Runfile $OUTFILE successfully created"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
index b6557f221..d3ae4b23f 100755
--- a/testcases/misc/lvm/prepare_lvm.sh
+++ b/testcases/misc/lvm/prepare_lvm.sh
@@ -7,7 +7,6 @@
 TST_TESTFUNC=prepare_lvm
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount pvcreate vgcreate lvcreate"
-. tst_test.sh
 
 LVM_DIR="${LVM_DIR:-/tmp}"
 LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
@@ -81,4 +80,5 @@ prepare_lvm()
 	tst_res TPASS "LVM mounts are ready"
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 0be4c5f96..65f4db3fe 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -4,8 +4,6 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-. busy_poll_lib.sh
-
 cleanup()
 {
 	[ -n "$busy_read_old" ] && \
@@ -47,4 +45,5 @@ test()
 	tst_netload_compare $(cat res_0) $(cat res_50) 1
 }
 
+. busy_poll_lib.sh
 tst_run
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index ec275bec9..ebae4d2f5 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -4,8 +4,6 @@
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-. busy_poll_lib.sh
-
 cleanup()
 {
 	[ -n "$busy_poll_old" ] && \
@@ -39,4 +37,5 @@ test()
 	tst_netload_compare $(cat res_0) $(cat res_50) 1
 }
 
+. busy_poll_lib.sh
 tst_run
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 844a7322a..04d5978f7 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -6,8 +6,6 @@
 
 TST_TEST_DATA="udp udp_lite"
 
-. busy_poll_lib.sh
-
 cleanup()
 {
 	[ -n "$busy_poll_old" ] && \
@@ -42,4 +40,5 @@ test()
 	tst_netload_compare $(cat res_0) $(cat res_50) 1
 }
 
+. busy_poll_lib.sh
 tst_run
diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
index 69e590031..7edbd7079 100755
--- a/testcases/network/busy_poll/busy_poll_lib.sh
+++ b/testcases/network/busy_poll/busy_poll_lib.sh
@@ -16,8 +16,6 @@ TST_NEEDS_CMDS="pkill sysctl ethtool"
 # for more stable results set to a single thread
 TST_NETLOAD_CLN_NUMBER=1
 
-. tst_net.sh
-
 busy_poll_check_config()
 {
 	if [ ! -f "/proc/sys/net/core/busy_read" -a \
@@ -31,3 +29,5 @@ busy_poll_check_config()
 			tst_brk TCONF "busy poll not supported by driver"
 	fi
 }
+
+. tst_net.sh
diff --git a/testcases/network/dccp/dccp01.sh b/testcases/network/dccp/dccp01.sh
index 4d8e6e0d4..b139d6c3a 100755
--- a/testcases/network/dccp/dccp01.sh
+++ b/testcases/network/dccp/dccp01.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC="test"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 
-. tst_net.sh
 
 test1()
 {
@@ -30,4 +29,5 @@ test3()
 	tst_netload_compare $res0 $res1 -100 100
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index ebee0c2e9..4e8166d47 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -11,9 +11,6 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="cat $dhcp_name awk ip pgrep pkill dhclient"
 
-. tst_net.sh
-. daemonlib.sh
-
 iface0="ltp_veth0"
 iface1="ltp_veth1"
 
@@ -174,3 +171,6 @@ EOF
 
 	stop_dhcp
 }
+
+. tst_net.sh
+. daemonlib.sh
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index 23dc8a45b..69c631dff 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -7,10 +7,9 @@
 # Author:       Manoj Iyer, manjo@mail.utexas.edu
 # Author:       Alexey Kodanev alexey.kodanev@oracle.com
 
-dhcp_name="dhcpd"
-
-. dhcp_lib.sh
 TST_SETUP="setup_dhcp"
+
+dhcp_name="dhcpd"
 lease_dir="/var/lib/misc"
 lease_file="$lease_dir/dhcpd.leases_tst"
 
@@ -84,4 +83,5 @@ print_dhcp_version()
 	dhcpd --version 2>&1
 }
 
+. dhcp_lib.sh
 tst_run
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index 855a74263..0183c1da2 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -5,20 +5,6 @@
 #
 # Author: Alexey Kodanev alexey.kodanev@oracle.com
 
-dhcp_name="dnsmasq"
-
-. dhcp_lib.sh
-
-log="/var/log/dnsmasq.tst.log"
-
-lease_dir="/var/lib/misc"
-tst_selinux_enforced && lease_dir="/var/lib/dnsmasq"
-lease_file="$lease_dir/dnsmasq.tst.leases"
-
-common_opt="--no-hosts --no-resolv --dhcp-authoritative \
-	--log-facility=$log --interface=$iface0 \
-	--dhcp-leasefile=$lease_file --port=0 --conf-file= "
-
 start_dhcp()
 {
 	dnsmasq $common_opt \
@@ -47,4 +33,18 @@ print_dhcp_version()
 	dnsmasq --version | head -2
 }
 
+. dhcp_lib.sh
+
+lease_dir="/var/lib/misc"
+tst_selinux_enforced && lease_dir="/var/lib/dnsmasq"
+
+dhcp_name="dnsmasq"
+log="/var/log/dnsmasq.tst.log"
+
+lease_file="$lease_dir/dnsmasq.tst.leases"
+
+common_opt="--no-hosts --no-resolv --dhcp-authoritative \
+	--log-facility=$log --interface=$iface0 \
+	--dhcp-leasefile=$lease_file --port=0 --conf-file= "
+
 tst_run
diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index 1527445d4..ee9768073 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -15,7 +15,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="cat awk diff"
 TST_NEEDS_DRIVERS="dummy"
 
-. tst_net.sh
 
 rm_dummy=
 
@@ -251,4 +250,5 @@ test6()
 	tst_res TPASS "'ip maddr' command successfully tested"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/iptables/iptables01.sh b/testcases/network/iptables/iptables01.sh
index b788b919a..6e141a976 100755
--- a/testcases/network/iptables/iptables01.sh
+++ b/testcases/network/iptables/iptables01.sh
@@ -5,5 +5,4 @@
 use_iptables=1
 
 . iptables_lib.sh
-
 tst_run
diff --git a/testcases/network/iptables/iptables_lib.sh b/testcases/network/iptables/iptables_lib.sh
index ad2a894b6..ab76cbd41 100755
--- a/testcases/network/iptables/iptables_lib.sh
+++ b/testcases/network/iptables/iptables_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2019-2022
 # Copyright (c) 2018-2019 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 #
@@ -14,8 +15,6 @@ TST_SETUP="${TST_SETUP:-init}"
 TST_CLEANUP="${TST_CLEANUP:-cleanup}"
 TST_NEEDS_CMDS="grep telnet"
 
-. tst_net.sh
-
 NFRUN()
 {
 	local rule
@@ -379,3 +378,5 @@ test6()
 	tst_res TINFO "$toolname limited logging succsess"
 	tst_res TPASS "$toolname can log packets with limited rate"
 }
+
+. tst_net.sh
diff --git a/testcases/network/iptables/nft01.sh b/testcases/network/iptables/nft01.sh
index bf2a53c28..2bb5779d2 100755
--- a/testcases/network/iptables/nft01.sh
+++ b/testcases/network/iptables/nft01.sh
@@ -9,8 +9,6 @@ use_iptables=0
 cleanup_table=0
 cleanup_chain=0
 
-. iptables_lib.sh
-
 do_setup()
 {
 	init
@@ -35,4 +33,5 @@ do_cleanup()
 	cleanup
 }
 
+. iptables_lib.sh
 tst_run
diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
index c7788b546..196b5b2f9 100755
--- a/testcases/network/mpls/mpls01.sh
+++ b/testcases/network/mpls/mpls01.sh
@@ -12,7 +12,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_DRIVERS="mpls_router"
 TST_NEEDS_CMDS="sysctl modprobe"
 
-. tst_net.sh
 
 cleanup()
 {
@@ -67,4 +66,5 @@ test3()
 	tst_res TPASS "created and removed mpls routes"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/mpls/mpls02.sh b/testcases/network/mpls/mpls02.sh
index 2fd3ec5bf..a35149ef2 100755
--- a/testcases/network/mpls/mpls02.sh
+++ b/testcases/network/mpls/mpls02.sh
@@ -6,8 +6,6 @@ TST_SETUP="setup"
 TST_TESTFUNC="do_test"
 TST_CLEANUP="cleanup"
 
-. mpls_lib.sh
-
 cleanup()
 {
 	ip route del $ip_rmt/$mask > /dev/null 2>&1
@@ -50,4 +48,5 @@ do_test()
 	fi
 }
 
+. mpls_lib.sh
 tst_run
diff --git a/testcases/network/mpls/mpls03.sh b/testcases/network/mpls/mpls03.sh
index 0db6dbf0f..fd9dd588b 100755
--- a/testcases/network/mpls/mpls03.sh
+++ b/testcases/network/mpls/mpls03.sh
@@ -6,9 +6,6 @@ TST_SETUP="setup"
 TST_TESTFUNC="mpls_virt_test"
 TST_CLEANUP="mpls_virt_cleanup"
 
-. virt_lib.sh
-. mpls_lib.sh
-
 setup()
 {
 	virt_type="gre"
@@ -21,4 +18,6 @@ setup()
 	mpls_virt_setup
 }
 
+. virt_lib.sh
+. mpls_lib.sh
 tst_run
diff --git a/testcases/network/mpls/mpls04.sh b/testcases/network/mpls/mpls04.sh
index 639a13ef8..aae4b3513 100755
--- a/testcases/network/mpls/mpls04.sh
+++ b/testcases/network/mpls/mpls04.sh
@@ -6,9 +6,6 @@ TST_SETUP="setup"
 TST_TESTFUNC="mpls_virt_test"
 TST_CLEANUP="mpls_virt_cleanup"
 
-. virt_lib.sh
-. mpls_lib.sh
-
 setup()
 {
 	virt_type="sit"
@@ -16,4 +13,6 @@ setup()
 	mpls_virt_setup
 }
 
+. virt_lib.sh
+. mpls_lib.sh
 tst_run
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 30e069581..380b568bb 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2018-2022
 # Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
 
 TST_MIN_KVER="4.3"
@@ -9,7 +10,6 @@ TST_NEEDS_DRIVERS="mpls_router mpls_iptunnel mpls_gso"
 TST_NEEDS_CMDS="sysctl modprobe"
 TST_TEST_DATA="icmp tcp udp"
 TST_NETLOAD_BINDTODEVICE=
-. tst_net.sh
 
 mpls_cleanup()
 {
@@ -96,3 +96,5 @@ mpls_virt_test()
 		tst_netload -S $ip6_virt_local -H $ip6_virt_remote -T $type -A $max_size
 	fi
 }
+
+. tst_net.sh
diff --git a/testcases/network/multicast/mc_cmds/mc_cmds.sh b/testcases/network/multicast/mc_cmds/mc_cmds.sh
index 00bbbeedf..bd59f3a16 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds.sh
+++ b/testcases/network/multicast/mc_cmds/mc_cmds.sh
@@ -28,9 +28,8 @@
 
 TCID=mc_cmds
 TST_TOTAL=1
-
+TST_CLEANUP=do_cleanup
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 knob="net.ipv4.icmp_echo_ignore_broadcasts"
 knob_changed=
@@ -92,7 +91,6 @@ do_cleanup()
 	tst_rmdir
 }
 
+. tst_net.sh
 setup
-TST_CLEANUP=do_cleanup
-
 do_test
diff --git a/testcases/network/multicast/mc_commo/mc_commo.sh b/testcases/network/multicast/mc_commo/mc_commo.sh
index b5370801a..bc47fda2c 100755
--- a/testcases/network/multicast/mc_commo/mc_commo.sh
+++ b/testcases/network/multicast/mc_commo/mc_commo.sh
@@ -30,9 +30,8 @@ OUTFILE=mc_commo_out
 
 TCID=mc_commo
 TST_TOTAL=2
-
+TST_CLEANUP=do_cleanup
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 do_setup()
 {
@@ -88,8 +87,8 @@ do_cleanup()
 	tst_rmdir
 }
 
+. tst_net.sh
 do_setup
-TST_CLEANUP=do_cleanup
 
 for i in $(seq 1 $TST_TOTAL); do
 	do_test
diff --git a/testcases/network/multicast/mc_member/mc_member.sh b/testcases/network/multicast/mc_member/mc_member.sh
index f41b03ace..5f44a1cee 100755
--- a/testcases/network/multicast/mc_member/mc_member.sh
+++ b/testcases/network/multicast/mc_member/mc_member.sh
@@ -32,9 +32,8 @@ ERRFILE=${ERRFILE:-errors}
 TCID=mc_member
 TST_TOTAL=1
 TST_COUNT=1
-
+TST_CLEANUP=do_cleanup
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 setup()
 {
@@ -133,7 +132,6 @@ do_cleanup()
 	tst_rmdir
 }
 
+. tst_net.sh
 setup
-TST_CLEANUP=do_cleanup
-
 do_test
diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index 58712e879..9bb46ad6e 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -10,8 +10,6 @@
 
 TST_TESTFUNC="do_test"
 
-. nfs_lib.sh
-
 do_test()
 {
 	ITERATIONS=${ITERATIONS:=50000}
@@ -25,4 +23,5 @@ do_test()
 	fi
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs01.sh b/testcases/network/nfs/nfs_stress/nfs01.sh
index 356e967ea..b21ec7899 100755
--- a/testcases/network/nfs/nfs_stress/nfs01.sh
+++ b/testcases/network/nfs/nfs_stress/nfs01.sh
@@ -10,8 +10,6 @@
 
 TST_TESTFUNC="do_test"
 
-. nfs_lib.sh
-
 do_test()
 {
 	tst_res TINFO "starting 'nfs01_open_files $NFILES'"
@@ -19,4 +17,5 @@ do_test()
 	tst_res TPASS "test finished successfully"
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs02.sh b/testcases/network/nfs/nfs_stress/nfs02.sh
index e80909b9a..b7fbbce9c 100755
--- a/testcases/network/nfs/nfs_stress/nfs02.sh
+++ b/testcases/network/nfs/nfs_stress/nfs02.sh
@@ -12,8 +12,6 @@ TST_CNT=3
 TST_TESTFUNC="do_test"
 LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"
 
-. nfs_lib.sh
-
 do_test1()
 {
 	tst_res TINFO "do_test1 $TC"
@@ -48,4 +46,5 @@ do_test3()
 	tst_res TPASS "test3 passed"
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs03.sh b/testcases/network/nfs/nfs_stress/nfs03.sh
index d68456d3a..e5f4de67c 100755
--- a/testcases/network/nfs/nfs_stress/nfs03.sh
+++ b/testcases/network/nfs/nfs_stress/nfs03.sh
@@ -8,8 +8,6 @@ TST_CLEANUP="nfs03_cleanup"
 TST_SETUP="nfs03_setup"
 TST_TESTFUNC="do_test"
 
-. nfs_lib.sh
-
 DIR_NUM=${DIR_NUM:-"100"}
 FILE_NUM=${FILE_NUM:-"100"}
 THREAD_NUM=${THREAD_NUM:-"1"}
@@ -92,4 +90,5 @@ nfs03_cleanup()
 	nfs_cleanup
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs04.sh b/testcases/network/nfs/nfs_stress/nfs04.sh
index 1f59af580..b58bebfab 100755
--- a/testcases/network/nfs/nfs_stress/nfs04.sh
+++ b/testcases/network/nfs/nfs_stress/nfs04.sh
@@ -12,7 +12,6 @@
 # Created by: Robbie Williamson (robbiew@us.ibm.com)
 
 TST_TESTFUNC="do_test"
-. nfs_lib.sh
 
 do_test()
 {
@@ -21,4 +20,5 @@ do_test()
     tst_res TPASS "Test finished"
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs05.sh b/testcases/network/nfs/nfs_stress/nfs05.sh
index 7ddf8239e..c18ef1ab4 100755
--- a/testcases/network/nfs/nfs_stress/nfs05.sh
+++ b/testcases/network/nfs/nfs_stress/nfs05.sh
@@ -14,8 +14,6 @@ THREAD_NUM=${THREAD_NUM:-"8"}
 TST_NEEDS_CMDS="make gcc"
 TST_TESTFUNC="do_test"
 
-. nfs_lib.sh
-
 do_test()
 {
     tst_res TINFO "start nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM"
@@ -24,4 +22,5 @@ do_test()
     tst_res TPASS "test finished"
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs06.sh b/testcases/network/nfs/nfs_stress/nfs06.sh
index 3d3e843ac..d51f7dc82 100755
--- a/testcases/network/nfs/nfs_stress/nfs06.sh
+++ b/testcases/network/nfs/nfs_stress/nfs06.sh
@@ -10,7 +10,6 @@
 
 TST_TESTFUNC="do_test"
 TST_CLEANUP="do_cleanup"
-. nfs_lib.sh
 
 THREAD_NUM=${THREAD_NUM:-"2"}
 
@@ -42,4 +41,5 @@ do_test()
 	tst_res TPASS "all fsstress processes completed on '$n' NFS mounts"
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs07.sh b/testcases/network/nfs/nfs_stress/nfs07.sh
index 7e5cc85ca..34f60cb44 100755
--- a/testcases/network/nfs/nfs_stress/nfs07.sh
+++ b/testcases/network/nfs/nfs_stress/nfs07.sh
@@ -8,9 +8,10 @@
 FILE_COUNT=5000
 
 TST_OPTS="n:"
-TST_PARSE_ARGS=do_parse_args
+TST_PARSE_ARGS="do_parse_args"
 TST_TESTFUNC="do_test"
 TST_SETUP="do_setup"
+TST_USAGE="show_usage"
 
 do_parse_args()
 {
@@ -19,10 +20,6 @@ do_parse_args()
 	esac
 }
 
-. nfs_lib.sh
-
-TST_USAGE="show_usage"
-
 show_usage()
 {
 	nfs_usage
@@ -64,4 +61,5 @@ do_test()
 	tst_res TPASS "All files and directories were correctly listed"
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 55ce1e11a..af7d46a21 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2016-2022
 # Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 
@@ -39,8 +40,6 @@ TST_NEEDS_DRIVERS="nfsd"
 # debugging whether test failures are related to veth/netns).
 LTP_NFS_NETNS_USE_LO=${LTP_NFS_NETNS_USE_LO:-}
 
-. tst_net.sh
-
 get_socket_type()
 {
 	local t
@@ -205,3 +204,5 @@ nfs_cleanup()
 		n=$(( n + 1 ))
 	done
 }
+
+. tst_net.sh
diff --git a/testcases/network/nfs/nfslock01/nfslock01.sh b/testcases/network/nfs/nfslock01/nfslock01.sh
index ee994eb20..b356b48ae 100755
--- a/testcases/network/nfs/nfslock01/nfslock01.sh
+++ b/testcases/network/nfs/nfslock01/nfslock01.sh
@@ -12,8 +12,6 @@
 TST_SETUP="do_setup"
 TST_TESTFUNC="do_test"
 
-. nfs_lib.sh
-
 LUSER=${LUSER:=root}
 
 do_setup()
@@ -62,4 +60,5 @@ do_test()
 	fi
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index 06844af39..6589c0930 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -6,8 +6,6 @@
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="nfsstat"
 
-. nfs_lib.sh
-
 get_calls()
 {
 	local name=$1
@@ -93,4 +91,5 @@ do_test()
 	fi
 }
 
+. nfs_lib.sh
 tst_run
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
index a4989b98f..b803e4331 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_CLEANUP=do_cleanup
 TST_NEEDS_CMDS="pkill rpcinfo"
-. rpc_lib.sh
 
 NUMLOOPS=${NUMLOOPS:-3}
 DATAFILES="${DATAFILES:-file.1 file.2}"
@@ -45,4 +44,5 @@ do_test()
 	done
 }
 
+. rpc_lib.sh
 tst_run
diff --git a/testcases/network/rpc/basic_tests/rpc_lib.sh b/testcases/network/rpc/basic_tests/rpc_lib.sh
index 256920e1e..28b675ff3 100644
--- a/testcases/network/rpc/basic_tests/rpc_lib.sh
+++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
@@ -1,8 +1,7 @@
 #!/bin/sh
-# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2022 Petr Vorel <pvorel@suse.cz>
 
 TST_NEEDS_CMDS="rpcinfo $TST_NEEDS_CMDS"
-. tst_net.sh
 
 check_rpc()
 {
@@ -19,3 +18,5 @@ check_rpc()
 	tst_res TINFO "registered RPC:"
 	echo "$services"
 }
+
+. tst_net.sh
diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
index ade971122..723db3d71 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="rpcinfo wc"
-. rpc_lib.sh
 
 do_setup()
 {
@@ -53,4 +52,5 @@ do_test()
 	EXPECT_RHOST_FAIL rpcinfo -u $thost 100000 5
 }
 
+. rpc_lib.sh
 tst_run
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index e1d952da8..cadae5520 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -17,7 +17,6 @@ TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_PARSE_ARGS=rpc_parse_args
 TST_NEEDS_CMDS="pkill rpcinfo"
-. rpc_lib.sh
 
 usage()
 {
@@ -91,4 +90,5 @@ do_test()
 	EXPECT_RHOST_PASS $CLIENT $(tst_ipaddr) $PROGNUMNOSVC $CLIENT_EXTRA_OPTS
 }
 
+. rpc_lib.sh
 tst_run
diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index a42bd4975..4dfef86ea 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -9,7 +9,6 @@ TST_NEEDS_ROOT=1
 TST_TEST_DATA=",-A 65000"
 TST_TEST_DATA_IFS=","
 
-. tst_net.sh
 
 test()
 {
@@ -26,4 +25,5 @@ test()
 	tst_netload_compare $res0 $res1 -200 200
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/sockets/bind_noport01.sh b/testcases/network/sockets/bind_noport01.sh
index 4eec4fd9c..19235afc7 100755
--- a/testcases/network/sockets/bind_noport01.sh
+++ b/testcases/network/sockets/bind_noport01.sh
@@ -8,7 +8,6 @@ TST_MIN_KVER="4.2"
 TST_NEEDS_TMPDIR=1
 TST_TEST_DATA="tcp udp udp_lite dccp"
 
-. tst_net.sh
 
 test1()
 {
@@ -31,4 +30,5 @@ test2()
 }
 
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-checksum.sh b/testcases/network/stress/broken_ip/broken_ip-checksum.sh
index c04038d8d..64b1ac411 100755
--- a/testcases/network/stress/broken_ip/broken_ip-checksum.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-checksum.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-dstaddr.sh b/testcases/network/stress/broken_ip/broken_ip-dstaddr.sh
index 9ba8c8167..56a9724e6 100755
--- a/testcases/network/stress/broken_ip/broken_ip-dstaddr.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-dstaddr.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -15,4 +14,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-fragment.sh b/testcases/network/stress/broken_ip/broken_ip-fragment.sh
index 6b8f25549..95efb6342 100755
--- a/testcases/network/stress/broken_ip/broken_ip-fragment.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-fragment.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-ihl.sh b/testcases/network/stress/broken_ip/broken_ip-ihl.sh
index 483cd5260..6588a165e 100755
--- a/testcases/network/stress/broken_ip/broken_ip-ihl.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-ihl.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
index ec6643af6..805b1f5ab 100755
--- a/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-nexthdr.sh
@@ -6,17 +6,17 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
-	# not supported on IPv4
-	TST_IPV6=6
-	TST_IPVER=6
-
 	tst_res TINFO "Sending ICMPv6 with wrong next header for $NS_DURATION sec"
 	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $NS_ICMPV6_SENDER_DATA_MAXSIZE" -n
 	tst_ping
 }
 
+. tst_net.sh
+# not supported on IPv4
+TST_IPV6=6
+TST_IPVER=6
+
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-plen.sh b/testcases/network/stress/broken_ip/broken_ip-plen.sh
index e757507df..2108a957e 100755
--- a/testcases/network/stress/broken_ip/broken_ip-plen.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-plen.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -15,4 +14,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-protcol.sh b/testcases/network/stress/broken_ip/broken_ip-protcol.sh
index 0483b5556..1563266a8 100755
--- a/testcases/network/stress/broken_ip/broken_ip-protcol.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-protcol.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/broken_ip/broken_ip-version.sh b/testcases/network/stress/broken_ip/broken_ip-version.sh
index 535a07f9b..4c80f2307 100755
--- a/testcases/network/stress/broken_ip/broken_ip-version.sh
+++ b/testcases/network/stress/broken_ip/broken_ip-version.sh
@@ -6,7 +6,6 @@
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_TESTFUNC="do_test"
-. tst_net.sh
 
 do_test()
 {
@@ -15,4 +14,5 @@ do_test()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index ff86063f6..50c45b8b7 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -8,7 +8,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_SETUP=tst_ipsec_setup
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	tst_netload -H $(tst_ipaddr rhost) -T dccp $opts -r $IPSEC_REQUESTS
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index 24c28fbde..566c36d16 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -8,7 +8,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_SETUP=tst_ipsec_setup_vti
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	tst_netload -H $ip_rmt_tun -T dccp $opts -r $IPSEC_REQUESTS -D $tst_vti
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/dns/dns-stress.sh b/testcases/network/stress/dns/dns-stress.sh
index dfc2ed5e0..c90366605 100755
--- a/testcases/network/stress/dns/dns-stress.sh
+++ b/testcases/network/stress/dns/dns-stress.sh
@@ -23,7 +23,6 @@ TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 # Minimum host ID in the zone file.
 # The ID is used as the host portion of the address
@@ -196,13 +195,10 @@ test02()
 	tst_resm TPASS "Test is finished successfully"
 }
 
+. tst_net.sh
 common_setup
-
 setup_$TST_IPVER
-
 start_named
-
 test01
 test02
-
 tst_exit
diff --git a/testcases/network/stress/ftp/ftp-download-stress.sh b/testcases/network/stress/ftp/ftp-download-stress.sh
index 4320bbd6f..44d8b8ef6 100755
--- a/testcases/network/stress/ftp/ftp-download-stress.sh
+++ b/testcases/network/stress/ftp/ftp-download-stress.sh
@@ -24,7 +24,6 @@ TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 # Big file size to upload/download in ftp tests (byte)
 DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-2147483647}
@@ -90,9 +89,8 @@ test02()
 	tst_resm TPASS "Test is finished successfully"
 }
 
+. tst_net.sh
 setup
-
 test01
 test02
-
 tst_exit
diff --git a/testcases/network/stress/ftp/ftp-upload-stress.sh b/testcases/network/stress/ftp/ftp-upload-stress.sh
index 602dc4ed6..cfd7d8765 100755
--- a/testcases/network/stress/ftp/ftp-upload-stress.sh
+++ b/testcases/network/stress/ftp/ftp-upload-stress.sh
@@ -24,7 +24,6 @@ TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 # Big file size to upload (byte)
 UPLOAD_BIGFILESIZE=${UPLOAD_BIGFILESIZE:-2147483647}  # 2GB - 1
@@ -98,9 +97,8 @@ test02()
 	tst_resm TPASS "Test is finished successfully"
 }
 
+. tst_net.sh
 setup
-
 test01
 test02
-
 tst_exit
diff --git a/testcases/network/stress/http/http-stress.sh b/testcases/network/stress/http/http-stress.sh
index 31fe5af8e..562a49fb2 100755
--- a/testcases/network/stress/http/http-stress.sh
+++ b/testcases/network/stress/http/http-stress.sh
@@ -24,7 +24,6 @@ TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 cleanup()
 {
@@ -74,9 +73,8 @@ test02()
 	tst_resm TPASS "Test is finished successfully"
 }
 
+. tst_net.sh
 setup
-
 test01
 test02
-
 tst_exit
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 2ae616cc3..af65c853a 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Hangbin Liu <haliu@redhat.com>
@@ -8,7 +8,6 @@
 TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_setup()
 {
@@ -22,4 +21,5 @@ do_test()
 	tst_ping -s $2
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index 18bc71cfb..ea3e4c45e 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -1,13 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_setup()
 {
@@ -21,4 +20,5 @@ do_test()
 	tst_ping -I $tst_vti -H $ip_rmt_tun -s $2
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if-addr-adddel.sh b/testcases/network/stress/interface/if-addr-adddel.sh
index f8f0d11d2..cb453e612 100755
--- a/testcases/network/stress/interface/if-addr-adddel.sh
+++ b/testcases/network/stress/interface/if-addr-adddel.sh
@@ -1,12 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 IF_CMD='ifconfig'
-. if-lib.sh
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
@@ -89,4 +88,5 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
+. if-lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if-addr-addlarge.sh b/testcases/network/stress/interface/if-addr-addlarge.sh
index 3cf7397eb..3c876c17d 100755
--- a/testcases/network/stress/interface/if-addr-addlarge.sh
+++ b/testcases/network/stress/interface/if-addr-addlarge.sh
@@ -1,12 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 IF_CMD='ifconfig'
-. if-lib.sh
 
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
@@ -110,4 +109,5 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
+. if-lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 2b1db6e00..b6f7668fa 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Author: Petr Vorel <pvorel@suse.cz>
 
 CMD="${CMD:-ip}"
@@ -14,7 +14,6 @@ TST_TESTFUNC="test_body"
 TST_PARSE_ARGS="if_parse_args"
 TST_USAGE="if_usage"
 TST_OPTS="c:"
-. tst_net_stress.sh
 
 if_usage()
 {
@@ -44,3 +43,5 @@ if_cleanup_restore()
 	restore_ipaddr
 	restore_ipaddr rhost
 }
+
+. tst_net_stress.sh
diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index d57f0bbe3..1fb667c19 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
@@ -8,7 +8,6 @@
 IF_CMD='ifconfig'
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
-. if-lib.sh
 
 # CHANGE_INTERVAL: The interval of the mtu change
 TST_TIMEOUT=1
@@ -117,4 +116,5 @@ test_body()
 	done
 }
 
+. if-lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if-route-adddel.sh b/testcases/network/stress/interface/if-route-adddel.sh
index 45ca5d51a..b50da268a 100755
--- a/testcases/network/stress/interface/if-route-adddel.sh
+++ b/testcases/network/stress/interface/if-route-adddel.sh
@@ -1,12 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 IF_CMD='route'
-. if-lib.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
@@ -64,4 +63,5 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
+. if-lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if-route-addlarge.sh b/testcases/network/stress/interface/if-route-addlarge.sh
index 14de3f6ce..7d09d1216 100755
--- a/testcases/network/stress/interface/if-route-addlarge.sh
+++ b/testcases/network/stress/interface/if-route-addlarge.sh
@@ -1,12 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 IF_CMD='route'
-. if-lib.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
 
@@ -76,4 +75,5 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
+. if-lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if-updown.sh b/testcases/network/stress/interface/if-updown.sh
index 094e57ac9..9a5709c85 100755
--- a/testcases/network/stress/interface/if-updown.sh
+++ b/testcases/network/stress/interface/if-updown.sh
@@ -1,13 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 IF_CMD='ifconfig'
 TST_CLEANUP="if_cleanup_restore"
-. if-lib.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
 
@@ -47,4 +46,5 @@ test_body()
 	tst_res TPASS "Test is finished correctly"
 }
 
+. if-lib.sh
 tst_run
diff --git a/testcases/network/stress/interface/if4-addr-change.sh b/testcases/network/stress/interface/if4-addr-change.sh
index 5af8fb980..b9ece2af9 100755
--- a/testcases/network/stress/interface/if4-addr-change.sh
+++ b/testcases/network/stress/interface/if4-addr-change.sh
@@ -8,7 +8,6 @@
 TST_CLEANUP="do_cleanup"
 TST_TESTFUNC="test_body"
 TST_NEEDS_CMDS="ifconfig"
-. tst_net.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 # Maximum host portion of the IPv4 address on the local host
@@ -61,4 +60,5 @@ test_body()
 	tst_ping
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 99fed0808..27f2595f6 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Hangbin Liu <haliu@redhat.com>
@@ -16,6 +16,11 @@ CALGO="deflate"
 
 IPSEC_REQUESTS="500"
 
+TST_OPTS="l:m:p:s:S:k:A:e:a:c:r:"
+TST_PARSE_ARGS=ipsec_lib_parse_args
+TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
+TST_USAGE=ipsec_lib_usage
+
 ipsec_lib_usage()
 {
 	echo "l n     n is the number of test link when tests run"
@@ -89,12 +94,6 @@ ipsec_lib_setup()
 	fi
 }
 
-TST_OPTS="l:m:p:s:S:k:A:e:a:c:r:"
-TST_PARSE_ARGS=ipsec_lib_parse_args
-TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
-TST_USAGE=ipsec_lib_usage
-. tst_net.sh
-
 get_key()
 {
 	local bits=$1
@@ -318,3 +317,5 @@ tst_ipsec_setup_vti()
 	ROD ip addr add $ip_loc_tun/$mask dev $tst_vti $address_opt
 	tst_rhost_run -s -c "ip addr add $ip_rmt_tun/$mask dev $tst_vti"
 }
+
+. tst_net.sh
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
index abd2dabb3..004098396 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
@@ -9,7 +9,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="do_setup"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_setup()
 {
@@ -28,4 +27,5 @@ do_test()
 	do_multicast_test_multiple_join $MCASTNUM_HEAVY true
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
index 33df2e422..cc1bd00a3 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
@@ -9,7 +9,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -17,4 +16,5 @@ do_test()
 	do_multicast_test_join_leave $MCASTNUM_NORMAL
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
index 10c65918f..00d0f150a 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
@@ -9,7 +9,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="do_setup"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_setup()
 {
@@ -22,4 +21,5 @@ do_test()
 	do_multicast_test_multiple_join $MCASTNUM_HEAVY
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
index 19bd426a4..0da2f5f64 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
@@ -9,7 +9,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -17,4 +16,5 @@ do_test()
 	do_multicast_test_join_leave $MCASTNUM_NORMAL true
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index cfc8a1b49..f890deea9 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -1,13 +1,11 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2017-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines Corp., 2006
 # Author: Petr Vorel <pvorel@suse.cz>
 #
 # Setup script for multicast stress tests.
 
-. tst_net_stress.sh
-
 mcast_setup4()
 {
 	local igmp_max_memberships="$1"
@@ -164,3 +162,5 @@ do_multicast_test_join_single_socket()
 	[ "$TST_IPV6" ] && params="-S $(tst_ipaddr) -m"
 	EXPECT_RHOST_PASS $MCAST_RCMD -t $NS_DURATION -r 0 $params $extra
 }
+
+. tst_net_stress.sh
diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
index cc1b8410c..52138d227 100755
--- a/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
+++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
@@ -12,7 +12,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal_udp"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -33,4 +32,5 @@ do_test()
 	tst_res TPASS "test finished successfully"
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
index 3394e0262..59c88806e 100755
--- a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
+++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
@@ -13,7 +13,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal_udp"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -50,4 +49,5 @@ do_test()
 	tst_res TPASS "test finished successfully"
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
index e80026720..d23cc0f17 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
@@ -13,7 +13,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -23,4 +22,5 @@ do_test()
 	do_multicast_test_join_single_socket
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
index 8773bd86b..7c1cda2d5 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
@@ -14,7 +14,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -27,4 +26,5 @@ do_test()
 	do_multicast_test_join_single_socket "$extra"
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh
index 8ab9af544..7bac7e7d6 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh
@@ -13,7 +13,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 SRC_ADDR_IPV4="10.10.10.1"
 SRC_ADDR_IPV6="fec0:100:100:100::1"
@@ -41,4 +40,5 @@ do_test()
 	EXPECT_RHOST_PASS $MCAST_RCMD -t $NS_DURATION -r 0 $params
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh
index 5947562f1..25923b231 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh
@@ -12,7 +12,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -32,4 +31,5 @@ do_test()
 	EXPECT_RHOST_PASS $MCAST_RCMD -t $NS_DURATION -r 0 $params
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh
index 3c064842f..de3d11b1d 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh
@@ -13,7 +13,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 do_test()
 {
@@ -52,4 +51,5 @@ do_test()
 	tst_res TPASS "test finished successfully"
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh
index bda064f7d..e0548e166 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh
@@ -13,7 +13,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
 TST_CLEANUP="mcast_cleanup"
 TST_TESTFUNC="do_test"
-. mcast-lib.sh
 
 SRC_ADDR_IPV4=10.10.10.1
 SRC_ADDR_IPV6=fec0:100:100:100::1
@@ -60,4 +59,5 @@ do_test()
 	tst_res TPASS "test finished successfully"
 }
 
+. mcast-lib.sh
 tst_run
diff --git a/testcases/network/stress/ns-tools/tst_net_stress.sh b/testcases/network/stress/ns-tools/tst_net_stress.sh
index 4b00ee7f8..6d8c5459a 100644
--- a/testcases/network/stress/ns-tools/tst_net_stress.sh
+++ b/testcases/network/stress/ns-tools/tst_net_stress.sh
@@ -10,8 +10,6 @@
 # NOTE: More information about network variables can be found
 # in tst_net.sh and testcases/network/stress/README.
 
-. tst_net.sh
-
 # Netmask of for the tested network
 IPV4_NETMASK="255.255.255.0"
 IPV4_NETMASK_NUM=24
@@ -122,3 +120,5 @@ test_rt_ip()
 	2) test_body 'ip_cmd';;
 	esac
 }
+
+. tst_net.sh
diff --git a/testcases/network/stress/route/route-change-dst.sh b/testcases/network/stress/route/route-change-dst.sh
index 2d88b5f73..a113f24d2 100755
--- a/testcases/network/stress/route/route-change-dst.sh
+++ b/testcases/network/stress/route/route-change-dst.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 # Rewrite into new shell API: Petr Vorel
@@ -11,8 +11,6 @@
 TST_SETUP="setup"
 TST_CLEANUP="route_cleanup"
 TST_TESTFUNC="test_dst"
-. route-lib.sh
-TST_CNT=$ROUTE_CHANGE_IP
 
 setup()
 {
@@ -34,4 +32,6 @@ test_dst()
 	tst_del_ipaddr -s -q -a $rhost rhost
 }
 
+. route-lib.sh
+TST_CNT=$ROUTE_CHANGE_IP
 tst_run
diff --git a/testcases/network/stress/route/route-change-gw.sh b/testcases/network/stress/route/route-change-gw.sh
index 6c650befd..58c94e57d 100755
--- a/testcases/network/stress/route/route-change-gw.sh
+++ b/testcases/network/stress/route/route-change-gw.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 # Rewrite into new shell API: Petr Vorel
@@ -11,8 +11,6 @@
 TST_SETUP="setup"
 TST_CLEANUP="route_cleanup"
 TST_TESTFUNC="test_gw"
-. route-lib.sh
-TST_CNT=$ROUTE_CHANGE_IP
 
 setup()
 {
@@ -34,4 +32,6 @@ test_gw()
 	tst_del_ipaddr -s -q -a $gw rhost
 }
 
+. route-lib.sh
+TST_CNT=$ROUTE_CHANGE_IP
 tst_run
diff --git a/testcases/network/stress/route/route-change-if.sh b/testcases/network/stress/route/route-change-if.sh
index 7e9c15fe4..665adceb6 100755
--- a/testcases/network/stress/route/route-change-if.sh
+++ b/testcases/network/stress/route/route-change-if.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines Corp., 2006
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 # Rewrite into new shell API: Petr Vorel
@@ -11,8 +11,6 @@
 TST_SETUP="setup"
 TST_CLEANUP="cleanup_if"
 TST_TESTFUNC="test_if"
-. route-lib.sh
-TST_CNT=$ROUTE_CHANGE_IP
 
 setup()
 {
@@ -38,4 +36,6 @@ test_if()
 	tst_del_ipaddr -s -q -a $gw rhost $link_num
 }
 
+. route-lib.sh
+TST_CNT=$ROUTE_CHANGE_IP
 tst_run
diff --git a/testcases/network/stress/route/route-change-netlink-dst.sh b/testcases/network/stress/route/route-change-netlink-dst.sh
index 0740d0963..7e8fd99a7 100755
--- a/testcases/network/stress/route/route-change-netlink-dst.sh
+++ b/testcases/network/stress/route/route-change-netlink-dst.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2022 Petr Vorel <pvorel@suse.cz>
 #
 # Change route destination via netlink
 # rhost: 10.23.x.1
@@ -9,7 +9,6 @@
 TST_SETUP="setup"
 TST_CLEANUP="route_cleanup"
 TST_TESTFUNC="test_netlink"
-. route-lib.sh
 
 setup()
 {
@@ -33,4 +32,5 @@ setup()
 	ROUTE_CHANGE_NETLINK_PARAMS="-d $(tst_iface) -r '$rhost_all'"
 }
 
+. route-lib.sh
 tst_run
diff --git a/testcases/network/stress/route/route-change-netlink-gw.sh b/testcases/network/stress/route/route-change-netlink-gw.sh
index 3119a1b31..574977fce 100755
--- a/testcases/network/stress/route/route-change-netlink-gw.sh
+++ b/testcases/network/stress/route/route-change-netlink-gw.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2022 Petr Vorel <pvorel@suse.cz>
 #
 # Change route gateway via netlink
 # gw (on rhost): 10.23.1.x, rhost: 10.23.0.1
@@ -9,7 +9,6 @@
 TST_SETUP="setup"
 TST_CLEANUP="route_cleanup"
 TST_TESTFUNC="test_netlink"
-. route-lib.sh
 
 setup()
 {
@@ -30,4 +29,5 @@ setup()
 	ROUTE_CHANGE_NETLINK_PARAMS="-d $(tst_iface) -g "$gw_all" -r $rhost"
 }
 
+. route-lib.sh
 tst_run
diff --git a/testcases/network/stress/route/route-change-netlink-if.sh b/testcases/network/stress/route/route-change-netlink-if.sh
index d1e64a40e..a28de02f7 100755
--- a/testcases/network/stress/route/route-change-netlink-if.sh
+++ b/testcases/network/stress/route/route-change-netlink-if.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2022 Petr Vorel <pvorel@suse.cz>
 #
 # Change route interface
 # gw (on rhost): 10.23.x.1, rhost: 10.23.0.1, switching ifaces on lhost
@@ -9,7 +9,6 @@
 TST_SETUP="setup"
 TST_CLEANUP="cleanup_if"
 TST_TESTFUNC="test_netlink"
-. route-lib.sh
 
 setup()
 {
@@ -36,4 +35,5 @@ setup()
 	ROUTE_CHANGE_NETLINK_PARAMS="-d '$iface_all' -g '$gw_all' -r $rhost"
 }
 
+. route-lib.sh
 tst_run
diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
index 194bd40cc..163c15423 100644
--- a/testcases/network/stress/route/route-lib.sh
+++ b/testcases/network/stress/route/route-lib.sh
@@ -1,10 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2019-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="ip"
-. tst_net.sh
 
 ROUTE_RHOST_PORT=${ROUTE_RHOST_PORT:-65535}
 ROUTE_MAX_IP=${ROUTE_MAX_IP:-5}
@@ -107,3 +106,5 @@ test_netlink()
 	fi
 	tst_res TPASS "$cmd passed"
 }
+
+. tst_net.sh
diff --git a/testcases/network/stress/route/route-redirect.sh b/testcases/network/stress/route/route-redirect.sh
index d77c37a7d..f65e14959 100755
--- a/testcases/network/stress/route/route-redirect.sh
+++ b/testcases/network/stress/route/route-redirect.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2006 International Business Machines  Corp.
 # Copyright (c) 2020 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 #
 # Verify the kernel is not crashed when the route is modified by
@@ -13,8 +14,6 @@ TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="ip"
 
-. route-lib.sh
-
 DST_HOST=
 DST_PORT="7"
 
@@ -59,4 +58,5 @@ do_test()
 	tst_res TPASS "test finished successfully"
 }
 
+. route-lib.sh
 tst_run
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index 4ec204165..e9aa950e4 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -8,7 +8,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_SETUP=tst_ipsec_setup
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_test()
 {
@@ -20,4 +19,5 @@ do_test()
 		-r $IPSEC_REQUESTS -S $(tst_ipaddr)
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index 9c5747121..c22eb02e4 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -8,7 +8,6 @@ TST_NEEDS_TMPDIR=1
 TST_SETUP=tst_ipsec_setup_vti
 TST_CLEANUP=tst_ipsec_cleanup
 TST_TESTFUNC=do_test
-. ipsec_lib.sh
 
 do_test()
 {
@@ -20,4 +19,5 @@ do_test()
 		-S $ip_loc_tun -D $tst_vti
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
index baf1a7896..e7c4d45ce 100755
--- a/testcases/network/stress/ssh/ssh-stress.sh
+++ b/testcases/network/stress/ssh/ssh-stress.sh
@@ -13,7 +13,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="sshd ssh ssh-keygen od pkill pgrep"
 
-. tst_net.sh
 
 # SSH config file on the remote host
 RHOST_SSH_CONF=
@@ -230,4 +229,5 @@ test3()
 	tst_res TPASS "Test finished successfully"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index 5c467034e..12662274e 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -8,7 +8,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_SETUP=tst_ipsec_setup
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 max_requests=10
 
@@ -22,4 +21,5 @@ do_test()
 		-R $max_requests
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index 41ab1ca98..925011aed 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -8,7 +8,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_SETUP=tst_ipsec_setup_vti
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 max_requests=10
 
@@ -22,4 +21,5 @@ do_test()
 		    -R $max_requests -D $tst_vti
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 1e10d208c..628888eac 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -9,7 +9,6 @@ TST_TESTFUNC=do_test
 TST_SETUP=tst_ipsec_setup
 TST_CNT=2
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_test()
 {
@@ -22,4 +21,5 @@ do_test()
 	tst_netload -H $(tst_ipaddr rhost) -T $type $opts -r $IPSEC_REQUESTS
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index d9a1e33af..1cf429123 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
@@ -9,7 +9,6 @@ TST_TESTFUNC=do_test
 TST_CNT=2
 TST_SETUP=tst_ipsec_setup_vti
 TST_CLEANUP=tst_ipsec_cleanup
-. ipsec_lib.sh
 
 do_test()
 {
@@ -22,4 +21,5 @@ do_test()
 	tst_netload -H $ip_rmt_tun -T $type $opts -r $IPSEC_REQUESTS -D $tst_vti
 }
 
+. ipsec_lib.sh
 tst_run
diff --git a/testcases/network/tcp_cc/bbr01.sh b/testcases/network/tcp_cc/bbr01.sh
index e26abb188..c2219d2fd 100755
--- a/testcases/network/tcp_cc/bbr01.sh
+++ b/testcases/network/tcp_cc/bbr01.sh
@@ -7,8 +7,6 @@ TST_TESTFUNC="do_test"
 TST_CLEANUP="cleanup"
 TST_MIN_KVER="4.13"
 
-. tcp_cc_lib.sh
-
 cleanup()
 {
 	tc qdisc del dev $(tst_iface) root netem > /dev/null 2>&1
@@ -30,4 +28,5 @@ do_test()
 	tcp_cc_test01 bbr -100
 }
 
+. tcp_cc_lib.sh
 tst_run
diff --git a/testcases/network/tcp_cc/bbr02.sh b/testcases/network/tcp_cc/bbr02.sh
index 714983807..0cc55fe82 100755
--- a/testcases/network/tcp_cc/bbr02.sh
+++ b/testcases/network/tcp_cc/bbr02.sh
@@ -7,9 +7,6 @@ TST_TESTFUNC="do_test"
 TST_CLEANUP="cleanup"
 TST_MIN_KVER="4.13"
 TST_TEST_DATA="pfifo_fast codel pfifo fq hfsc hhf htb pie prio sfb sfq"
-
-. tcp_cc_lib.sh
-
 TST_CLEANUP="cleanup"
 
 cleanup()
@@ -37,4 +34,5 @@ do_test()
 	tcp_cc_test01 bbr -100
 }
 
+. tcp_cc_lib.sh
 tst_run
diff --git a/testcases/network/tcp_cc/dctcp01.sh b/testcases/network/tcp_cc/dctcp01.sh
index 14ee96dbf..fbce6f4a0 100755
--- a/testcases/network/tcp_cc/dctcp01.sh
+++ b/testcases/network/tcp_cc/dctcp01.sh
@@ -9,8 +9,6 @@ TST_TESTFUNC="do_test"
 TST_CLEANUP="cleanup"
 TST_MIN_KVER="3.18"
 
-. tcp_cc_lib.sh
-
 cleanup()
 {
 	tc qdisc del dev $(tst_iface) root netem loss 0.5% ecn
@@ -36,4 +34,5 @@ do_test()
 	tcp_cc_test01 dctcp 10
 }
 
+. tcp_cc_lib.sh
 tst_run
diff --git a/testcases/network/tcp_cc/tcp_cc_lib.sh b/testcases/network/tcp_cc/tcp_cc_lib.sh
index 779716fd1..9b903f59b 100755
--- a/testcases/network/tcp_cc/tcp_cc_lib.sh
+++ b/testcases/network/tcp_cc/tcp_cc_lib.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TST_NEEDS_TMPDIR=1
@@ -8,8 +9,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sysctl tc"
 TST_NEEDS_DRIVERS="sch_netem"
 
-. tst_net.sh
-
 def_alg="cubic"
 prev_qlen=
 prev_queue=
@@ -104,3 +103,5 @@ tcp_cc_test01()
 
 	tst_netload_compare $res0 $res1 $threshold
 }
+
+. tst_net.sh
diff --git a/testcases/network/tcp_cmds/arping/arping01.sh b/testcases/network/tcp_cmds/arping/arping01.sh
index 6388f6a7a..6ae96e4ac 100755
--- a/testcases/network/tcp_cmds/arping/arping01.sh
+++ b/testcases/network/tcp_cmds/arping/arping01.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC="do_test"
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="arping"
 
-. tst_net.sh
 
 do_test()
 {
@@ -19,4 +18,5 @@ do_test()
 	EXPECT_PASS arping -w $timeout "$ip_addr" -I $dev -fq
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
index 06b38fcba..4058fbe11 100755
--- a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
+++ b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC="do_test"
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="cut clockdiff"
 
-. tst_net.sh
 
 do_test()
 {
@@ -27,4 +26,5 @@ do_test()
 	fi
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/host/host01.sh b/testcases/network/tcp_cmds/host/host01.sh
index 18b91027c..6a4067495 100755
--- a/testcases/network/tcp_cmds/host/host01.sh
+++ b/testcases/network/tcp_cmds/host/host01.sh
@@ -9,7 +9,6 @@
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="awk grep host hostname tail"
 
-. tst_net.sh
 
 do_test()
 {
@@ -30,4 +29,5 @@ do_test()
 	fi
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 6ad987c49..644a1fb8d 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -13,7 +13,6 @@ TST_OPTS="c:"
 TST_PARSE_ARGS="parse_args"
 TST_USAGE="usage"
 TST_NEEDS_ROOT=1
-. tst_net.sh
 
 do_setup()
 {
@@ -85,4 +84,5 @@ do_test()
 	tst_res TPASS "verified adding/removing $entry_name cache entry"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/netstat/netstat01.sh b/testcases/network/tcp_cmds/netstat/netstat01.sh
index a7c8d6112..ae364e030 100755
--- a/testcases/network/tcp_cmds/netstat/netstat01.sh
+++ b/testcases/network/tcp_cmds/netstat/netstat01.sh
@@ -8,7 +8,6 @@
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="netstat"
 
-. tst_net.sh
 
 do_test()
 {
@@ -23,4 +22,5 @@ do_test()
 	done
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
index bc9c1f99b..39f79119b 100755
--- a/testcases/network/tcp_cmds/ping/ping01.sh
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -14,7 +14,6 @@
 TST_SETUP="do_setup"
 TST_TESTFUNC="do_test"
 
-. tst_net.sh
 
 do_setup()
 {
@@ -37,4 +36,5 @@ do_test()
 	done
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index 07a713531..8eaa3d33a 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -5,7 +5,6 @@
 TST_TESTFUNC="do_test"
 TST_NEEDS_ROOT=1
 
-. tst_net.sh
 
 do_test()
 {
@@ -13,4 +12,5 @@ do_test()
 		 -p "000102030405060708090a0b0c0d0e0f" -c "${COUNT:-3}"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01.sh b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
index 7104de7aa..ce3f647b1 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01.sh
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01.sh
@@ -12,7 +12,6 @@ TST_CLEANUP=do_cleanup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="diff ss stat"
-. tst_net.sh
 
 do_setup()
 {
@@ -50,4 +49,5 @@ do_cleanup()
 	[ -n "$server_started" ] && tst_rhost_run -c "pkill $server"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/tc/tc01.sh b/testcases/network/tcp_cmds/tc/tc01.sh
index a9da45b41..d3224d69d 100755
--- a/testcases/network/tcp_cmds/tc/tc01.sh
+++ b/testcases/network/tcp_cmds/tc/tc01.sh
@@ -24,8 +24,6 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_DRIVERS="sch_teql"
 TST_NEEDS_CMDS="tc modprobe dmesg grep"
 
-. tst_test.sh
-
 setup()
 {
 	ROD modprobe $TST_NEEDS_DRIVERS
@@ -44,4 +42,5 @@ do_test()
 	fi
 }
 
+. tst_test.sh
 tst_run
diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh b/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh
index 32953e7e0..00599e6f2 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01.sh
@@ -25,6 +25,7 @@
 TST_TOTAL=1
 TCID="tcpdump01"
 TST_CLEANUP=do_cleanup
+TST_USE_LEGACY_API=1
 
 do_setup()
 {
@@ -64,10 +65,8 @@ do_cleanup()
 	tst_rmdir
 }
 
-TST_USE_LEGACY_API=1
 . tst_net.sh
 
 do_setup
 do_test
-
 tst_exit
diff --git a/testcases/network/tcp_cmds/telnet/telnet01.sh b/testcases/network/tcp_cmds/telnet/telnet01.sh
index a6e6024fb..93343b995 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01.sh
+++ b/testcases/network/tcp_cmds/telnet/telnet01.sh
@@ -21,7 +21,6 @@ TCID="telnet01"
 TST_TOTAL=1
 
 TST_USE_LEGACY_API=1
-. tst_net.sh
 
 setup()
 {
@@ -83,6 +82,8 @@ telnet_test()
 	tst_rhost_run -u $RUSER -c "rm -f $RUSER.$RHOST"
 }
 
+. tst_net.sh
+
 setup
 
 do_test
diff --git a/testcases/network/tcp_cmds/tracepath/tracepath01.sh b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
index 2b75c1004..2790751b1 100755
--- a/testcases/network/tcp_cmds/tracepath/tracepath01.sh
+++ b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
@@ -6,7 +6,6 @@
 
 TST_TESTFUNC="do_test"
 TST_SETUP="setup"
-. tst_net.sh
 
 setup()
 {
@@ -53,4 +52,5 @@ do_test()
 	tst_res TPASS "traced path to '$rhost' in $hops_num hops"
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index 0e59ed506..88438c3e1 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -30,7 +30,6 @@ tcp_fastopen_parse_args()
 	esac
 }
 
-. tst_net.sh
 
 cleanup()
 {
@@ -71,4 +70,5 @@ test2()
 	tst_netload_compare $time_tfo_off $time_tfo_on 3
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 0140aef9a..06813bd7b 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -9,7 +9,6 @@ TST_NEEDS_CMDS="traceroute"
 TST_SETUP="setup"
 TST_TESTFUNC="test"
 TST_NEEDS_TMPDIR=1
-. tst_net.sh
 
 setup()
 {
@@ -67,4 +66,5 @@ test2()
 	run_trace -T
 }
 
+. tst_net.sh
 tst_run
diff --git a/testcases/network/virt/fou01.sh b/testcases/network/virt/fou01.sh
index 903cb38f6..51f76f965 100755
--- a/testcases/network/virt/fou01.sh
+++ b/testcases/network/virt/fou01.sh
@@ -10,7 +10,6 @@ TST_OPTS="t:"
 TST_PARSE_ARGS="parse_args"
 
 virt_type="fou"
-. virt_lib.sh
 
 GRE_IP_PROTO=47
 
@@ -58,4 +57,5 @@ do_setup()
 		   "local $rmt_ip remote $loc_ip $encap_cmd $FOU_PORT"
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index b731343c8..9ddc6fe71 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -8,6 +8,9 @@ TST_NEEDS_TMPDIR=1
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
 TST_NEEDS_DRIVERS="geneve"
+TST_TESTFUNC=do_test
+TST_CLEANUP=virt_cleanup
+VIRT_PERF_THRESHOLD_MIN=160
 
 virt_type="geneve"
 start_id=16700000
@@ -16,11 +19,6 @@ start_id=16700000
 # that is why using here 'vxlan_*' library functions.
 vxlan_dst_addr="uni"
 
-TST_TESTFUNC=do_test
-TST_CLEANUP=virt_cleanup
-VIRT_PERF_THRESHOLD_MIN=160
-. virt_lib.sh
-
 do_test()
 {
 	tst_res TINFO "the same VNI must work"
@@ -35,4 +33,5 @@ do_test()
 	virt_compare_netperf "fail"
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/geneve02.sh b/testcases/network/virt/geneve02.sh
index 169bc4ec0..79086c7fd 100755
--- a/testcases/network/virt/geneve02.sh
+++ b/testcases/network/virt/geneve02.sh
@@ -6,6 +6,12 @@ TST_NEEDS_TMPDIR=1
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
 TST_NEEDS_DRIVERS="geneve"
+TST_TESTFUNC=do_test
+TST_CLEANUP=virt_cleanup
+TST_TEST_DATA="noudpcsum udp6zerocsumtx udp6zerocsumrx, udpcsum"
+TST_TEST_DATA_IFS=","
+VIRT_PERF_THRESHOLD_MIN=160
+
 virt_type="geneve"
 start_id=16700000
 
@@ -13,13 +19,6 @@ start_id=16700000
 # that is why using here 'vxlan_*' library functions.
 vxlan_dst_addr="uni"
 
-TST_TESTFUNC=do_test
-TST_CLEANUP=virt_cleanup
-TST_TEST_DATA="noudpcsum udp6zerocsumtx udp6zerocsumrx, udpcsum"
-TST_TEST_DATA_IFS=","
-VIRT_PERF_THRESHOLD_MIN=160
-. virt_lib.sh
-
 do_test()
 {
 	virt_check_cmd virt_add ltp_v0 id 1 $2 remote \
@@ -32,4 +31,5 @@ do_test()
 	return 0
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index db5be6de2..58f34d235 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -12,6 +12,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=virt_netperf_msg_sizes
 TST_SETUP=virt_gre_setup
 TST_CLEANUP=virt_cleanup
-. virt_lib.sh
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/gre02.sh b/testcases/network/virt/gre02.sh
index d5566064f..84adbbf3b 100755
--- a/testcases/network/virt/gre02.sh
+++ b/testcases/network/virt/gre02.sh
@@ -6,6 +6,6 @@ TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=virt_netperf_rand_sizes
 TST_SETUP=virt_gre_setup
 TST_CLEANUP=virt_cleanup
-. virt_lib.sh
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index e8b10637f..992d62a9c 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -11,6 +11,6 @@ virt_type="ipvlan"
 TST_TEST_DATA="mode l2,mode l3,mode l3s"
 TST_TEST_DATA_IFS=","
 TST_TESTFUNC=virt_test_02
-. virt_lib.sh
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index d9d6e73a6..cc4b18d32 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -11,5 +11,4 @@
 IPSEC_PROTO="ah"
 
 . macsec_lib.sh
-
 tst_run
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 0c40b25a1..b374ce24a 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -13,5 +13,4 @@ EALGO="aes"
 MACSEC_LIB_SETUP="replay on window 300 encrypt on protect on"
 
 . macsec_lib.sh
-
 tst_run
diff --git a/testcases/network/virt/macsec03.sh b/testcases/network/virt/macsec03.sh
index b7bd8fead..a532fee58 100755
--- a/testcases/network/virt/macsec03.sh
+++ b/testcases/network/virt/macsec03.sh
@@ -6,8 +6,7 @@ IPSEC_PROTO="esp_aead"
 EALGO="aes"
 MACSEC_LIB_SETUP="replay on window 1000 encrypt on protect on"
 
-. macsec_lib.sh
-
 TST_TESTFUNC=virt_netperf_rand_sizes
 
+. macsec_lib.sh
 tst_run
diff --git a/testcases/network/virt/macsec_lib.sh b/testcases/network/virt/macsec_lib.sh
index ac77f0976..f1e7d4eaf 100755
--- a/testcases/network/virt/macsec_lib.sh
+++ b/testcases/network/virt/macsec_lib.sh
@@ -13,8 +13,6 @@ TST_TESTFUNC=virt_netperf_msg_sizes
 TST_SETUP="${TST_SETUP:-macsec_lib_setup}"
 TST_CLEANUP="${TST_CLEANUP:-macsec_lib_cleanup}"
 TST_NEEDS_DRIVERS="macsec"
-. ipsec_lib.sh
-. virt_lib.sh
 
 # MACSEC_LIB_SETUP:
 # [ cipher { default | gcm-aes-128 } ] [ encrypt { on | off } ]
@@ -54,3 +52,6 @@ macsec_lib_cleanup()
 	virt_cleanup
 	tst_ipsec_cleanup
 }
+
+. ipsec_lib.sh
+. virt_lib.sh
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index 3c4fda50b..960b96b7a 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -11,6 +11,6 @@ virt_type="macvlan"
 TST_TEST_DATA="mode private,mode vepa,mode bridge,mode passthru"
 TST_TEST_DATA_IFS=","
 TST_TESTFUNC=virt_test_02
-. virt_lib.sh
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 93a3d34f7..cce5a44e0 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -11,6 +11,6 @@ virt_type="macvtap"
 TST_TEST_DATA="mode private,mode vepa,mode bridge,mode passthru"
 TST_TEST_DATA_IFS=","
 TST_TESTFUNC=virt_test_02
-. virt_lib.sh
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/sit01.sh b/testcases/network/virt/sit01.sh
index 27fa0ee77..0b9a3aff9 100755
--- a/testcases/network/virt/sit01.sh
+++ b/testcases/network/virt/sit01.sh
@@ -7,7 +7,6 @@ TST_TESTFUNC=virt_netperf_msg_sizes
 TST_SETUP=do_setup
 TST_CLEANUP=virt_cleanup
 virt_type="sit"
-. virt_lib.sh
 
 do_setup()
 {
@@ -20,4 +19,5 @@ do_setup()
 		   "local $(tst_ipaddr rhost) remote $(tst_ipaddr)"
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index e9cdab595..98a9bb6aa 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) 2018-2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2014-2021 Oracle and/or its affiliates. All Rights Reserved.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
@@ -18,6 +18,13 @@
 
 TST_SETUP="${TST_SETUP:-virt_lib_setup}"
 TST_CLEANUP="${TST_CLEANUP:-cleanup_vifaces}"
+TST_NEEDS_ROOT=1
+
+# Max performance loss (%) for virtual devices during network load
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
+if [ -n "$VIRT_PERF_THRESHOLD_MIN" ] && [ "$VIRT_PERF_THRESHOLD" -lt $VIRT_PERF_THRESHOLD_MIN ]; then
+	 VIRT_PERF_THRESHOLD="$VIRT_PERF_THRESHOLD_MIN"
+fi
 
 virt_lib_usage()
 {
@@ -58,23 +65,6 @@ virt_lib_setup()
 	ROD_SILENT "ip link delete ltp_v0"
 }
 
-TST_NEEDS_ROOT=1
-. tst_net.sh
-
-ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
-ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
-
-ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
-ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
-
-vxlan_dstport=0
-
-# Max performance loss (%) for virtual devices during network load
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
-if [ -n "$VIRT_PERF_THRESHOLD_MIN" ] && [ "$VIRT_PERF_THRESHOLD" -lt $VIRT_PERF_THRESHOLD_MIN ]; then
-	 VIRT_PERF_THRESHOLD="$VIRT_PERF_THRESHOLD_MIN"
-fi
-
 cleanup_vifaces()
 {
 	tst_res TINFO "cleanup virtual interfaces..."
@@ -384,3 +374,13 @@ virt_gre_setup()
 	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
 	"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
 }
+
+. tst_net.sh
+
+ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
+ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
+
+ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
+ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
+
+vxlan_dstport=0
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 69d2564cb..045b12a6f 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -19,6 +19,6 @@ TST_TEST_DATA=",$p0 $lb0 $rh0,$p0 $lb0 $rh1,$p0 $lb1 $rh0,$p0 $lb1 $rh1,\
 $p1 $lb0 $rh0,$p1 $lb0 $rh1,$p1 $lb1 $rh0,$p1 $lb1 $rh1"
 TST_TEST_DATA_IFS=","
 TST_TESTFUNC=virt_test_01
-. virt_lib.sh
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index 04a8a5c60..f9a25667e 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -10,11 +10,11 @@
 virt_type="vlan"
 
 TST_TESTFUNC=do_test
-. virt_lib.sh
 
 do_test()
 {
 	virt_add_delete_test "id 4094"
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index b7125ae7a..3230a9f65 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -26,7 +26,6 @@ TST_TEST_DATA_IFS=","
 TST_TESTFUNC=do_test
 TST_SETUP=virt_lib_setup
 TST_CLEANUP=virt_cleanup
-. virt_lib.sh
 
 do_test()
 {
@@ -44,4 +43,5 @@ do_test()
 	virt_cleanup_rmt
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 531691531..332b77b44 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -9,14 +9,13 @@
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
 TST_USAGE=virt_lib_usage
-
-virt_type="vxlan"
-start_id=16700000
-
 TST_TEST_DATA="l2miss l3miss,norsc nolearning noproxy,\
 ttl 0x01 tos 0x01,ttl 0xff tos 0xff,gbp"
 TST_TEST_DATA_IFS=","
 TST_TESTFUNC=virt_test_01
-. virt_lib.sh
 
+virt_type="vxlan"
+start_id=16700000
+
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 04036a0df..4223f4e2f 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -10,13 +10,11 @@
 TST_OPTS="hi:d:"
 TST_PARSE_ARGS=virt_lib_parse_args
 TST_USAGE=virt_lib_usage
+TST_TESTFUNC=do_test
 
 virt_type="vxlan"
 start_id=16700000
 
-TST_TESTFUNC=do_test
-. virt_lib.sh
-
 do_test()
 {
 	local mult_addr="239.1.1.1"
@@ -25,4 +23,5 @@ do_test()
 	virt_add_delete_test "id $start_id group $mult_addr"
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 7e5453222..ccb97d704 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -32,7 +32,6 @@ TST_CLEANUP=virt_cleanup
 # switch, VxLAN can be much slower when comparing to the performance without
 # any encapsulation.
 VIRT_PERF_THRESHOLD_MIN=160
-. virt_lib.sh
 
 do_test()
 {
@@ -51,4 +50,5 @@ do_test()
 	virt_cleanup_rmt
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/vxlan04.sh b/testcases/network/virt/vxlan04.sh
index 2418e5edd..3beb8c45a 100755
--- a/testcases/network/virt/vxlan04.sh
+++ b/testcases/network/virt/vxlan04.sh
@@ -16,7 +16,6 @@ virt_type="vxlan"
 start_id=16700000
 vxlan_dst_addr="uni"
 VIRT_PERF_THRESHOLD_MIN=160
-. virt_lib.sh
 
 do_test()
 {
@@ -29,4 +28,5 @@ do_test()
 	virt_cleanup_rmt
 }
 
+. virt_lib.sh
 tst_run
diff --git a/testcases/network/virt/wireguard01.sh b/testcases/network/virt/wireguard01.sh
index 05d696a78..3cf67416e 100755
--- a/testcases/network/virt/wireguard01.sh
+++ b/testcases/network/virt/wireguard01.sh
@@ -8,8 +8,6 @@ TST_CLEANUP=cleanup
 TST_TESTFUNC=test
 TST_CNT=3
 
-. wireguard_lib.sh
-
 setup()
 {
 	if tst_net_use_netns && [ "$VIRT_PERF_THRESHOLD" -lt 700 ]; then
@@ -53,4 +51,5 @@ test3()
 	virt_compare_netperf "fail"
 }
 
+. wireguard_lib.sh
 tst_run
diff --git a/testcases/network/virt/wireguard02.sh b/testcases/network/virt/wireguard02.sh
index c16ae68d1..a7d8f2071 100755
--- a/testcases/network/virt/wireguard02.sh
+++ b/testcases/network/virt/wireguard02.sh
@@ -1,14 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2020 Oracle and/or its affiliates. All Rights Reserved.
 
 TST_CLEANUP=cleanup
 TST_TESTFUNC=test1
 TST_SETUP=wireguard_lib_setup
 
-. ipsec_lib.sh
-. wireguard_lib.sh
-
 IPSEC_MODE="tunnel"
 IPSEC_PROTO="esp_aead"
 AEALGO="rfc4106_256"
@@ -45,4 +43,6 @@ test1()
 	tst_netload_compare $time_ipsec $time_wg -100
 }
 
+. ipsec_lib.sh
+. wireguard_lib.sh
 tst_run
diff --git a/testcases/network/virt/wireguard_lib.sh b/testcases/network/virt/wireguard_lib.sh
index 2e36bce30..c59ecbbdf 100755
--- a/testcases/network/virt/wireguard_lib.sh
+++ b/testcases/network/virt/wireguard_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2022
 # Copyright (c) 2020 Oracle and/or its affiliates. All Rights Reserved.
 
 TST_NEEDS_TMPDIR=1
@@ -11,7 +12,6 @@ TST_NEEDS_DRIVERS="wireguard"
 VIRT_PERF_THRESHOLD_MIN=${VIRT_PERF_THRESHOLD_MIN:-200}
 
 virt_type="wireguard"
-. virt_lib.sh
 
 # Usage: wireguard_lib_setup [TYPE]
 # TYPE: [ default | invalid_allowed_ips | invalid_pub_keys ]
@@ -64,3 +64,5 @@ wireguard_lib_cleanup()
 {
 	virt_cleanup
 }
+
+. virt_lib.sh
diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index f7f5db7bc..505dae5d7 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -12,7 +12,6 @@ TST_TESTFUNC="do_test"
 TST_CNT=2
 
 . daemonlib.sh
-. tst_net.sh
 
 setup()
 {
@@ -109,4 +108,5 @@ do_test()
 	esac
 }
 
+. tst_net.sh
 tst_run
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
