From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Jan 2020 12:56:33 +0800
Subject: [LTP] [PATCH v2] syscalls/userfaultfd01: add hint about
 unprivileged_userfaultfd
In-Reply-To: <8a1a9b95-5c42-2176-857a-e3c36fa42b55@cn.fujitsu.com>
References: <1576641763-18305-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eKbbXjonuiKMdHcRda98hJikmGW4=YtWft0-1QAj0oBQ@mail.gmail.com>
 <8a1a9b95-5c42-2176-857a-e3c36fa42b55@cn.fujitsu.com>
Message-ID: <CAEemH2djB=2=HD=RQxkABDzFt5ZOZr+iVT3_chahSoZSLhoqqQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

On Mon, Jan 6, 2020 at 5:10 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> ...
> > Can we do the "vm.unprivileged_userfaultfd" check in the setup() and do
> > set to 1 if it exists?
> I remembered Jan Stancek has a patch about bpf hint about
> unprivileged_bpf_disabled, I do as same as that patch did.
>
> Also, month agos about acct02 discussion, Cyril points about adjusting
> the threshold value of resume and suppend to make case passes.
>
> So, I have a question that we have unified standards about these cases
> (bpf, acct02, affected by sysctl)? Report TCONF or modify argument to
> make case passes?
>

After thinking over, to report TCONF is the wise method here because this
test might run with an unprivileged user and it can not modify the knob
"vm.unprivileged_userfaultfd".

Sorry and now I pull back my last comment.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200107/cb5dcf9f/attachment-0001.htm>
