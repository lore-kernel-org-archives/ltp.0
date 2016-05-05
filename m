From: Li Wang <liwang@redhat.com>
Date: Thu, 5 May 2016 14:13:39 +0800
Subject: [LTP] LTP Release
In-Reply-To: <20160504115432.GB12244@rei.lan>
References: <20160503124652.GD6059@rei.lan>
 <CAEemH2e+DTsHcTePT10OXrXhV0W-YtQiNTiOgndPku8PO-UCPw@mail.gmail.com>
 <20160504115432.GB12244@rei.lan>
Message-ID: <20160505061339.GA426@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 04, 2016 at 01:54:32PM +0200, Cyril Hrubis wrote:
> Hi!
> > > Are there any pending issues/patches that should be solved/applied
> > > before the release?
> > 
> > How about the following patch set? are there any possible to handle
> > them before the release time?
> > 
> > http://lists.linux.it/pipermail/ltp/2016-April/001533.html
> 
> Is not executed in default_scenario so the risk of changing it just
> before the release is low. I suppose that the testcases does not work
> correctly without these changes, right?

yes, right. I'm OK to skip these fix for current LTP released.

and the other simple one as well.

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
