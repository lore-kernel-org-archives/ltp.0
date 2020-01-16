From: Rachel Sibley <rasibley@redhat.com>
Date: Thu, 16 Jan 2020 11:39:14 -0500
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.12-100.fc30
 (fedora-30)
In-Reply-To: <20200116155952.GB558@rei>
References: <cki.0.BMO32N203K@redhat.com> <20200116155952.GB558@rei>
Message-ID: <b251c469-ade3-bc34-8e07-1789640693e8@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 1/16/20 10:59 AM, Cyril Hrubis wrote:
> Hi!
>>      Pipeline: https://xci32.lab.eng.rdu2.redhat.com/cki-project/brew-pipeline/pipelines/384229
> 
> Looks like unreachable URL again.
> 

Oops sorry about that, since the Fedora maintainers had access to internal logs we used the regular
template, only after did we start cc'ing LTP for upstream failures. I just changed it to the correct
email template to include links to our external logs.

The failure was a dmesg check probably related to running on a slow kvm guest:

[ 5646.612562] watchdog: BUG: soft lockup - CPU#15 stuck for 31s! [systemd-journal:559]
[ 5840.828707] watchdog: BUG: soft lockup - CPU#10 stuck for 23s! [systemd:1]
[ 6018.881344] watchdog: BUG: soft lockup - CPU#2 stuck for 50s! [systemd-coredum:819905]
[ 6047.933641] watchdog: BUG: soft lockup - CPU#15 stuck for 21s! [systemd:1]
[ 6100.825887] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [systemd-coredum:819905]
[ 6369.103978] watchdog: BUG: soft lockup - CPU#5 stuck for 23s! [diotest6:819897]
[ 6780.415986] watchdog: BUG: soft lockup - CPU#10 stuck for 22s! [khvcd:223]
[ 6831.956434] watchdog: BUG: soft lockup - CPU#3 stuck for 70s! [migration/3:25]
[ 6831.956436] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [kworker/2:2:1997]
[ 6864.394439] watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [rcu_sched:10]
[ 7004.381847] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [rcu_sched:10]
[ 7084.688008] watchdog: BUG: soft lockup - CPU#4 stuck for 67s! [kworker/4:3:818401]
[ 7108.389938] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [rcu_sched:10]
[ 7303.256283] watchdog: BUG: soft lockup - CPU#7 stuck for 110s! [diotest6:819970]

-Rachel

