From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Apr 2020 16:29:07 +0200
Subject: [LTP] [PATCH V3 1/2] tst_timer: Add support for kernel's 64 bit
 timespec
In-Reply-To: <20200422132642.GA9086@yuki.lan>
References: <cover.1587033556.git.viresh.kumar@linaro.org>
 <08a307591b531593bbaa5b1e8a4c841e80493937.1587033556.git.viresh.kumar@linaro.org>
 <20200421154006.GA14036@yuki.lan> <20200422131801.GA9146@dell5510>
 <20200422132642.GA9086@yuki.lan>
Message-ID: <20200422142907.GB9086@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > $ gcc --version
> > gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
> 
> Looks like there are some problems with the anonymouns unions, probably
> gcc 4.4 does not support these. I will have a look later on.

Looking into the issue, anonymous unions are part of c11 standard so it
looks like gcc 4.4 is too old to support that. I have tested 4.4.5 which
definitelly lacks the support.

So I guess I will have to change the code so that the union has a name,
its not a big deal since we aren't touching the fields directly but only
in a few get/set functions.

-- 
Cyril Hrubis
chrubis@suse.cz
