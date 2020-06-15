From: Li Wang <liwang@redhat.com>
Date: Mon, 15 Jun 2020 15:26:04 +0800
Subject: [LTP] [PATCH v3] Wrapper for Syzkaller reproducers
In-Reply-To: <20200610072732.GA32619@dell5510>
References: <20200609113421.10936-1-rpalethorpe@suse.com>
 <20200609165921.GA28805@dell5510>
 <fa3b9d86-84f7-be61-f06f-c32f3ab60d3a@linuxfoundation.org>
 <CACT4Y+bYdmD7vdNUayT86oiW8yVLUBdFLOZRJ1nTi9AE99KzSg@mail.gmail.com>
 <ce8bd6c0-0abb-e09e-b21f-5e769ffd3ab3@linuxfoundation.org>
 <20200609195851.GA29515@x230>
 <8b3cbf25-83ad-42da-f3ec-e2bafdfff97c@linuxfoundation.org>
 <874krjxuby.fsf@our.domain.is.not.set> <20200610072732.GA32619@dell5510>
Message-ID: <CAEemH2dKooCXs84Qa=AoAd+QrHLZWo4Ko_hzOvHy6Cm74JVADw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 10, 2020 at 3:27 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Shuah, Richard,
>
> > > If this patch doesn't intend to update syzkaller-repo, there is
> > > nothing to do for linux-arts. I thought that this patch is for
> > > Dmitry's syzkaller repo I update from and looking get this into
> > > linux-arts directly.
>
> > > Since this is LTP patch, ignore my comments. Sorry for the noise.
>
> > > thanks,
> > > -- Shuah
>
> > No problem at all, I should have made that more clear.
>
> > Infact I will send a seperate patch to linux-arts mentioning the LTP
> > wrapper.
> Thanks you both for clarifying.
>
> @Jan, @Cyril, @Yang, @Li: any ack/objection to this patch?
>

I have no objection to merging the syzkaller patch.
Build and run some of the testcase locally(Fedora32) by manual, it works
well.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200615/49a22ccd/attachment.htm>
