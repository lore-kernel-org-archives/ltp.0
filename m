From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Tue, 27 Feb 2018 14:47:49 +0800
Subject: [LTP] [error] report a fail about udp4_ipsec_vti*
Message-ID: <85fed43e-5f7c-f2c3-3f00-b7e4cf9d6f1f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey

    I run udp4[6]_ipsec_vti always fail. when client /server message 
size is 65463

then timeout will happen. I try to modify the client/server message size 
then run

this case and find the size is less than 1428 the case running is ok.  
But I do not know

why the threshold size is 1428.  can you  tell me the reason of this 
failure.

the test log is below:

<<test_start>>>
tag=udp4_ipsec_vti01 stime=1519695625
cmdline="udp_ipsec_vti.sh -p ah -m tunnel -s "100 1000 65463""
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
udp_ipsec_vti 1 TINFO: Network config (local -- remote):
udp_ipsec_vti 1 TINFO: eth1 -- eth1
udp_ipsec_vti 1 TINFO: 192.168.100.42/24 -- 192.168.100.117/24
udp_ipsec_vti 1 TINFO: fd00:1:1:1::1/64 -- fd00:1:1:1::2/64
udp_ipsec_vti 1 TINFO: Test vti + IPsec[ah/tunnel]
udp_ipsec_vti 1 TINFO: Add IPs to vti tunnel,  loc: 10.23.1.1/30, rmt: 
10.23.1.2/30
udp_ipsec_vti 1 TINFO: run server 'netstress -T udp -R 500000 -g 42456'
udp_ipsec_vti 1 TINFO: check that server port in 'LISTEN' state
udp_ipsec_vti 1 TINFO: run client 'netstress -l -T udp -H 10.23.1.2 -n 
100 -N 100 -a 2 -r 500 -d tst_netload.res -g 42456'
udp_ipsec_vti 1 TPASS: netstress passed, time spent '47' ms
udp_ipsec_vti 2 TINFO: run server 'netstress -T udp -R 500000 -g 50062'
udp_ipsec_vti 2 TINFO: check that server port in 'LISTEN' state
udp_ipsec_vti 2 TINFO: run client 'netstress -l -T udp -H 10.23.1.2 -n 
1000 -N 1000 -a 2 -r 500 -d tst_netload.res -g 50062'
udp_ipsec_vti 2 TPASS: netstress passed, time spent '51' ms
udp_ipsec_vti 3 TINFO: run server 'netstress -T udp -R 500000 -g 46465'
udp_ipsec_vti 3 TINFO: check that server port in 'LISTEN' state
udp_ipsec_vti 3 TINFO: run client 'netstress -l -T udp -H 10.23.1.2 -n 
65463 -N 65463 -a 2 -r 500 -d tst_netload.res -g 46465'
tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
netstress.c:777: INFO: max requests '500000'
netstress.c:803: INFO: using UDP
netstress.c:582: INFO: assigning a name to the server socket...
tst_test.c:980: INFO: Timeout per run is 0h 05m 00s
netstress.c:756: INFO: connection: addr '10.23.1.2', port '46465'
netstress.c:757: INFO: client max req: 500
netstress.c:758: INFO: clients num: 2
netstress.c:763: INFO: client msg size: 65463
netstress.c:764: INFO: server msg size: 65463
netstress.c:771: INFO: max timeout errors 12
netstress.c:696: INFO: set '/proc/sys/net/ipv4/tcp_tw_reuse' to '1'
netstress.c:803: INFO: using UDP
netstress.c:407: INFO: Running the test over IPv4
netstress.c:353: WARN: client exit on '0' request
netstress.c:426: BROK: client[1] failed: No message of desired type
netstress.c:161: INFO: unset '/proc/sys/net/ipv4/tcp_tw_reuse' back to '0'

Summary:
passed   0
failed   0
skipped  0
warnings 1
udp_ipsec_vti 3 TFAIL: expected 'pass' but ret: '1

That's all

Thanks

Lianwen Sun



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180227/1c5c5ff7/attachment-0001.html>
