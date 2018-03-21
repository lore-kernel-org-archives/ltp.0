From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Mar 2018 14:28:11 +0300
Subject: [LTP] [PATCH] cve: new regression test-case for CVE-2018-5803
In-Reply-To: <20180320140051.mxh5mqndc4gp72og@dell5510>
References: <1520872613-30423-1-git-send-email-alexey.kodanev@oracle.com>
 <20180320140051.mxh5mqndc4gp72og@dell5510>
Message-ID: <a26d2a06-429a-b0dd-995a-c01dbb7a4718@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/20/2018 05:00 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> There are two test-cases in runtest/cve:
>> * cve-2018-5803 - for over-sized INIT_ACK packet
>> * cve-2018-5803_2 - for over-sized INIT packet
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>>  include/lapi/socket.h         |    4 +
>>  runtest/cve                   |    2 +
>>  testcases/cve/.gitignore      |    1 +
>>  testcases/cve/cve-2018-5803.c |  124 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 131 insertions(+), 0 deletions(-)
>>  create mode 100644 testcases/cve/cve-2018-5803.c
> 
>> diff --git a/include/lapi/socket.h b/include/lapi/socket.h
>> index 426906f..d58c460 100644
>> --- a/include/lapi/socket.h
>> +++ b/include/lapi/socket.h
>> @@ -45,6 +45,10 @@
>>  # define SOCK_CLOEXEC 02000000
>>  #endif
> 
>> +#ifndef SOL_SCTP
>> +# define SOL_SCTP	132
>> +#endif
> I suppose you deliberately don't include linux/socket.h where
> SOL_SCTP is defined.

Hi Petr,


Do you think we should include linux headers for consistency?


>> +
>>  #ifndef SOL_UDPLITE
>>  # define SOL_UDPLITE		136 /* UDP-Lite (RFC 3828) */
>>  #endif
>> diff --git a/runtest/cve b/runtest/cve
>> index 0c385c6..826bb0b 100644
...
>> +
>> +	if (!pid) {
>> +		struct sockaddr_in6 addr6;
>> +		socklen_t addr_size = sizeof(addr6);
>> +
>> +		if (accept(sfd, (struct sockaddr *)&addr6, &addr_size) < 0)
>> +			tst_brk(TBROK | TERRNO, "accept() failed");
>> +		exit(0);
>> +	}
>> +
>> +	fcntl(cfd, F_SETFL, O_NONBLOCK);
>> +	connect(cfd, (struct sockaddr *)&rmt, sizeof(rmt));
> Minor nit: you can use SAFE_CONNECT().
> 


No, it should fail in the kernels with the fix, on the second test-case when
we get over-sized INIT chunk, I think ENOMEM returns in that case.


>> +
>> +	SAFE_KILL(pid, SIGKILL);
>> +	SAFE_WAITPID(pid, NULL, 0);
>> +
>> +	tst_res(TPASS, "test doesn't cause crash");
>> +}
>> +
>> +static struct tst_option options[] = {
>> +	{"a:", &addr_param, "-a       number of additional IP address params"},
>> +	{NULL, NULL, NULL}
>> +};
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.forks_child = 1,
>> +	.test_all = run,
>> +	.options = options
>> +};
> 
> LGTM.
> Tested-by: Petr Vorel <pvorel@suse.cz>
> Found one BROK on EINVAL on setsockopt(), most of older kernels in VM don't crash, bug generate
> heavy load.

Does it happen with a single address parameter? We could also lower parameter
size in the second test, e.g. from 10000 to 4000.

Also change SOCK_STREAM to SOCK_SEQPACKET

diff --git a/testcases/cve/cve-2018-5803.c b/testcases/cve/cve-2018-5803.c
index 3f03d8a..6bee914 100644
--- a/testcases/cve/cve-2018-5803.c
+++ b/testcases/cve/cve-2018-5803.c
@@ -63,7 +63,7 @@ static void setup_client(void)
        struct sockaddr_in6 addr_buf[addr_num];
        int i;

-       cfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
+       cfd = SAFE_SOCKET(AF_INET6, SOCK_SEQPACKET, IPPROTO_SCTP);
        rmt.sin6_family = AF_INET6;
        rmt.sin6_addr = in6addr_loopback;
        rmt.sin6_port = htons(port);


I could also add IPv4 version...

Thanks,
Alexey
