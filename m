From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Jun 2019 17:21:51 +0200
Subject: [LTP] [PATCH v2] syscalls/ioctl_ns0[156]: align stack and wait
 for child
In-Reply-To: <278919491.27726511.1560349549390.JavaMail.zimbra@redhat.com>
References: <916c20b9a379badd37a85aa1e1339566c9807d23.1560248542.git.jstancek@redhat.com>
 <20190612135929.GA3048@rei.lan>
 <278919491.27726511.1560349549390.JavaMail.zimbra@redhat.com>
Message-ID: <20190612152151.GC3048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Default alignment is not enough:
>   Alignment:                              2 * sizeof(size_t) (default)
>        (i.e., 8 byte alignment with 4byte size_t). This suffices for
>        nearly all current machines and C compilers. However, you can
>        define MALLOC_ALIGNMENT to be wider than this if necessary.
> 
> I'm guessing most of tests cross M_MMAP_THRESHOLD, and get page alignment
> from mmap. But should we rely on that?
> 
> How about posix_memalign()?

I guess that we need to fix the ltp_clone_malloc() function as well, we
should probably add a helper to allocate memory to the clone library
which would make use of the posix_memalign() and make use of it
internally as well...

-- 
Cyril Hrubis
chrubis@suse.cz
