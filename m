From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Jun 2019 13:28:26 +0300
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file
	sync test-cases
In-Reply-To: <20190619095805.GC16577@rei.lan>
References: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
 <20190617150640.GD16831@rei>
 <CAOQ4uxithmPn6J=B2kaGKT0JOpqzyVEkHU+zMqhXCYnnH+ZHVQ@mail.gmail.com>
 <20190619095805.GC16577@rei.lan>
Message-ID: <CAOQ4uxiahDrw157AmkKch+S29zxHU6neVOU9EmYaAcYtDzfVdg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 19, 2019 at 12:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > With these modification the test was stable and worked fine for more
> > > than 100 iterations for me. It still fails for FUSE based filesystems
> > > but that is to be expected since FUSE does not implement sync_file_range
> > > yet.
> > >
> >
> > What is the proposed way to resolve this failure?
> > If FUSE does not implement sync_file_range, shouldn't test detect
> > it and return TCONF?
>
> Well the call returns success but does not sync anything on FUSE based
> filesystems so the choices here are:
>
> 1) Disable the test of FUSE
> 2) Keep the test failing and ignore the failures
>
> Which one do you prefer?
>

I prefer the first option.

My preference may seem inconsistent with my opinion that
F_SETLEASE tests should NOT be disabled for overlayfs.

The difference is that sync_file_range() API does not promise
any real guaranties vs. F_SETLEASE that has a very clear
definition of how it should behave.
A subtle difference, but I think it matters.

BTW, I did already fix the overlayfs F_SETLEASE bug.
It is queued for 5.3 (by file locks maintainer).
I will post fixes to LTP F_SETLEASE tests once the kernel
fix is merged.

Thanks,
Amir.
