From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 11:51:45 +0100
Subject: [LTP] [RFC PATCH 1/1] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <YFHPbD132yWLMqK8@yuki.lan>
References: <20210317083347.9791-1-pvorel@suse.cz> <YFHPbD132yWLMqK8@yuki.lan>
Message-ID: <YFHfQeFg0Uzwl3kH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

Cyril, Li, Jan, thanks for your tips, I'll use them for v2.
Few notes to some of Cyril's tips.

> > +### C tests
> > +* use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
> > +* record in `.gitignore`
> > +* check coding style with `checkpatch.pl`

> Checkpatch is distributed with linux kernel source code, please also use
> reasonably recent one.
I'd prefer not duplicate the info, that's why I linked it docs, which already
mention this. Thus I'd prefer add "reasonably recent one" to
doc/test-writing-guidelines.txt.

> > +(more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style[C coding style])
> > +* docparse documentation

> + proper documentation comment
>   -- this should be explained somewhere and linked here
Agree, but I'll probably skip this one.

> + If a test is a regression test it should include tags
>   -- this should be explained somewhere as well and linked here
+1

> > +### Shell tests
> > +* use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
> > +* check coding style with `checkbashism.pl`

> I guess that we should add the link to debian devscripts here
Again, I wanted to remove duplicity, but just repeating link here does no harm.

Kind regards,
Petr
