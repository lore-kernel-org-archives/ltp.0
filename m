From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Mar 2019 17:24:21 +0100
Subject: [LTP] [PATCH v2] sysctl01: fix fails on live-patched kernels
In-Reply-To: <20190308115831.GB1360@dell5510>
References: <20190307183728.7659-1-jbaier@suse.cz>
 <20190308115831.GB1360@dell5510>
Message-ID: <20190308162421.GA2811@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> ...
> > +	klp_tag = strstr(buf.version, "/kGraft-");
> > +	if (!klp_tag)
> > +		klp_tag = strstr(buf.version, "/lp-");
> > +	if (klp_tag) {
> > +		right_brace = strchr(klp_tag, ')');
> > +		if (right_brace)
> > +			memmove(klp_tag, right_brace, sizeof(char) * (strlen(right_brace)+1));
> sizeof(char) == 1 by definition :)

Merged, with this tiny fix + extended commit message.
Thanks for your patch!

Kind regards,
Petr
