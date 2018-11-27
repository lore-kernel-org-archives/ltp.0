From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 18:41:56 +0100
Subject: [LTP] [PATCH v2] getrlimit/getrlimit03: new test for underlying
 syscall variants
In-Reply-To: <20181107212213.129534-1-ghackmann@google.com>
References: <20181106194725.GA11344@rei.lan>
 <20181107212213.129534-1-ghackmann@google.com>
Message-ID: <20181127174156.GA19801@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Greg,

> Depending on the architecture, Linux provides up to three syscalls that
> have been used to implement getrlimit(2) in different libc
> implementations.  These syscalls differ in the size and signedness of
> rlim_t.

> This test compares the results returned by all three syscalls, confirming
> that they either match or were appropriately capped at the respective
> RLIM_INFINITY constant.

> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---

Thanks for your patch, pushed with minor GPL related change (replaced GPL text
with SPDX-License-Identifier).


Kind regards,
Petr
