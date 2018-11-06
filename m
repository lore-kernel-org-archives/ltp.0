From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 16:54:53 +0100
Subject: [LTP] [PATCH 5/5] syscalls/posix_fadvise0[13]: Start using new
 library.
In-Reply-To: <CAOQ4uxho-DGW+efhpJZBxFnewANdbTk0uv4pGB3ct96ma3cSNg@mail.gmail.com>
References: <20181105235019.254846-1-sspatil@google.com>
 <20181105235019.254846-6-sspatil@google.com>
 <CAOQ4uxho-DGW+efhpJZBxFnewANdbTk0uv4pGB3ct96ma3cSNg@mail.gmail.com>
Message-ID: <20181106155452.GD3014@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The only thing that should matter in the context of this test is
> whether or not posix_fadvise() is supported by the kernel.
> For some reason that is not clear to me (are we tinyfying the kernel syscall
> by syscall now?), the support for fadvise in the kernel can be configured out
> with CONFIG_ADVISE_SYSCALLS=n. So IMO, this test really needs a
> runtime check, not a build time check like above.

Yes, I would expect that we would get ENOSYS in a case that kernel is
build without the support for the call. And we don't have to check in
the setup, we can do tst_brk(TCONF, ...) in the actuall test as well.

-- 
Cyril Hrubis
chrubis@suse.cz
