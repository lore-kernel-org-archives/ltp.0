From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Aug 2021 15:35:20 +0800
Subject: [LTP] [PATCH 1/3] tst_test_macros: Fix TST_EXP_*() default
 message
In-Reply-To: <20210823150520.25614-2-chrubis@suse.cz>
References: <20210823150520.25614-1-chrubis@suse.cz>
 <20210823150520.25614-2-chrubis@suse.cz>
Message-ID: <CAEemH2dYcF=N3F=MZXPVLgBHBa3Xt=iT8ACeQ4_9THXu-kyYtA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 23, 2021 at 11:05 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> We have to erase the last comma because otherwise we pass down one more
> empty parameter to the TST_EXP_*_() macros which then causes the FMT
> string to be empty and we end up with an empty default message.
>


Patchset looks good from the code layer though it is a bit complicate
in 2/3 stringify handling, but that should be acceptable.

My only hesitating is about ##__VA_ARGS__, because it says that is still
as GNU's extension but have not got into standard C.

So I especially run with GitHub CI and got pretty compiling results, then I
have
a positive attitude on applying these patches unless there is someone who
blames it broken something in a general (but I guess the possibility is
very little).
https://github.com/wangli5665/ltp/runs/3408080506

Feel free to add my reviews:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210824/294f5d33/attachment.htm>
