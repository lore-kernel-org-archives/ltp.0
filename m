From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Jan 2021 10:26:07 +0100
Subject: [LTP] [PATCH] unzip01.sh: Fix failure with BusyBox unzip
In-Reply-To: <20201221112250.27944-1-radoslav.kolev@suse.com>
References: <20201221112250.27944-1-radoslav.kolev@suse.com>
Message-ID: <X/Qwr3CwJmggYZuC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

> BusyBox unzip uses the word 'inflating' instead of 'extracting'.
> Detect it and check for the correct match in the output.

> Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
> ---
>  testcases/commands/unzip/unzip01.sh | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

> diff --git a/testcases/commands/unzip/unzip01.sh b/testcases/commands/unzip/unzip01.sh
> index 750718de4..1b9a1665f 100755
> --- a/testcases/commands/unzip/unzip01.sh
> +++ b/testcases/commands/unzip/unzip01.sh
> @@ -12,6 +12,14 @@ TST_NEEDS_TMPDIR=1
>  TST_NEEDS_CMDS="unzip"
>  . tst_test.sh

> +EXTRACT_MATCH=""
FYI shell syntax allow to drop quotes here:
EXTRACT_MATCH=

> +
> +if unzip 2>&1 | grep -q 'BusyBox'; then
> +	EXTRACT_MATCH="inflating"
> +else
> +	EXTRACT_MATCH="extracting"
> +fi

Thanks for a fix. Obviously correct, I pushed it with a tiny change (readability):

EXTRACT_MATCH="extracting"

if unzip 2>&1 | grep -q 'BusyBox'; then
	EXTRACT_MATCH="inflating"
fi

Kind regards,
Petr
