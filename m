From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2019 13:13:53 +0530
Subject: [LTP] [PATCH v3 0/3] syscalls: add tgkill test-cases
In-Reply-To: <20190319135454.GG6204@rei>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
 <20190319135454.GG6204@rei>
Message-ID: <CAFA6WYPwvrpb=-Wvv7LGQsz9taK0BAj2jsZkynpq+idQfcf7-w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 19 Mar 2019 at 19:25, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Pushed with minor changes, thanks.

Thanks for these changes and merge.

>
> Also we are still missing the EPERM error case, for that we would have
> to start the test as root, fork a child change the UID and GID and
> attempt to send a signal to parent process.
>

Hmm I see. I will try to add test case for this too.

-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
