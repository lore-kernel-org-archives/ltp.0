From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 15 Feb 2019 12:26:28 +0300
Subject: [LTP] [PATCH 2/4] netstress: allow setting MSG_ZEROCOPY for
 other protocols
In-Reply-To: <20190214233442.GB12954@x230>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
 <1549908467-15609-3-git-send-email-alexey.kodanev@oracle.com>
 <20190214233442.GB12954@x230>
Message-ID: <71eb61bc-4a65-bc35-d039-8b4099256c10@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 15.02.2019 02:34, Petr Vorel wrote:
> Hi Alexey,
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for review!

> 
>> ---
>>  testcases/network/netstress/netstress.c |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
>> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
>> index 2cdc91a..63d02c9 100644
>> --- a/testcases/network/netstress/netstress.c
>> +++ b/testcases/network/netstress/netstress.c
>> @@ -942,13 +942,14 @@ static void setup(void)
>>  		}
>>  	}
> 
>> +	if (zcopy)
>> +		send_flags |= MSG_ZEROCOPY;
>> +
>>  	switch (proto_type) {
>>  	case TYPE_TCP:
>>  		tst_res(TINFO, "TCP %s is using %s TCP API.",
>>  			(client_mode) ? "client" : "server",
>>  			(fastopen_api) ? "Fastopen" : "old");
>> -		if (zcopy)
>> -			send_flags |= MSG_ZEROCOPY;
>>  		check_tfo_value();
>>  	break;
>>  	case TYPE_UDP:
> 
> BTW MSG_ZEROCOPY is enabled only for TCP and UDP, but we allow it to be set on
> all, which leads to BROK:
> ./netstress -z -T sctp
> tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> netstress.c:938: INFO: max requests '3'
> netstress.c:990: INFO: SCTP server
> netstress.c:693: INFO: assigning a name to the server socket...
> netstress.c:700: INFO: bind to port 37196
> safe_net.c:186: BROK: netstress.c:717: setsockopt(3, 1, 60, 0x7fff155701a4, 4) failed: ???
> 

This is expected fail, I would keep it.

Hmm, there is no error description. I've checked the errno returned and the
kernel sources, found that it is actually returning ENOTSUPP(524). I think it
should rather be EOPNOTSUPP(95), since the error is returned to user-space [1]:

diff --git a/net/core/sock.c b/net/core/sock.c
index 6aa2e7e..f6c57de 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1023,9 +1023,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
                               sk->sk_protocol == IPPROTO_TCP) ||
                              (sk->sk_type == SOCK_DGRAM &&
                               sk->sk_protocol == IPPROTO_UDP)))
-                               ret = -ENOTSUPP;
+                               ret = -EOPNOTSUPP;
                } else if (sk->sk_family != PF_RDS) {
-                       ret = -ENOTSUPP;
+                       ret = -EOPNOTSUPP;
                }
                if (!ret) {
                        if (val < 0 || val > 1)



For LTP library: may be we need to return the actual errno if strerror()
returns nothing?


[1] https://lists.gt.net/linux/kernel/2207071

> 
> Kind regards,
> Petr
> 

