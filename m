From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 13:54:32 +0200
Subject: [LTP] LTP Release
In-Reply-To: <CAEemH2e+DTsHcTePT10OXrXhV0W-YtQiNTiOgndPku8PO-UCPw@mail.gmail.com>
References: <20160503124652.GD6059@rei.lan>
 <CAEemH2e+DTsHcTePT10OXrXhV0W-YtQiNTiOgndPku8PO-UCPw@mail.gmail.com>
Message-ID: <20160504115432.GB12244@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Are there any pending issues/patches that should be solved/applied
> > before the release?
> 
> How about the following patch set? are there any possible to handle
> them before the release time?
> 
> http://lists.linux.it/pipermail/ltp/2016-April/001533.html

Is not executed in default_scenario so the risk of changing it just
before the release is low. I suppose that the testcases does not work
correctly without these changes, right?

-- 
Cyril Hrubis
chrubis@suse.cz
