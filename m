From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Mar 2021 16:39:53 +0800
Subject: [LTP] [PATCH 1/3] lib: Add proper filesystem skiplist
In-Reply-To: <b3391506-259b-1376-2c51-4d2a1557a44a@suse.cz>
References: <20210310122625.25425-1-chrubis@suse.cz>
 <20210310122625.25425-2-chrubis@suse.cz>
 <30fec758-5e18-fceb-ec23-646253ba0e46@suse.cz> <YEjyLBZQ+D1CHqnq@rei.lan>
 <b3391506-259b-1376-2c51-4d2a1557a44a@suse.cz>
Message-ID: <CAEemH2dzPtskPCJR+639u08k3LV3-XPB6AzNj4adDDvjY9Dydw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Thu, Mar 11, 2021 at 12:34 AM Martin Doucha <mdoucha@suse.cz> wrote:

> On 10. 03. 21 17:22, Cyril Hrubis wrote:
> > Hi!
> >>> +static int has_kernel_support(const char *fs_type, const char *const
> *skiplist)
> >>>  {
> >>>     static int fuse_supported = -1;
> >>>     const char *tmpdir = getenv("TMPDIR");
> >>>     char buf[128];
> >>>     int ret;
> >>>
> >>> +   if (tst_fs_in_skiplist(fs_type, skiplist))
> >>> +           return 0;
> >>> +
> >>>     if (!tmpdir)
> >>>             tmpdir = "/tmp";
> >>>
> >>> @@ -84,26 +105,24 @@ static int has_kernel_support(const char
> *fs_type, int flags)
> >>>             return 0;
> >>>     }
> >>>
> >>> -   if (flags & TST_FS_SKIP_FUSE) {
> >>> -           tst_res(TINFO, "Skipping FUSE as requested by the test");
> >>> +   if (tst_fs_in_skiplist("fuse", skiplist))
> >>>             return 0;
> >>> -   }
> >>>
> >>>     tst_res(TINFO, "FUSE does support %s", fs_type);
> >>>     return 1;
> >>>  }
> >>
> >> I don't think that has_kernel_support() should look at the skiplist at
> >> all. The entire skiplist logic should be handled in
> >> tst_get_supported_fs_types(). But has_kernel_support() could return
> >> different (non-zero) values for native support and for FUSE support.
> >
> > I do not agree, that would add more complexity to an internal function
> > that is not exported outside the library.
>
> Your patchset adds complexity to tst_fs_is_supported() which is a public
> wrapper of has_kernel_support(), even though it's only used indirectly
> in shell tests. Some tests might use that function directly in the
> future so let's make the interface cleaner, not hairier.
>

+1

I have the same view as Martin. Since only regarding the function name
has_kernel_support() should only take care of the kernel supported
filesystem
but not include any blacklist from users. That will make people confused in
code reading.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210311/7d7d0a1a/attachment.htm>
