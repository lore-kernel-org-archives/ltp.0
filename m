From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Mar 2021 13:29:50 +0100
Subject: [LTP] [PATCH] lib/tst_supported_fs_types.c: Add tmpfs to
 filesystem whitelist
In-Reply-To: <20210309130115.9693-1-zhaogongyi@huawei.com>
References: <20210309130115.9693-1-zhaogongyi@huawei.com>
Message-ID: <YEi7vh9tDZ7hKltx@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In many embedded system, we need add tmpfs to filesystem whitelist since
> there is only tmpfs can be used to test.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> 
> ---------------
> v2->v3:
> 1)skipping mkfs for tmpfs gracefully.
> 2)replace sprintf with snprintf.
> 3)remove __func__ in the message
> 4)replace rmdir with SAFE_RMDIR
> ---------------

Minor nits:

This changelog part should be below the "---" line, since that part gets
cut out automatically and the patch subject should have v3 in it's name
(git format-patch -v3 ...).

As for the rest of the patch, it's nearly perfect, I will push it with
minor changes but we need to apply my patchset[1] first so that we can
skip a few tests on tmpfs.

[1] http://patchwork.ozlabs.org/project/ltp/list/?series=233180

-- 
Cyril Hrubis
chrubis@suse.cz
