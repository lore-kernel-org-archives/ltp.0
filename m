From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Feb 2017 18:46:44 +0300
Subject: [LTP] [PATCH v3 2/4] network: Add TI-RPC and TS-RPC tests into
 network.sh
In-Reply-To: <20170216223721.11493-2-pvorel@suse.cz>
References: <20170216223721.11493-1-pvorel@suse.cz>
 <20170216223721.11493-2-pvorel@suse.cz>
Message-ID: <21adc0e1-0084-fd8f-9832-2293c02a9e03@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 17.02.2017 1:37, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * Use -d as -s has already been used as option for SCTP.
> ---
> ...
>  	echo "  -t    TCP/IP command tests"
> +	echo "  -c    TI-RPC tests"
> +	echo "  -s    TS-RPC tests"

Changed the above to '-d' option and pushed, thanks!

Best regards,
Alexey

