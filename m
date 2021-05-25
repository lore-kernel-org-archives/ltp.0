From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 25 May 2021 23:08:21 +0100
Subject: [LTP] Recent Yocto Project LTP experiences (hangs)
Message-ID: <0dc10bb052f327dc4c76d01dc70930bebc6bf151.camel@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I was asked to summarise some recent issues we (Yocto Project) ran into 
with LTP recently. This is with ltp version 20210121.

The easier one is summarised at:

https://lists.yoctoproject.org/g/swat/topic/further_ltp_hang_kernel/83025674

Basically we saw out x86 builds hanging in the loopback mount tests
with a load of kernel back traces and processes in D states.
We're running with the idea this is a 5.10.37 kernel issue when
we upgraded to that point release and we think upgrading to 5.10.38 fixes?
it. Time will tell.

The couple of harder ones are these:

An ARM hang in proc01:

https://lists.yoctoproject.org/g/swat/topic/debug_data_for_ltp_qemu_hang/82811657

and secondly an x86 hang in cgroup_xattr:

https://lists.yoctoproject.org/g/swat/topic/debug_data_for_ltp_qemu_hang/82811657

The debug data we have is above. Given the range of other "intermittent"?
issues we have in our automated testing, I took the action to disable the above two
tests:

http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=b73c484a58dbbde3989393163fc968f06109823c

as noted there, one additional piece of data is that the proc01 test was had?
/proc/kmsg as an open file. We saw the same issue 2 or 3 times, not every 
but most builds.

We're not ltp experts, I did try and document how we could get data when
one of these issues occurs here:

https://lists.yoctoproject.org/g/swat/topic/how_to_provide_info_for_a/83006794

If there is extra information we could be adding it would be most welcome
and we can note it for any future issues.

There is the possibility that the issues from the 5.10.37 issue could
have caused the other issues and upgrading the kernel may have addressed
them but right now I'm not keen to experiment with more locked up test?
instances. Like ltp, we're a bit stretched on the resourcing front but
I did want to share what we have.

Cheers,

Richard



