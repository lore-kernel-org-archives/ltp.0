From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Apr 2020 15:43:39 +0200
Subject: [LTP] [PATCH] Add test for CVE 2018-7566
In-Reply-To: <20200408103050.27706-1-mdoucha@suse.cz>
References: <20200408103050.27706-1-mdoucha@suse.cz>
Message-ID: <20200408134339.GA10178@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fixes #606

Add your signed-off-by here and pushed, thanks.

> ---
> 
> There are two reproducers for this CVE:
> - ioctl()/ioctl() race
> - ioctl()/write() race
> 
> I've implemented the first one because it reliably crashes SLE-12SP3 GM kernel.
> The other reproducer gets stuck in one of the syscalls but I couldn't get it
> to trigger an actual crash. Should I implement the other one as well?

Yes please, stuck tests is easy to detect as well, moreover the behavior
of these tests is unpredictable anyways so we cannot really tell what
will happen when the bug is triggered.

-- 
Cyril Hrubis
chrubis@suse.cz
