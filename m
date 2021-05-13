From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 May 2021 20:17:35 +0200
Subject: [LTP] [PATCH v2 4/5] docparse: Sort alphabetically tags in table
In-Reply-To: <20210504190240.24250-5-pvorel@suse.cz>
References: <20210504190240.24250-1-pvorel@suse.cz>
 <20210504190240.24250-5-pvorel@suse.cz>
Message-ID: <YJ1tP1wcMUoXgYBx@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  docparse/testinfo.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
> index 2aeee1a17..857278ac8 100755
> --- a/docparse/testinfo.pl
> +++ b/docparse/testinfo.pl
> @@ -424,8 +424,9 @@ sub content_all_tests

>  		$tmp2 = undef;
>  		my %commits;
> +		my @sorted_tags = sort { $a->[0] cmp $b->[0] } @{$json->{'tests'}{$name}{tags}};
Hm, this introduced bug on older perl. I'll send a fix for it.

Kind regards,
Petr

> -		for my $tag (@{$json->{'tests'}{$name}{tags}}) {
> +		for my $tag (@sorted_tags) {
>  			if (!defined($tmp2)) {
>  				$content .= table . "|Tags|Info\n"
>  			}
