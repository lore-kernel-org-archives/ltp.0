From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jan 2021 15:53:56 +0100
Subject: [LTP] [PATCH 2/2] testinfo.pl: Optimize imports
In-Reply-To: <20210121130033.20764-2-pvorel@suse.cz>
References: <20210121130033.20764-1-pvorel@suse.cz>
 <20210121130033.20764-2-pvorel@suse.cz>
Message-ID: <YBLQBCUzE2PzK8Dj@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Merged this simple one.

Kind regards,
Petr

> ---
>  docparse/testinfo.pl | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

> diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
> index b636b3c0e..b5ab02bc1 100755
> --- a/docparse/testinfo.pl
> +++ b/docparse/testinfo.pl
> @@ -6,8 +6,7 @@
>  use strict;
>  use warnings;

> -use JSON;
> -use LWP::Simple;
> +use JSON qw(decode_json);
>  use Cwd qw(abs_path);
>  use File::Basename qw(dirname);
