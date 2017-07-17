From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Jul 2017 03:01:40 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/setrlimit: add setrlimit04
In-Reply-To: <87h8yfi3v6.fsf@our.domain.is.not.set>
References: <efe5be914c757f391b9f0eba0630548dea309f1b.1500030543.git.jstancek@redhat.com>
 <87h8yfi3v6.fsf@our.domain.is.not.set>
Message-ID: <812380836.53324474.1500274900880.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> Hi Jan,
> 
> Jan Stancek writes:
> 
> > + *   DESCRIPTION
> > + *     Attempt to run a trivial binary with stack < 1MB.
> > + *
> > + *     Early patches for stack guard gap caused that gap size was
> > + *     contributing towards stack limit. This caused failures
> > + *     for new processes (E2BIG) when ulimit was set to anything
> > + *     lower than size of gap. commit 1be7107fbe18 "mm: larger
> > + *     stack guard gap, between vmas" sets default gap size to 1M
> > + *     (for systems with 4k pages), so let's set stack limit to 512kB
> > + *     and confirm we can still run some trivial binary.
> > + */
> 
> The first sentance is difficult to parse. I think you are saying that in
> the early patches the stack gaurd gap was included in the stack
> size.

Yes. I didn't dig into details, but I think your formula below
is close.

> The stack size is then compared to the stack limit, so a process
> would fail to start if
> 
> [initial process stack usage] + [stack gap] > [stack limit].
> 
> However the stack gap should not be included in this calculation.

