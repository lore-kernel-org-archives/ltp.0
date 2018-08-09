From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Aug 2018 12:59:41 +0800
Subject: [LTP] [PATCH 0/6] rewrite exec() family tests to newlib
In-Reply-To: <20180808123628.GB19147@rei>
References: <20180808055434.26293-1-liwang@redhat.com>
 <20180808123628.GB19147@rei>
Message-ID: <CAEemH2cQbMpfBKHn5Uw13Vsmzc=wyXV0LN3n50OsvxCiH=+17A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 8, 2018 at 8:36 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > This patch set are base on Cyril's new patch(lib: Fix result
> > propagation after exec() + tst_reinit()) to rewrite all exec[lvpe]
> > testcase in new API.
>
> I was thinking about doing exactly this yesterday, it's nice to see it
> done so fast :-).
>
> The patches 1-5 are pushed with two changes:
>
> * There is no need to set the .needs_root flag for exec*01 testcases
>
> * It's wrong to do waitpid() for the child that reports the results
>   (and it's even written in the test-writing-guidelines) that is because
>   tst_brk() is propagated using the exit value, hence children that use
>   the test library API has to be waited for in the test library (which
>   happens automatically once the main test process exits the test
>   function)
>

Yes, that's right. Thanks for the explanation.
And, I have looked though all the comments in patch 6/6, there're all pertinent
advice.  Agreed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180809/0cbfd44b/attachment.html>
