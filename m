From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 Feb 2019 14:03:51 +0100
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <CAOQ4uxj-=5J2809-11_X4-zXPWOyrmLyFZd+acz692mB9YM3gw@mail.gmail.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <CAOQ4uxj-=5J2809-11_X4-zXPWOyrmLyFZd+acz692mB9YM3gw@mail.gmail.com>
Message-ID: <20190215130350.GA26339@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +
> > +       fd =  SAFE_OPEN(TST_FILE, O_RDWR|O_CREAT, MODE);
> > +
> > +       /* Filling the test file */
> > +       for (counter = 0; counter < TST_FILE_SIZE_MB; counter++)
> > +               SAFE_WRITE(1, fd, buffer, SIZE_MB);
> > +
> > +       TEST(syncfs(fd));
> > +       if (TST_RET != 0)
> > +               tst_brk(TFAIL | TTERRNO, "syncfs(fd) failed");
> > +
> > +       SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> > +                       nwrite_sec_val);
> > +
> > +       write_sec = SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);
> > +
> > +       if ((write_sec - prev_write_sec) * 512 >=
> > +           (TST_FILE_SIZE_MB * SIZE_MB))
> > +               tst_res(TPASS, "Test filesystem synced to device");
> > +       else
> > +               tst_res(TFAIL, "Failed to sync test filesystem to device");
> > +
> > +       SAFE_CLOSE(fd);
> > +}
> > +
> 
> It's good to have a tests that verified syncfs() actually does what it
> is meant to do.
> It's awkward that none of the tests for fsync() fdatasync() sync()
> sync_file_range()
> check that.
> 
> It would be very low hanging to have the exact same test that you wrote
> iterate on several test cases where the only difference is the op called on
> fd. (fsync,fdatasync,syncfs) should all have the same consequence wrt
> minimal written sectors.
> With a little more effort, sync() and sync_file_range() could also be
> added to test cases.
> 
> I realize that LTP usually puts syscalls tests under the specific
> kernel/syscalls directory, but in this case, I believe code reuse calls
> for a single test that exercises all three syscalls.

We can always put the common code into a header/library and still have a
test for each of the syscalls as we usually do in LTP.

-- 
Cyril Hrubis
chrubis@suse.cz
