From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Feb 2016 22:19:58 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160212175308.GA30723@rei.suse.cz>
References: <20160105111136.GA32659@rei.lan> <20160208180211.GE9844@rei>
 <20160209164352.GC11823@rei.lan> <20160209165703.GA5441@rei.lan>
 <20160209174618.GB5441@rei.lan>
 <1670220208.19308377.1455100978449.JavaMail.zimbra@redhat.com>
 <20160210114134.GA10106@rei.lan> <20160211160313.GA22877@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz>
Message-ID: <20160216211958.GC2515@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The up to date code is at the same place as usual.
(https://github.com/metan-ucw/ltp)

Apart from added support of acquiring a device, checkpoints and
resource files the IPC was rewritten to shared memory.

Now the library, before the test is started, mmaps a page backed by a
file on /dev/shm/. The first few bytes are used for shared struct
results, the rest is used by checkpoints if checkpoints are needed. The
struct result values are incremented by gcc atomic operations (which is
thread safe as well), the open question is if we need a fallback to
inline assembler if these are not supported. Then there is a special
function to open checkpoint shm file from a process started by a exec (a
few of the testcases does so) since it must open the shm rather than a
file in a temporary directory.

There are still some rough edges and the code should be reviewed, but at
least 90% of the functionality is there and working.

As usuall comments are welcome :)

-- 
Cyril Hrubis
chrubis@suse.cz
