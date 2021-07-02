From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Jul 2021 20:01:54 +0800
Subject: [LTP] [PATCH 1/2] lib: limit the size of tmpfs in LTP
In-Reply-To: <YN7afAs3Mup5UbIf@yuki>
References: <20210701055208.715395-1-liwang@redhat.com> <YN7afAs3Mup5UbIf@yuki>
Message-ID: <CAEemH2dJ4FYh-7-8C5na-uB1jg31mdV8wC+7w_DHG1463XudHA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:



> > +char *limit_tmpfs_mount_size(const char *mnt_data, unsigned int size);
>
> If we want this function to be public it has to be prefixed with 'tst_'.
>
> Also do we really need this to be public?
>

No, we don't. I put it in the tst_device.c only hope to make use of the
DEV_SIZE_MB definition, and now seems this is a bad idea.

Looks like we should move it back to tst_test.c and state it as a static
function.



>
> > +static char tmpfs_buf[1024];
>
> Can we please, instead of adding a global variable, pass the buffer and
> it's size to the limit_tmpfs_mount size, and then create the path on the
> stack in the prepare device function?
>
>
Sure.


>
> > +char *limit_tmpfs_mount_size(const char *mnt_data, unsigned int size)
> > +{
> > +     unsigned int dev_size = MAX(size, DEV_SIZE_MB);
> > +
> > +     if (mnt_data)
> > +             snprintf(tmpfs_buf, sizeof(tmpfs_buf), "%s,size=%uM",
> mnt_data, dev_size);
> > +     else
> > +             snprintf(tmpfs_buf, sizeof(tmpfs_buf), "size=%uM",
> dev_size);
> > +
> > +     tst_resm(TINFO, "Limiting tmpfs size to %uMB", dev_size);
> > +
> > +     return tmpfs_buf;
> > +}
>
> If we passed the filesystem type to this function here as well we could
> do:
>
>         if (!strcmp(fs_type, "tmpfs"))
>                 return mnt_data;
>
> As a first thing in this function and then we could pass the return
> value from this function to the SAFE_MOUNT() unconditionally.
>

+1 This sounds good.


> > +
> > +             if (!strcmp(tdev.fs_type, "tmpfs"))
> > +                     tst_test->mnt_data = mnt_data;
>
> I guess that we are doing this in order to export the changes in the
> mnt_data to the test, right?
>
> Is that needed for something or are you doing this just in a case that
> somebody will use that?
>

No, you probably mis-read this part.

In contrast, this is just to restore it to the original value,
because we don't want to export the changed tst_test->mnt_data
take effect on other filesystems.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210702/b0f9c08e/attachment.htm>
