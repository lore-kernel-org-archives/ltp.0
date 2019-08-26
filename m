From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2019 07:05:20 -0400 (EDT)
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
In-Reply-To: <20190826104127.GA14729@haruka>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
 <20190826104127.GA14729@haruka>
Message-ID: <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > Do you see this LTP prot_hsymlinks failure on linux next 20190823 on
> > x86_64 and i386 devices?
> > 
> > test output log,
> > useradd: failure while writing changes to /etc/passwd
> > useradd: /home/hsym was created, but could not be removed
> 
> This looks like an unrelated problem, failure to write to /etc/passwd
> probably means that filesystem is full or some problem happend and how
> is remounted RO.

In Naresh' example, root is on NFS:
  root=/dev/nfs rw nfsroot=10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-nfsrootfs-tyuevoxm,tcp,hard,intr

10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-nfsrootfs-tyuevoxm on / type nfs (rw,relatime,vers=2,rsize=4096,wsize=4096,namlen=255,hard,nolock,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.66.16.123,mountvers=1,mountproto=tcp,local_lock=all,addr=10.66.16.123)
devtmpfs on /dev type devtmpfs (rw,relatime,size=3977640k,nr_inodes=994410,mode=755)

Following message repeats couple times in logs:
  NFS: Server wrote zero bytes, expected XXX

Naresh, can you check if there are any errors on NFS server side?
Maybe run NFS cthon against that server with client running next-20190822 and next-20190823.

> 
> I do not see the kernel messages from this job anywhere at the job
> pages, is it stored somewhere?

It appears to be mixed in same log file:
  https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190823/testrun/886412/log
