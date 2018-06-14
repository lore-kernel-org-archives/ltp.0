From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jun 2018 13:34:46 +0200
Subject: [LTP] [PATCH 1/1] network.sh: Cleanup netpan logs
In-Reply-To: <0d87312d-359b-fbb7-0e8f-c93c0e9da86d@oracle.com>
References: <20180610101309.8201-1-pvorel@suse.cz>
 <0d87312d-359b-fbb7-0e8f-c93c0e9da86d@oracle.com>
Message-ID: <20180614113446.nrhp5xx6e445istk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 10.06.2018 13:13, Petr Vorel wrote:
> > network.sh script doesn't delete it's logs, which can lead to fill /tmp.
> > Remove these files, which unify behavior with runltp and runltplite.sh
> > (just don't use trap to force remove on INT).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Thanks, pushed!


Kind regards,
Petr
