From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Jun 2021 17:42:42 +0800
Subject: [LTP] [RFC PATCH 3/3] doc: Update LTPROOT and PATH environment
 variables
In-Reply-To: <20210615163307.10755-4-pvorel@suse.cz>
References: <20210615163307.10755-1-pvorel@suse.cz>
 <20210615163307.10755-4-pvorel@suse.cz>
Message-ID: <CAEemH2eLDk8rb3wUMCjz6Txo333f4Mae1AWZy0Rt6mTYuvYf6w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 16, 2021 at 12:33 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> to address changes in two previous commits.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  README.md          | 2 +-
>  doc/user-guide.txt | 7 +++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/README.md b/README.md
> index 703395c6b..b0ad47dfa 100644
> --- a/README.md
> +++ b/README.md
> @@ -162,7 +162,7 @@ $ testcases/bin/ioctl01 -h
>  Many require certain environment variables to be set
>
>  ```
> -$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> +$ LTPROOT=/opt/ltp testcases/bin/wc01.sh

I'm wondering does this really work? or, did I miss something?

Experiment in my kvm guest (with apply your patches):

# LTPROOT=/root/ltp-install wc01.sh
bash: wc01.sh: command not found...

# LTPROOT=/root/ltp-install testcases/bin/wc01.sh
-bash: testcases/bin/wc01.sh: No such file or directory

# LTPROOT=/root/ltp-install PATH="$PATH:$LTPROOT/testcases/bin" wc01.sh
wc01 1 TINFO: timeout per run is 0h 5m 0s
wc01 1 TPASS: wc passed with -c option.
wc01 2 TPASS: wc passed with --bytes option.
wc01 3 TPASS: wc passed with -l option.
wc01 4 TPASS: wc passed with --lines option.
wc01 5 TPASS: wc passed with -L option.
wc01 6 TPASS: wc passed with --max-line-length option.
wc01 7 TPASS: wc passed with -w option.
wc01 8 TPASS: wc passed with --words option.
wc01 9 TPASS: wc passed with -m option.
wc01 10 TPASS: wc passed with --chars option.
wc01 11 TPASS: wc passed with --help option.
wc01 12 TPASS: wc passed with --version option.

Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0

-- 
Regards,
Li Wang

