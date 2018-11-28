From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Nov 2018 11:52:23 +0200
Subject: [LTP] [PATCH v3 3/6] syscalls/readahead02: abort test if
 readahead syscall fails
In-Reply-To: <20181120161811.GB18182@rei.lan>
References: <20181010233441.5337-1-amir73il@gmail.com>
 <20181010233441.5337-4-amir73il@gmail.com>
 <20181120161811.GB18182@rei.lan>
Message-ID: <CAOQ4uxgk89yC+hTRKQUrjdM+Kbm31n2SuHfUE5frNp1J2mSorw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 20, 2018 at 6:32 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > There is no reason to continue the test if readahead syscall fails
> > and we can also check and report TCONF if filesystem does not support
> > readahead.
>
> This looks good, but I would like to get rid of the check_ret function
> as I said in the first case.
>
> So maybe we can leave it in the cleanup but move the actuall code in
> this patch. Does that sounds good to you?

Will do.

Thanks,
Amir.
