From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Apr 2020 11:18:54 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200409074505.GA2601@dell5510>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <20200409074505.GA2601@dell5510>
Message-ID: <20200409091854.GA9792@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that we can even drop the TCID extern definition from the tst_test.h
> > header if the weak attribute works fine.
> 
> I'd be for adding this patch (both version works), Cyril, will you send it
> to ML / push it?

Feel free do that yourself. I would be for the version without extern
definition in tst_test.h then.

> I'd also be for adding -fno-common to Travis after this fix.

Sounds good.

-- 
Cyril Hrubis
chrubis@suse.cz
