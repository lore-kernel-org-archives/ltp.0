From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 8 Jun 2020 10:52:09 -0400 (EDT)
Subject: [LTP] sched_rr_get_interval01 , sched_rr_get_interval02 ,
 sched_rr_get_interval03 testcase failure
In-Reply-To: <BMXPR01MB23442B106F1292542BA7F85CEE850@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB23442B106F1292542BA7F85CEE850@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <1210169239.15186381.1591627929151.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> <<<test_output>>>
> incrementing stop
> sched_rr_get_interval01 1 TBROK : sched_rr_get_interval01.c:131:
> sched_setscheduler() failed

Common cause is that you run tests in cgroup that has zero cpu.rt_runtime_us.

1. Are sched_setparam02 and sched_getscheduler01 passing?

2. Can you rerun with this patch:
     https://github.com/linux-test-project/ltp/commit/94e6163082055700db700c33ed0eab537420fdaf.patch
   or use strace? 

