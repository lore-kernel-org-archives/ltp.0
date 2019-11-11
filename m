From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Nov 2019 12:00:04 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc6-dd89262=2Ecki_=28mainline=2Ekernel=2Eorg=29?=
In-Reply-To: <cki.ECB352932E.9FL0Q68EC2@redhat.com>
References: <cki.ECB352932E.9FL0Q68EC2@redhat.com>
Message-ID: <232041279.11531466.1573491604178.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
>      ? LTP lite

perf_event_open02 again:

<<<test_start>>>
tag=perf_event_open02 stime=1573434398
cmdline="perf_event_open02"
contacts=""
analysis=exit
<<<test_output>>>
perf_event_open02    0  TINFO  :  overall task clock: 54172980
perf_event_open02    0  TINFO  :  hw sum: 1423341410, task clock sum: 255289913
perf_event_open02    0  TINFO  :  ratio: 4.712495
perf_event_open02    1  TFAIL  :  perf_event_open02.c:394: test failed (ratio was greater than )
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=17 cstime=0
<<<test_end>>>

I ran it by hand on same system with same kernel. It's giving ratio close to 9
for past couple hours:

perf_event_open02    0  TINFO  :  overall task clock: 32829317
perf_event_open02    0  TINFO  :  hw sum: 2701673973, task clock sum: 295085628
perf_event_open02    0  TINFO  :  ratio: 8.988479
perf_event_open02    1  TPASS  :  test passed

