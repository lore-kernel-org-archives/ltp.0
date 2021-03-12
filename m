From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Mar 2021 11:42:34 +0100
Subject: [LTP] [PATCH 2/2] docparse: Unify Description and Algorithm
 titles
In-Reply-To: <20210308160122.24522-2-pvorel@suse.cz>
References: <20210308160122.24522-1-pvorel@suse.cz>
 <20210308160122.24522-2-pvorel@suse.cz>
Message-ID: <YEtFmok1oxZjcKVi@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
> index b5ab02bc1..f3a657d4d 100755
> --- a/docparse/testinfo.pl
> +++ b/docparse/testinfo.pl
> @@ -308,7 +308,7 @@ sub content_all_tests
>  
>  				# fix formatting for asciidoc [DOCUMENTATION] => *DOCUMENTATION*
                                                                                  ^
										  This
										  should
										  be
										  *Documentation*

>  				if ($doc =~ s/^\[(.*)\]$/$1/) {
> -					$doc = paragraph(bold($doc));
> +					$doc = paragraph(bold(ucfirst(lc($doc))));
>  				}
>  
>  				$content .= "$doc\n";

Other than that it looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
