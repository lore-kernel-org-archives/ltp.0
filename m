From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 27 Feb 2017 14:26:54 +0300
Subject: [LTP] [PATCH] tst_netload: new options and improvemnts
In-Reply-To: <1485784959-31864-1-git-send-email-alexey.kodanev@oracle.com>
References: <1485784959-31864-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <5a99c1cb-a68e-333c-dd15-ef0beb3de9d2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/30/2017 05:02 PM, Alexey Kodanev wrote:
> * Add getopts parsing, make them transparent to 'netstress' tool
>
> * cat 'netstress' output only on failure (not expected result)
>
> * remove 'ping' type, ICMP traffic can be generated with tst_ping()
>
> * tst_netload() sets TPASS/TFAIL flags depending on '-e' parameter --
>   expected result.
>
> * allow to overwrite most significant parameters with environment
>   variables:
>   'TST_NETLOAD_CLN_NUMBER' -- number of clients,
>   'TST_NETLOAD_CLN_REQUESTS' -- client requests,
>   'TST_NETLOAD_MAX_SRV_REPLIES' -- max server replies after which
>   TCP connection will be closed.

Applied.

