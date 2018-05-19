From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Sat, 19 May 2018 14:28:06 +0800
Subject: [LTP] report a fail about udp6_ipsec*
Message-ID: <964ce82b-c9b5-8df5-6f48-27dbd9bec1ce@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

   I have a question about the udp6_ipsec*. the testcase udp6_ipsec03,

udp6_ipsec05,udp6_ipsec09 ... test fail on RHEL6.10Beta. and report the

same error message. "send(7, 0x7fca636badb0, 65527, 16384) failed: EMSGSIZE". 

I'm not sure whether is means the send() do not support send this size 

message on the rhel6.10beta or the testcase have some problem.

  Can you give me some advise.


man send

EMSGSIZE
      The  socket type requires that message be sent atomically, and the
      size of the message to be sent made this impossible

the rhel6.10beta do not support fastopen.

the test result is below:
<<<test_output>>>
udp_ipsec 1 TINFO: Network config (local -- remote):
udp_ipsec 1 TINFO: eth1 -- eth1
udp_ipsec 1 TINFO: 192.168.1.74/24 -- 192.168.1.76/24
udp_ipsec 1 TINFO: fd00:1:1:1::1/64 -- fd00:1:1:1::2/64
udp_ipsec 1 TINFO: run server 'netstress -T udp -R 500000 -B /tmp/ltp-t29eH8gszB/udp_ipsec.uAhB4jpE2Y'
udp_ipsec 1 TINFO: run client 'netstress -l -T udp -H fd00:1:1:1::2 -n 100 -N 100 -a 2 -r 500 -d tst_netload.res -g 42349'
udp_ipsec 1 TPASS: netstress passed, time spent '31' ms
udp_ipsec 2 TINFO: run server 'netstress -T udp -R 500000 -B /tmp/ltp-t29eH8gszB/udp_ipsec.uAhB4jpE2Y'
udp_ipsec 2 TINFO: run client 'netstress -l -T udp -H fd00:1:1:1::2 -n 1000 -N 1000 -a 2 -r 500 -d tst_netload.res -g 59313'
udp_ipsec 2 TPASS: netstress passed, time spent '43' ms
udp_ipsec 3 TINFO: run server 'netstress -T udp -R 500000 -B /tmp/ltp-t29eH8gszB/udp_ipsec.uAhB4jpE2Y'
udp_ipsec 3 TINFO: run client 'netstress -l -T udp -H fd00:1:1:1::2 -n 65527 -N 65527 -a 2 -r 500 -d tst_netload.res -g 37520'
tst_test.c:1015: INFO: Timeout per run is 0h 50m 00s
netstress.c:891: INFO: connection: addr 'fd00:1:1:1::2', port '37520'
netstress.c:892: INFO: client max req: 500
netstress.c:893: INFO: clients num: 2
netstress.c:898: INFO: client msg size: 65527
netstress.c:899: INFO: server msg size: 65527
netstress.c:912: INFO: max timeout errors 12
netstress.c:944: INFO: using UDP
netstress.c:477: INFO: Running the test over IPv6
safe_net.c:176: BROK: netstress.c:331: send(6, 0x7fca62cb9db0, 65527, 16384) failed: EMSGSIZE
safe_net.c:176: BROK: netstress.c:331: send(7, 0x7fca636badb0, 65527, 16384) failed: EMSGSIZE

Summary:
passed   0
failed   0
skipped  0
warnings 0
udp_ipsec 3 TFAIL: expected 'pass' but ret: '1'

Thanks you,
Lianwen.


