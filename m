From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 14:09:21 +0100
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
 create appointed size fs
In-Reply-To: <1457444133-5671-1-git-send-email-zlang@redhat.com>
References: <1457444133-5671-1-git-send-email-zlang@redhat.com>
Message-ID: <20160309130921.GB28171@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
> +                    const char *fs_type, const char *const fs_opts[],
> +                    const char *fssize, const char *blocksize);
> +
> +#define tst_mkfs(cleanup_fn, dev, fs_type, fs_opts) \
> +	tst_mkfs_sized(cleanup_fn, dev, fs_type, fs_opts, NULL, NULL)

Also make this static inline function instead. We only use such macros
for SAFE_MACROS() where we have to pass correct __FILE__ and __LINE__,
which is very special occasion.

-- 
Cyril Hrubis
chrubis@suse.cz
