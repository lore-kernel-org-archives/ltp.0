From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Apr 2017 15:22:55 +0200
Subject: [LTP] [RFC PATCH 1/1] config.mk: Explicitly set used C and C++
 standard
In-Reply-To: <20170427131032.GB14404@rei.lan>
References: <20170414122312.22734-1-pvorel@suse.cz>
 <20170427131032.GB14404@rei.lan>
Message-ID: <20170427132255.kflvm76zv6cqbrq4@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > IMHO If we really want to require old standard, we should explicitly say which one.
> > I suppose passing a flag is appropriate way than to use c89 as CC variable.

> Where do we say that we require old standard?
We don't, I just understood it from Alexeys' comments.

[1]:
Please also use checkpatch and fix any errors/warnings reported:
    total: 5 errors, 37 warnings

[2]:
Used default options for gcc in OL6, I guess in my case it has --std=gnu89
by default and you have something different, may be gnu99...

> All I can think of is that we should produce portable code, which is
> something completely different that sticking to a single C standard
> revision...
Make sense :-). Thanks for your comments, please forget on the patch.


Kind regards,
Petr

[1]: http://lists.linux.it/pipermail/ltp/2017-April/004230.html
[2]: http://lists.linux.it/pipermail/ltp/2017-April/004315.html
