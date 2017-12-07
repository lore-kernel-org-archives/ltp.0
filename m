From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 7 Dec 2017 14:52:52 +0300
Subject: [LTP] [RFC PATCH 2/2] lib/test_net.sh: Check for ip command
In-Reply-To: <20171206144214.27317-2-pvorel@suse.cz>
References: <20171206144214.27317-1-pvorel@suse.cz>
 <20171206144214.27317-2-pvorel@suse.cz>
Message-ID: <6a3ee066-2d3b-3901-797e-c5b2b5e14fb3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/06/2017 05:42 PM, Petr Vorel wrote:
> + remove this check from tests which uses test_net.sh.

Not all library functions require 'ip' so why do we need these
rules to apply globally or am I missing something?

>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> I guess most of the time we need root in test_net.sh, but there might be
> someone setting netns with LTP_NETNS and then running tests without root.  Do
> we want to care or we just force tst_require_root in test_net.sh ?

I think we could add it in init_ltp_netspace or/and to tst_restore_ipaddr(),
i.e. checks forip command and root.

Thanks,
Alexey

