From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Jun 2018 13:38:52 +0300
Subject: [LTP] [PATCH 1/1] network.sh: Cleanup netpan logs
In-Reply-To: <20180610101309.8201-1-pvorel@suse.cz>
References: <20180610101309.8201-1-pvorel@suse.cz>
Message-ID: <0d87312d-359b-fbb7-0e8f-c93c0e9da86d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10.06.2018 13:13, Petr Vorel wrote:
> network.sh script doesn't delete it's logs, which can lead to fill /tmp.
> Remove these files, which unify behavior with runltp and runltplite.sh
> (just don't use trap to force remove on INT).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
