From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Jul 2017 10:35:30 +0200
Subject: [LTP] [RFC PATCH v7 10/11] network: Add tools for setup IP
 related environment variables
In-Reply-To: <778792d9-e201-f64d-f8f1-cb5ebe783aa9@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-11-pvorel@suse.cz>
 <778792d9-e201-f64d-f8f1-cb5ebe783aa9@oracle.com>
Message-ID: <20170727083530.exjmur6emuurbqwm@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 21.07.2017 7:04, Petr Vorel wrote:
> > New tools:
> > * tst_net_ip_prefix
> > Strip prefix from IP address and save both
> > If no prefix found sets default prefix.

> > * tst_net_iface_prefix
> > tst_net_iface_prefix reads prefix and interface from rtnetlink.

> > * tst_net_vars takes input of local and remote address and setup most of
> > test link (IP related) environment variables.

> Have you checked my comments for the previous version?
Sure :-). I've spent quite some time to think about that and test it, but of course I
might overlook something.
Anything particular you don't agree with?

...
> > +int main(int argc, char *argv[])
> > +{
> > +	char *ip_str = NULL, *prefix_str = NULL;
> > +	int is_ipv6, is_rhost = 0;
> > +
> > +	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
> > +		!strcmp(argv[1], "--help"));
> > +	if (argc < 2 || is_usage) {
> > +		usage(argv[0]);
> > +		exit(is_usage ? EXIT_SUCCESS : EXIT_FAILURE);
> > +	}
> > +	if (!strcmp(argv[1], "-r"))
> > +		is_rhost = 1;
> > +
> > +	ip_str = argv[is_rhost ? 2 : 1];
> > +	is_ipv6 = !!strchr(ip_str, ':');
> > +
> > +	prefix_str = strchr(ip_str, '/');
> > +	if (prefix_str)
> > +		vars.prefix = get_prefix(ip_str, is_ipv6);
> > +	else {
> > +		vars.prefix = is_ipv6 ? DEFAULT_IPV6_PREFIX : DEFAULT_IPV4_PREFIX;
> > +		tst_res_comment(TBROK,
> > +				"prefix and interface not found for '%s'. Using default value %d.\n",
> > +				ip_str, vars.prefix);

> The message is misleading, after tst_net_ip_prefix the script
> calls tst_net_iface_prefix.So better remove it, looks like
> it will be printed every time if you relies on auto configuration.
OK.

...
> > +static void print_vars(int is_ipv6)
> > +{
> > +	if (is_ipv6) {
> > +		print_svar("IPV6_LHOST", vars.ipv6_lhost);
> > +		print_svar("IPV6_RHOST", vars.ipv6_rhost);

> It is already done by tst_net_ip_prefix
Oh, good catch, sorry.

> > +		print_svar("IPV6_LNETMASK", vars.ipv6_lnetmask);
> > +		print_svar_change("IPV6_RNETMASK", vars.ipv6_rnetmask);
> > +		print_svar("IPV6_LNETWORK", vars.ipv6_lnetwork);
> > +		print_svar("IPV6_RNETWORK", vars.ipv6_rnetwork);
> > +		print_svar("LHOST_IPV6_HOST", vars.lhost_ipv6_host);
> > +		print_svar("RHOST_IPV6_HOST", vars.rhost_ipv6_host);
> > +		print_svar("IPV6_NET32_UNUSED", vars.ipv6_net32_unused);
> > +	} else {
> > +		print_svar("IPV4_LHOST", vars.ipv4_lhost);
> > +		print_svar("IPV4_RHOST", vars.ipv4_rhost);

> Here the same.

Thanks for your review!

Kind regards,
Petr
