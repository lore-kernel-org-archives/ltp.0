From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Apr 2017 09:21:07 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_kvcmp: Add support for extra kernel
	versions
In-Reply-To: <20170427130152.GA14404@rei.lan>
References: <20170421155244.29773-1-chrubis@suse.cz>
 <343130515.905228.1493020687050.JavaMail.zimbra@redhat.com>
 <20170426150641.GA6165@rei.suse.de>
 <1624205915.3497140.1493281707439.JavaMail.zimbra@redhat.com>
 <20170427130152.GA14404@rei.lan>
Message-ID: <316485995.3602202.1493299267158.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > +static int compare_kver(const char *cur_kver, char *kver)
> > +{
> > +        const char *ver, *exver;
> > +        const char *distname = tst_kvcmp_distname(cur_kver);
> > +        int v1, v2, v3;
> > +
> > +        ver = strtok(kver, " ");
> > +
> > +        while ((exver = strtok(NULL, " "))) {
> > +                char *exkver = strchr(exver, ':');
> > +
> > +                if (!exkver) {
> > +                        fprintf(stderr, "Invalid extra version '%s'\n",
> > exver);
> > +                        exit(2);
> > +                }
> > +
> > +                *(exkver++) = '\0';
> > +
> > +                if (!distname || strcmp(distname, exver))
> > +                        continue;
> > +
> > +                return tst_kvexcmp(exkver, cur_kver);
> > +        }
> > 
> > If distname != NULL, that means that this is a distro we recognize.
> > And if we reached here, after while loop, that means we didn't
> > match any distro specified in "kver", correct?
> 
> Correct.
> 
> > So, is it OK to make conclusion, that there is a problem in kver?
> 
> Not at all. Even if we recognize the distro and the distname is non-NULL
> we can have any subset of distribution specific kernel versions
> (including empty one) in the input string. Hence if the loop does not
> mach any extra version against the currently detected distribution we
> simply fall back to the generic kernel version that should be at the
> start of the string.
> 
> Think about the distribution specific versions as of overrides that
> apply only if the distribution version is matched, otherwise we use the
> generic kernel version to make the decision.

OK, I see where my reasoning failed.

> 
> The only thing that should probably be validated here are the
> distribution names passed in the kver string. As it is everything that
> is not matched is skipped including possible typos. Hence I was speaking
> about adding a function that would check if given distribution name is
> valid (known to the library code).

I'd put that on todo/wish list, since this extended version matching
isn't widely used.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
