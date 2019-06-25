From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 26 Jun 2019 00:13:23 +0800
Subject: [LTP] [PATCH] runpwtests03: use expr to calculate total_cpus
 for runpwtests03
In-Reply-To: <5D11FEA7.1000104@cn.fujitsu.com>
References: <20190625100351.19800-1-po-hsu.lin@canonical.com>
 <5D11FEA7.1000104@cn.fujitsu.com>
Message-ID: <CAMy_GT-BOitiVB6vJCno6=M5d+iz6+RxKMxsiXHH0TYbiZS7+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello!

The $() here is for the tst_ncpus executable, which will return the
total cpu number.

Thanks
PHLin

On Tue, Jun 25, 2019 at 6:59 PM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> On 2019/06/25 18:03, Po-Hsu Lin wrote:
> > The arithmetic operation (( total_cpus-=1 )) does not work for dash,
> > which was symbolic linked to /bin/sh on some OS like Ubuntu.
> >
> > In such case, people will see error like:
> >    runpwtests03.sh: total_cpus-=1: not found
> >
> > And this further leads to access for a non-existing file and cause
> > false-positive result in the end:
> >    runpwtests03.sh: cannot create
> >    /sys/devices/system/cpu/cpu8/cpufreq/scaling_governor: Directory nonexistent
> >    runpwtests03.sh: FAIL: Unable to set governor -- powersave for cpu8
> >    Power_Management03 2 TFAIL: Changing governors
> >
> > Use expr instead for fix this issue.
> >
> > Signed-off-by: Po-Hsu Lin<po-hsu.lin@canonical.com>
> > ---
> >   testcases/kernel/power_management/runpwtests03.sh | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
> > index 11197937f..3fb85d273 100755
> > --- a/testcases/kernel/power_management/runpwtests03.sh
> > +++ b/testcases/kernel/power_management/runpwtests03.sh
> > @@ -25,8 +25,7 @@ export TST_TOTAL=4
> >   . pm_include.sh
> >
> >   check_cpufreq_sysfs_files() {
> > -     total_cpus=$(tst_ncpus)
> > -     (( total_cpus-=1 ))
> > +     total_cpus=`expr $(tst_ncpus) - 1`
>
> Hi,
>
> It's wrong for single variable to use $(), did you mean ${tst_ncpus}?
>
> Best Regards,
> Xiao Yang
> >       RC=0
> >
> >       for cpu in $(seq 0 "${total_cpus}" )
> > @@ -51,8 +50,7 @@ check_cpufreq_sysfs_files() {
> >   change_govr() {
> >       available_govr=$(get_supporting_govr)
> >
> > -     total_cpus=$(tst_ncpus)
> > -     (( total_cpus-=1 ))
> > +     total_cpus=`expr $(tst_ncpus) - 1`
> >       RC=0
> >
> >       for cpu in $(seq 0 "${total_cpus}" )
> > @@ -79,8 +77,7 @@ change_freq() {
> >       available_govr=$(get_supporting_govr)
> >       RC=0
> >
> > -     total_cpus=$(tst_ncpus)
> > -     (( total_cpus-=1 ))
> > +     total_cpus=`expr $(tst_ncpus) - 1`
> >
> >       if ( echo ${available_govr} | grep -i "userspace" \
> >               >/dev/null 2>&1 ); then
>
>
>
