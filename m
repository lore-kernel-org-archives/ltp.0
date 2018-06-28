From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jun 2018 12:23:27 +0200
Subject: [LTP] [PATCH 1/2 v2] tst_test: Fail the test subprocess cannot
 be killed
In-Reply-To: <CAEemH2dag5EXRbWdHf31Qj9Wx9O+MJHuwR5xxaemG50g6b5wSg@mail.gmail.com>
References: <20180627152217.7067-1-chrubis@suse.cz>
 <CAEemH2f7TQG+eSznxEnM-NgBx4gjvx=wy6JZh0mjCD_+=mbsGQ@mail.gmail.com>
 <CAEemH2dag5EXRbWdHf31Qj9Wx9O+MJHuwR5xxaemG50g6b5wSg@mail.gmail.com>
Message-ID: <20180628102327.GC21866@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I'm a little worried about here, image that, if a process_A(test_pid)
> > exist to make function kill(-test_pid, 0) return 0 at first time, then
> > we go into this while loop, but during the sleeping time process_A
> > exit and system reuse the test_pid to another process_B, we will still
> > keep looping and very probably make mistake to report TFAIL(with stack
> > of  process_B dump to ltp user in PATCH 2/2).
> 
> Maybe we could verify the content of '/proc/test_pid/cmdline' in this loop
> to make sure test_pid is still using by the process we wanted?

That unfortunatelly does not work, half of the /proc/$pid/* files block
on reading when this happens as there is a deadlock in the kernel and
the processes that try to read these files end up deadlocked too.

-- 
Cyril Hrubis
chrubis@suse.cz
