From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 May 2019 19:45:16 +0300
Subject: [LTP] [PATCH v4] syscalls/copy_file_range: add/restructured
	tests
In-Reply-To: <20190520152400.GA11845@dell5510>
References: <20190506105457.22350-1-camann@suse.com>
 <1ef7d8ee-ae31-b44c-71e6-7d09da55eda2@suse.com>
 <20190506201948.GA9828@dell5510> <20190520143135.GA27341@dell5510>
 <20190520144645.GD28976@rei.lan> <20190520152400.GA11845@dell5510>
Message-ID: <CAOQ4uxivgpoMeUUxm-fboFfiXLXn+QXNzKJWSHAZhidwUsuvng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 20, 2019 at 6:24 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > > 2) Glibc adds internal implementation of copy_file_range(), used as fallback
> > > when kernel < 4.5 (which brought copy_file_range()) [1]. I guess there is no way
> > > to use it explicitly :(.
>
> > Well we can always use filesystem that does not support the operation,
> > so running the test for all filesystems should get the emulation covered
> > for sure...
> Oh, that's the way :).

Actually, there is no such thing as filesystem that does not support
copy_file_range() because the kernel provides a fallback default implementation
(in-kernel copy).

> Merged then, thanks for your patch, Christian.
>

I was going to ask that you drop the EXDEV test, because I am working on a path
set to relax the cross-device constraint.
Oh well. I will post a patch to remove that test case once my code is merged.

Thanks,
Amir.
