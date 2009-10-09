Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yamato@redhat.com>) id 1Mw9Pw-0002at-Tv
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:57:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mw9Po-0006pi-RP
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:57:32 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n996vIKB006342
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Oct 2009 02:57:18 -0400
Received: from localhost (beach.nrt.redhat.com [10.64.200.71])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id n996vGFa008884
	for <ltp-list@lists.sourceforge.net>; Fri, 9 Oct 2009 02:57:17 -0400
Date: Fri, 09 Oct 2009 16:01:16 +0900 (JST)
Message-Id: <20091009.160116.554867037284655652.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Subject: [LTP] the status about porting testcases in Crackerjack to LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The table in http://ltp.sourceforge.net/wiki/ about "porting testcases
in Crackerjack to LTP" is a bit obsolete.

Before restarting to work on *16 and *64 testcases, I've summarized
the status of porting.

Subrata, could you update the page based on following information?

Masatake YAMATO


Already ported to LTP from crackerjack (42/92)
----------------------------------------------------------------------
@  Done(42/92)

Not ported to LTP yet (45/92)
----------------------------------------------------------------------
!  None are working on. (22/92)
?  No completed. Masatake YAMATO will do. (23/92)
>  In review-phase.


No need to work (3/92)
------------------------------------------------------------------------
-  LTP maintainer said "Need not look into this right now. " or something (2/92)
=  LTP maintainer said "We have a different form of this at ... 
                       But i would like to see this tested inside testcases/kernel/ syscalls..."(1/92)



Detail
------------------------------------------------------------------------
No. System Call       Comment on its position To-be-Ported-by              Status                      
                      w.r.t LTP                                                                        
                      We have ftruncate at                                                             
                      testcases/kernel/                                                                
                      syscalls/ftruncate/.                                                             
                      But this may not be                                                              
@   ftruncate64       doing the ftruncate64() Masatake YAMATO <            Completed on 05/08/2008     
                      test. You may need to   yamato@redhat.com>                                       
                      include/port                                                                     
                      ftruncate64 on similar                                                           
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      We have setgid at                                                                
                      testcases/kernel/                                                                
                      syscalls/setgid. You                                                             
@   setgid16          may need to include/    Masatake YAMATO <            Completed on 04/08/2008     
                      port setgid16 on        yamato@redhat.com>                                       
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64.                                                                       

                      We have this at                                                                  
                      testcases/kernel/                                                                
                      syscalls/ipc/shmget.                                                             
                      Need not look into this                                                          
                      right now. May be after                                                          
                      the porting is over, we                                                          
                      can see whether there                                                            
                      is some additional                                                               
-   shmget            functionality that      Need Volunteer               N/A                         
                      Crackerjack shmget is                                                            
                      covering over                                                                    
                      LTP-shmget. We may then                                                          
                      need to add 1/2 test                                                             
                      cases in this regard.                                                            
                      But, not to be                                                                   
                      prioritized                                                                      
                      immediately.                                                                     

                      We need this from                                                                
@   mbind             Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!   removexattr       Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@   exit_group        Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere
                                                                         
                      We need this from                                                                
@   io_cancel         Crackerjack as we do    Masatake YAMATO<             Completed on 26/06/2008     
                      not have this in LTP    yamato@redhat.com>                                       
                      anywhere                                                                         

                      We have a different                                                              
                      form of this at                                                                  
                      recently added Memory                                                            
                      Hotplug testcases at                                                             
                      testcases/kernel/                                                                
                      hotplug/memory_hotplug/                                                          
=   migrate_pages     . But i would like to   Need Volunteer               N/A                         
                      see this tested inside                                                           
                      testcases/kernel/                                                                
                      syscalls, as hotplug                                                             
                      testing presently is                                                             
                      optional. So, please                                                             
                      include/port this as                                                             
                      well                                                                             

                      We have setgroups at                                                             
                      testcases/kernel/                                                                
                      syscalls/setgroups. You                                                          
@   setgroups16       may need to include/    Masatake YAMATO <            Completed on 27/08/2008     
                      port setgroups16 on     yamato@redhat.com>                                       
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We have getdents at                                                              
                      testcases/kernel/                                                                
                      syscalls/getdents. You                                                           
?  getdents64         may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port getdents64 on      subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  add_key            Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have getegid at                                                               
                      testcases/kernel/                                                                
                      syscalls/getegid. You                                                            
