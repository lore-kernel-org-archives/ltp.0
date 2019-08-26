From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Aug 2019 19:20:59 +0530
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
In-Reply-To: <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
 <20190826104127.GA14729@haruka>
 <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYsHpNKFHr=ZukVvj+uMJDyHj2Xwb9bCfzPQyYzMjZ0rCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan and Cyril,

On Mon, 26 Aug 2019 at 16:35, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > Hi!
> > > Do you see this LTP prot_hsymlinks failure on linux next 20190823 on
> > > x86_64 and i386 devices?
> > >
> > > test output log,
> > > useradd: failure while writing changes to /etc/passwd
> > > useradd: /home/hsym was created, but could not be removed
> >
> > This looks like an unrelated problem, failure to write to /etc/passwd
> > probably means that filesystem is full or some problem happend and how
> > is remounted RO.
>
> In Naresh' example, root is on NFS:
>   root=/dev/nfs rw nfsroot=10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-nfsrootfs-tyuevoxm,tcp,hard,intr

Right !
root is mounted on NFS.

>
> 10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-nfsrootfs-tyuevoxm on / type nfs (rw,relatime,vers=2,rsize=4096,wsize=4096,namlen=255,hard,nolock,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.66.16.123,mountvers=1,mountproto=tcp,local_lock=all,addr=10.66.16.123)
> devtmpfs on /dev type devtmpfs (rw,relatime,size=3977640k,nr_inodes=994410,mode=755)
>
> Following message repeats couple times in logs:
>   NFS: Server wrote zero bytes, expected XXX
>
> Naresh, can you check if there are any errors on NFS server side?

I have re-tested the failed tests on next-20190822 and all get pass
which is also
using same NFS server [1] [2].

> Maybe run NFS cthon against that server with client running next-20190822 and next-20190823.

Thanks for the pointers.
I will setup and run NFS cthon on next-20190822 and next-20190823.

>
> >
> > I do not see the kernel messages from this job anywhere at the job
> > pages, is it stored somewhere?
>
> It appears to be mixed in same log file:
>   https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190823/testrun/886412/log

For the record the following tests failed on linux -next-20190823 on x86_64
and i386. The filesystem is mounted on NFS and tests are using
locally mounted hard drive ( with -d /scratch ).

Juno-r2 device filesystem mounted on NFS and did not see these errors
and test getting pass on -next-20190823.

These failures are reproducible all time on next-20190823 kernel on x86_64
and i386 device with root mounted on NFS [3] [4] [5] [6].

I will git bisect to find out which is bad commit.

prot_hsymlinks: [3]
------------------
useradd: failure while writing changes to /etc/passwd
useradd: /home/hsym was created, but could not be removed
userdel: user 'hsym' does not exist
prot_hsymlinks    1  TBROK  :  prot_hsymlinks.c:325: Failed to run
cmd: useradd hsym
prot_hsymlinks    2  TBROK  :  prot_hsymlinks.c:325: Remaining cases broken
prot_hsymlinks    3  TBROK  :  prot_hsymlinks.c:325: Failed to run
cmd: userdel -r hsym
prot_hsymlinks    4  TBROK  :  tst_sig.c:234: unexpected signal
SIGIOT/SIGABRT(6) received (pid = 8324).

logrotate01: [4]
-------------
compressing log with: /bin/gzip
error: error creating temp state file /var/lib/logrotate.status.tmp:
Input/output error
logrotate01    1  TFAIL  :  ltpapicmd.c:154: Test #1: logrotate
command exited with 1 return code. Output:

sem_unlink_2-2: [5]
------------------
make[3]: Entering directory
'/opt/ltp/testcases/open_posix_testsuite/conformance/interfaces/sem_unlink'
cat: write error: Input/output error
conformance/interfaces/sem_unlink/sem_unlink_2-2: execution: FAILED

syslog{01 ...10} [6]
-------------------
cp: failed to close '/etc/syslog.conf.ltpback': Input/output error
syslog01    1  TBROK  :  ltpapicmd.c:188: failed to backup /etc/syslog.conf

cp: failed to close '/etc/syslog.conf.ltpback': Input/output error
syslog02    1  TBROK  :  ltpapicmd.c:188: failed to backup /etc/syslog.conf

...
cp: failed to close '/etc/syslog.conf.ltpback': Input/output error
syslog10    1  TBROK  :  ltpapicmd.c:188: failed to backup /etc/syslog.conf

ref:
PASS on 20190222:
[1] https://lkft.validation.linaro.org/scheduler/job/890446#L1232
[2] https://lkft.validation.linaro.org/scheduler/job/890454

FAILED on 20190823:
[3] https://lkft.validation.linaro.org/scheduler/job/890404#L1245
[4] https://lkft.validation.linaro.org/scheduler/job/886408#L2544
[5] https://lkft.validation.linaro.org/scheduler/job/886409#L3088
[6] https://lkft.validation.linaro.org/scheduler/job/890400#L1234

 - Naresh
