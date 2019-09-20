From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 20 Sep 2019 15:48:23 +0200
Subject: [LTP] [PATCH v3 0/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <20190919135043.14359-1-pvorel@suse.cz>
References: <20190919135043.14359-1-pvorel@suse.cz>
Message-ID: <1568987303.3024.7.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, 2019-09-19 at 15:50 +0200, Petr Vorel wrote:
> Hi,
> 
> changes v2->v3:
> * cast to int if awk is not available (Li) instead of TCONF
> * actually round variable (with 0.5) (Clemens)
> * fix variable description (Clemens)

Patchset looks good to me! Well done!

> * add 2 tests for TST_TIMEOUT (it'd be more useful to test
>   LTP_TIMEOUT_MUL, but I'd wait for Christian's shell test
>   patch [1] being merged)

lets place them in `lib/newlib_tests/shell/testcases` as Christian is
doing and add the `# output: ` tag so it might work then.
Or lets place them in a separate Patchset which we can merge after [1].


> [1] https://patchwork.ozlabs.org/patch/1151766/
