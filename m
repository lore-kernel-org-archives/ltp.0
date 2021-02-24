From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Feb 2021 09:30:03 +0100
Subject: [LTP] [PATCH v4] vfs: fix copy_file_range regression in
 cross-fs copies
In-Reply-To: <CAOQ4uxjtap0jQat19h7g+6xvpMnqrwEihgN7pw11d57kkRVsaw@mail.gmail.com>
References: <CAOQ4uxjGkm0Pn84UW6JKSK3mFkrPKykfkXDLL1V4YPSgAOXULA@mail.gmail.com>
 <20210218143635.24916-1-lhenriques@suse.de>
 <CAOQ4uxjtap0jQat19h7g+6xvpMnqrwEihgN7pw11d57kkRVsaw@mail.gmail.com>
Message-ID: <YDYOi5QTuas+ScAZ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> On Thu, Feb 18, 2021 at 4:35 PM Luis Henriques <lhenriques@suse.de> wrote:

> > A regression has been reported by Nicolas Boichat, found while using the
> > copy_file_range syscall to copy a tracefs file.  Before commit
> > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > kernel would return -EXDEV to userspace when trying to copy a file across
> > different filesystems.  After this commit, the syscall doesn't fail anymore
> > and instead returns zero (zero bytes copied), as this file's content is
> > generated on-the-fly and thus reports a size of zero.

> > This patch restores some cross-filesystem copy restrictions that existed
> > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > devices").  Filesystems are still allowed to fall-back to the VFS
> > generic_copy_file_range() implementation, but that has now to be done
> > explicitly.


> Petr,

> Please note that the check for verify_cross_fs_copy_support() in LTP
> tests can no longer be used to determine if copy_file_range() is post v5.3.
> You will need to fix the tests to expect cross-fs failures (this change of
> behavior is supposed to be backported to stable kernels as well).

> I guess the copy_file_range() tests will need to use min_kver.

Thanks for info! I see, after "vfs: fix copy_file_range regression in cross-fs
copies" and backported to 5.4.x, 5.10.x and 5.11.x we'll probably have to
replace verify_cross_fs_copy_support() with .min_kver = "5.3".

We have also tst_kvercmp2() in case original 5dae222a5ff0 ("vfs: allow
copy_file_range to copy across devices") was backported to any enterprise distro
(and then this fix would follow).

Kind regards,
Petr

> Thanks,
> Amir.
