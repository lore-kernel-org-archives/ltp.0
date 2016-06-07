From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Jun 2016 08:19:01 -0400 (EDT)
Subject: [LTP] [PATCH] linux_syscall_numbers: add sched_[get|set]attr
 for ppc and s390
In-Reply-To: <20160607120831.GA1801@rei.lan>
References: <79dd48009e53a6a887967034b7c20f0c8665325d.1465301288.git.jstancek@redhat.com>
 <20160607120831.GA1801@rei.lan>
Message-ID: <1309630501.4252329.1465301941193.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 7 June, 2016 2:08:31 PM
> Subject: Re: [LTP] [PATCH] linux_syscall_numbers: add sched_[get|set]attr for ppc and s390
> 
> Hi!
> > sched_getattr and sched_setattr may fail on powerpc and s390
> > on kernels > 3.14 with older userspace because LTP defines
> > syscall numbers only for x86 and arm.
> > 
> > This patch adds also numbers for ppc and s390.
> 
> I would say that this falls into obviously right category, you should
> have pushed this right away, nevertheless acked.

OK, thanks for ack anyway. Pushed.

Regards,
Jan
