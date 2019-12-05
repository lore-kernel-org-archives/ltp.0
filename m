From: Rachel Sibley <rasibley@redhat.com>
Date: Thu, 5 Dec 2019 08:20:19 -0500
Subject: [LTP] ??? FAIL: Test report for kernel 5.2.21-rt14-eccdce6.cki
 (rt-devel)
In-Reply-To: <20191205122735.GB5693@rei.lan>
References: <cki.A05205186F.8840CLEZ0B@redhat.com>
 <20191205122735.GB5693@rei.lan>
Message-ID: <ad2609c0-81f2-513d-6f50-0e492374e359@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 12/5/19 7:27 AM, Cyril Hrubis wrote:
> Hi!
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>         Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
>>              Commit: eccdce6cb526 - v5.2.21-rt14
>>
>> The results of these automated tests are provided below.
>>
>>      Overall result: FAILED (see details below)
>>               Merge: OK
>>             Compile: OK
>>               Tests: FAILED
>>
>>      Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/cki-pipeline/pipelines/323141
> 
> This URL does not seem to be accessible from outside.

Sorry about that, the template was set incorrectly for this tree, we
have since fixed it.

The test case which failed was mount01:

<<<test_start>>>
tag=mount01 stime=1575466201
cmdline="mount01"
contacts=""
analysis=exit
<<<test_output>>>
mke2fs 1.45.3 (14-Jul-2019)
/dev/loop0 is apparently in use by the system; will not make a 
filesystem here!
mount01     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
mount01     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra 
opts=''
mount01     1  TBROK  :  tst_mkfs.c:100: mkfs.ext2:1: mount01.c failed 
with 86
mount01     2  TBROK  :  tst_mkfs.c:100: Remaining cases broken
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>

> 

