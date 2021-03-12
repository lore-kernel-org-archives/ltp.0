From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 12:02:07 +0100
Subject: [LTP] [PATCH 2/2] docparse: Unify Description and Algorithm
 titles
In-Reply-To: <YEtFmok1oxZjcKVi@yuki.lan>
References: <20210308160122.24522-1-pvorel@suse.cz>
 <20210308160122.24522-2-pvorel@suse.cz> <YEtFmok1oxZjcKVi@yuki.lan>
Message-ID: <YEtKL70YWfv+yzyZ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> >  				# fix formatting for asciidoc [DOCUMENTATION] => *DOCUMENTATION*
>                                                                                   ^
> 										  This
> 										  should
> 										  be
> 										  *Documentation*

> >  				if ($doc =~ s/^\[(.*)\]$/$1/) {
> > -					$doc = paragraph(bold($doc));
> > +					$doc = paragraph(bold(ucfirst(lc($doc))));
> >  				}

> >  				$content .= "$doc\n";

> Other than that it looks good.
Thanks, fixed and patchset merged.

Yang, sorry I didn't put it into docparse.c.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
