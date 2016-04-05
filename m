From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Apr 2016 16:16:28 +0200
Subject: [LTP] Test library API changes
In-Reply-To: <2132205957.18145239.1459779125022.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan> <20160317160606.GA31815@rei.lan>
 <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
 <20160331100146.GA20485@rei.lan>
 <1766074746.16671841.1459521955321.JavaMail.zimbra@redhat.com>
 <20160404120444.GA13327@rei.lan>
 <2132205957.18145239.1459779125022.JavaMail.zimbra@redhat.com>
Message-ID: <20160405141627.GA21660@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Or do you have a better idea how to proceed?
> 
> I don't think I have. I was thinking about macros to generate
> both prototypes, but that would probably get messy soon.
> 
> One related idea I had for more "visual separation", was to
> create subdir, e.g. include/oldlib and move all oldlib exclusive
> headers there. And then add  that dir to include dirs in CFLAGS,
> so nothing changes for tests.
> 
> Then (if I get the big picture), we could tell: "if you're looking
> for a function for your newlib test, just avoid _fn headers
> and anything in oldlib subdir". And same would apply for adding new
> functions to newlib.
> 
> What I image people do to discover these functions is search in ltp/include,
> and I'm guessing they'll get up to 3 hits: old header (which may or may not
> have old_ in name), _fn header and tst_ header.
> 
> This is what made me think if we can somehow steer them to look
> at newlib headers first.

I've added a patch on the top of the one that adds the new library that
moves the old headers to include/old. Now only config.h, tst_* headers
and safe_*fn.h are directly in include.

The resource files are documented in the test-writing-guidelines as well
and the patchset is rebased on the top of the latest ltp git.

-- 
Cyril Hrubis
chrubis@suse.cz
