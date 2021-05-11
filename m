From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 11 May 2021 15:58:05 +0300
Subject: [LTP] [PATCH] bugfix for network/lib6/getaddrinfo_01.c
In-Reply-To: <YJp2u+lUy9VMq9Wb@pevik>
References: <20210511091630.23257-1-dongshijiang@inspur.com>
 <YJp2u+lUy9VMq9Wb@pevik>
Message-ID: <d1dc697b-f73a-3be4-c5df-151aae021265@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11.05.2021 15:21, Petr Vorel wrote:
> Hi,
> 
> [ Cc: Alexey, Martin and Cyril ]
> 
>> For test cases (test2 ,IPV4 canonical name) and (test13 ,IPV6 canonical name)
> 
>> The gethostname() API returns the official name of host, not the canonical name of host.
>> The canonical name of host needs to be obtained through the gethostbyname() API;
> 
> Yes, test 2 and 13 fails systems which don't use FQDN as hostname and have DNS records
> due mismatch short name and FQDN, e.g.:
> getaddrinfo_01    2  TFAIL  :  getaddrinfo_01.c:140: getaddrinfo IPv4 canonical name ("foo.suse.cz") doesn't match hostname ("foo")
> 
> It's a bit strange to use deprecated gethostbyname() in getaddrinfo() tests :).

Yeah, gethostbyname() is obsolete, we shouldn't compare both here,
i.e. getaddrinfo() vs gethostbyname()...

> Yes, it's the easiest way to get FQDN instead of just "short" hostname. But
> Maybe simple check if we have FQDN with strchr for dot and TCONF it's just short
> name would be better.

+1, and instead of TCONF we could check the "shortname" that
we pass to getaddrinfo():

>>  	shortname[MAXHOSTNAMELEN] = '\0';
>>  	p = strchr(shortname, '.');
>>  	if (p)

...
> 
> FYI Workaround on systems which do not have DNS record is to use /etc/fstab.
> We should document in testcases/network/README.md that when using /etc/fstab,

/etc/hosts

> well recommended order FQDN and *then* short name is required, e.g.:
> ::1 foo.suse.cz foo
> 
> Other setup fails, e.g.:
> ::1 foo
> ::1 foo foo.suse.cz
> 
> leads to error:
> getaddrinfo_01   13  TFAIL  :  getaddrinfo_01.c:611: getaddrinfo IPv6 canonical name ("foo") doesn't match hostname ("foo.suse.cz")
> 
> and setup:
> ::1 foo.suse.cz
> 
> leads to
> getaddrinfo_01   12  TFAIL  :  getaddrinfo_01.c:594: getaddrinfo IPv6 basic lookup ("foo") returns -5 ("No address associated with hostname")
> 
> The best would be if the test checked the correct setup itself
> but not sure how do it to not complicate this test too much.
> I guess during rewrite of this test we might decide to split it.
> 
> Other TODO (not related to this patch:
> e.g.: it fails when there no DNS record nor records in /etc/hosts:
> 
> getaddrinfo_01    1  TFAIL  :  getaddrinfo_01.c:117: getaddrinfo IPv4 basic lookup ("myhost") returns -2 ("Name or service not known")
> ...
> getaddrinfo_01   12  TFAIL  :  getaddrinfo_01.c:599: getaddrinfo IPv6 basic lookup ("myhost") returns -2 ("Name or service not known")
> 
> Any distro installer should add them, but I guess we should TCONF in this case.
> 
> or when there is DNS A record, but not AAAA: 
> getaddrinfo_01   12  TFAIL  :  getaddrinfo_01.c:596: getaddrinfo IPv6 basic lookup ("myhost.suse.cz") returns -5 ("No address associated with hostname")
> 
> During rewriting to new API test would deserve cleanup, e.g.
> remove duplicity in gaiv4() and gaiv6() (getaddrinfo() can deal with IPv4
> and IPv6 in a nice way through hints, see safe_getaddrinfo()).
> 
> Kind regards,
> Petr
> 

