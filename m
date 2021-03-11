From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 11 Mar 2021 09:38:45 +0800
Subject: [LTP] [PATCH 2/2] docparse: Unify Description and Algorithm
 titles
In-Reply-To: <20210308160122.24522-2-pvorel@suse.cz>
References: <20210308160122.24522-1-pvorel@suse.cz>
 <20210308160122.24522-2-pvorel@suse.cz>
Message-ID: <604974A5.6080604@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/3/9 0:01, Petr Vorel wrote:
> Instead owo'n'df fixing sources docs unify it during doc generation.
Hi Petr,

Your fix unifies Description and Algorithm in metadata.{html, pdf}.
I wonder if we should do the conversion in metadata.json instead.

Best Regards,
Xiao Yang
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   docparse/testinfo.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
> index b5ab02bc1..f3a657d4d 100755
> --- a/docparse/testinfo.pl
> +++ b/docparse/testinfo.pl
> @@ -308,7 +308,7 @@ sub content_all_tests
>
>   				# fix formatting for asciidoc [DOCUMENTATION] =>  *DOCUMENTATION*
>   				if ($doc =~ s/^\[(.*)\]$/$1/) {
> -					$doc = paragraph(bold($doc));
> +					$doc = paragraph(bold(ucfirst(lc($doc))));
>   				}
>
>   				$content .= "$doc\n";



