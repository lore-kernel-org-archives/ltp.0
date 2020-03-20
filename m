From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Mar 2020 10:03:42 +0100
Subject: [LTP] [PATCH v4 2/3] Add socket address initialization
 functions to tst_net library
In-Reply-To: <20200317121057.13529-2-mdoucha@suse.cz>
References: <20200317121057.13529-1-mdoucha@suse.cz>
 <20200317121057.13529-2-mdoucha@suse.cz>
Message-ID: <20200320090342.GA12179@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> @@ -145,3 +146,73 @@ void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6)
>  	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
>  		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
Just a note: tst_brk_comment() and tst_res_comment() prepend '# ' to the
message. This was meant only for tst_net_vars.c, tst_net_ip_prefix.c and
tst_net_iface_prefix.c, to prevent shell eval breakage. But let's use it also
for tests as the code gets simpler.

Kind regards,
Petr
