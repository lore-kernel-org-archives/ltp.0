From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 3 Apr 2017 14:41:06 +0300
Subject: [LTP] [RFC PATCH v2 3/3] network: Use tst_net_vars to set up
	variables
In-Reply-To: <20170403071428.11754-4-pvorel@suse.cz>
References: <20170403071428.11754-1-pvorel@suse.cz>
 <20170403071428.11754-4-pvorel@suse.cz>
Message-ID: <68c3a5d7-5131-4692-df0d-98be86dba46a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.04.2017 10:14, Petr Vorel wrote:
> +# set test links + networks that aren't reachable through the test links
> +IPV4_HOST="${IPV4_HOST:-10.0.0.1/24}"
> +IPV4_HOST2="${IPV4_HOST2:-10.0.0.2/24}"

It would be better to use "IPV4_RHOST" and "IPV4_LHOST" names instead,
though it might be on the same host. This lines up with "RHOST" variable.

Also note that previously, 10.0.0.1 address was assigned to remote host
and 10.0.0.2 to the local host, we shouldn't change it.

Thanks,
Alexey
