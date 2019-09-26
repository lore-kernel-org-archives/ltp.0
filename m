From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Sep 2019 17:02:15 +0800
Subject: [LTP] LTP Release
In-Reply-To: <20190925112236.GA17496@rei.lan>
References: <20190906130707.GA7515@rei.lan> <20190925112236.GA17496@rei.lan>
Message-ID: <CAEemH2cCONPcaTJGz=-3ndZFoHAKkr7gxw1ezuZDdP=rj10MMw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 25, 2019 at 7:22 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> I did a few testruns and so far it looks good.
>
> I've send one patch for acct02, which is mostly cosmetic, that I would
> like to get merged.
>
> I would still consider merging the eBPF regression test, does anybody
> have a strong opinion on this?
>
> Apart from this preadv203 sometimes fails to trigger EAGAIN on virtual
> machines, but I doubt we can fix this before the release, I will try to
> do so later on.
>
> The rest seems to be good, i.e. failures does not seem to be bugs in
> tests.
>
> What is the status from rest of you? Is there anything that should be
> considered for the release? Is something failing unexpectedly?
>

No more failure from my side except the known issues(timer_create01,
acct02). It's time to release a new package since now is already ending in
September.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190926/26a8384c/attachment.htm>
