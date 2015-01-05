Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y86vz-0003WK-HL
	for ltp-list@lists.sourceforge.net; Mon, 05 Jan 2015 12:38:59 +0000
Date: Mon, 5 Jan 2015 13:38:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150105123823.GA30102@rei.suse.de>
References: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
	<1415206150-12848-1-git-send-email-mmarhefk@redhat.com>
	<20141202164235.GA22135@rei.suse.de>
	<1962544618.7994595.1417604885928.JavaMail.zimbra@redhat.com>
	<20141217141028.GA17634@rei> <5495D100.8000107@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5495D100.8000107@redhat.com>
Subject: Re: [LTP] [PATCH v2] containers: added mountns/mountns05.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> May I ask why there needs to be a distinction between "parent" and
> "child" embedded into the checkpoint implementation, going as far as
> checking 'p' or 'c' read from FIFO? Why does it matter?
> I guess it adds a little to "code safety", but also severely limits
> the use cases for checkpointing. Why not simply have a "regular" mutex
> lock, like ie. pthread mutexes?

The distinction is unfortunately mandated by the differencies between
the parent (main test process) and child (forked process).

The parent is expected to prepare the testing environment and also do a
cleanup and therefore uses the tst_* interface, passes the cleanup
function pointer to the calls etc. The parent also includes timeout
logic which ensures that the parent does not hang while waiting for
children to come up.

The child processes does only the some test related task and does not
use the tst_ interface, exit with plain exit(), etc. The letter that is
send around is different in order to enforce that the right function is
called, no more no less. What this avoids, for example, is calling
cleanup callback from the child process that is common mistake which
leads to ugly race conditions.

Note also that before commit 8c1e0b3afe4f1c4da32fe7d1b5fa9738aacacab4
any usage of tst_* interface in child processes was strongly
discouraged.

Maybe we can rethink the API a bit now...

> Going a bit further - wouldn't it be easier to simply let the test(s)
> use sysv ipc, with tstlib-created objects (IPC_PRIVATE), providing
> semi-safe macros for svipc(7) functions (permitting ie. EAGAIN)?
> 
> (or even use sysv ipc for the mutex implementation, think semtimedop(2)
>  instead of open_wronly_timed)

I've considered that.

There are a few downsides to this approach. Apart from these being
global system resources the reason why I've choosen fifos over these is
that they can be compiled out of kernel and there are minimal systems
out there run fine without them. And while I do not care much that
sysvipc tests are broken on such configuration I certainly do not want
to break rest of the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
