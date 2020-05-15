From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 09:21:56 +0200
Subject: [LTP] [PATCH v2 1/4] INSTALL: Update requirements
In-Reply-To: <CAEemH2fQ3yfDfNqNeUfLAAWY6hUDcEybbU+dK=hwrwg2rFj60A@mail.gmail.com>
References: <20200514190906.27130-1-pvorel@suse.cz>
 <CAEemH2e5G53VPLp4bOe_i-2_4eRSF9dbTC378rqN-AwGanUTEw@mail.gmail.com>
 <20200515062221.GB5117@dell5510>
 <CAEemH2fQ3yfDfNqNeUfLAAWY6hUDcEybbU+dK=hwrwg2rFj60A@mail.gmail.com>
Message-ID: <20200515072156.GA17488@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > I'd prefer it in simple form (single line) + I thought bison is more
> > common than
> > byacc (but maybe I'm wrong). I'm not a big fan of sudo (but can add it
> > there).


> Sure, I have no preference here :). I added the 'sudo' just because I
> noticed that the INSTALL use many $ before commands which means in non-root
> user.
I added '#' in v3, but if anybody requires I can change it to sudo.


> > + Added headers and gcc. But on the other hand I wanted to have package
> > reference in
> > travis/*.sh (where are missing some packages which are installed by
> > default with
> > gcc, e.g. , but it does not harm to have it offline.

> +1
In the end in v3 I mentioned glibc and kernel headers, but also mentioned travis/*.sh.


> > Should I remove links to the tools? And we obviously don't list a compiler.


> Personally I think links are useless, people opened this INSTALL could also
> have the ability to use google for finding the package link:).
Agree, thus removed in v3.

Kind regards,
Petr
