From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Apr 2021 08:19:40 +0200
Subject: [LTP] [PATCH 0/3] network/virt: new FOU and GUE tests
In-Reply-To: <20210422131630.28565-1-alexey.kodanev@oracle.com>
References: <20210422131630.28565-1-alexey.kodanev@oracle.com>
Message-ID: <YIZbfLBS7C5hUu++@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The first patch adds IPv6 flag '-6' to the library, which
> will be used by the two new tests in this patch series too.

> The rest are adding two similar tests for UDP tunneling.

fou01.sh and gue01.sh are nearly the same, but I also wouldn't complicate things
by putting functions into virt_lib.sh to reduce duplicity.

Thus whole patchset LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
