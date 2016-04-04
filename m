From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Apr 2016 14:04:45 +0200
Subject: [LTP] Test library API changes
In-Reply-To: <1766074746.16671841.1459521955321.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan> <20160314125153.GB600@rei.lan>
 <20160314160036.GA2511@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan> <20160317160606.GA31815@rei.lan>
 <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
 <20160331100146.GA20485@rei.lan>
 <1766074746.16671841.1459521955321.JavaMail.zimbra@redhat.com>
Message-ID: <20160404120444.GA13327@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Now rest of the library calls should be wired to the new library as
> > well, see for example this header:
> > 
> > https://github.com/metan-ucw/ltp/blob/master/include/tst_fs.h
> 
> Isn't it the other way around? Newlib interface wired to old lib implementation?
> Do the names with "_" at the end have any special meaning?

What I was trying to describe is that the rest of the functionality is
available there i.e. wired to the new library.

The names with _ are the original prototypes so that we can have
functions with and without the cleanup parameter depending on which
proxy static inline function is selected.

> Was "#ifdef TST_TEST_H__" used in previous versions? Is there a difference
> between ifdef approach and splitting interface to old_* header?

Well the old headers are there for two cases. Either the functions does
not need to be exported to the testcases as the functionality is
provided by the library, or the header contains some kind of SAFE_MACROS
(minus the safe_macros.h that wasn't renamed beacause it's included
directly in many testcases). I could have split the rest of the headers
the very same way but we would need three files for each. One with the
internal functions with underscore and one for oldlib and one for newlib
inline functions, which looked to me like unnecessary many files.

Looking at it now we can easily stick the static inline functions for
oldlib to the test.h. But we would still need to split the tst_ headers
into two, one for the prototypes with underscore ending in _fn.h and one
with the static inline for new library.

Or do you have a better idea how to proceed?

> > The documentation was updated as well (I've even added a few functions
> > that were not documented previously).
> 
> "resource_files" still appears to be undocumented.

Right. Will fix that.

> > I've also compared build logs to make sure that the changes haven't
> > introduced new warnings and did a few syscall testruns to make sure
> > everything works fine. Both looks good to me.
> > 
> > We are not that far from next LTP release. As a matter of fact we should
> > start preparing for it anytime soon. Ideally I would like to get this
> > merged before the release freeze and testing. What do you think?
> 
> I think technically it's going to work fine. My only worry is
> how much are old/new API mixed together when I'm looking at
> ltp/include directory. And I keep thinking: "As someone editing
> testcase that is using old/new API, what headers should/shouldn't
> I use?"

Currently everything test needs is included in tst_test.h which is all
that should be included in the newlib testcase. Which is IMHO better
than requiring to include new header for each couple of functions. And
given that everything that the library exports should start either with
TST_ tst_ SAFE_ or safe_ there shouldn't be any unexpected collisions
either.

-- 
Cyril Hrubis
chrubis@suse.cz
