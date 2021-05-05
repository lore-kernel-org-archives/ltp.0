From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 5 May 2021 12:33:52 +0200
Subject: [LTP] [PATCH v3 6/6] Add test for CVE 2020-25705
In-Reply-To: <YJJtpXWM4BxH2ffu@pevik>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-6-mdoucha@suse.cz> <YJJtpXWM4BxH2ffu@pevik>
Message-ID: <4ea9d02a-2867-1977-cfd3-bd591d211733@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05. 05. 21 12:04, Petr Vorel wrote:
> I wonder if it'd be useful *later* (not bothering with it now) to allow tests
> just declare .needs_netdevice = 1 and have generic network setup done (similarly
> it's done in tst_net.sh). Or just define addresses a prefixes and do library to
> do the setup.

Sounds like a good idea.

> 
>> +	NETDEV_SET_STATE("ltp_veth2", 1);
>> +	NETDEV_ADD_ROUTE_INET("ltp_veth2", 0, 0, htonl(0xfa444e40), 26,
> nit: maybe define 0xfa444e40 (and 0xfa444e00) and 26 as constants?
>> +		0);
>> +
>> +	/* Configure parent namespace */
>> +	NETDEV_CHANGE_NS_FD("ltp_veth1", parentns);
>> +	SAFE_SETNS(parentns, CLONE_NEWNET);
>> +	addr = SRCADDR_BASE; /* 250.68.78.65 */
> nit: maybe repeating the address in the comment is not needed.

Yes, I should fix this and the <time.h> issue. Please push everything up
to patch 5 and then I'll resubmit v4 just for this patch.

> FYI I tested the test on several VM. Very old kernel detects problem only on
> more runs. But given it's 3.16 (and b38e7819cae9 is a fix for 4cdf507d5452 from
> v3.18-rc1 we can ignore this).

Pass is expected here. Vanilla v3.16 AFAIK does not have the global ICMP
rate limiter which introduced the real vulnerability in the first place.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
