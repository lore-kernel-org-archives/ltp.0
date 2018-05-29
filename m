From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 May 2018 10:07:39 +0200
Subject: [LTP] [PATCH 2/4] net: Allow to overwrite libraries getopts
	handlers
In-Reply-To: <a751aab4-fbf4-91d1-90d6-047873441694@oracle.com>
References: <20180526111545.20521-1-pvorel@suse.cz>
 <20180526111545.20521-2-pvorel@suse.cz>
 <a751aab4-fbf4-91d1-90d6-047873441694@oracle.com>
Message-ID: <20180529080739.GB10361@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

...
> > -TST_OPTS="hl:m:p:s:S:k:A:e:a:c:r:"
> > -TST_PARSE_ARGS=ipsec_lib_parse_args
> > +TST_OPTS="${TST_OPTS:-hl:m:p:s:S:k:A:e:a:c:r:}"

> So, to customize these options we would need to implement the original
> library options as well or you are going to pass the rest of the options
> to the library ipsec_lib_parse_args handler?

> I think TST_OPTS should include the library ones and the new options
> from the test.

> It would be better to show the usage somewhere, i.e. when it is
> really needed.
OK, I'll include this one in patchset, which migrate virt_lib.sh + ipsec_lib.sh into the
new API. I tried to introduce some changes before as the whole patch is going to be quite
big (due other bugs and the need to migrate virt_lib.sh and ipsec_lib.sh altogether.

My idea is if the test which uses any of virt_lib.sh or ipsec_lib.sh needs to change
getopts, it's it's responsibility to add these getopts.


Kind regards,
Petr
