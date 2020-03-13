From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Mar 2020 15:50:04 +0100
Subject: [LTP] [PATCH v3 1/3] Create separate .c file for
 include/tst_net.h
In-Reply-To: <20200313125742.GA5232@rei.lan>
References: <20200312125545.3976-1-mdoucha@suse.cz>
 <20200312125545.3976-2-mdoucha@suse.cz> <20200313125742.GA5232@rei.lan>
Message-ID: <dcac6d42-dff5-53ed-34eb-5aed3e184896@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13. 03. 20 13:57, Cyril Hrubis wrote:
> Hi!
>> +int tst_bit_count(uint32_t i);
>> +int tst_mask2prefix(struct in_addr mask);
>> +int tst_ipv4_mask_to_int(const char *prefix);
>> +int tst_safe_atoi(const char *s, int *ret_i);
>> +int tst_get_prefix(const char *ip_str, int is_ipv6);
>> +void tst_get_in_addr(const char *ip_str, struct in_addr *ip);
>> +void tst_get_in6_addr(const char *ip_str, struct in6_addr *ip6);
> 
> Do we need all of these exported in the public API?
> 
> It looks to me like most of these shouldn't be exported at all.

I guess that's a question for Petr. I'll be happy to drop the functions
meant to be private from the .h file and make them static in the .c file.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
