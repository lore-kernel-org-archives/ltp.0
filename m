From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Oct 2019 15:37:33 +0200
Subject: [LTP] [PATCH] mlock_8-1,
 munlock_10-1: don't use LONG_MAX as invalid pointer
In-Reply-To: <2e51e5453562001b5b6992ccc897d9177e6673ca.1571053661.git.jstancek@redhat.com>
References: <2e51e5453562001b5b6992ccc897d9177e6673ca.1571053661.git.jstancek@redhat.com>
Message-ID: <20191018133733.GA31681@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> arm64 kernel with commit 057d3389108e ("mm: untag user pointers passed to
> memory syscalls") will assume this is tagged user pointer and will
> attempt to clear first byte. This leads to test hitting different error
> (EINVAL instead of ENOMEM).

> Add a helper function which provides invalid/unused pointer from user
> address space.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Agree with Cyril points (double underscores at the beginning are reserved for
libc and putting very brief info at get_invalid_ptr(().

Kind regards,
Petr
