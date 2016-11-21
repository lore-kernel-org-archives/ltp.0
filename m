From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Nov 2016 12:58:35 +0100
Subject: [LTP] [PATCH 1/1] testcases: bashisms: s/==/=/
In-Reply-To: <20161115224123.30623-1-pvorel@suse.cz>
References: <20161115224123.30623-1-pvorel@suse.cz>
Message-ID: <20161121115835.GB25334@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -    if [ "$mount_point" == "" ]; then
> +    if [ "$mount_point" = "" ]; then

These could be further fixed to [ -z "$mount_point" ].

> diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> index c776fc9..253480c 100755
> --- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> +++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
> @@ -40,12 +40,12 @@ ext4_test_journal_checksum()
>  	local checksum=
>  	local async_commit=
>  
> -	if [ "$3" == "" ]; then
> +	if [ "$3" = "" ]; then
>  		checksum="No use"
>  	else
>  		checksum="Used"
>  	fi
> -	if [ "$4" == "" ]; then
> +	if [ "$4" = "" ]; then
>  		async_commit="No use"
>  	else
>  		async_commit="Used"

And these as well.


Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
