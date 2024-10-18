Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F893D2FFF7
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 11:52:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 346423C6930
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 13:52:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E9623C1A39
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 13:52:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz;
 receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3E6F6469C7
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 13:52:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E5CA51FDBF;
 Fri, 18 Oct 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D608E13680;
 Fri, 18 Oct 2024 11:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MUT0M/hLEmcQCAAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 11:52:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 74482A080A; Fri, 18 Oct 2024 13:52:24 +0200 (CEST)
Date: Fri, 18 Oct 2024 13:52:24 +0200
From: Jan Kara <jack@suse.cz>
To: Zizhi Wo <wozizhi@huawei.com>
Message-ID: <20241018115224.jsz3rrnqpx5mwhze@quack3>
References: <20241018071353.2732203-1-wozizhi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241018071353.2732203-1-wozizhi@huawei.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: E5CA51FDBF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10: Calling drop_cache three times to
 ensure the inode is evicted
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
Cc: yangerkun@huawei.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri 18-10-24 15:13:53, Zizhi Wo wrote:
> In commmit 6df425bb7040 ("fanotify10: Calling drop_cache twice to ensure
> the inode is evicted"), the number of drop_cache operations was increased
> to two in order to prevent inodes from being left uncleared due to inodes
> and dentries being on different NUMA nodes, which would cause the testcase
> to fail.
> 
> However, during our local testing, I found that this testcase still
> occasionally fails:
> 
> fanotify10.c:771: TINFO: Test #27: don't ignore fs events created inside a parent with evicted ignore mark
> fanotify10.c:510: TPASS: Found 0 ignore marks which is in expected range 0-0
> fanotify10.c:510: TPASS: Found 0 ignore marks which is in expected range 0-0
> fanotify10.c:510: TPASS: Found 0 ignore marks which is in expected range 0-0
> fanotify10.c:510: TPASS: Found 1 ignore marks which is in expected range 0-8
> fanotify10.c:510: TPASS: Found 1 ignore marks which is in expected range 0-8
> fanotify10.c:510: TPASS: Found 1 ignore marks which is in expected range 0-8
> ......
> fanotify10.c:841: TPASS: group 0 (8) got 16 events: mask 20 pid=22962
> fanotify10.c:841: TPASS: group 1 (8) got 16 events: mask 20 pid=22962
> fanotify10.c:841: TPASS: group 2 (8) got 16 events: mask 20 pid=22962
> fanotify10.c:836: TFAIL: group 0 (4) with FAN_MARK_FILESYSTEM got unexpected number of events (15 != 16)
> fanotify10.c:836: TFAIL: group 1 (4) with FAN_MARK_FILESYSTEM got unexpected number of events (15 != 16)
> fanotify10.c:836: TFAIL: group 2 (4) with FAN_MARK_FILESYSTEM got unexpected number of events (15 != 16)
> ......

Sigh, I'm not sure we can ever make this work reliably.
 
> In this testcase(Test #27), ignore_path is "fs_mnt/testdir", and event_path
> is "fs_mnt/testdir/testfile". The purpose of ignore_path is to verify that
> the ignore_mark does not pin the corresponding inode. If any inodes remain
> after drop_cache, the test case will fail. Here, the ignore_path is located
> in a two-level directory structure, and two drop_cache operations might
> still not be enough.
> 
> Consider the scenario where the parent inode is on NUMA0, the parent dentry
> is on NUMA1, the child inode is on NUMA2, and the child dentry is on NUMA3.
> After the first drop_cache, the child dentry is cleared, its inode and
> parent dentry are placed in the *corresponding* lru link list; after the
> second drop_cache, the parent dentry and the child inode are cleared; only
> after the third drop_cache would the parent inode be fully released. The
> corresponding kernel flow is as follows:
> 
> drop_caches_sysctl_handler
>   drop_slab
>     // Traverse NUMA in order.
>     drop_slab_node
>     ...
>       // Free dentry, child dentry pin parent dentry and its inode.
>       prune_dcache_sb
>       ...
>         dentry_unlink_inode
>         ...
>           // Place the inode into its corresponding NUMA lru link list.
>           list_lru_add
>       /*
>        * Free inode. If the NUMA where the inode resides is different from
>        * its dentry, the inode may not be released this time.
>        */
>       prune_icache_sb
> 
> 			drop_cache1	drop_cache2	drop_cache3
> NUMA0: parent inode	exist		exist		free
> NUMA1: parent dentry	exist		free		free
> NUMA2: child inode	exist		free		free
> NUMA3: child dentry	free		free		free

Well, this is right but there's also the while ((freed >> shift++) > 1)
loop in drop_slab() which should generally make us loop as long as there's
something to reclaim. But yes, if in theory the only thing we can reclaim
is the child dentry in the first round, then what you suggest may happen.

> Due to the release of the dependency chain, the drop_cache cleanup also
> takes several times. Therefore, to be safe, three drop_cache operations are
> needed to handle the two-level directory structure.

OK, I'm willing to give this one last try. If it doesn't work out, I'd just
drop these tests until we can find a more reliable way of testing this.

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index ce5469580..eedd1442f 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -515,7 +515,11 @@ static void drop_caches(void)
>  	if (syncfs(fd_syncfs) < 0)
>  		tst_brk(TBROK | TERRNO, "Unexpected error when syncing filesystem");
>  
> -	/* Need to drop twice to ensure the inode is evicted. */
> +	/*
> +	 * In order to ensure that the inode can be released in the two-tier
> +	 * directory structure, drop_cache is required three times.
> +	 */
> +	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
>  	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
>  	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
