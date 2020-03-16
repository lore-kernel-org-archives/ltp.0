From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Mar 2020 17:33:55 +0100
Subject: [LTP] [PATCH v3 1/3] Create separate .c file for
 include/tst_net.h
In-Reply-To: <20200316141842.GB26750@rei.lan>
References: <20200312125545.3976-1-mdoucha@suse.cz>
 <20200312125545.3976-2-mdoucha@suse.cz>
 <20200313125742.GA5232@rei.lan>
 <dcac6d42-dff5-53ed-34eb-5aed3e184896@suse.cz>
 <20200316141842.GB26750@rei.lan>
Message-ID: <20200316163355.GA8204@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Cyril,

> > >> +int tst_bit_count(uint32_t i);
> > >> +int tst_mask2prefix(struct in_addr mask);
> > >> +int tst_ipv4_mask_to_int(const char *prefix);
> > >> +int tst_safe_atoi(const char *s, int *ret_i);
> > >> +int tst_get_prefix(const char *ip_str, int is_ipv6);
> > >> +void tst_get_in_addr(const char *ip_str, struct in_addr *ip);
> > >> +void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6);

> > > Do we need all of these exported in the public API?

> > > It looks to me like most of these shouldn't be exported at all.

> > I guess that's a question for Petr. I'll be happy to drop the functions
> > meant to be private from the .h file and make them static in the .c file.

> Let's do that, there is no point in exporting unused functions.
When I created tst_net.h, I thought functions would be used in other tests, as
they're general network functions. This is not true for tst_{brk,res}_comment()
macro, MAX_IPV{4,6}_PREFIX defintions and tst_safe_atoi() which are specific
tst_net_{iface,ip}_prefix.c and tst_net_vars.c. We should probably have separate
header (and probably source file) for these macros and for functions which
aren't needed (yet), which would be used just for tst_net_{iface,ip}_prefix.c
and tst_net_vars.c and not exported by API.

tst_safe_atoi() has confusing name, because this function does not lead to
tst_brk(), but uses tst_brk_comment() (it's a bit confusing, but not sure for
proper name).

But maybe you meant to have all of them as private (accessible by few C sources
which need them and export only these new functions Martin added in his second
commit.

Kind regards,
Petr
