From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 13 Feb 2017 19:42:06 +0300
Subject: [LTP] [PATCH v2 2/4] network: Add TI-RPC and TS-RPC tests into
 network.sh
In-Reply-To: <20170208144500.27340-2-pvorel@suse.cz>
References: <20170208144500.27340-1-pvorel@suse.cz>
 <20170208144500.27340-2-pvorel@suse.cz>
Message-ID: <b0f86e07-e820-905b-844d-a94b4f3dbc91@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 08.02.2017 17:44, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testscripts/network.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/testscripts/network.sh b/testscripts/network.sh
> index 2d2c6762c..fce59f576 100755
> --- a/testscripts/network.sh
> +++ b/testscripts/network.sh
> @@ -24,6 +24,8 @@ usage()
>  	echo "  -r    RPC tests"
>  	echo "  -s    SCTP tests"
>  	echo "  -t    TCP/IP command tests"
> +	echo "  -c    TI-RPC tests"
> +	echo "  -s    TS-RPC tests"

Unfortunately I missed it in the first version, we already has '-s'
option for SCTP.

Thanks,
Alexey
