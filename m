From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Thu, 22 Mar 2018 16:03:58 +0800
Subject: [LTP] [PATCH] busy_poll* : revise poll_cmp
In-Reply-To: <4f48b8e7-21ca-088e-24eb-c5b79c3bac18@oracle.com>
References: <c999a175-d02b-beda-7418-95a5b0f2d432@cn.fujitsu.com>
 <fae2ea47-a416-f2b4-ee2b-f022f14a14a0@oracle.com>
 <a10e1806-2646-528d-c327-d061affc522b@cn.fujitsu.com>
 <4f48b8e7-21ca-088e-24eb-c5b79c3bac18@oracle.com>
Message-ID: <d027896f-144d-6b4e-a08f-65fe1d6112e2@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey

On 03/21/2018 06:50 PM, Alexey Kodanev wrote:
> On 03/20/2018 03:18 AM, sunlianwen wrote:
>> Hi Alexey
>>
>>    You are right, I think is wrong, I debug this case again,
>>
>> and find the driver is virtio_net no support busy poll.
>
> There is support in virtio_net... may be the problem in the underlying
> configuration/driver, latency between guest and the other host? you could
> also try netperf -H remote_host -t TCP_RR with/without busy_polling:
>
> # sysctl net.core.busy_read=50
> # sysctl net.core.busy_poll=50
>
Thanks your advise. and I find a patch:"virtio_net: remove custom busy_poll"
patch link 
:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/virtio_net.c?id=ceef438d613f6d
I am not sure  whether this patch  mean virtio_net no support busy poll.

Below is debuginfo follow your advise.

# sysctl net.core.busy_read=0
net.core.busy_read = 0

# sysctl net.core.busy_poll=0
net.core.busy_poll = 0

# netperf -H 192.168.122.248 -t TCP_RR
MIGRATED TCP REQUEST/RESPONSE TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET 
to 192.168.122.248 () port 0 AF_INET : first burst 0
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

16384  87380  1        1       10.00    30101.63
16384  87380

# sysctl net.core.busy_read=50
net.core.busy_read = 50
# sysctl net.core.busy_poll=50
net.core.busy_poll = 50

# netperf -H 192.168.122.248 -t TCP_RR
MIGRATED TCP REQUEST/RESPONSE TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET 
to 192.168.122.248 () port 0 AF_INET : first burst 0
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec

16384  87380  1        1       10.00    37968.90
16384  87380

-----------------------------------------------------------------------
<<<test_output>>>
incrementing stop
busy_poll01 1 TINFO: Network config (local -- remote):
busy_poll01 1 TINFO: eth1 -- eth1
busy_poll01 1 TINFO: 192.168.1.41/24 -- 192.168.1.20/24
busy_poll01 1 TINFO: fd00:1:1:1::1/64 -- fd00:1:1:1::2/64
busy_poll01 1 TINFO: set low latency busy poll to 50
busy_poll01 1 TINFO: run server 'netstress -R 500000 -B 
/tmp/ltp-EmybkMxKgu/busy_poll01.IIOgfKYQ6P'
busy_poll01 1 TINFO: run client 'netstress -l -H 192.168.1.20 -a 2 -r 
500000 -d res_50 -g 44175'
busy_poll01 1 TPASS: netstress passed, time spent '53265' ms
busy_poll01 2 TINFO: set low latency busy poll to 0
busy_poll01 2 TINFO: run server 'netstress -R 500000 -B 
/tmp/ltp-EmybkMxKgu/busy_poll01.IIOgfKYQ6P'
busy_poll01 2 TINFO: run client 'netstress -l -H 192.168.1.20 -a 2 -r 
500000 -d res_0 -g 46767'
busy_poll01 2 TPASS: netstress passed, time spent '23393' ms
busy_poll01 3 TFAIL: busy poll result is '-127' %
<<<execution_status>>>
initiation_status="ok"
duration=79 termination_type=exited termination_id=1 corefile=no
cutime=148 cstime=6930
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20180118

###############################################################

             Done executing testcases.
             LTP Version:  20180118
###############################################################

Thanks,
Lianwen Sun


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180322/f8d6223c/attachment.html>
