From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 May 2021 21:57:19 +0200
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <20210517085637.16866-1-aleksei.kodanev@bell-sw.com>
References: <20210517085637.16866-1-aleksei.kodanev@bell-sw.com>
Message-ID: <YKLKn3o7A38/nyjt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The test is now independent of various machine settings
> regarding the test host name as it adds predefined names
> and aliases to /etc/hosts file and restores it to its
> original state after completing the test.

> This should fix the following failures:
> * when gethostname() returns an alias name that doesn't
>   match canonical name;
> * No AAAA record for the returned name from gethostname().

> Addresses and names added to /etc/hosts are more or less
> unique, so that there are no conflicts with the existing
> configuration.

> Also most of the duplicate code is now gone.

Thanks a lot. On a first look looks very nice, I'll try to review tomorrow.
I'd be for merging this before release as the old code is broken.

> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Congratulations to a new job. That explains why NFS related patches didn't
reached you. FYI nfs-utils related "Fix NFSv4 export of tmpfs filesystems" patch
from Neil Brown [1], fix for my bug report (with naive attempt to fix it) found
with LTP NFS tests [2].

Kind regards,
Petr

[1] https://lore.kernel.org/linux-nfs/162122673178.19062.96081788305923933@noble.neil.brown.name/
[2] https://lore.kernel.org/linux-nfs/YILQip3nAxhpXP9+@pevik/T/#t
