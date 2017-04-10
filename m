From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 10 Apr 2017 13:36:28 +0300
Subject: [LTP] [RFC PATCH v4 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <20170405204418.3240-3-pvorel@suse.cz>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <20170405204418.3240-3-pvorel@suse.cz>
Message-ID: <ca79cf52-c655-17d6-9a53-34e6a4a0f2fb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 04/05/2017 11:44 PM, Petr Vorel wrote:
> ...
> +static int get_ipv4_info(struct in_addr *lIp, struct in_addr *rIp, int prefix)
> +{
> +	vars.ipv4_network = get_ipv4_network(lIp->s_addr, prefix,
> +		FLAG_GET_NETWORK);
> +	if (strcmp(vars.ipv4_network, get_ipv4_network(rIp->s_addr, prefix,
> +			FLAG_GET_NETWORK))) {
> +		fprintf(stderr, "Please use the same network for both IP addresses\n");
> +		return -1;

Thinking more about this, we shouldn't put such restrictions on
network configuration as well. There could be more complex setup
involving routers, NAT, etc.

Thanks,
Alexey

