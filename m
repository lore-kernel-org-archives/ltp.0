From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 11 Dec 2020 14:09:57 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: add getopts to tst_ping()
In-Reply-To: <X9M4ol3AqYU8YtZQ@pevik>
References: <20201208162440.14538-1-alexey.kodanev@oracle.com>
 <X9M4ol3AqYU8YtZQ@pevik>
Message-ID: <4b2f0cc7-2caf-34a5-12c2-6d0c33bfcbf0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11.12.2020 12:15, Petr Vorel wrote:
> Hi Alexey,
> 
> BTW -f does not require root (but effectively it's required by netns setup).

Hi Petr,

Are sure -f doesn't require root?

> 
>> * Replace '-i 0' with '-f'
> Out of curiosity, why flood ping is better than -i 0?
> More effective stressing?

I think it's better to use the option that is specially made
for this, isn't it? AFAIK, -f won't do verbose printing, though
we could add -q too along with -i 0...

> 
> Ad Busybox ping fallback -i 0.01, interesting -i 0 keeps blocked in
> recvfrom():
> 
> $ strace busybox ping -i 0 localhost
> setsockopt(0, SOL_SOCKET, SO_BROADCAST, [1], 4) = 0
> setsockopt(0, SOL_SOCKET, SO_RCVBUF, [7280], 4) = 0
> rt_sigaction(SIGINT, {sa_handler=0x55935b81f3a0, sa_mask=[INT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f82be570af0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> sendto(0, "\10\0H\25*k\0\0T\2200\357\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 64, 0, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, 28) = 64
> rt_sigaction(SIGALRM, {sa_handler=0x55935b81f4d0, sa_mask=[ALRM], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f82be570af0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0}, it_value={tv_sec=0, tv_usec=0}}, NULL) = 0
> recvfrom(0, "E\0\0Tf\25@\0@\1\326\221\177\0\0\1\177\0\0\1\10\0H\25*k\0\0T\2200\357"..., 192, 0, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, [16]) = 84
> recvfrom(0, "E\0\0Tf\26\0\0@\1\26\221\177\0\0\1\177\0\0\1\0\0P\25*k\0\0T\2200\357"..., 192, 0, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, [16]) = 84
> write(1, "64 bytes from 127.0.0.1: seq=0 t"..., 5264 bytes from 127.0.0.1: seq=0 ttl=64 time=0.634 ms
> ) = 52
> recvfrom(0,
> 
> Is that a bug?
> 

Looks like a bug.

> Kind regards,
> Petr
> 
>> * Add similar checks for the flood and interval options as
>>   in ping02 test

