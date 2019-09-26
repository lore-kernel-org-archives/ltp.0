From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2019 21:07:07 +0300
Subject: [LTP] copy_file_range() errno changes introduced in v5.3-rc1
In-Reply-To: <20190926175700.GA12619@x230>
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510>
 <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
 <20190926175700.GA12619@x230>
Message-ID: <CAOQ4uxisQx1C7DXrcmq0gma4-bxbaPS5UNwpwnoDOtjYVypXwA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 26, 2019 at 8:57 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > > > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
>
> > Started to return EXDEV?? quite the opposite.
> > But LTP tests where already adapted to that behavior AFAICT:
> > 15cac7b46 syscalls/copy_file_range01: add cross-device test
> I'm talking about copy_file_range02 (15cac7b46 changes copy_file_range01).
>
> Anyway, the problem which I want to fix is a backward compatibility for v5.2 and
> older to fix errors like this:
>
> copy_file_range02.c:102: INFO: Test #7: overlaping range
> copy_file_range02.c:134: FAIL: copy_file_range returned wrong value: 16
> copy_file_range02.c:102: INFO: Test #8: block device
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
> copy_file_range02.c:102: INFO: Test #9: char device
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
> ...
> copy_file_range02.c:102: INFO: Test #11: max length lenght
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EOVERFLOW, but got: EINVAL (22)
> copy_file_range02.c:102: INFO: Test #12: max file size
> copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EFBIG, but got: EINVAL (22)
>
> LTP hasn't defined yet any policy about changing errnos,
> as it's probably best to check whether change was intentional
> (like your obvious fixes) or not.
>

IIUC, copy_file_range02 was written after v5.3 changes to verify that
copy_file_range
stays unbroken.
As such, I would suggest that you check if kernel supports cross-fs copy, like
copy_file_range01 does and if it doesn't, skip the test entirely.
If some one ever backports cross-fs copy to any distro stable kernel, then one
would better also backkport all of those API fixes, otherwise test will fail.

Thanks,
Amir.
