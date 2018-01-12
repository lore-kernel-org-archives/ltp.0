From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 12 Jan 2018 09:46:51 -0500 (EST)
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2ep93OYxwXbj_fwdQDiFhCBaKd3Aj2nrt1k4uim+RBRDQ@mail.gmail.com>
References: <20171220113323.GD6688@rei> <20180109181745.GA11221@rei.lan>
 <1073451511.4987996.1515523657228.JavaMail.zimbra@redhat.com>
 <CAEemH2ep93OYxwXbj_fwdQDiFhCBaKd3Aj2nrt1k4uim+RBRDQ@mail.gmail.com>
Message-ID: <333263467.6012020.1515768411422.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

> ​I ran LTP on the upstream kernel-4.15-rc6 across x86_64/ppc64(le)/s390x​,
> and catch some failures as below, ​but currently I haven't get a chance to
> look into the detail, just post here.​
> 
> 
> migrate_pages02   FAIL  x86_64

I posted patch for this, but since it's only rc kernels it can wait.

> shmt02/03/04/05/06/07/08/09/10   FAIL ppc64
> -------------------------------------------
> shmt02      1  TFAIL  :  shmt02.c:71: shmget Failed: shmid = -1, errno = 22
> shmt03      1  TFAIL  :  shmt03.c:72: shmget Failed: shmid = -1, errno = 22
> ...
> shmt10      2  TFAIL  :  shmt10.c:98: Error: shmid = -1

I haven't seen this in my tests. Are you able to reproduce it?

> switch01  FAIL  ppc64(le)

Just pushed patch for this one.

Regards,
Jan
