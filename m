From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 27 Jun 2020 18:31:47 +1000
Subject: [LTP] [PATCH] crypto: af_alg - Fix regression on empty requests
In-Reply-To: <20200626062948.GA25285@gondor.apana.org.au>
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com>
 <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
 <20200623064056.GA8121@gondor.apana.org.au>
 <20200623170217.GB150582@gmail.com>
 <20200626062948.GA25285@gondor.apana.org.au>
Message-ID: <20200627083147.GA9365@gondor.apana.org.au>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 26, 2020 at 04:29:48PM +1000, Herbert Xu wrote:
>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when...")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reported-by: kernel test robot <rong.a.chen@intel.com>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
