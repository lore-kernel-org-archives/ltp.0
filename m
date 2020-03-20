From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 20 Mar 2020 10:43:14 +0100
Subject: [LTP] [PATCH v4 3/3] Add connection tests for bind()
In-Reply-To: <20200320085427.GA14750@dell5510>
References: <20200317121057.13529-1-mdoucha@suse.cz>
 <20200317121057.13529-3-mdoucha@suse.cz> <20200320085427.GA14750@dell5510>
Message-ID: <5cf7a3b1-1b34-d10c-5c93-e77ef77f3044@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20. 03. 20 9:54, Petr Vorel wrote:
> Hi Martin,
> 
> whole patchset is very nice work. Thanks!
> 
>> +static void setup(void)
>> +{
>> +	srand(time(0));
>> +
>> +	tst_init_sockaddr_inet(&ipv4_addr, IPV4_ADDRESS, 0);
>> +	tst_init_sockaddr_inet_bin(&ipv4_any_addr, INADDR_ANY, 0);
>> +	tst_init_sockaddr_inet6_bin(&ipv6_addr, &in6addr_loopback, 0);
>> +	tst_init_sockaddr_inet6_bin(&ipv6_any_addr, &in6addr_any, 0);
>> +}
> You don't use tst_init_sockaddr_inet6() at all. How about using it?
> 
> Or do you have some reason not to use it?

tst_init_sockaddr_inet6() was trivial to implement so it's there for
future use. The only reason why I'm not using it is that both loopback
and wildcard addresses are provided by libc in expanded form so I don't
need to convert them from string. I'll leave this patch as is.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
