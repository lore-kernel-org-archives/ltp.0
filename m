From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Nov 2016 13:20:20 +0100
Subject: [LTP] new shell library
Message-ID: <bc5b8dd3-0b75-7381-b892-ffa34b24dace@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 22 November, 2016 12:21:49 PM
> Subject: Re: [LTP] new shell library
> 
> Hi!
> > Looks good. Only thing that failed was 'file' test on older distros,
> > because output of 'file' is slightly different for certain file types.
> 
> Hmm, I've seen that as well and fixed a few occurences.
> 
> Should we fix that before the patchset gets merged or will you fix that
> afterwards in a follow up patch?

I'm attaching changes, which allow file_test to pass on RHEL5.6/6.0/6.9/7.3
and the rest we can fix if/when we encounter any.

If that works for you, then I suggest to add/squash this on top of your changes.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rhel_file_test_changes.patch
Type: text/x-patch
Size: 1412 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161122/b6e9a0e4/attachment.bin>
