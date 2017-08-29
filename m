From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Aug 2017 16:58:08 +0200
Subject: [LTP] [PATCH v2 1/7] tst_atomic: Add load,
 store and use __atomic builtins
In-Reply-To: <20170828110241.30453-1-rpalethorpe@suse.com>
References: <20170828110241.30453-1-rpalethorpe@suse.com>
Message-ID: <00e8fd78-6cc0-6e5d-4055-b255fc317aa1@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/28/2017 01:02 PM, Richard Palethorpe wrote:
> Also add more fallback inline assembly for the existing architectures and add
> SPARC64. Use the __atomic_* compiler intrinsics when available.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Hi,

I gave this patch a go on number of old/new distros, x86_64, ppc64le
and s390 and I haven't ran into issues. My review is mostly only
comparison against kernel sources as much of inline assembly is beyond me.

I think we could use a comment about what sort of ordering do we expect
from tst_atomic.h. I always assumed we care only for compiler barriers,
and when we use __sync_* functions, it's more for convenience (not
because we wanted full memory barrier).

I don't quite understand tst_atomic_load/store() for aarch64, because
when I look at kernel's arch/arm64/include/asm/atomic.h
these are a lot simpler:
#define atomic_read(v)                  READ_ONCE((v)->counter)
#define atomic_set(v, i)                WRITE_ONCE(((v)->counter), (i))

The rest of fallback functions looks good to me (at least for architectures
I checked). I expect fallback is used only by very small fringe of users
and their numbers will only go down in future.

Regards,
Jan