@  getegid16          may need to include/    Masatake YAMATO <            Completed on 04/09/2008     
                      port getegid16 on       yamato@redhat.com>                                       
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  io_destroy         Crackerjack as we do    Masatake YAMATO <            Completed on 12/07/2008     
                      not have this in LTP    yamato@redhat.com>                                       
                      anywhere                                                                         

                      We need this from                                                                
!  newfstat           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!   set_mempolicy     Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  timer_getoverrun   Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have fadvise64                                                                
                      support added by                                                                 
                      Masatake Yamato. But i  Already Taken care of by                                 
@  fadvise64_64       am not sure what this   Masatake yamato              Completed                   
                      fadvise64_64 is. May                                                             
                      need to include/port                                                             
                      this as well                                                                     
                      We need this from                                                                
@  io_getevents       Crackerjack as we do    Masatake YAMATO <            Completed on 12/07/2008     
                      not have this in LTP    yamato@redhat.com>                                       
                      anywhere                                                                         

                      We need this from                                                                
!   newlstat          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  rt_sigaction       Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  sigreturn          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  timer_gettime      Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have geteuid at                                                               
                      testcases/kernel/                                                                
                      syscalls/geteuid. You                                                            
?  geteuid16          may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port geteuid16 on       subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
!  newuname           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  rt_sigprocmask     Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  bdflush            Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have getgid at                                                                
                      testcases/kernel/                                                                
                      syscalls/getgid. You                                                             
@  getgid16           may need to include/    Masatake YAMATO <            Completed on 19/09/2008     
                      port getgid16 on        yamato@redhat.com>                                       
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  rt_sigqueueinfo    Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  ioprio_get         Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  rt_sigsuspend      Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have setregid at                                                              
                      testcases/kernel/                                                                
                      syscalls/setregid. You                                                           
?  setregid16         may need to include/    Subrata Modak<               Subrata Modak<              
                      port setregid16 on      subrata@linux.vnet.ibm.com>  subrata@linux.vnet.ibm.com> 
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  tkill              Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have getgroups at                                                             
                      testcases/kernel/                                                                
                      syscalls/getgroups. You                                                          
?   getgroups16       may need to include/    Subrata Modak<               Subrata Modak<              
                      port getgroups16 on     subrata@linux.vnet.ibm.com>  subrata@linux.vnet.ibm.com> 
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
!   ioprio_set        Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@   sched_getaffinity Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@   ssetmask          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have fchown at                                                                
                      testcases/kernel/                                                                
                      syscalls/fchown. You                                                             
?   fchown16          may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port fchown16 on        subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  io_setup           Crackerjack as we do    Masatake YAMATO <            Completed on 12/07/2008     
                      not have this in LTP    yamato@redhat.com>                                       
                      anywhere                                                                         

                      We need this from                                                                
!  mmap2              Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         
                      We have setresgid at                                                             
                      testcases/kernel/                                                                
                      syscalls/setresgid. You                                                          
?  setresgid16        may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port setresgid16 on     subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We have truncate at                                                              
                      testcases/kernel/                                                                
                      syscalls/truncate. You                                                           
@  truncate64         may need to include/    Masatake YAMATO <            Completed on 05/08/2008     
                      port truncate64 on      yamato@redhat.com>                                       
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  get_mempolicy      Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         
                      We need this from                                                                
@  io_submit          Crackerjack as we do    Masatake YAMATO <            Completed on 12/07/2008     
                      not have this in LTP    yamato@redhat.com>                                       
                      anywhere                                                                         

                      We have stat at                                                                  
                      testcases/kernel/                                                                
                      syscalls/stat. You may  Subrata Modak<                                           
?  stat64             need to include/port    subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      stat64 on similar lines                                                          
                      to sendfile64 and                                                                
                      fadvise64                                                                        

                      We need this from                                                                
@  keyctl             Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have setresuid at                                                             
                      testcases/kernel/                                                                
                      syscalls/setresuid. You                                                          
?  setresuid16        may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port setresuid16 on     subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We have chown at                                                                 
                      testcases/kernel/                                                                
                      syscalls/chown. You may Subrata Modak<                                           
?   chown16           need to include/port    subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      chown16 on similar                                                               
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      We have fcntl at                                                                 
                      testcases/kernel/                                                                
                      syscalls/fcntl. You may Subrata Modak<                                           
