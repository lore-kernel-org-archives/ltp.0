From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Sep 2019 19:57:00 +0200
Subject: [LTP] copy_file_range() errno changes introduced in v5.3-rc1
In-Reply-To: <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510>
 <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
Message-ID: <20190926175700.GA12619@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.

> Started to return EXDEV?? quite the opposite.
> But LTP tests where already adapted to that behavior AFAICT:
> 15cac7b46 syscalls/copy_file_range01: add cross-device test
I'm talking about copy_file_range02 (15cac7b46 changes copy_file_range01).

Anyway, the problem which I want to fix is a backward compatibility for v5.2 and
older to fix errors like this:

copy_file_range02.c:102: INFO: Test #7: overlaping range
copy_file_range02.c:134: FAIL: copy_file_range returned wrong value: 16
copy_file_range02.c:102: INFO: Test #8: block device
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
copy_file_range02.c:102: INFO: Test #9: char device
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
...
copy_file_range02.c:102: INFO: Test #11: max length lenght
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EOVERFLOW, but got: EINVAL (22)
copy_file_range02.c:102: INFO: Test #12: max file size
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EFBIG, but got: EINVAL (22)

LTP hasn't defined yet any policy about changing errnos,
as it's probably best to check whether change was intentional
(like your obvious fixes) or not.

> > > > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.

> > > I'm not Amir, but by my recollection, yes, those are intentional. :)
> > Thanks for a quick confirmation.


> Which reminds me - I forgot to send the man pages patch out to maintainer:
> https://lore.kernel.org/linux-fsdevel/20190529174318.22424-15-amir73il@gmail.com/

> At least according to man page -EACCES is also possible.
Thanks for fixing man :).

Kind regards,
Petr
