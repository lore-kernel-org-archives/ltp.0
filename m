From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jan 2018 15:22:53 +0100
Subject: [LTP] [PATCH] endian_switch01: rewrite to newlib
In-Reply-To: <0db42a518baa79cd6139f566482e2dab11cfb4bd.1515587913.git.jstancek@redhat.com>
References: <0db42a518baa79cd6139f566482e2dab11cfb4bd.1515587913.git.jstancek@redhat.com>
Message-ID: <20180110142253.GB3746@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Also check that syscall is supported (doesn't return ENOSYS),
> before running actual test. This is to address kernels where
> this syscall is disabled by default:
>   commit 727f13616c45 ("powerpc: Disable the fast-endian switch syscall by default")

Looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
