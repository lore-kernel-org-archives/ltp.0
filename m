From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 17:20:29 +0200
Subject: [LTP] [PATCH v2] network/lib6/getaddrinfo01: rewrite with the
 new API + use static hostnames
In-Reply-To: <f584f853-c13c-cc16-8e75-085af0b82418@bell-sw.com>
References: <20210518091422.41857-1-aleksei.kodanev@bell-sw.com>
 <f584f853-c13c-cc16-8e75-085af0b82418@bell-sw.com>
Message-ID: <YKPbPXy113n/5IFo@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 18.05.2021 12:14, Alexey Kodanev wrote:
> > The test is now independent of various machine settings
> > regarding the test host name as it adds predefined names
> > and aliases to /etc/hosts file and restores it to its
> > original state after completing the test.

> > This should fix the following failures:
> > * when gethostname() returns an alias name that doesn't
> >   match canonical name;
> > * No AAAA record for the returned name from gethostname().

> > Addresses and names added to /etc/hosts are more or less
> > unique, so that there are no conflicts with the existing
> > configuration.

> > Also most of the duplicate code is now gone.

> > Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---

> Adding missing v2 update suggested by Petr:
> * description tag
> * new check_addrinfo_badflags(const char *) to remove even more code
> duplication.
Nice, thanks!

I've tested it in various distros running and compiling (+ it actually fixes
configuration bug, ...) but understand Cyril's concern about breakage last
minute before release. So we should probably merge after the release.

Kind regards,
Petr
