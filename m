From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Apr 2018 16:31:57 +0200
Subject: [LTP] [PATCH v3] syscalls/mmap17.c: Add new regression test
In-Reply-To: <1519284767-1758-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1544687918.1306598.1518385631571.JavaMail.zimbra@redhat.com>
 <1519284767-1758-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180404143157.GA30264@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We add a regression test to check if mmap() can't map invalid physical
> addresses.  If mmap() maps /dev/mem offsets outside of the addressable
> limits of a system, setting reserved bits corrupts the page table and
> may trigger a kernel crash.

I wonder if we can address Jan's comment and make it more generic by
trying to mmap a certain sequence of offsets in /dev/mem and either
expect them to return a valid pointer or fail with MAP_FAILED. We would
have to make sure that we got the 1ULL<<phys_addr_bits there for the x86
case but we wouldn't have to skip the test on non-x86 hardware.

-- 
Cyril Hrubis
chrubis@suse.cz
