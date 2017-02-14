From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 10:31:08 +0100
Subject: [LTP] [PATCH] lib/tst_tmpdir.c: fix compilation with older
 kernels
In-Reply-To: <1487041769-14292-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1487041769-14292-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170214093107.GA23548@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Compilation fails because of undefined __USE_GNU on RHEL5.11GA.
> So we need to define _GNU_SOURCE to make __USE_GNU defined.

Good catch. I've updated the changelog, since the problem is about older
libc not kernel and pushed along with a few more typo fixed I've done
yesterday.

-- 
Cyril Hrubis
chrubis@suse.cz
