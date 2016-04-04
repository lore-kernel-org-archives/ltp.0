From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Apr 2016 10:12:05 -0400 (EDT)
Subject: [LTP] Test library API changes
In-Reply-To: <20160404120444.GA13327@rei.lan>
References: <20160105111136.GA32659@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan> <20160317160606.GA31815@rei.lan>
 <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
 <20160331100146.GA20485@rei.lan>
 <1766074746.16671841.1459521955321.JavaMail.zimbra@redhat.com>
 <20160404120444.GA13327@rei.lan>
Message-ID: <2132205957.18145239.1459779125022.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 4 April, 2016 2:04:45 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> > > Now rest of the library calls should be wired to the new library as
> > > well, see for example this header:
> > > 
> > > https://github.com/metan-ucw/ltp/blob/master/include/tst_fs.h
> > 
> > Isn't it the other way around? Newlib interface wired to old lib
> > implementation?
> > Do the names with "_" at the end have any special meaning?
> 
> What I was trying to describe is that the rest of the functionality is
> available there i.e. wired to the new library.
> 
> The names with _ are the original prototypes so that we can have
> functions with and without the cleanup parameter depending on which
> proxy static inline function is selected.
> 
> > Was "#ifdef TST_TEST_H__" used in previous versions? Is there a difference
> > between ifdef approach and splitting interface to old_* header?
> 
> Well the old headers are there for two cases. Either the functions does
> not need to be exported to the testcases as the functionality is
> provided by the library, or the header contains some kind of SAFE_MACROS
> (minus the safe_macros.h that wasn't renamed beacause it's included
> directly in many testcases). I could have split the rest of the headers
> the very same way but we would need three files for each. One with the
> internal functions with underscore and one for oldlib and one for newlib
> inline functions, which looked to me like unnecessary many files.
> 
> Looking at it now we can easily stick the static inline functions for
> oldlib to the test.h. But we would still need to split the tst_ headers
> into two, one for the prototypes with underscore ending in _fn.h and one
> with the static inline for new library.
> 
> Or do you have a better idea how to proceed?

I don't think I have. I was thinking about macros to generate
both prototypes, but that would probably get messy soon.

One related idea I had for more "visual separation", was to
create subdir, e.g. include/oldlib and move all oldlib exclusive
headers there. And then add  that dir to include dirs in CFLAGS,
so nothing changes for tests.

Then (if I get the big picture), we could tell: "if you're looking
for a function for your newlib test, just avoid _fn headers
and anything in oldlib subdir". And same would apply for adding new
functions to newlib.

What I image people do to discover these functions is search in ltp/include,
and I'm guessing they'll get up to 3 hits: old header (which may or may not
have old_ in name), _fn header and tst_ header.

This is what made me think if we can somehow steer them to look
at newlib headers first.

> 
> > > The documentation was updated as well (I've even added a few functions
> > > that were not documented previously).
> > 
> > "resource_files" still appears to be undocumented.
> 
> Right. Will fix that.
> 
> > > I've also compared build logs to make sure that the changes haven't
> > > introduced new warnings and did a few syscall testruns to make sure
> > > everything works fine. Both looks good to me.
> > > 
> > > We are not that far from next LTP release. As a matter of fact we should
> > > start preparing for it anytime soon. Ideally I would like to get this
> > > merged before the release freeze and testing. What do you think?
> > 
> > I think technically it's going to work fine. My only worry is
> > how much are old/new API mixed together when I'm looking at
> > ltp/include directory. And I keep thinking: "As someone editing
> > testcase that is using old/new API, what headers should/shouldn't
> > I use?"
> 
> Currently everything test needs is included in tst_test.h which is all
> that should be included in the newlib testcase. Which is IMHO better
> than requiring to include new header for each couple of functions.

I agree.

Regards,
Jan

> And
> given that everything that the library exports should start either with
> TST_ tst_ SAFE_ or safe_ there shouldn't be any unexpected collisions
> either.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
