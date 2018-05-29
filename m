From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 29 May 2018 14:01:40 +0300
Subject: [LTP] rport a fail about test_1_to_1_events
In-Reply-To: <b95918a7-5fa3-45bf-32d9-e14bb8f6f3c2@cn.fujitsu.com>
References: <b95918a7-5fa3-45bf-32d9-e14bb8f6f3c2@cn.fujitsu.com>
Message-ID: <155b4394-e32e-ae7d-e09a-954e3f67d127@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/29/2018 10:04 AM, Sun Lianwen wrote:
> Hi Alexey,
> 
>   I run the testcase "test_1_to_1_events failed" on rhel7.5 which kernel version is 
> 
> 4.17-rc7. and run this testcase pass when the kernel version is 3.10.0-862.but I don't 
> 
> know where have problem in the 4.17-rc7 kernel or the testcase have some problem.
> 
> the test result is below:
> <<<test_output>>>
> incrementing stop
> test_1_to_1_events.c    1  TPASS  :  COMM_UP notification on client socket - SUCCESS                                                          
> test_1_to_1_events.c    2  TPASS  :  COMM_UP notification on server socket - SUCCESS                                                          
> test_1_to_1_events.c    3  TBROK  :  sctputil.c:241: Got a notification, expecting adatamsg                                                   
> test_1_to_1_events.c    4  TBROK  :  sctputil.c:241: Remaining cases broken

Looks like the same issue:

https://github.com/sctp/lksctp-tools/issues/24


> ----------------------------------------------------------------------------------------------------
> I tcpdump get the packet is below:
> 18:12:47.723499 IP (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 92)                                          
>     localhost.52224 > localhost.1024: sctp
>         1) [INIT] [init tag: 594978118] [rwnd: 106496] [OS: 10] [MIS: 65535] [init TSN: 1560186424]                                           
> 18:12:47.723527 IP (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 324)                                         
>     localhost.1024 > localhost.52224: sctp
>         1) [INIT ACK] [init tag: 3986079895] [rwnd: 106496] [OS: 10] [MIS: 10] [init TSN: 1657179001]                                         
> 18:12:47.723536 IP (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 296)                                         
>     localhost.52224 > localhost.1024: sctp
>         1) [COOKIE ECHO]
> 18:12:47.723552 IP (tos 0x2,ECT(0), ttl 64, id 0, offset 0, flags [DF], proto SCTP (132), length 36)                                          
>     localhost.1024 > localhost.52224: sctp
>         1) [COOKIE ACK]
> 18:12:47.723883 IP (tos 0x2,ECT(0), ttl 64, id 1, offset 0, flags [DF], proto SCTP (132), length 64)                                          
>     localhost.52224 > localhost.1024: sctp
>         1) [DATA] (B)(E) [TSN: 1560186424] [SID: 1] [SSEQ 0] [PPID 0x67458b6b] [Payload:                                                      
>         0x0000:  6865 6c6c 6f2c 2077 6f72 6c64 210a 00    hello,.world!..]                                                                    
> 18:12:47.723891 IP (tos 0x2,ECT(0), ttl 64, id 8626, offset 0, flags [DF], proto SCTP (132), length 48)                                       
>     localhost.1024 > localhost.52224: sctp
>         1) [SACK] [cum ack 1560186424] [a_rwnd 106481] [#gap acks 0] [#dup tsns 0]                                                            
> 18:12:47.724041 IP (tos 0x2,ECT(0), ttl 64, id 8627, offset 0, flags [DF], proto SCTP (132), length 40)                                       
>     localhost.1024 > localhost.52224: sctp
>         1) [ABORT]
> -----------------------------------------------------------------------------------------------------
> Thanks
> Sun Lianwen
> 
> 
> 

