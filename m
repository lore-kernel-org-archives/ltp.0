From: Li Wang <liwang@redhat.com>
Date: Sun, 14 Jan 2018 12:28:09 +0800
Subject: [LTP] LTP release
In-Reply-To: <333263467.6012020.1515768411422.JavaMail.zimbra@redhat.com>
References: <20171220113323.GD6688@rei> <20180109181745.GA11221@rei.lan>
 <1073451511.4987996.1515523657228.JavaMail.zimbra@redhat.com>
 <CAEemH2ep93OYxwXbj_fwdQDiFhCBaKd3Aj2nrt1k4uim+RBRDQ@mail.gmail.com>
 <333263467.6012020.1515768411422.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2crBXogA8MJ+eJ_WqD7g9DCA72t=RjMa3x+L8n6FZWgfg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, Jan 12, 2018 at 10:46 PM, Jan Stancek <jstancek@redhat.com> wrote:

> > ​I ran LTP on the upstream kernel-4.15-rc6 across
> x86_64/ppc64(le)/s390x​,
> > and catch some failures as below, ​but currently I haven't get a chance
> to
> > look into the detail, just post here.​
> >
> >
> > migrate_pages02   FAIL  x86_64
>
> I posted patch for this, but since it's only rc kernels it can wait.
>
> > shmt02/03/04/05/06/07/08/09/10   FAIL ppc64
> > -------------------------------------------
> > shmt02      1  TFAIL  :  shmt02.c:71: shmget Failed: shmid = -1, errno =
> 22
> > shmt03      1  TFAIL  :  shmt03.c:72: shmget Failed: shmid = -1, errno =
> 22
> > ...
> > shmt10      2  TFAIL  :  shmt10.c:98: Error: shmid = -1
>
> I haven't seen this in my tests. Are you able to reproduce it?
>

That's a little bit strange, I see these failures on a kvm guest system.
But after reserving it to run by manual, I could NOT reproduce it any
more.​ :(



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180114/c5450fab/attachment.html>
