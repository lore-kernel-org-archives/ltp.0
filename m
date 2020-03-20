From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 20 Mar 2020 10:44:29 +0100
Subject: [LTP] [PATCH v4 2/3] Add socket address initialization
 functions to tst_net library
In-Reply-To: <20200320090342.GA12179@dell5510>
References: <20200317121057.13529-1-mdoucha@suse.cz>
 <20200317121057.13529-2-mdoucha@suse.cz> <20200320090342.GA12179@dell5510>
Message-ID: <44354b4a-ad4e-6555-44a9-f02427f0352b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20. 03. 20 10:03, Petr Vorel wrote:
> Hi Martin,
> 
>> @@ -145,3 +146,73 @@ void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6)
>>  	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
>>  		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
> Just a note: tst_brk_comment() and tst_res_comment() prepend '# ' to the
> message. This was meant only for tst_net_vars.c, tst_net_ip_prefix.c and
> tst_net_iface_prefix.c, to prevent shell eval breakage. But let's use it also
> for tests as the code gets simpler.

Should I move them back to tst_net.h then? Or tst_test.h even?

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
