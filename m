From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 16 Apr 2019 18:42:25 +0800
Subject: [LTP] [PATCH v3] syscalls/mmap17.c: Add new regression test
In-Reply-To: <20180404143157.GA30264@rei>
References: <1544687918.1306598.1518385631571.JavaMail.zimbra@redhat.com>
 <1519284767-1758-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180404143157.GA30264@rei>
Message-ID: <5CB5B191.90502@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 3:59, Cyril Hrubis wrote:

> I wonder if we can address Jan's comment and make it more generic by
> trying to mmap a certain sequence of offsets in /dev/mem and either
> expect them to return a valid pointer or fail with MAP_FAILED. We would
> have to make sure that we got the 1ULL<<phys_addr_bits there for the x86
> case but we wouldn't have to skip the test on non-x86 hardware.
Hi Cyril

   This patch has been created long time ago, we should start it again. I think we
   should make this case more generic.  It should test mmap whether check physical
   addr size valid instead of triggering a rare crash.

   We can look for a max phys_addr_bit on all arch architectures.  AFAIK, the max
   phys_addr_bit is 52, we can test it as below:

   mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 1ULL<<52)



