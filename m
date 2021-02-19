From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 19 Feb 2021 16:15:50 +0000
Subject: [LTP] Error on few tests, asking for help on debug
In-Reply-To: <20210218174756.702dc94d@kmaincent-XPS-13-7390>
References: <20210218174756.702dc94d@kmaincent-XPS-13-7390>
Message-ID: <8735xs58zt.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

K?ry Maincent <kory.maincent@bootlin.com> writes:

> Hello,
>
> I have issues with tests: msgstress03, msgstress04, semctl09 and iptables.
> I join the error message above.
> Could you point me out what could be the problems?
>
> Thanks, Regards,
>
> K?ry
>
>
> msgstress03
> [  983.559819] cgroup: fork rejected by pids controller
> in /user.slice/user-0.slice/session-c2.scope
> Fork failed (may be OK if under stress)
> Fork failed (may be OK if under stress)
> Fork failed (may be OK if under stress)
> Fork failed (may be OK if under stress)
> Fork failed (may be OK if under stress)
> Fork failed (may be OK if under stress)
> msgstress03    1  TFAIL  :  msgstress03.c:155:  Fork failed (may be OK if under
> stress)
>
> msgstress04
> msgstress04    0  TINFO  :  Found 32000 available message queues
> msgstress04    0  TINFO  :  Using upto 2097091 pids
> Fork failure in the first child of child group 6331
> Fork failure in the second child of child group 6325
> Fork failure in the first child of child group 6320
> Fork failure in the first child of child group 6323
> Fork failure in the second child of child group 6308
> Fork failure in the first child of child group 6332
> Fork failure in the second child of child group 6297
> Fork failure in the second child of child group 6333
> Fork failure in the first child of child group 6326
> msgstress04    1  TFAIL  :  msgstress04.c:204: Fork failed (may be OK if under
> stress)

Probably you just hit some resource limit. You could trace it to find
out, but this is a common error on this type of test.

>
> semctl09  
> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s                           
> semctl09.c:71: TINFO: Test SYS_semctl syscall        
> semctl09.c:136: TINFO: Test SEM_STAT_ANY with nobody user                 
> semctl09.c:158: TPASS: SEM_INFO returned valid index 10 to semid 10
> semctl09.c:168: TPASS: Counted used = 1                            
> semctl09.c:116: TPASS: semset_cnt = 1                              
> semctl09.c:123: TPASS: sen_cnt = 2                                 
> semctl09.c:136: TINFO: Test SEM_STAT_ANY with root user                        
> semctl09.c:158: TPASS: SEM_INFO returned valid index 10 to semid 10            
> semctl09.c:168: TPASS: Counted used = 1                            
> semctl09.c:116: TPASS: semset_cnt = 1                              
> semctl09.c:123: TPASS: sen_cnt = 2                                 
> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s              
> semctl09.c:74: TINFO: Test libc semctl()             
> semctl09.c:136: TINFO: Test SEM_STAT_ANY with nobody user                       
> semctl09.c:152: TFAIL: SEM_STAT_ANY doesn't pass the buffer specified by the cal
> semctl09.c:136: TINFO: Test SEM_STAT_ANY with root user                         
> semctl09.c:152: TFAIL: SEM_STAT_ANY doesn't pass the buffer specified
> by the cal

Check that your glibc does not have the bug listed in the test source.

>
> iptables
> iptables01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface              
> iptables01 1 TINFO: add local addr 10.0.0.2/24                               
> iptables01 1 TINFO: add local addr fd00:1:1:1::2/64                          
> iptables01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface              
> iptables01 1 TINFO: add remote addr 10.0.0.1/24                              
> iptables01 1 TINFO: add remote addr fd00:1:1:1::1/64                         
> iptables01 1 TINFO: Network config (local -- remote):              
> iptables01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1                   
> iptables01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24                                  
> iptables01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64                        
> iptables01 1 TINFO: timeout per run is 0h 5m 0s                                 
> iptables01 1 TINFO: INIT: Flushing all rules                                    
> iptables01 1 TINFO: iptables -L -t filter will list all rules in table filter
> iptables01 1 TINFO: iptables -L -t filter lists rules                        
> iptables01 1 TINFO: iptables -L -t nat will list all rules in table nat      
> iptables01 1 TINFO: iptables -L -t nat lists rules                           
> iptables01 1 TINFO: iptables -L -t mangle will list all rules in table mangle
> iptables01 1 TINFO: iptables -L -t mangle lists rules                        
> iptables01 1 TPASS: iptables -L lists rules                                     
> iptables01 2 TINFO: Use iptables to DROP packets from particular IP             
> iptables01 2 TINFO: Rule to block icmp from 127.0.0.1                           
> iptables01 2 TINFO: Pinging 127.0.0.1                                           
> iptables01 1 TBROK: test killed, timeout! If you are running on slow machine,
> try exporting LTP_TIMEOUT_MUL > 1

I don't know about this one.

-- 
Thank you,
Richard.
