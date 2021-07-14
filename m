From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:37:12 +0200
Subject: [LTP] [PATCH v4 4/7] lib: Add script for running tests
In-Reply-To: <YO2f+P8Z9l6SISDG@yuki>
References: <20210713101338.6985-1-pvorel@suse.cz>
 <20210713101338.6985-5-pvorel@suse.cz> <YO2T4J14roLUT32t@yuki>
 <YO2gUL2/s29SGdNo@pevik> <YO2f+P8Z9l6SISDG@yuki>
Message-ID: <YO72mA9nhaCq1bLe@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

...
> > > Not sure what we can do here, I guess that timings would be hard to fix
> > > on VMs that run the tests.

> > If I remember correctly Richie suggested that FAIL is also OK. He said only
> > TBROK and TCONF is a problem. I'd prefer to fuzzy sync tests which always pass,
> > but after this effort I can work on API tests metadata, which would allow also
> > this.

> Another possibility would be relaxing the timings on VMs. I guess that
> we could change the treshold for reaching the criticall section to 10 on
> VMs.
I'd be for it, we have checks for VM. @Richie, any opinion about it?

Kind regards,
Petr
