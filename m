From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jul 2019 11:50:00 +0200
Subject: [LTP] [PATCH] doc: Mention network tests in variables
In-Reply-To: <20190718092910.GA25241@rei.lan>
References: <20190718092037.13594-1-pvorel@suse.cz>
 <20190718092910.GA25241@rei.lan>
Message-ID: <20190718095000.GA15944@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I'd prefer using hyperlinks in docs (as it's supposed to be viewed
> > mainly in a browser) but these are the only variants (which looks too
> > ugly to me):

> > NOTE: link:../../blob/master/testcases/network/README.md[Network tests] use additional variables
> > in 'tst_net.sh'.
> > (this one at least keeps links to forks)

> > NOTE: https://github.com/linux-test-project/ltp/blob/master/testcases/network/README.md[Network tests] use additional variables
> > in 'tst_net.sh'.

> > => I'd be for giving up links.

> Given that test-writing-guidelines text is also on the LTP wiki the first one would not work anyways...
It works when using '../../blob/master/testcases/network/README.md' works, see [1] :).

> So yes I do agree that pointing out people to the relative location of
> the README.md is probably the best we can do, acked.
But unless Alexey objects, I'd be also for plain text version.

Kind regards,
Petr

[1] https://github.com/pevik/ltp/wiki/TEST
