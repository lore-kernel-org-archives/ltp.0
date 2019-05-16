From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 16 May 2019 04:35:23 -0400 (EDT)
Subject: [LTP] Oldest still supported kernel
In-Reply-To: <20190516073826.GA14532@dell5510>
References: <20190516073826.GA14532@dell5510>
Message-ID: <1051593197.23090826.1557995723298.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> 
> do we declare oldest still supported kernel version?
> According to distrowatch [1] still supported RHEL-6.9 is using v2.6.32.

6.9 is already EOL, but there still are other supported RHEL6 streams (up to 2024).

> Is it the oldest version we want to support or even something older?

I'd like minimum to be at least 3.10.0 / glibc-2.17 (RHEL7).

Older distros use LTP mostly for regression tests, so it might be acceptable
for users to switch to older release tag, rather than always latest master.

There's also an option, we create a "legacy" branch for old distros,
and accept only critical fixes (no new tests, rewrites, etc.). It would
be unsupported, but provide place where legacy users can cooperate.

> Latest still supported stable kernel is 3.16, which is obviously too new for
> enterprise distros.
> 
> It'd be nice to specify latest supported kernel (and glibc) version in docs
> and remove old autotools checks (we have some checks for v2.6.25).
> 
> Kind regards,
> Petr
> 
> [1] https://distrowatch.com/table.php?distribution=redhat
> 
