From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:34:40 +0200
Subject: [LTP] [PATCH v2 3/8] doc: Add rules and recommendations list
In-Reply-To: <87sg0hni07.fsf@suse.de>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-4-rpalethorpe@suse.com>
 <YO7CU8UebcFN2VtY@pevik> <87sg0hni07.fsf@suse.de>
Message-ID: <YO72AKW7/AEDsMtp@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Hello Petr,

> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Richie,

> >> +++ b/doc/test-writing-guidelines.txt
> >> @@ -10,6 +10,11 @@ NOTE: See also
> >>        https://github.com/linux-test-project/ltp/wiki/Shell-Test-API[Shell Test API],
> >>        https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].

> >> +Rules and recommendations which are "machine checkable" should be
> >> +tagged with an ID like +LTP-XXX+. There will be a corresponding entry
> >> +in 'doc/rules.tsv'. When you run 'make check' or 'make check-test' it
> >> +will display these IDs as a reference.
> >> +
> > Actually text is on the top. I suppose, you probably planned to put
> > this into "2.1 C coding style".

> I'm not sure where to put it. The coding style is mostly about syntax
> and formatting. The rules file can state anything machine checkable, so
> that can include shell, directory structure, what functions are used
> etc.

Not sure myself myself. But my note was that you put it below NOTE,
above "1. Guide to clean and understandable code" which looks strange to me.

But not a big deal with it, just a nit.

Kind regards,
Petr

> > Kind regards,
> > Petr

> >>  1. Guide to clean and understandable code
> >>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