?  fcntl64            need to include/port    subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      fcntl64 on similar                                                               
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      But work for this has   Vijay Kumar B. <             Completed on 26/07/2008.    
-  move_pages         been already initiated. vijaykumar@bravegnu.org>     This was not ported, but    
                      Need not consider this                               written by him              

                      We have statfs at                                                                
                      testcases/kernel/                                                                
                      syscalls/statfs. You                                                             
?   statfs64          may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port statfs64 on        subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@   clock_getres      Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have lchown at                                                                
                      testcases/kernel/                                                                
                      syscalls/lchown. You                                                             
?  lchown16           may need to include/    Subrata Modak<               Subrata Modak<              
                      port lchown16 on        subrata@linux.vnet.ibm.com>  subrata@linux.vnet.ibm.com> 
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We have setreuid at                                                              
                      testcases/kernel/                                                                
                      syscalls/setreuid. You                                                           
?   setreuid16        may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port setreuid16 on      subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
!  fgetxattr          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!   lgetxattr         Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!   mq_getsetattr     Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  unshare            Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  clock_nanosleep    Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  flistxattr         Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  mq_notify          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  ppoll              Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  useclock_settime   Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  mq_open            Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  set_thread_area    Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  listxattr          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  mq_timedreceive    Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have pread at                                                                 
                      testcases/kernel/                                                                
                      syscalls/pread. You may Subrata Modak<                                           
?  pread64            need to include/port    subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      pread64 on similar                                                               
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      We need this from                                                                
68  set_tid_address   Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  fremovexattr       Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  llistxatt          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  mq_timedsend       Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have pselect at                                                               
                      testcases/kernel/                                                                
                      syscalls/pselect. You                                                            
?  pselect64          may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port pselect64 on       subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  utimes             Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  fsetxattr          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  mq_unlink          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  gettid             Crackerjack as we do    Masatake YAMATO <            Completed on 17/06/2008     
                      not have this in LTP    yamato@redhat.com>                                       
                      anywhere                                                                         

                      We need this from                                                                
!  lremovexattr       Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  quotactl           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have setuid at                                                                
                      testcases/kernel/                                                                
                      syscalls/setuid and                                                              
                      testcases/kernel/       Subrata Modak<                                           
?  setuid16           syscalls/mount. You may subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      need to include/port                                                             
                      setuid16 on similar                                                              
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      We have fstat at                                                                 
                      testcases/kernel/                                                                
                      syscalls/fstat. You may Subrata Modak<                                           
?  fstat64            need to include/port    subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      fstat64 on similar                                                               
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      We need this from                                                                
!  setxattr           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have fstatat at                                                               
                      testcases/kernel/                                                                
                      syscalls/fstatat. You                                                            
?  fstatat64          may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port fstatat64 on       subrata@linux.vnet.ibm.com>                              
                      similar lines to s                                                               
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
  lsetxattr           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
!  readahead          Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have setfsgid at                                                              
                      testcases/kernel/                                                                
                      syscalls/setfsgid. You                                                           
?  setfsgid16         may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port setfsgid16 on      subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
@  sgetmask           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We need this from                                                                
@  waitid             Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have fstatfs at                                                               
                      testcases/kernel/                                                                
                      syscalls/fstatfs. You                                                            
?  fstatfs64          may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port fstatfs64 on       subrata@linux.vnet.ibm.com>                              
                      similar lines to s                                                               
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We have getuid at                                                                
                      testcases/kernel/                                                                
                      syscalls/getuid. You                                                             
>  getuid16           may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port getuid16 on        subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

                      We need this from                                                                
!  getxattr           Crackerjack as we do    Need Volunteer               N/A                         
                      not have this in LTP                                                             
                      anywhere                                                                         

                      We have lstat at                                                                 
                      testcases/kernel/                                                                
                      syscalls/lstat. You may Subrata Modak<                                           
?  lstat64            need to include/port    subrata@linux.vnet.ibm.com>  Completed on 07/11/2008     
                      lstat64 on similar                                                               
                      lines to sendfile64 and                                                          
                      fadvise64                                                                        

                      We have setfsuid at                                                              
                      testcases/kernel/                                                                
                      syscalls/setfsuid. You                                                           
?  setfsuid16         may need to include/    Subrata Modak<               Completed on 07/11/2008     
                      port setfsuid16 on      subrata@linux.vnet.ibm.com>                              
                      similar lines to                                                                 
                      sendfile64 and                                                                   
                      fadvise64                                                                        

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
