From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 May 2021 21:59:34 +0200
Subject: [LTP] [PATCH] network/lib6/getaddrinfo01: rewrite with the new
 API + use static hostnames
In-Reply-To: <b7744613-ee02-c4a5-e5ed-da3da60a6e7b@bell-sw.com>
References: <20210518091422.41857-1-aleksei.kodanev@bell-sw.com>
 <YKQSTR1wkB/U81Em@pevik>
 <b7744613-ee02-c4a5-e5ed-da3da60a6e7b@bell-sw.com>
Message-ID: <YKVuJksJkHh7uxbX@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 18.05.2021 22:15, Petr Vorel wrote:
> > Hi Alexey,

> > ...
> >> +static void setup(void)
> >> +{
> >> +	unsigned int i;
> >> +	int fd;
> > ...
> >> +	SAFE_CP(host_file, "hosts");
> > One more thing, could we check for /etc/hosts before?

> Hi Petr,

> Yes, why not. I assume it can be read-only, but I hope we won't hide a
> configuration bug with this...

Hi Alexey,

hm, not sure if we can hide configuration bug. For a traditional distros
probably yes, but not for embedded and other special distros.
And good point, I'd TCONF also when file is read-only (which is more likely that
file not presented). We can always think about different solution if anybody
complains about this requirement.

Kind regards,
Petr

> > Because we want to TCONF on systems without it not TBROK.
> > And I guess there are embedded systems without it out there.

> > Kind regards,
> > Petr


