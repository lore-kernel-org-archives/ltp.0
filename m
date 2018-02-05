From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Feb 2018 14:48:53 +0100
Subject: [LTP] [RFC,
 COMMITTED 1/1] configure: add knob to control numa support
In-Reply-To: <20180205132857.GA20417@x230>
References: <20180205132441.19130-1-pvorel@suse.cz>
 <20180205132857.GA20417@x230>
Message-ID: <20180205134853.GA30063@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > From: Anders Roxell <anders.roxell@linaro.org>
> > Allow to disable numa from the top level.
<snip>

> Although the autodetection was fixed in commit bf3441268 ("numa: Check for API >= v2 with
> autoconf") (the patch is for ltp released 4 years ago), I committed this as user should be
> able to decide whether to compile tests or not.

> I'm sorry, I've introduced two errors with this commit:

> 1) there should be default=no as we want to have
> it default:
> -    [without numa support (default=yes)]),
> +    [without numa support (default=no)]),

> So, this is easily to be fixed.

> 2) I haven't realized that, the TCONF message is misleading when
> configured with '--without-numa':
> tst_test.c:712: CONF: test requires libnuma >= 2 and it's development packages

> So I guess the whole idea of our functionality compiling with error
> message "you lack support" doesn't work well with enabling and disabling
> features by user. There should be a way to define in config variable
> WITHOUT_NUMA and print correct message "Compiled without NUMA support".

> I'm going to fix this if you like the idea allowing users to configure
> what is being build (there might be requests in the future to add more
> switches). Otherwise I'll revert it.

And this comes from github pull request:
https://github.com/linux-test-project/ltp/pull/248


Kind regards,
Petr
