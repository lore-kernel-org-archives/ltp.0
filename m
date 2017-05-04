From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 4 May 2017 16:41:36 +0200
Subject: [LTP] [RFC PATCH v5 2/3] network: Add tool for setup IP
 variables
In-Reply-To: <20170503160751.1634-3-pvorel@suse.cz>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <20170503160751.1634-3-pvorel@suse.cz>
Message-ID: <20170504164136.46444e27@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Just a couple of minor comments, I haven't properly read it.

On Wed,  3 May 2017 18:07:50 +0200
"Petr Vorel" <pvorel@suse.cz> wrote:

> +/*
> + * Function prefix2mask is from ipcalc project, ipcalc.c.
> + */
> +struct in_addr prefix2mask(int prefix)
> +{
> +	struct in_addr mask;
> +
> +	memset(&mask, 0, sizeof(mask));

FYI for these memsets you could use 'struct foo bar = { 0 }' instead. Although
it generates warnings on older compilers if the struct starts with another
composite data type.

> +
> +static int read_prefix(const char *ip_str, int is_ipv6)
> +{
> +	uint8_t family = is_ipv6 ? AF_INET6 : AF_INET;
> +
> +	char buf[16384];
> +	int len;
> +
> +	struct {
> +		struct nlmsghdr nlhdr;
> +		struct ifaddrmsg addrmsg;
> +	} msg;
> +
> +	struct nlmsghdr *retmsg;
> +
> +	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.nlhdr.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
> +	msg.nlhdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT;
> +	msg.nlhdr.nlmsg_type = RTM_GETADDR;
> +	msg.addrmsg.ifa_family = family;
> +
> +	send(sock, &msg, msg.nlhdr.nlmsg_len, 0);
> +	len = recv(sock, buf, sizeof(buf), 0);
> +	retmsg = (struct nlmsghdr *)buf;

No error checking? I suppose it is unlikely to fail, but it can't hurt.

> +
> +	while NLMSG_OK(retmsg, len) {
> +		struct ifaddrmsg *retaddr;
> +		struct rtattr *retrta;
> +		char pradd[128];
> +		int attlen;
> +
> +		retaddr = (struct ifaddrmsg *)NLMSG_DATA(retmsg);
> +		retrta = (struct rtattr *)IFA_RTA(retaddr);
> +		attlen = IFA_PAYLOAD(retmsg);
> +
> +		while RTA_OK(retrta, attlen) {
> +			if (retrta->rta_type == IFA_ADDRESS) {
> +				inet_ntop(family, RTA_DATA(retrta), pradd, sizeof(pradd));
> +				if (!strcmp(pradd, ip_str))
> +					return retaddr->ifa_prefixlen;
> +			}
> +			retrta = RTA_NEXT(retrta, attlen);
> +
> +		}
> +		retmsg = NLMSG_NEXT(retmsg, len);
> +	}
> +
> +	return -1;
> +}
> +

Thank you,
Richard.
