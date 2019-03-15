From: Eric Biggers <ebiggers@kernel.org>
Date: Fri, 15 Mar 2019 12:49:15 -0700
Subject: [LTP] [PATCH 4/6] crypto/af_alg03: new regression test for
 rfc7539 hash alg validation
In-Reply-To: <20190315184018.GA3112@x230>
References: <20190221053026.18489-1-ebiggers@kernel.org>
 <20190221053026.18489-5-ebiggers@kernel.org>
 <20190315092952.GA4990@dell5510> <20190315161341.GA77949@gmail.com>
 <20190315184018.GA3112@x230>
Message-ID: <20190315194914.GC77949@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 15, 2019 at 07:40:18PM +0100, Petr Vorel wrote:
> Hi Eric,
> 
> > > you forget to add af_alg03 into runtest/cve.
> > > The same applies to af_alg0{4,5}.
> 
> > As far as I know, there are no CVEs assigned for those bugs.
> Wouldn't be better to add them to runtest/cve (or other runtest file) just with
> filename? And rename them in runtest file once the CVEs are assigned?
> 
> > - Eric
> 
> Kind regards,
> Petr

Oh, I missed that they're not in any runtest file at all.  They all should be in
runtest/crypto (in addition to the ones with CVEs being in runtest/cve).

- Eric
