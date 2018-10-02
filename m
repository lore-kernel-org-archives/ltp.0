From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Oct 2018 15:03:39 +0200
Subject: [LTP] [RFC PATCH 4/5] runtest/commands: adjust names for
 keyctl01, sysctl01, unshare01
In-Reply-To: <1536849882-28897-5-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20181002130338.GG24796@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> runtest/syscalls already defines tests with these ids, but there
> they point to different commands. In order to avoid name conflicts
> we need to rename tests either in runtest/commands or in runtest/syscalls.
> Since the tests in runtest/syscalls are much older, I chose to rename
> the tests in runtest/commands.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  runtest/commands | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/runtest/commands b/runtest/commands
> index ee7e9f4..f27d2fa 100644
> --- a/runtest/commands
> +++ b/runtest/commands
> @@ -37,7 +37,7 @@ which01 which01.sh
>  lsmod01 lsmod01.sh
>  insmod01 insmod01.sh
>  wc01 wc01.sh
> -keyctl01 keyctl01.sh
> +keyctl_01 keyctl01.sh
>  gdb01 gdb01.sh
> -unshare01 unshare01.sh
> -sysctl01 sysctl01.sh
> +unshare_01 unshare01.sh
> +sysctl_01 sysctl01.sh

Hmm, that's a bit hacky. Maybe we should add a _sh suffix to all the
testcases in commands so that it's clear that these are shell scripts.

-- 
Cyril Hrubis
chrubis@suse.cz
