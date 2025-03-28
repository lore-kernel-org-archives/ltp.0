Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA9C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743188973; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=OwThXZCTaHCgK+o5NJtLOC/BROdZrNMmDbgOh8H8xY4=;
 b=nQciJDAd+AmBagQEtprlZvokxOXvDacTNf2bgwzoaQ+URI+fPE8x60azQZP/XhJkEFC7A
 HvyodElOlUQ1mijwVkMTGVGXS0y/EYEBsMZkdmp/DzRKoYKkXDEj5IYidVCKuW25xJYBqSZ
 W/aY70FRr1E9dqFYcnFWLcyzfWspPQA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 801333CA4C2
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 20:09:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEAA13C93D4
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 20:09:10 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E2DBF1A0027D
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 20:09:08 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 976E25C6847;
 Fri, 28 Mar 2025 19:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB8C4CEE4;
 Fri, 28 Mar 2025 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743188946;
 bh=nbVAbadFhwirIIc7wDc9emhsG/6sME7ykQ1kn6t6U48=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dB3UELKKWurwo5YB6MHwFg/UZUce61fmOuW0NiU9qFlFdtoNv0aOf8YfAgXZPl/VK
 LnRc6mubqtAjjwkdjUQPZWkbXjEWwyo9K6zW6LAA74Be8JbsB91M+5435jttZzFU+z
 2bYAnSgTaLkzS616JBBRVmk7K2lKc5/LqQ0dQZNqJo0vxu9km++GxxMOwPXezFu5OR
 Gmued/cHagZgMmn2Wkv3ONd2KESeVcsywtzTS0eYb5Qb3EEdRv00wIk3buiNm7b6sF
 WhlFhMw/njMC/KKbBSmHRNF2dXZoi/kG6jExwozgFY7EI9kQkXZo/PROy5tjNwBU2I
 mMPyKH3bTT/BQ==
Date: Fri, 28 Mar 2025 12:09:04 -0700
To: Jan Kara <jack@suse.cz>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 David Bueso <dave@stgolabs.net>, Tso Ted <tytso@mit.edu>,
 Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <Z-bz0IZuTtwNYPBq@bombadil.infradead.org>
References: <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
 <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
 <Z+JSwb8BT0tZrSrx@xsang-OptiPlex-9020>
 <Z-X_FiXDTSvRSksp@bombadil.infradead.org>
 <Z-YjyBF-M9ciJC7X@bombadil.infradead.org>
 <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-ZwToVfJbdTVRtG@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, gost.dev@samsung.com,
 Alistair Popple <apopple@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, mcgrof@kernel.org, Oliver Sang <oliver.sang@intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 28, 2025 at 02:48:00AM -0700, Luis Chamberlain wrote:
> On Thu, Mar 27, 2025 at 09:21:30PM -0700, Luis Chamberlain wrote:
> > Would the extra ref check added via commit 060913999d7a9e50 ("mm:
> > migrate: support poisoned recover from migrate folio") make the removal
> > of the spin lock safe now given all the buffers are locked from the
> > folio? This survives some basic sanity checks on my end with
> > generic/750 against ext4 and also filling a drive at the same time with
> > fio. I have a feeling is we are not sure, do we have a reproducer for
> > the issue reported through ebdf4de5642fb6 ("mm: migrate: fix reference
> > check race between __find_get_block() and migration")? I suspect the
> > answer is no.

Sebastian, David, is there a reason CONFIG_DEBUG_ATOMIC_SLEEP=y won't
trigger a atomic sleeping context warning when cond_resched() is used?
Syzbot and 0-day had ways to reproduce it a kernel warning under these
conditions, but this config didn't, and require dan explicit might_sleep()

CONFIG_PREEMPT_BUILD=y
CONFIG_ARCH_HAS_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_PREEMPT_RCU=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

Are there some preemption configs under which cond_resched() won't
trigger a kernel splat where expected so the only thing I can think of
is perhaps some preempt configs don't implicate a sleep? If true,
instead of adding might_sleep() to one piece of code (in this case
foio_mc_copy()) I wonder if instead just adding it to cond_resched() may
be useful.

Note that the issue in question wouldn't trigger at all with ext4, that
some reports suggset it happened with btrfs  (0-day) with LTP, or
another test from syzbot was just coincidence on any filesystem, the
only way to reproduce this really was by triggering compaction with the
block device cache and hitting compaction as we're now enabling large
folios with the block device cache, and we've narrowed that down to
a simple reproducer of running

dd if=/dev/zero of=/dev/vde bs=1024M count=1024.

and by adding the might_sleep() on folio_mc_copy()

Then as for the issue we're analzying, now that I get back home I think
its important to highlight then that generic/750 seems likely able to
reproduce the original issue reported by commit ebdf4de5642fb6 ("mm:
migrate: fix reference check race between __find_get_block() and migration")
and that it takes about 3 hours to reproduce, which requires reverting
that commit which added the spin lock:

Mar 28 03:36:37 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-28 03:36:37
<-- snip -->
Mar 28 05:57:09 extra-ext4-4k kernel: EXT4-fs error (device loop5): ext4_get_first_dir_block:3538: inode #5174: comm fsstress: directory missing '.'

Jan, can you confirm if the symptoms match the original report?

It would be good for us to see if running the newly proposed generic/764
I am proposing [0] can reproduce that corruption faster than 3 hours.

If we have a reproducer we can work on evaluating a fix for both the
older ext4 issue reported by commit ebdf4de5642fb6 and also remove
the spin lock from page migration to support large folios.

And lastly, can __find_get_block() avoid running in case of page
migration? Do we have semantics from a filesystem perspective to prevent
work in filesystems going on when page migration on a folio is happening
in atomic context? If not, do we need it?

[0] https://lore.kernel.org/all/20250326185101.2237319-1-mcgrof@kernel.org/T/#u

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
