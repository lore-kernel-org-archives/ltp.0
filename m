From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 5 Jul 2018 17:57:10 +0200
Subject: [LTP] FAILED: patch "[PATCH] ovl: hash non-dir by lower inode
 for fsnotify" failed to apply to 4.14-stable tree
In-Reply-To: <CABdQkv9mUMF_ewvE2_7AUXpxoS2ZUcbnxo+iL3yF3FU-aVLkBQ@mail.gmail.com>
References: <152086697777252@kroah.com>
 <CABdQkv8E4Ofv5MSX=U0wk1MZ5=szUSr54vshhn6X_wsB+tEz2g@mail.gmail.com>
 <20180705151810.GA11929@kroah.com>
 <CABdQkv_yJL5-DEr4D5D=VTvC7WTq292OCmZteccROHmTwTjY6g@mail.gmail.com>
 <20180705153051.GA13764@kroah.com>
 <CABdQkv9mUMF_ewvE2_7AUXpxoS2ZUcbnxo+iL3yF3FU-aVLkBQ@mail.gmail.com>
Message-ID: <20180705155710.GA20455@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 05, 2018 at 12:53:24PM -0300, Rafael David Tinoco wrote:
> > What bug?  Please never top-post, you loose all context :(
> 
> Won't happen again.
> 
> Summary is this:
> 
> commit 764baba80168ad3adafb521d2ab483ccbc49e344
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Sun Feb 4 15:35:09 2018 +0200
> 
>     ovl: hash non-dir by lower inode for fsnotify
> 
> INFO: inotify issue with non-dir non-upper files in overlayfs exists
> in LTS <= v4.14.
> INFO: LTP inotify08 test fails on * v4.14 and bellow * and should be skipped.
> 
> And message was informative only (clearly didn't work). Either way, do
> you think it's worth informing existing LTS bugs, found by test
> tooling, here ?

Why can't we fix those bugs in the stable kernel releases?  Is it too
difficult to do so?

thanks,

greg k-h
