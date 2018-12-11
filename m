From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 11 Dec 2018 10:43:34 -0800
Subject: [LTP] [PATCH v2 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <20181211123251.GA27346@rei>
References: <20181211060317.18698-1-ebiggers@kernel.org>
 <20181211060317.18698-4-ebiggers@kernel.org>
 <20181211123251.GA27346@rei>
Message-ID: <20181211184334.GD221175@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Tue, Dec 11, 2018 at 01:32:52PM +0100, Cyril Hrubis wrote:
> Hi!
> > --- a/runtest/crypto
> > +++ b/runtest/crypto
> > @@ -1 +1,2 @@
> >  pcrypt_aead01 pcrypt_aead01
> > +crypto_user01 crypto_user01
> > diff --git a/runtest/cve b/runtest/cve
> > index c4ba74186..78a5d8db2 100644
> > --- a/runtest/cve
> > +++ b/runtest/cve
> > @@ -3,6 +3,7 @@ cve-2011-0999 thp01 -I 120
> >  cve-2011-2183 ksm05 -I 10
> >  cve-2011-2496 vma03
> >  cve-2012-0957 uname04
> > +cve-2013-2547 crypto_user01
> >  cve-2014-0196 cve-2014-0196
> >  cve-2015-0235 gethostbyname_r01
> >  cve-2015-7550 keyctl02
> > @@ -36,3 +37,4 @@ cve-2017-17053 cve-2017-17053
> >  cve-2017-18075 pcrypt_aead01
> >  cve-2018-5803 sctp_big_chunk
> >  cve-2018-1000001 realpath01
> > +cve-2018-19854 crypto_user01
> 
> Does it really make sense to run this test twice just under different
> name?
> 
> BTW: I'm working on test tags and metadata patches that would make
> failed tests print list of CVEs and kernel commits that fixed them on a
> failure and also under the -h help switch, which should fix this once
> for all.
> 
> See:
> 
> http://lists.linux.it/pipermail/ltp/2018-November/009895.html
> http://lists.linux.it/pipermail/ltp/2018-November/010118.html
> 

No it doesn't really make sense to run a test twice, but this has two associated
CVE numbers, resulting in two runs when tests are run by CVE number.  Are you
saying you'd prefer that it be listed under just the more recent CVE?  Or are
you saying the runtest/cve file will be going away and replaced by something
else anyway?

- Eric
