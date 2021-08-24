From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Aug 2021 17:29:31 +0800
Subject: [LTP] [PATCH 1/3] tst_test_macros: Fix TST_EXP_*() default
 message
In-Reply-To: <YSSyVtSF6UmqYlu4@yuki>
References: <20210823150520.25614-1-chrubis@suse.cz>
 <20210823150520.25614-2-chrubis@suse.cz>
 <CAEemH2dYcF=N3F=MZXPVLgBHBa3Xt=iT8ACeQ4_9THXu-kyYtA@mail.gmail.com>
 <YSSyVtSF6UmqYlu4@yuki>
Message-ID: <CAEemH2dpz577XH6q2fEw7uHYOvOORs8NLT_CroRvOnoAK2jQnw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 24, 2021 at 4:48 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Patchset looks good from the code layer though it is a bit complicate
> > in 2/3 stringify handling, but that should be acceptable.
> >
> > My only hesitating is about ##__VA_ARGS__, because it says that is still
> > as GNU's extension but have not got into standard C.
>
> Note that we have been using it in the header from the start. There were
> just a few places where it was missing, mostly in the variants that have
> been added later.
>

Ah great, I was neglect that point.  Hence it should be safe enough.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210824/e05904b8/attachment-0001.htm>
