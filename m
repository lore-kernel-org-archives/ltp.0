From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Feb 2019 02:24:10 -0500 (EST)
Subject: [LTP] [PATCH] fcntl36: make sure write threads complete at
 least 1 loop
In-Reply-To: <20190223101601.p4yv342uwi75scmx@XZHOUW.usersys.redhat.com>
References: <815b921d8f5eeeabd65096c96c7572520b3287fb.1550862006.git.jstancek@redhat.com>
 <20190223101601.p4yv342uwi75scmx@XZHOUW.usersys.redhat.com>
Message-ID: <836137249.2634537.1551079450318.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Fri, Feb 22, 2019 at 08:01:11PM +0100, Jan Stancek wrote:
> > A failure has been reported while this test ran on a 1 CPU KVM guest
> > with 4.20 kernel:
> >   ...
> >   fcntl36.c:303: INFO: OFD r/w lock vs POSIX read lock
> >   fcntl36.c:360: FAIL: Unexpected data offset 3072 value 1
> > 
> > I wasn't able to reproduce it, to test the theory that
> > one of write threads was given time on CPU only after
> > loop_flag changed. Which means it wasn't able to complete
> > a single iteration.
> 
> Ack. Thanks!
> 

Pushed.

Regards,
Jan

